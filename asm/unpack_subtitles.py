#!/usr/bin/env python
# -*- coding: windows-1252 -*-

import os
import struct

from rhCompression import lzss

PATH_SUBTITLES = "./subtitles/en"
PATH_OUTPUT = "./subtitles/out-en"

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
        with open( os.path.join( PATH_SUBTITLES , f ), "rb" ) as fd :    
            print "> unpacking" , f
            # Verifica a marca
            if fd.read(4) != "\x02\x00\x00\x00":
                raise Exception()
                
            addr_tileset = struct.unpack("<L" , fd.read(4))[0]
            addr_tilemap = struct.unpack("<L" , fd.read(4))[0]
            filesize = struct.unpack("<L" , fd.read(4))[0]
            
            # leitura do tileset
            fd.seek( addr_tileset , 0 )
            addr_compfile = struct.unpack("<L" , fd.read(4))[0] + addr_tileset
            # o resto não é realmente importante
            buff = lzss.uncompress( fd , addr_compfile )
            
            # criando o tileset a partir dos dados descomprimidos
            tilesdict = create_tilesdict( buff , 4 )
            
            # leitura do tilemap
            fd.seek( addr_tilemap , 0 )
            tblptr = []
            while True:
                ptr = struct.unpack("<L" , fd.read(4))[0]
                if ptr == 0 :
                    break
                tblptr.append( addr_tilemap + ptr )
                
            for i , ptr in enumerate(tblptr):
                # ignorar as stamps no começo do tilemap
                fd.seek( ptr + 8 )
                
                name, ext = f.split(".")
                output = os.path.join( PATH_OUTPUT , name )
                if not os.path.isdir( output ):
                    os.mkdir( output )
                
                with open( os.path.join( output , "%d.%s" % (i, ext)) , "wb" ) as raw:                   
                    for _ in range( 1024 ):
                        key = struct.unpack( "<H" , fd.read(2))[0]           
                        
                        # TODO - Imagens com multiplas paletas
                        key &= 0xFFF
                        
                        if (key & 0xC00) == 0xC00 :
                            raw.write(diagonal(tilesdict[(key & 0x3FF)]))
                        elif (key & 0x800) == 0x800:
                            raw.write(vertical(tilesdict[(key & 0x3FF)]))
                        elif (key & 0x400) == 0x400:
                            raw.write(horizontal(tilesdict[(key & 0x3FF)]))
                        else:
                            raw.write(tilesdict[(key & 0x3FF)])                
                            
                
                
            
            
         
            
            
                
                
                
                
    
    