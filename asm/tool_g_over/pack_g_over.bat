@echo off

call pack_tiles.bat
python tool_g_over.py -m p -s "new_g_over" -d "new\g_over.bin"