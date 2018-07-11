@echo off

echo "Packing 000_tileset"

copy /B/Y "asm_game_parm_001\001_000.bin" "asm_game_parm_001\001_000_novo.bin"
copy /B/Y "asm_game_parm_001\001_001.bin" "asm_game_parm_001\001_001_novo.bin"
rem concatena as imagens para criar um tileset full
copy /B/Y "asm_game_parm_000\000_001_image.bin"+"asm_game_parm_000\000_000_image_traduzida.bin" "asm_game_parm_000\000_image_full.bin"

pypy tool_tilemap.py -m p -s "asm_game_parm_000/000_001_image.bin" -d "asm_game_parm_000/000_001_tileset_novo.bin" -t "asm_game_parm_001\001_001_novo.bin" -f "asm_game_parm_000/000_image_full.bin" -e 0 -c 4
pypy tool_tilemap.py -m p -s "asm_game_parm_000/000_000_image_traduzida.bin" -d "asm_game_parm_000/000_000_tileset_novo.bin" -t "asm_game_parm_001\001_000_novo.bin" -f "asm_game_parm_000/000_image_full.bin" -e 0 -c 4