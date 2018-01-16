@echo off

cls

echo "Assembling arm9.bin"
cd subtitles
..\armips.exe subtitles.asm
cd .. 
copy "subtitles\arm9.bin" "ROM Original\ROCK\arm9.bin" /B/Y

echo "Assembling obj_dat.bin and obj_fnt.bin"
cd tool_obj
call run_asm.bat
call pack_obj.bat
cd ..
copy "tool_obj\new\obj_fnt.bin" "ROM Original\ROCK\data\obj_fnt.bin" /B/Y
copy "tool_obj\new\obj_dat.bin" "ROM Original\ROCK\data\obj_dat.bin" /B/Y

cd tool_title
call pack_title.bat
cd..
copy "tool_title\new\title.bin" "ROM Original\ROCK\data\title.bin" /B/Y

cd tool_elf
call pack_elf.bat
cd..
copy "tool_elf\new\elf.bin" "ROM Original\ROCK\data\elf.bin" /B/Y 

echo "Repacking rom"
cd "ROM Original"
call empacotar_rom.bat
cd ..
