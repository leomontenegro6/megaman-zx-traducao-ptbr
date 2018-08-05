#!/usr/bin/env python
# -*- coding: windows-1252 -*-

# author: diego.hahn
#

# HARDCODED AO EXTREMO :D 
import struct
import os
import sys

import lzss

COMPRESSION_FLAG = [0, 0x80000000, 0, 0x80000000, 0, 0 ]

PTR2_MARK = [0x80200100,0x80200100,0x80200100]
P = [ 0x08, 0x0B, 0x0C ]

def Unpack(src, dst):
    print ">> Unpacking g_over.bin"
    
    if not os.path.isdir(dst):
        os.makedirs(dst)    
    
    with open( src , "rb" ) as fd:
    
        entries = struct.unpack("<L", fd.read(4))[0]       
        ptrs = struct.unpack( "<%dL" % (entries+1) , fd.read(4*(entries+1)) )
        
        for i in range( entries ):
            addr = ptrs[i] & 0x7fffffff
            next = ptrs[i+1] & 0x7fffffff
            size = next - addr
            fd.seek( addr )        
            with open( os.path.join(dst, "%03d.bin" % i) , "wb" ) as out:
                out.write( fd.read( size ) )
        
            if ( ptrs[i] & 0x80000000 ):
                with open( os.path.join(dst, "%03d.bin" % i), "rb" ) as fd1:
                    ret = lzss.uncompress( fd1, 0 )
                    
                with open( os.path.join(dst, "%03d_descomprimido.bin" % i), "wb" ) as fd1:
                    ret.tofile( fd1 )          

    # unpack 000.bin
    with open( os.path.join( dst , "000.bin" ), "rb" ) as fd:
        for i in range( 2 ):
            addr = fd.tell() + struct.unpack("<L" , fd.read(4))[0]
            size = struct.unpack("<L" , fd.read(4))[0]
            # size_palette = struct.unpack("<L" , fd.read(4))[0] & 0xFFFF  
            # addr_palette = fd.tell() + struct.unpack("<L" , fd.read(4))[0]
            dummy = fd.read(12)
            link = fd.tell()
            
            path = "asm_g_over_000"
            if not os.path.isdir( path ):
                os.makedirs( path )
                
            with open( os.path.join( path , "%03d.bin" % i ) , "wb" ) as od:
                fd.seek( addr )
                od.write( fd.read( size ) )
            
            # with open( os.path.join( path , "%03d_palette.bin" % i ) , "wb" ) as od:
                # fd.seek( addr_palette )
                # od.write( fd.read( size_palette ) ) 

            fd.seek( link )
            
    # unpack 001.bin
    with open( os.path.join( dst , "001_descomprimido.bin" ), "rb" ) as fd:
        addr_0 = struct.unpack("<L" , fd.read(4))[0]
        addr_1 = struct.unpack("<L" , fd.read(4))[0]
        addr_2 = struct.unpack("<L" , fd.read(4))[0]
               
        path = "asm_g_over_001"
        if not os.path.isdir( path ):
            os.makedirs( path )
            
        with open( os.path.join( path , "001_000.bin" ) , "wb" ) as od:
            fd.seek( addr_0 + 4 )
            w, h = struct.unpack("<2H", fd.read(4))
            size = w*h*2           
            od.write( fd.read( size ) )
        
        with open( os.path.join( path , "001_001.bin" ) , "wb" ) as od:
            fd.seek( addr_1 + 4 )
            w, h = struct.unpack("<2H", fd.read(4))
            size = w*h*2 
            od.write( fd.read( size ) )           
            
        with open( os.path.join( path , "001_002.bin" ) , "wb" ) as od:
            fd.seek( addr_2 + 4 )
            w, h = struct.unpack("<2H", fd.read(4))
            size = w*h*2 
            od.write( fd.read( size ) )           
            

                
            
# 0x00000078 -> Ponteiro pro arquivo + f.tell()
# 0x00007320 -> Tamanho do arquivo
# 0x80460100 -> ??
# 0x0000738C -> Ponteiro pra paleta de cores + f.tell()
# 0x00080000 -> ??          

def Pack(src, dst):
    print ">> Packing elf.bin"
    
    ptr_table_1_path = os.path.join( src, "ptr_table_1" )
    if not os.path.isdir(ptr_table_1_path):
        os.makedirs(ptr_table_1_path)  

    ptr_table_2_path = os.path.join( ptr_table_1_path, "004" )
    if not os.path.isdir(ptr_table_2_path):
        os.makedirs(ptr_table_2_path)

    files = os.listdir(ptr_table_2_path)
    splitted_files = [ f for f in files if "palette" not in f ]
    splitted_pallete = [ f for f in files if "palette" in f ]        
    
    # Este arquivo importa
    with open( os.path.join( ptr_table_1_path , "004.bin" ), "wb" ) as fd:

        fd.seek(0x3c)
        
        ptr_table_2_table = []
        
        for i, f in enumerate(splitted_files):
            addr = fd.tell()
        
            input = open( os.path.join(ptr_table_2_path, f), "rb" )
            buff = input.read()
            fd.write( buff )
            input.close()
            if ( fd.tell() % 4 != 0 ):
                fd.write( "\x00" * (4 - (fd.tell() % 4)) )
            
            size = len(buff)
            paddr = fd.tell()            
            if ("%03d_palette.bin" % i) in splitted_pallete:
                input = open( os.path.join(ptr_table_2_path, ("%03d_palette.bin" % i)), "rb" )
                buff = input.read()
                fd.write( buff )
                input.close()
                
                psize = len(buff)
            else:
                psize = 0
            
            ptr_table_2_table.append( (addr, size, PTR2_MARK[i], paddr, psize) )   
            
        fd.seek(0x0)           
        for i, p in enumerate(ptr_table_2_table):
            fd.write( struct.pack( "<L", p[0] - fd.tell() ))
            fd.write( struct.pack( "<L", p[1] ))
            fd.write( struct.pack( "<L", p[2] ))
            fd.write( struct.pack( "<L", p[3] - fd.tell() ))
            fd.write( struct.pack( "<L", p[4] | 0x00080000 | ( P[i] << 24 ) ))        
    
    with open( dst, "wb" ) as fd:    
        fd.write( struct.pack("<L", 0x000006) )
        fd.seek( 0x20 )
        
        ptr_table_1_table = []
        for i, f in enumerate(range(6)): 
            addr = fd.tell()
        
            input = open( os.path.join(ptr_table_1_path, "%03d.bin" % f), "rb" )
            fd.write( input.read() )
            input.close()
            
            if ( fd.tell() % 4 != 0 ):
                fd.write( "\x00" * (4 - (fd.tell() % 4)) )            
            
            ptr_table_1_table.append(addr)
        ptr_table_1_table.append(fd.tell())        
        
        fd.seek( 0x04 )
        for i, p in enumerate(ptr_table_1_table):
            fd.write( struct.pack( "<L", p | COMPRESSION_FLAG[i] ))    
    
if __name__ == "__main__":

    import argparse
    
    os.chdir( sys.path[0] )
    #os.system( 'cls' )

    parser = argparse.ArgumentParser()
    parser.add_argument( '-m', dest = "mode", type = str, required = True )
    parser.add_argument( '-s', dest = "src", type = str, nargs = "?", required = True )
    parser.add_argument( '-d', dest = "dst", type = str, nargs = "?", required = True )
    
    args = parser.parse_args()            

    if args.mode == "u":
        Unpack( args.src , args.dst )
    elif args.mode == "p": 
        Pack( args.src , args.dst  )
    else:
        sys.exit(1)               
        
    

            
    