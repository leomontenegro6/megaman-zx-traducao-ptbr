@echo off

echo "Unpacking 004 tilesets"
python tool_tilemap.py -m u -s "old_elf/ptr_table_1/004/001.bin" -d "asm_elf_004_001/001_image.bin" -e 6 -c 4
python tool_tilemap.py -m u -s "old_elf/ptr_table_1/004/002.bin" -d "asm_elf_004_002/002_image.bin" -e 7 -c 4
