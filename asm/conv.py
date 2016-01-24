#!/usr/bin/env python
# -*- coding: windows-1252 -*-

''' Script para converter o dump de memória do no$gba em binário '''

import sys
with open( "dump.b" , 'rb' ) as fd:

    out = open( "dump.bin", 'wb' )

    while True:
    
        _addr = fd.read( 8 ) # Endereço
        if len( _addr ) != 8:
            out.close()
            sys.exit(1)
            
        fd.seek( 1, 1 )        
        # Hex
        _hex = fd.read( 47 )
        if len( _hex ) != 47:
            out.close()
            sys.exit(1)        
        
        fd.seek( 2, 1 )
        # Ascii
        _ascii = fd.read( 16 )
        if len( _ascii ) != 16:
            out.close()
            sys.exit(1)        
        
        fd.seek( 3, 1 )        
        out.write( ''.join( map( lambda x : chr(int(x, 16) ) , _hex.split( ' ' ) ) ) )
        
        
    