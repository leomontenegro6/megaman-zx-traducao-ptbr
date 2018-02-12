@echo off

xcopy /S/Y "old_sub" "new_sub\"

xcopy /Y/F "new_sub\ptr_table_1\001.bin" "asm_sub_000_001\001_tm_teste1.bin"

REM rem Cria o tileset sem o avatar
pypy tool_tilemap.py -m p -f "asm_sub_000_001\001_image_sem_avatar.bin" -tsf "asm_sub_000_001\001_ts_sem_avatar.bin" -c 8 -tsa 0x0 -tmf "asm_sub_000_001\001_tm_teste1.bin" -tma 0x83c -tms 2048 -tmo 0

REM rem Concatena tileset original e avatar
copy /B/Y "asm_sub_000_001\001_ts_sem_avatar.bin"+"asm_sub_000_001\001_image_apenas_avatar.bin" "asm_sub_000_001\001_tileset_full.bin"

rem Gera o tilemap da imagem completa
pypy tool_tilemap.py -m p -f "asm_sub_000_001\001_image.bin" -tsf "new_sub\ptr_table_1\000\001.bin" -tsF "asm_sub_000_001\001_tileset_full.bin" -c 8 -tsa 0x0 -tmf "new_sub\ptr_table_1\001.bin" -tma 0x83c -tms 2048 -tmo 0 -odr -oib
rem pypy tool_tilemap.py -m p -f "asm_sub_000_002\002_image.bin" -tsf "new_sub\ptr_table_1\000\002.bin" -c 8 -tsa 0x0 -tmf "new_sub\ptr_table_1\001.bin" -tma 0x1044 -tms 2048 -tmo 512