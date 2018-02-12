#!/usr/bin/env python
# -*- coding: windows-1252 -*-

# author: diego.hahn
#

import os
import struct
import sys
import array

def vertical(buffer, codec):
    c = ''
    if codec == 4:
        for y in range(8)[::-1]:
            c += buffer[4*y:4*(y+1)]    
    else:
        for y in range(8)[::-1]:
            c += buffer[8*y:8*(y+1)]
    return c

def horizontal(buffer, codec):
    c = ''
    if codec == 4:
        for y in range(8):
            reverse = buffer[4*y:4*(y+1)][::-1]
            for w in range(4):
                c += chr((ord(reverse[w]) << 4 | ord(reverse[w]) >> 4) & 0xFF)    
    else:
        for y in range(8):
            reverse = buffer[8*y:8*(y+1)][::-1]
            for w in range(8):
                c += reverse[w]
    return c
    
def diagonal(buffer, codec):
    return horizontal(vertical(buffer, codec), codec)

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

def reduce_tilesdict( tilesdict,codec ):
    offset = 0 
    reduced_tilesdict = dict()
    for x in tilesdict: 
        if reduced_tilesdict.has_key(tilesdict[x]):
            continue
        elif reduced_tilesdict.has_key(horizontal(tilesdict[x],codec)):
            continue
        elif reduced_tilesdict.has_key(vertical(tilesdict[x],codec)):
            continue
        elif reduced_tilesdict.has_key(diagonal(tilesdict[x],codec)):
            continue                        
        else:
            reduced_tilesdict.update({tilesdict[x]:offset})
            offset += 1 
    # inverte o dicionário
    ret = dict()
    for k,v in reduced_tilesdict.items():
        ret.update({v:k})
            
    return ret 

def EncodeImage( src, dst, tmmap, codec, **kwargs ):
    assert os.path.isfile(src), "Invalid tileset file"    
    assert os.path.isfile(tmmap), "Invalid tilemap file"

    assert codec == 4 or codec == 8, "Invalid codec"
       
    flags = kwargs.get("flags", 0)       
       
    # Tilemap params
    tmoffs = kwargs.get("tmoffs", 0 )
    tmaddr = kwargs.get("tmaddr", 0 )
    tmsize = kwargs.get("tmsize", os.path.getsize(tmmap))
    assert (tmaddr + tmsize) <= os.path.getsize(tmmap) , "Out of range" 
    
    # Tileset params
    tsaddr = kwargs.get("tsaddr", 0)
    tssize = kwargs.get("tssize", os.path.getsize(src))
    tsfull = kwargs.get("tsfull", "")
    assert (tsaddr + tssize) <= os.path.getsize(src) , "Out of range" 

    if tsfull:    
        assert os.path.isfile(tsfull), "Invalid full tileset file"
        # Monta o tileset a partir da imagem full (concatenação de todas as imagens)
        with open( tsfull, "rb" ) as fd :    
            tilesdict = create_tilesdict( fd.read() , codec )
            # Simplifica o dicionário de tiles para apenas tiles únicos
            if not ( flags & (1<<0) ):
                reduced_td = reduce_tilesdict(tilesdict,codec)
            else:
                reduced_td = tilesdict                
            
            # Monta o tileset
            tileset = array.array("c")
            out = open( dst, "wb" )
            for i in range(len(reduced_td)):
                tileset.extend(reduced_td[i])
                out.write(reduced_td[i]) 
            out.close()
    else:
        with open( src, "rb" ) as fd :
            tilesdict = create_tilesdict( fd.read() , codec )
            # Simplifica o dicionário de tiles para apenas tiles únicos
            if not ( flags & (1<<0) ):
                reduced_td = reduce_tilesdict(tilesdict,codec)
            else:
                reduced_td = tilesdict
            
            # Monta o tileset
            tileset = array.array("c")
            out = open( dst, "wb" )
            for i in range(len(reduced_td)):
                tileset.extend(reduced_td[i])
                out.write(reduced_td[i]) 
            out.close()
                        
    with open( src, "rb" ) as fd:
        #fd.seek( tsaddr )
        tilesdict = create_tilesdict( fd.read() , codec )
    
        # Monta o tilemap -  a informação da paleta de cores vem do tilemap original
        tilemap = list()
        val = reduced_td.values()
        for i in range(len(tilesdict)):
            if tilesdict[i] in val:
                tilemap.append( 0x0000 | val.index(tilesdict[i]))
            elif horizontal(tilesdict[i],codec) in val:
                tilemap.append( 0x0400 | val.index(horizontal(tilesdict[i], codec)))
            elif vertical(tilesdict[i],codec) in val:
                tilemap.append( 0x0800 | val.index(vertical(tilesdict[i], codec)))
            elif diagonal(tilesdict[i],codec) in val:
                tilemap.append( 0x0C00 | val.index(diagonal(tilesdict[i], codec)))   
            else:
                raise Exception
                sys.exit(1)
    
    # Atualiza o tilemap
    with open(tmmap, "r+b") as fd:
        fd.seek( tmaddr )
        
        palette = []
        for i in range(tmsize/2):
            palette.append(struct.unpack("<H", fd.read(2))[0] & 0xF000)

        fd.seek( tmaddr )
        for i in range(tmsize/2):
            fd.write(struct.pack("<H", palette[i] | (tilemap[i] + tmoffs )))

def DecodeImage( src, dst, tmmap, codec, **kwargs ):
    assert os.path.isfile(src), "Invalid tileset file"    
    assert os.path.isfile(tmmap), "Invalid tilemap file"

    assert codec == 4 or codec == 8, "Invalid codec"
        
    flags = kwargs.get("flags", 0)
    
    # Tilemap params
    tmoffs = kwargs.get("tmoffs", 0 )
    tmaddr = kwargs.get("tmaddr", 0 )
    tmsize = kwargs.get("tmsize", os.path.getsize(tmmap))
    print tmaddr , tmsize , os.path.getsize(tmmap)
    assert (tmaddr + tmsize) <= os.path.getsize(tmmap) , "Out of range" 
    
    # Tileset params
    tsaddr = kwargs.get("tsaddr", 0)
    tssize = kwargs.get("tssize", os.path.getsize(src))
    if tssize == 0 : tssize = os.path.getsize(src)
    print tsaddr , tssize , os.path.getsize(src)
    assert (tsaddr + tssize) <= os.path.getsize(src) , "Out of range" 
   
    # tsfull = kwargs.get("tsfull", src)
    # tsfadd = kwargs.get("tsfadd", 0)
    # tsfsiz = kwargs.get("tsfsiz", os.path.getsize(tsfull))
    # assert os.path.isfile(tsfull), "Invalid full tileset file"    

    # Verifica se existe o caminho do arquivo destino
    p = os.path.dirname(dst)
    if not os.path.isdir(p):
        os.makedirs(p)
    
    # Leitura do tilemap
    with open( src, "rb" ) as fd:
        fd.seek(tsaddr)
        tilesdict = create_tilesdict( fd.read(tssize) , codec )
        
    with open( tmmap, "rb") as fd:
        fd.seek(tmaddr)        
        tmsize = tmsize/2
        
        out = open( dst, "wb" )
        for _ in range( tmsize ):
            key = struct.unpack( "<H" , fd.read(2))[0]           
            
            # TODO - Imagens com multiplas paletas
            key &= 0xFFF
            
            if (key & 0xC00) == 0xC00 :
                out.write(diagonal(tilesdict[(key & 0x3FF) - tmoffs], codec))
            elif (key & 0x800) == 0x800:
                out.write(vertical(tilesdict[(key & 0x3FF) - tmoffs], codec))
            elif (key & 0x400) == 0x400:
                out.write(horizontal(tilesdict[(key & 0x3FF) - tmoffs], codec))
            else:
                out.write(tilesdict[(key & 0x3FF) - tmoffs])     
                
        out.close()

def hex_int( x ):
    return int(x, 16)
        
if __name__ == "__main__":
    
    import argparse
    
    os.chdir( sys.path[0] )
    #os.system( 'cls' )

    parser = argparse.ArgumentParser()
    parser.add_argument( '-m', dest = "mode", type = str, required = True )
    #parser.add_argument( '-s', dest = "src", type = str, nargs = "?", required = True )
    parser.add_argument( '-f', dest = "file", type = str, nargs = "?", required = True )

    parser.add_argument( '-c', dest = "codec", type = int, required = True )
    
    parser.add_argument( '-tsf', dest = "tsfile", type = str, nargs = "?", required = True )
    parser.add_argument( '-tsa', dest = "tsaddr", type = hex_int, default = 0 )
    parser.add_argument( '-tss', dest = "tssize", type = int, default = 0 )
    parser.add_argument( '-tsF', dest = "tsfull", type = str, nargs = "?", default = "" )
    
    # Argumentos tilemap
    parser.add_argument( '-tmf', dest = "tmfile", type = str, nargs = "?", required = True )
    parser.add_argument( '-tma', dest = "tmaddr", type = hex_int, default = 0 )
    parser.add_argument( '-tmo', dest = "tmoffs", type = int, default = 0 )    
    parser.add_argument( '-tms', dest = "tmsize", type = int, default = 0 )
    
    # Dont reduce
    parser.add_argument( '-odr', dest = "optdre", action="store_true" )
    # Ignore blank tiles
    parser.add_argument( '-oib', dest = "optibl", action="store_true" )

    
    args = parser.parse_args()            
    
    flags = (args.optdre << 0) | (args.optibl << 1)

    if args.mode == "u":
        DecodeImage( args.tsfile , args.file , args.tmfile , args.codec , tsaddr = args.tsaddr , tssize = args.tssize , tmaddr = args.tmaddr , tmsize = args.tmsize , tmoffs = args.tmoffs , tsfull = args.tsfull , flags = flags )
    elif args.mode == "p":
        EncodeImage( args.file , args.tsfile , args.tmfile , args.codec , tsaddr = args.tsaddr , tssize = args.tssize , tmaddr = args.tmaddr , tmsize = args.tmsize , tmoffs = args.tmoffs , tsfull = args.tsfull , flags = flags )
    