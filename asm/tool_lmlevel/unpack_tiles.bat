@echo off

echo "Unpacking 000 tilesets"
pypy tool_tilemap.py -m u -t "asm_lmlevel_001\001_000.bin" -s "asm_lmlevel_000\000.bin" -d "asm_lmlevel_000\000_000_image.bin" -e 0 -c 4
pypy tool_tilemap.py -m u -t "asm_lmlevel_001\001_001.bin" -s "asm_lmlevel_000\000.bin" -d "asm_lmlevel_000\000_001_image.bin" -e 0 -c 4
pypy tool_tilemap.py -m u -t "asm_lmlevel_001\001_002.bin" -s "asm_lmlevel_000\000.bin" -d "asm_lmlevel_000\000_002_image.bin" -e 0 -c 4
pypy tool_tilemap.py -m u -t "asm_lmlevel_001\001_003.bin" -s "asm_lmlevel_000\000.bin" -d "asm_lmlevel_000\000_003_image.bin" -e 0 -c 4

