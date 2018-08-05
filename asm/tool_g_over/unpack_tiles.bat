@echo off

echo "Unpacking 000 tilesets"
pypy tool_tilemap.py -m u -t "asm_g_over_001\001_000.bin" -s "asm_g_over_000\000.bin" -d "asm_g_over_000\000_000_image.bin" -e 0 -c 8
pypy tool_tilemap.py -m u -t "asm_g_over_001\001_001.bin" -s "asm_g_over_000\000.bin" -d "asm_g_over_000\000_001_image.bin" -e 0 -c 8
pypy tool_tilemap.py -m u -t "asm_g_over_001\001_002.bin" -s "asm_g_over_000\001.bin" -d "asm_g_over_000\001_000_image.bin" -e 0 -c 8
