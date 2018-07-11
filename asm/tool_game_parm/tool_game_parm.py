#!/usr/bin/env python
# -*- coding: windows-1252 -*-

# author: diego.hahn
#

# HARDCODED AO EXTREMO :D 

import struct
import os

def Unpack( src, dst ):
    print ">> Unpacking game_parm.bin"
    
    with open( src, "rb" ) as fd:   
    
        if not os.path.isdir( dst ):
            os.makedirs( dst )
    
        entries = struct.unpack( "<L", fd.read(4) )[0]
        ptrs = struct.unpack( "<%dL" % (entries+1) , fd.read(4*(entries+1)) )
        
        for i in range(entries):
            out = os.path.join( dst , "%03d.bin" % i )
            with open( out, "wb" ) as od:
                fd.seek( ptrs[i] )
                od.write( fd.read( ptrs[i+1] - ptrs[i] ) )

    # Desempacota o arquivo 000.bin
    with open( os.path.join( dst , "000.bin" ), "rb" ) as fd:
        addr = fd.tell() + struct.unpack("<L" , fd.read(4))[0]
        size = struct.unpack("<L" , fd.read(4))[0]
        dummy = fd.read(4)
        addr_palette = fd.tell() + struct.unpack("<L" , fd.read(4))[0]
        size_palette = struct.unpack("<L" , fd.read(4))[0] & 0xFFFF    
               
        path = "asm_game_parm_000"
        if not os.path.isdir( path ):
            os.makedirs( path )
            
        with open( os.path.join( path , "000.bin" ) , "wb" ) as od:
            fd.seek( addr )
            od.write( fd.read( size ) )
        
        with open( os.path.join( path , "000_palette.bin" ) , "wb" ) as od:
            fd.seek( addr_palette )
            od.write( fd.read( size_palette ) )      
    
    # Desempacota o arquivo 001.bin
    with open( os.path.join( dst , "001.bin" ), "rb" ) as fd:
        addr_0 = struct.unpack("<L" , fd.read(4))[0]
        addr_1 = struct.unpack("<L" , fd.read(4))[0]
               
        path = "asm_game_parm_001"
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
    