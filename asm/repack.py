#!/usr/bin/env python
# -*- coding: windows-1252 -*-

''' Script para fazer o repack da rom '''

import os
import re
import array
import struct
import math

FILENAME = "0484 RockMan ZX (JP).nds"
PATH = "ROCKMANZX"

counter = 0xf000
files_counter = 0
fat_files = []
fnt_files = []
ovly_files = []

def Crc16(string):
	polynomial = 0xA001
	
	table = array.array('H')
	#Geração dos polinômios
	for byte in range(256):
		crc = 0
		for bit in range(8):
			if (byte ^ crc) & 1:
				crc = (crc >> 1) ^ polynomial
			else:
				crc >>= 1
			byte >>= 1
		table.append(crc)

	#Cálculo do CHECKSUM
	crc = 0xffff
	for x in string:
		crc = (crc >> 8) ^ table[(crc ^ ord(x)) & 0xff]
		
	return crc

class Folder(list):
    def __init__( self , root , id , parent ):
        list.__init__([])
        self.root = root
        self.num_dir = 0
        self.num_parent = parent
        self.num_id = id
        
class File:
    def __init__( self , path , address ):
        self.path = path
        self.length = os.path.getsize(path)
        self.address = address

def mktree( path , parent ):
    global counter 
    folder = Folder( os.path.basename(path) , counter , parent )
    counter += 1
    
    # FAT 
    data = sorted(os.listdir( path ) ) 
    for d in data:
        fullpath = os.path.join(path, d)
        if not os.path.isdir( fullpath ):
            fat_files.append( File( fullpath, -1 ) )
            #folder.append( d )          
    
    # FNT
    data = sorted(os.listdir( path ), key = lambda v : v.lower() ) 
    # Processa primeiro os arquivos   
    for d in data:
        fullpath = os.path.join(path, d)
        if not os.path.isdir( fullpath ):
            fnt_files.append( File( fullpath, -1 ) )
            folder.append( d )                  
    # Em seguida processa os diretórios
    for d in data:
        if d == "FSI.CT": # Única pasta que deve ser ignorada
            continue    
        fullpath = os.path.join(path, d)        
        if os.path.isdir( fullpath ):
            child = mktree( fullpath , folder.num_id )
            folder.append( child )
            folder.num_dir += ( child.num_dir + 1 )    
            
    return folder

def mktblname( data , table , dirtree ):
    global files_counter

    folders = []
        
    if dirtree.num_id == 0xf000 :
        # 3.2 - Cálculo do offset .. 8 bytes para cada entrada
        table.extend( struct.pack( "<L" ,  ( 1 + dirtree.num_dir ) * 8 ) )
        table.extend( struct.pack( "<H" ,  files_counter ) )        
        table.extend( struct.pack( "<H" ,  ( 1 + dirtree.num_dir ) ) )
    else:
        table.extend( struct.pack( "<L" ,  struct.unpack( "<L" , table[:4] )[0] + len(data) ) )
        table.extend( struct.pack( "<H" ,  files_counter ) )        
        table.extend( struct.pack( "<H" ,  dirtree.num_parent ) )          
    
    for d in dirtree:
        if isinstance( d, Folder ):
            data.extend( struct.pack( "B", 0x80 | len(d.root) ) )
            data.extend( d.root )
            data.extend( struct.pack( "<H", d.num_id ) )
            folders.append( d )
        else:
            data.extend( struct.pack( "B", 0x00 | len(d) ) )
            data.extend( d )
            files_counter += 1
    data.extend( "\0" )     

    for d in folders:
        mktblname( data, table, d )

MAIN_FILES = [  "ndsheader.bin" ,
                "arm9.bin" ,
                "arm9ovltable.bin" ,
                "arm7.bin" ,
                "arm7ovltable.bin" ,
                "fnt.bin" ,
                "fat.bin" ,
                "banner.bin" ]

if __name__ == "__main__":
        
    # Procura pela pasta FSI.CT
    fsict = os.path.join( PATH , "FSI.CT" )
    if not os.path.isdir( fsict ):
        raise Exception("Not a CT2 dump")
           
    # Procura pelo arquivo principais
    for f in MAIN_FILES:
        if not os.path.isfile( os.path.join( fsict , f ) ):
            raise Exception( "Missing %s file" % f )
            
    with open( FILENAME, "w+b" ) as fd:
        # Grava o arquivo "ndsheader.bin"
        with open( os.path.join( fsict , "ndsheader.bin" ), "rb" ) as t:
            fd.write( t.read() )
            fd.write( "\0" * (fd.tell() % 0x4000))
            
        # Grava o arquivo "arm9.bin"
        with open( os.path.join( fsict , "arm9.bin" ), "rb" ) as t:
            addr_arm9 = fd.tell()
            fd.write( t.read() )
            size_arm9 = fd.tell() - addr_arm9
            if ( fd.tell() % 0x200 ) != 0:
                fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )

        # Grava o arquivo "arm9ovltable.bin"
        with open( os.path.join( fsict , "arm9ovltable.bin" ), "rb" ) as t:
            addr_arm9ovltable = fd.tell()
            fd.write( t.read() )
            size_arm9ovltable = fd.tell() - addr_arm9ovltable
            if ( fd.tell() % 0x200 ) != 0:
                fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )
            
        # Grava os overlays9
        total_overlay9 = os.path.getsize( os.path.join( fsict , "arm9ovltable.bin" ) ) / 32
        for f in range(total_overlay9):
            path = os.path.join( fsict , "overlay9_%04d.bin" % f )
            with open( path , "rb" ) as t:
                ovly_files.append( File( path , fd.tell() ) )
                fd.write( t.read() )
                if ( fd.tell() % 0x200 ) != 0:
                    fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )
                files_counter += 1
                        
        print "Total overlay9 ",total_overlay9       
        
        # Grava o arquivo "arm7.bin"
        with open( os.path.join( fsict , "arm7.bin" ), "rb" ) as t:
            addr_arm7 = fd.tell()
            fd.write( t.read() )
            size_arm7 = fd.tell() - addr_arm7
            if ( fd.tell() % 0x200 ) != 0:
                fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )        

        # Grava o arquivo "arm7ovltable.bin"
        with open( os.path.join( fsict , "arm7ovltable.bin" ), "rb" ) as t:
            addr_arm7ovltable = fd.tell()
            fd.write( t.read() )
            size_arm7ovltable = fd.tell() - addr_arm7ovltable
            if ( fd.tell() % 0x200 ) != 0:
                fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )        
        
        total_overlay7 = os.path.getsize( os.path.join( fsict , "arm7ovltable.bin" ) ) / 32
        for f in range(total_overlay7):
            path = os.path.join( fsict , "overlay7_%04d.bin" % f )
            with open( path , "rb" ) as t:
                ovly_files.append( File( path , fd.tell() ) )
                fd.write( t.read() )
                if ( fd.tell() % 0x200 ) != 0:
                    fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )
                files_counter += 1
 
        print "Total overlay7 ", total_overlay7
            
        # Segunda parte: criação da árvore de diretórios
        dirtree = mktree(PATH, counter)
        
        # Terceira parte: iteração em cima da árvore criada
        # 3.1 - Quantos diretórios? (não esquecer que o root é +1)
        print "Total folders (without root) ", dirtree.num_dir 
            
        # 3.3 - Criação do nome dos arquivos
        names = array.array("c")
        table = array.array("c")
        mktblname( names , table , dirtree )
        
        fnt = array.array("c")
        fnt.extend( table )
        fnt.extend( names )
        
        # Grava a nova fnt
        addr_fnt = fd.tell()
        fnt.tofile(fd)
        size_fnt = fd.tell() - addr_fnt
        if ( fd.tell() % 0x200 ) != 0:
            fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )

        # Grava a fat "fake"
        addr_fat = fd.tell()
        fd.write( "\0" * ( files_counter * 8 ) )
        size_fat = fd.tell() - addr_fat
        if ( fd.tell() % 0x200 ) != 0:
            fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )

        # Grava o arquivo "banner.bin"
        with open( os.path.join( fsict , "banner.bin" ), "rb" ) as t:
            addr_banner = fd.tell()
            fd.write( t.read() )
            size_banner = fd.tell() - addr_banner
            if ( fd.tell() % 0x200 ) != 0:
                fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )                
                
        # Grava os arquivos:
        for f in fat_files:
            with open( os.path.join( f.path ), "rb" ) as t:
                f.address = fd.tell()
                fd.write( t.read() )
                if ( fd.tell() % 0x200 ) != 0:
                    fd.write( "\0" * (0x200 - (fd.tell() % 0x200)) )     

        # Atualiza endereços dos objetos
        for f in fnt_files:
            for d in fat_files:
                if f.path == d.path:
                    f.address = d.address
                    break
        
        # Atualiza a fat:
        files = ovly_files + fnt_files
        fd.seek( addr_fat )
        for f in files:
            fd.write( struct.pack( "<L" , f.address ) )
            fd.write( struct.pack( "<L" , f.address + f.length ) )

        # Padding final
        fd.seek( 0, 2)
        romsize = fd.tell()
        print "Rom size ", romsize
        padding = 2**int(math.log(romsize,2)+1) - romsize
        # fd.write( "\0" * padding )
        
        # Atualização dos endereços
        fd.seek( 0x20 )
        fd.write( struct.pack( "<L" , addr_arm9 ) )
        fd.seek( 0x2c )
        fd.write( struct.pack( "<L" , size_arm9 - 12 ) )
        fd.seek( 0x30 )
        fd.write( struct.pack( "<L" , addr_arm7 ) )
        fd.seek( 0x3c )
        fd.write( struct.pack( "<L" , size_arm7 ) )

        fd.write( struct.pack( "<L" , addr_fnt ) )
        fd.write( struct.pack( "<L" , size_fnt ) )
        fd.write( struct.pack( "<L" , addr_fat ) )
        fd.write( struct.pack( "<L" , size_fat ) )      

        fd.write( struct.pack( "<L" , addr_arm9ovltable ) )
        fd.write( struct.pack( "<L" , size_arm9ovltable ) )
        
        if size_arm7ovltable > 0:
            fd.write( struct.pack( "<L" , addr_arm7ovltable ) )
            fd.write( struct.pack( "<L" , size_arm7ovltable ) )  
        else:
            fd.write( struct.pack( "<L" , 0 ) )
            fd.write( struct.pack( "<L" , 0 ) )          

        fd.seek( 0x68 )        
        fd.write( struct.pack( "<L" , addr_banner ) )  
        
        fd.seek(0x80, 0)
        fd.write(struct.pack('<L', romsize))
        
        # CRC
        fd.seek( 0, 0 )
        crc = Crc16(fd.read(0x15E))

        fd.seek( 0x15e, 0 )
        fd.write( struct.pack( "<H" , crc ) )
      
        
        
    