@echo off

echo "Unpacking 000_tileset"
REM python tool_tilemap.py -m u -s "asm_title_000/000_tileset.bin" -d "asm_title_000/000_0_image.bin" -e 0 -c 8
REM python tool_tilemap.py -m u -s "asm_title_000/000_tileset.bin" -d "asm_title_000/000_1_image.bin" -e 1 -c 8
REM python tool_tilemap.py -m u -s "asm_title_000/000_tileset.bin" -d "asm_title_000/000_2_image.bin" -e 17 -c 8
REM python tool_tilemap.py -m u -s "asm_title_000/000_tileset.bin" -d "asm_title_000/000_3_image.bin" -e 18 -c 8


REM echo "Unpacking 001_tileset"
REM python tool_tilemap.py -m u -s "asm_title_001/001_tileset.bin" -d "asm_title_001/001_0_image.bin" -e 2 -c 8
REM python tool_tilemap.py -m u -s "asm_title_001/001_tileset.bin" -d "asm_title_001/001_1_image.bin" -e 3 -c 8
REM python tool_tilemap.py -m u -s "asm_title_001/001_tileset.bin" -d "asm_title_001/001_2_image.bin" -e 4 -c 8
rem python tool_tilemap.py -m u -s "asm_title_001/001_tileset.bin" -d "asm_title_001/001_3_image.bin" -e 19 -c 8

REM echo "Unpacking 002_tileset"
REM python tool_tilemap.py -m u -s "asm_title_002/002_tileset.bin" -d "asm_title_002/002_0_image.bin" -e 5 -c 4
python tool_tilemap.py -m u -s "asm_title_002/002_tileset.bin" -d "asm_title_002/002_1_image.bin" -e 6 -c 4
python tool_tilemap.py -m u -s "asm_title_002/002_tileset.bin" -d "asm_title_002/002_2_image.bin" -e 7 -c 4
python tool_tilemap.py -m u -s "asm_title_002/002_tileset.bin" -d "asm_title_002/002_3_image.bin" -e 8 -c 4