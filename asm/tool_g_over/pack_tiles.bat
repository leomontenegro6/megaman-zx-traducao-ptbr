@echo off

copy /B/Y "tilemap_general.bin" "tilemap_general_novo.bin"
xcopy /S/Y "old_elf" "new_elf\"

echo "Packing 004_tileset"
rem concatena as imagens para criar um tileset full
pypy tool_tilemap.py -m p -s "asm_elf_004_002/002_image.bin" -d "new_elf/ptr_table_1/004/002.bin" -f "asm_elf_004_002/002_image.bin" -e 7 -c 4
pypy tool_tilemap.py -m p -s "asm_elf_004_001/001_image.bin" -d "new_elf/ptr_table_1/004/001.bin" -f "asm_elf_004_001/001_image.bin" -e 6 -c 4

pypy cl-comp.py -i "tilemap_general_novo.bin" -o "new_elf/ptr_table_1/005.bin" -m c -t lz10
