@echo off

copy /B/Y "tilemap_general.bin" "tilemap_general_novo.bin"

echo "Packing 000_tileset"
rem concatena as imagens para criar um tileset full
copy /B/Y "asm_title_000\000_3_image.bin"+"asm_title_000\000_2_image.bin"+"asm_title_000\000_1_image.bin"+"asm_title_000\000_0_image.bin" "asm_title_000\000_image_full.bin"
python tool_tilemap.py -m p -s "asm_title_000/000_0_image.bin" -d "asm_title_000/000_tileset_novo.bin" -f "asm_title_000/000_image_full.bin" -e 0 -c 8
python tool_tilemap.py -m p -s "asm_title_000/000_1_image.bin" -d "asm_title_000/000_tileset_novo.bin" -f "asm_title_000/000_image_full.bin" -e 1 -c 8
python tool_tilemap.py -m p -s "asm_title_000/000_2_image.bin" -d "asm_title_000/000_tileset_novo.bin" -f "asm_title_000/000_image_full.bin" -e 17 -c 8
python tool_tilemap.py -m p -s "asm_title_000/000_3_image.bin" -d "asm_title_000/000_tileset_novo.bin" -f "asm_title_000/000_image_full.bin" -e 18 -c 8

REM echo "Packing 001_tileset"
REM rem concatena as imagens para criar um tileset full
REM copy /B/Y "asm_title_001\001_2_image.bin"+"asm_title_001\001_1_image.bin"+"asm_title_001\001_0_image.bin" "asm_title_001\001_image_full.bin"
REM python tool_tilemap.py -m p -s "asm_title_001/001_0_image.bin" -d "asm_title_001/001_tileset_novo.bin" -f "asm_title_001/001_image_full.bin" -e 2 -c 8
REM python tool_tilemap.py -m p -s "asm_title_001/001_1_image.bin" -d "asm_title_001/001_tileset_novo.bin" -f "asm_title_001/001_image_full.bin" -e 3 -c 8
REM python tool_tilemap.py -m p -s "asm_title_001/001_2_image.bin" -d "asm_title_001/001_tileset_novo.bin" -f "asm_title_001/001_image_full.bin" -e 4 -c 8

REM echo "Packing 002_tileset"
REM rem concatena as imagens para criar um tileset full
REM copy /B/Y "asm_title_002\002_0_image.bin" "asm_title_002\002_image_full.bin"
REM python tool_tilemap.py -m p -s "asm_title_002/002_0_image.bin" -d "asm_title_002/002_tileset_novo.bin" -f "asm_title_002/002_image_full.bin" -e 5 -c 4
