@echo off

echo "Unpacking 000 tilesets"
pypy tool_tilemap.py -m u -t "asm_game_parm_001\001_000.bin" -s "asm_game_parm_000\000.bin" -d "asm_game_parm_000\000_000_image.bin" -e 0 -c 4
pypy tool_tilemap.py -m u -t "asm_game_parm_001\001_001.bin" -s "asm_game_parm_000\000.bin" -d "asm_game_parm_000\000_001_image.bin" -e 0 -c 4

