#!/usr/bin/env python
# -*- coding: windows-1252 -*-

# author: diego.hahn
#

# HARDCODED AO EXTREMO :D 

import os
import struct
import sys
import array

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
        length = len(buff) / 32
        for x in range(length):
            tilesdict.update({x:buff[32*x:32*(x+1)]})
    else:
        length = len(buff) / 64
        for x in range(length):
            tilesdict.update({x:buff[64*x:64*(x+1)]})
    return tilesdict

def reduce_tilesdict( tilesdict ):
    offset = 0 
    reduced_tilesdict = dict()
    for x in tilesdict: 
        if reduced_tilesdict.has_key(tilesdict[x]):
            continue
        elif reduced_tilesdict.has_key(horizontal(tilesdict[x])):
            continue
        elif reduced_tilesdict.has_key(vertical(tilesdict[x])):
            continue
        elif reduced_tilesdict.has_key(diagonal(tilesdict[x])):
            continue                        
        else:
            reduced_tilesdict.update({tilesdict[x]:offset})
            offset += 1 
    # inverte o dicionário
    ret = dict()
    for k,v in reduced_tilesdict.items():
        ret.update({v:k})
            
    return ret 

def EncodeImage( src, dst, map, full, entry, codec ):
    # Monta o tileset a partir da imagem full (concatenação de todas as imagens)
    with open( full, "rb" ) as fd :    
        tilesdict = create_tilesdict( fd.read() , codec )
        # Simplifica o dicionário de tiles para apenas tiles únicos
        reduced_td = reduce_tilesdict(tilesdict)
        
        # Monta o tileset
        tileset = array.array("c")
        out = open( dst, "wb" )
        for i in range(len(reduced_td)):
            tileset.extend(reduced_td[i])
            out.write(reduced_td[i]) 
        out.close()
                        
    with open( src, "rb" ) as fd:
        tilesdict = create_tilesdict( fd.read() , codec )
    
        # Monta o tilemap -  a informação da paleta de cores vem do tilemap original
        tilemap = list()
        val = reduced_td.values()
        for i in range(len(tilesdict)):
            if tilesdict[i] in val:
                tilemap.append( 0x0000 | val.index(tilesdict[i]))
            elif horizontal(tilesdict[i]) in val:
                tilemap.append( 0x0400 | val.index(horizontal(tilesdict[i])))
            elif vertical(tilesdict[i]) in val:
                tilemap.append( 0x0800 | val.index(vertical(tilesdict[i])))
            elif diagonal(tilesdict[i]) in val:
                tilemap.append( 0x0C00 | val.index(diagonal(tilesdict[i])))   
            else:
                raise Exception
                sys.exit(1)

    size = 0x20*0x20
    # Atualiza o tilemap
    with open(map, "r+b") as fd:             
        palette = []
        for i in range(size):
            palette.append(struct.unpack("<H", fd.read(2))[0] & 0xF000)

        fd.seek(0)
        for i in range(size):
            fd.write(struct.pack("<H", palette[i] | tilemap[i]))

def DecodeImage( src, dst, map, entry, codec ):

    # Leitura do tilemap
    with open( src, "rb" ) as fd:
        tilesdict = create_tilesdict( fd.read() , codec )
        
    with open(map, "rb") as fd:

        size = 0x20*0x20
        out = open( dst, "wb" )
        for _ in range( size ):
            key = struct.unpack( "<H" , fd.read(2))[0]           
            
            # TODO - Imagens com multiplas paletas
            key &= 0xFFF
            
            if (key & 0xC00) == 0xC00 :
                out.write(diagonal(tilesdict[(key & 0x3FF)]))
            elif (key & 0x800) == 0x800:
                out.write(vertical(tilesdict[(key & 0x3FF)]))
            elif (key & 0x400) == 0x400:
                out.write(horizontal(tilesdict[(key & 0x3FF)]))
            else:
                out.write(tilesdict[(key & 0x3FF)])     
                
        out.close()

if __name__ == "__main__":
    
    import argparse
    
    os.chdir( sys.path[0] )
    #os.system( 'cls' )

    parser = argparse.ArgumentParser()
    parser.add_argument( '-m', dest = "mode", type = str, required = True )
    parser.add_argument( '-s', dest = "src", type = str, nargs = "?", required = True )
    parser.add_argument( '-d', dest = "dst", type = str, nargs = "?", required = True )
    parser.add_argument( '-t', dest = "map", type = str, nargs = "?", required = True )
    parser.add_argument( '-f', dest = "full", type = str, nargs = "?" )
    parser.add_argument( '-e', dest = "entry", type = int, required = True )
    parser.add_argument( '-c', dest = "codec", type = int, required = True )
    
    args = parser.parse_args()            

    if args.mode == "u":
        DecodeImage( args.src , args.dst , args.map , args.entry , args.codec )
    elif args.mode == "p":
        EncodeImage( args.src , args.dst , args.map, args.full , args.entry , args.codec )
    