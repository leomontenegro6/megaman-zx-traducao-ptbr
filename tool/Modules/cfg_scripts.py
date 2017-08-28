'''
Created on 05/03/2013

@author: diego.hahn
'''

import os.path
import sys

python_path = os.path.dirname( sys.executable )
packages_path = os.path.join( python_path , r"Lib\site-packages" )

scripts_path = os.path.dirname( os.path.abspath( __file__ ) )

libs = [r"" , r"rhCompression", r"rhImages", r"pytable"]

with open( os.path.join( packages_path , "mylibs.pth" ), "w" ) as pth:
    for lib in libs:
        lib_path = os.path.join( scripts_path, lib )
        if os.path.isdir( lib_path ):
            print( ">>> Adding %s to pth file" % lib )
            pth.write( "%s\n" % lib_path )

