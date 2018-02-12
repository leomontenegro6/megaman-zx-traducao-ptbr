@echo off

call pack_tiles.bat
python tool_sub.py -m p -s "new_sub" -d "new\sub.bin"