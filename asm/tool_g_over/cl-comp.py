#!/usr/bin/env pypy
# -*- coding: windows-1252 -*-

# author: diego.hahn
#

# HARDCODED AO EXTREMO :D 

import os
import sys

import lzss

if __name__ == "__main__":
    import argparse

    os.chdir( sys.path[0] )
    #os.system( 'cls' )

    parser = argparse.ArgumentParser()
    parser.add_argument( '-m', dest = "mode", type = str, required = True )
    parser.add_argument( '-t', dest = "type", type = str, required = True )
    parser.add_argument( '-i', dest = "src", type = str, nargs = "?", required = True )
    parser.add_argument( '-o', dest = "dst", type = str, nargs = "?", required = True )
    
    args = parser.parse_args()            

    if args.mode == "d":
        with open( args.src, "rb" ) as fd:
            if args.type == "lz10":
                ret = lzss.uncompress( fd, 0 )
            
        with open( args.dst, "wb" ) as fd:
            ret.tofile( fd )    
    
    elif args.mode == "c":
        with open( args.src, "rb" ) as fd:
            if args.type == "lz10":
                ret = lzss.compress( fd )
            
        with open( args.dst, "wb" ) as fd:
            ret.tofile( fd )
            