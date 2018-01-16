@echo off

call pack_tiles.bat
python tool_elf.py -m p -s "new_elf" -d "new\elf.bin"