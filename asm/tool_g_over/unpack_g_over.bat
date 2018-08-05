@echo off

pypy tool_g_over.py -m u -s "old\g_over.bin" -d "old_g_over"

REM pypy cl-comp.py -i "old_g_over\001.bin" -o "old_g_over/001_descomprimido.bin" -m d -t lz10
REM pypy cl-comp.py -i "old_g_over\003.bin" -o "old_g_over/003_descomprimido.bin" -m d -t lz10
