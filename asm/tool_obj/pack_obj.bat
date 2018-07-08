@echo off

xcopy /S/Y "old_obj_fnt" "new_obj_fnt\"
xcopy /S/Y "old_obj_dat" "new_obj_dat\"

call run_asm.bat
pypy tool_obj.py -m p -s1 "new_obj_dat" -d1 "new\obj_dat.bin" -s2 "new_obj_fnt" -d2 "new\obj_fnt.bin"