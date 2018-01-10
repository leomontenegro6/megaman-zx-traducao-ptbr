@echo off

call pack_tiles.bat
python tool_title.py -m p -s "new_title" -d "new\title.bin"