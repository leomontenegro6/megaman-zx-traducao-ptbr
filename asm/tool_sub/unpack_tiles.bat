@echo off

echo "Unpacking 004 tilesets"


rem pypy tool_tilemap.py -m u -s "old_sub/ptr_table_1/000/001.bin" -d "asm_sub_000_001/001_image.bin" -e 0 -c 8 -o 0
pypy tool_tilemap.py -m u -s "old_sub/ptr_table_1/000/002.bin" -d "asm_sub_000_002/002_image.bin" -e 0 -c 8 -o 512
