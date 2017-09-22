#!/usr/bin/env python
# -*- coding: windows-1252 -*-

import os
import struct
import array
import mmap

from rhCompression import lzss

PATH_SUBTITLES = "./subtitles/out-ptbr"
PATH_OUTPUT = "./subtitles/ptbr"

def vertical(buffer):
    c = ''
    for y in range(8)[::-1]:
        c += buffer[4*y:4*(y+1)]
    return c

def horizontal(buffer):
    c = ''
    for y in range(8):
        reverse = buffer[4*y:4*(y+1)][::-1]
        for w in range(4):
            c += chr((ord(reverse[w]) << 4 | ord(reverse[w]) >> 4) & 0xFF)
    return c
    
def diagonal(buffer):
    return horizontal(vertical(buffer))
    
def create_tilesdict( buff , codec ):
    tilesdict = {}
    if codec == 4:
        lenght = len(buff) / 32
        for x in range(lenght):
            tilesdict.update({x:buff[32*x:32*(x+1)]})
    else:
        lenght = len(buff) / 64
        for x in range(lenght):
            tilesdict.update({x:buff[64*x:64*(x+1)]})
    return tilesdict    
    
if __name__ == "__main__":

    for f in os.listdir( PATH_SUBTITLES ):
        path = os.path.join( PATH_SUBTITLES , f )
        offset = 0
        tileset = array.array("c")
        tilemaps = []
        dc = {}        
        for g in os.listdir( path ):          
            with open( os.path.join( path , g ), "rb" ) as fd :   
            
                buff = fd.read()
                tilesdict = create_tilesdict( buff , 4 )
                
                for x in tilesdict: 
                    if dc.has_key(tilesdict[x]):
                        continue
                    elif dc.has_key(horizontal(tilesdict[x])):
                        continue
                    elif dc.has_key(vertical(tilesdict[x])):
                        continue
                    elif dc.has_key(diagonal(tilesdict[x])):
                        continue                        
                    else:
                        dc.update({tilesdict[x]:offset})
                        offset += 1   

        newdc = {}
        
        for x in dc:
            newdc.update({dc[x]:x})
        for x in newdc:
            tileset.extend(newdc[x])                        
        
        for g in os.listdir( path ):  
            with open( os.path.join( path , g ), "rb" ) as fd :   
            
                buff = fd.read()
                tilesdict = create_tilesdict( buff , 4 )

                # dc = {}

                # for x in tilesdict: 
                    # if dc.has_key(tilesdict[x]):
                        # continue
                    # elif dc.has_key(horizontal(tilesdict[x])):
                        # continue
                    # elif dc.has_key(vertical(tilesdict[x])):
                        # continue
                    # elif dc.has_key(diagonal(tilesdict[x])):
                        # continue                        
                    # else:
                        # dc.update({tilesdict[x]:offset})
                        # offset += 1
                        
                # newdc = {}
                
                # for x in dc:
                    # newdc.update({dc[x]:x})
                # for x in newdc:
                    # tileset.extend(newdc[x])
                    
                tm = array.array("c")
                for x in tilesdict:
                    if dc.has_key(tilesdict[x]):
                        tm.extend( struct.pack("<H", 0x8000 | dc[tilesdict[x]])) 
                    elif dc.has_key(horizontal(tilesdict[x])):
                        tm.extend( struct.pack("<H", 0x8400 | dc[horizontal(tilesdict[x])]))
                    elif dc.has_key(vertical(tilesdict[x])):
                        tm.extend( struct.pack("<H", 0x8800 | dc[vertical(tilesdict[x])]))
                    elif dc.has_key(diagonal(tilesdict[x])):
                        tm.extend( struct.pack("<H", 0x8C00 | dc[diagonal(tilesdict[x])]))      
                    else:
                        raise Exception
                        sys.exit(1)

                tilemaps.append( tm )
            
        temp = mmap.mmap( -1, len(tileset ) )
        temp.write( tileset )
        comp = lzss.compress(temp)
        
        with open( os.path.join( PATH_OUTPUT , "%s.bin" % f ) , "wb" ) as fd:
            print "> packing" ,  "%s.bin" % f
            fd.seek( 0x10, 0 )
            addr_tileset = fd.tell()
            fd.write( struct.pack( "<L", 0x14 ) ) # localização do tileset
            fd.write( struct.pack( "<L", len( comp ) ) )
            fd.write( struct.pack( "<L" , 0x80220100 ) )
            fd.write( struct.pack( "<L", len( comp ) + 8 ) )
            fd.write( struct.pack( "<L" , 0x08080020 ) )
            comp.tofile( fd )
            fd.write( struct.pack( "<L" , 0x000003E0 ) )
            fd.write( struct.pack( "<L" , 0x00007FFF ) )
            fd.write( "\x00" * 24 )
            
            addr_tilemap = fd.tell()
            offset = 4*len(tilemaps)
            tblptr = map( lambda x : offset + x*(2048+8) , range(len(tilemaps)) )
            for addr in tblptr:
                fd.write( struct.pack( "<L" , addr ) )
                
            for data in tilemaps:
                fd.write( struct.pack( "<L" , 0 ) )
                fd.write( struct.pack( "<L" , 0x00200020  ) )
                data.tofile( fd )
                
            size = fd.tell()
            fd.seek( 0, 0 )
            fd.write( struct.pack( "<L" ,0x2 ) )
            fd.write( struct.pack( "<L" , addr_tileset ) )
            fd.write( struct.pack( "<L" , addr_tilemap ) )
            fd.write( struct.pack( "<L" , size ) )
            

                
            