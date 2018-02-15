#!/usr/bin/env python
# -*- coding: windows-1252 -*-

# author: diego.hahn
#

# HARDCODED AO EXTREMO :D 
import struct
import os
import sys

COMPRESSION_FLAG = [0x80000000, 0, 0x80000000, 0, 0x80000000, 0x80000000, 0x80000000, 0]

PTR2_MARK = [0x80460100,0x80460100,0x80220100,0x80440100,0x80440100,0x80440100]

def Unpack(src, dst):
    print ">> Unpacking title.bin"
    with open( src , "rb" ) as fd:
        ptr_table_1_path = os.path.join( dst, "ptr_table_1" )
        if not os.path.isdir(ptr_table_1_path):
            os.makedirs(ptr_table_1_path)
            
        fd.seek( 0x08 )       
        for i in range(7):
            addr, next = struct.unpack("<LL", fd.read(8))
            addr &= 0x7fffffff
            next &= 0x7fffffff 
            size = next - addr
            link = fd.tell() - 4
            
            fd.seek( addr )          
            with open( os.path.join(ptr_table_1_path , "%03d.bin" % i) , "wb" ) as out:
                out.write( fd.read( size ) )                
            fd.seek( link )
            
        ptr_table_2_path = os.path.join( dst, "ptr_table_2" )
        if not os.path.isdir(ptr_table_2_path):
            os.makedirs(ptr_table_2_path)
            
        fd.seek( 0x28 )
        for i in range(6):
            p = fd.tell()
            addr, size = struct.unpack("<LL", fd.read(8))
            addr += p
            fd.read(12)
            link = fd.tell()
            print hex(addr), hex(link), size
            
            fd.seek(addr)
            with open( os.path.join(ptr_table_2_path , "%03d.bin" % i) , "wb" ) as out:
                out.write( fd.read( size ) )
            fd.seek( link )             

def Pack(src, dst):
    print ">> Packing title.bin"
    with open( dst, "wb" ) as fd:
        fd.write( struct.pack("<L", 0x000008 ))
        fd.write( struct.pack("<L", 0x000028 ))
    
        ptr_table_2_path = os.path.join( src, "ptr_table_2" )
    
        files = os.listdir(ptr_table_2_path)
        splitted_files = [ f for f in files if "palette" not in f ]
        splitted_pallete = [ f for f in files if "palette" in f ]
        
        fd.seek(0xa0)
        
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
            
        ptr_table_1_path = os.path.join( src, "ptr_table_1" )            
        files = os.listdir(ptr_table_1_path)
        ptr_table_1_table = []
        for i, f in enumerate(files): 
            addr = fd.tell()
        
            input = open( os.path.join(ptr_table_1_path, f), "rb" )
            fd.write( input.read() )
            input.close()
            
            if ( fd.tell() % 4 != 0 ):
                fd.write( "\x00" * (4 - (fd.tell() % 4)) )            
            
            ptr_table_1_table.append(addr)
        ptr_table_1_table.append(fd.tell())
        
        fd.seek( 0x08 )
        for i, p in enumerate(ptr_table_1_table):
            fd.write( struct.pack( "<L", p | COMPRESSION_FLAG[i] ))
            
        for i, p in enumerate(ptr_table_2_table):
            fd.write( struct.pack( "<L", p[0] - fd.tell() ))
            fd.write( struct.pack( "<L", p[1] ))
            fd.write( struct.pack( "<L", p[2] ))
            fd.write( struct.pack( "<L", p[3] - fd.tell() ))
            fd.write( struct.pack( "<L", p[4] | 0x00080000 ))

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
        
    

            
    