@echo off

xcopy /S/Y "old_g_over" "new_g_over\"

echo "Packing 000_tileset"

copy /B/Y "asm_g_over_000\000_000_image.bin"+"asm_g_over_000\000_001_image.bin" "asm_g_over_000\000_tileset_full.bin"
rem concatena as imagens para criar um tileset full
pypy tool_tilemap.py -m p -s "asm_g_over_000/000_000_image.bin" -d "asm_g_over_000/000.bin" -t "asm_g_over_001\001_000.bin"  -f "asm_g_over_000/000_tileset_full.bin" -e 0 -c 8
pypy tool_tilemap.py -m p -s "asm_g_over_000/000_001_image.bin" -d "asm_g_over_000/000.bin" -t "asm_g_over_001\001_001.bin"  -f "asm_g_over_000/000_tileset_full.bin" -e 0 -c 8

REM pypy cl-comp.py -i "tilemap_general_novo.bin" -o "new_elf/ptr_table_1/005.bin" -m c -t lz10
