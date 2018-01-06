#!/usr/bin/env python
# -*- coding: windows-1252 -*-

# author: diego.hahn
#

# HARDCODED AO EXTREMO :D 
import struct
import os
import sys

def Unpack(src_dat, dst_dat, src_fnt, dst_fnt):
    print ">> Unpacking obj_dat.bin"
    with open( src_dat , "rb" ) as fd:    
        if not os.path.isdir( dst_dat ):
            os.makedirs(dst_dat)
            
        total_ptr = struct.unpack("<L" , fd.read(4))[0]
        
        for i in range(total_ptr):
            addr, next = struct.unpack("<LL", fd.read(8))
            size = next - addr
            link = fd.tell() - 4
            fd.seek( addr )
            
            with open( os.path.join(dst_dat , "%03d.bin" % i) , "wb" ) as out:
                out.write( fd.read( size ) )
                
            fd.seek( link )

    print ">> Unpacking obj_fnt.bin"            
    with open( src_fnt , "rb" ) as fd:
        if not os.path.isdir( dst_fnt ):
            os.makedirs( dst_fnt )
            
        total_ptr = struct.unpack("<L" , fd.read(4))[0]
        
        for i in range(total_ptr):
            addr, next = struct.unpack("<LL", fd.read(8))
            size = next - addr
            link = fd.tell() - 4
            fd.seek( addr )
            
            with open( os.path.join(dst_fnt , "%03d.bin" % i) , "wb" ) as out:
                out.write( fd.read( size ) )
                
            fd.seek( link )

def Pack(src_dat, dst_dat, src_fnt, dst_fnt):
    print ">> Packing obj_dat.bin"
    with open( dst_dat, "wb" ) as fd:    
        files = os.listdir( src_dat )
        
        fd.write( struct.pack( "<L" , len(files) ) )
        fd.write( "\x00" * 4*(len(files) + 1) )
        
        ptrs = []
        for f in sorted( files ):
            ptrs.append( fd.tell() )
            with open( os.path.join( src_dat, f), "rb" ) as input:
                fd.write(input.read())
        ptrs.append( fd.tell() )
        
        fd.seek( 0x4 )
        for ptr in ptrs:
            fd.write( struct.pack( "<L" , ptr ) )
            
    print ">> Packing obj_fnt.bin"
    with open( dst_fnt, "wb" ) as fd:    
        files = os.listdir( src_fnt )
        
        fd.write( struct.pack( "<L" , len(files) ) )
        fd.write( "\x00" * 4*(len(files) + 1) )
        
        ptrs = []
        for f in sorted( files ):
            ptrs.append( fd.tell() )
            with open( os.path.join( src_fnt, f), "rb" ) as input:
                fd.write(input.read())
        ptrs.append( fd.tell() )
        
        fd.seek( 0x4 )
        for ptr in ptrs:
            fd.write( struct.pack( "<L" , ptr ) )                
    

if __name__ == "__main__":

    import argparse
    
    os.chdir( sys.path[0] )
    #os.system( 'cls' )

    parser = argparse.ArgumentParser()
    parser.add_argument( '-m', dest = "mode", type = str, required = True )
    parser.add_argument( '-s1', dest = "src_dat", type = str, nargs = "?", required = True )
    parser.add_argument( '-s2', dest = "src_fnt", type = str, nargs = "?", required = True )
    parser.add_argument( '-d1', dest = "dst_dat", type = str, nargs = "?", required = True )
    parser.add_argument( '-d2', dest = "dst_fnt", type = str, nargs = "?", required = True )
    
    args = parser.parse_args()            

    if args.mode == "u":
        Unpack( args.src_dat , args.dst_dat , args.src_fnt , args.dst_fnt )
    # insert bg
    elif args.mode == "p": 
        Pack( args.src_dat , args.dst_dat , args.src_fnt , args.dst_fnt )
    else:
        sys.exit(1)               
        
    

            
    