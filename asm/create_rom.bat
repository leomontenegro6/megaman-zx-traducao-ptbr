@echo off

cls

echo "Assembling arm9.bin"
cd subtitles
..\armips.exe subtitles.asm
cd .. 

rem Copia o arm9 alterado e as legendas geradas
copy "subtitles\arm9.bin" "ROM Modificada\ROCK\arm9.bin" /B/Y
copy "subtitles\ptbr\mm00_br.bin" "ROM Modificada\ROCK\data\mm00_br.bin" /B/Y
copy "subtitles\ptbr\mm01_br.bin" "ROM Modificada\ROCK\data\mm01_br.bin" /B/Y
copy "subtitles\ptbr\mm02_br.bin" "ROM Modificada\ROCK\data\mm02_br.bin" /B/Y
copy "subtitles\ptbr\mm03_br.bin" "ROM Modificada\ROCK\data\mm03_br.bin" /B/Y
copy "subtitles\ptbr\mm05_br.bin" "ROM Modificada\ROCK\data\mm05_br.bin" /B/Y
copy "subtitles\ptbr\mm06_br.bin" "ROM Modificada\ROCK\data\mm06_br.bin" /B/Y

echo "Assembling obj_dat.bin and obj_fnt.bin"
cd tool_obj
call pack_obj.bat
cd ..
copy "tool_obj\new\obj_fnt.bin" "ROM Modificada\ROCK\data\obj_fnt.bin" /B/Y
copy "tool_obj\new\obj_dat.bin" "ROM Modificada\ROCK\data\obj_dat.bin" /B/Y

REM copy "tool_obj\obj_fnt.bin" "ROM Modificada\ROCK\data\obj_fnt.bin" /B/Y
REM copy "tool_obj\obj_dat.bin" "ROM Modificada\ROCK\data\obj_dat.bin" /B/Y

cd tool_title
call pack_title.bat
cd..
copy "tool_title\new\title.bin" "ROM Modificada\ROCK\data\title.bin" /B/Y

cd tool_elf
call pack_elf.bat
cd..
copy "tool_elf\new\elf.bin" "ROM Modificada\ROCK\data\elf.bin" /B/Y 

cd tool_sub
call pack_sub.bat
cd..
copy "tool_sub\new\sub.bin" "ROM Modificada\ROCK\data\sub.bin" /B/Y 

copy "tool_game_parm\new\game_parm.bin" "ROM Modificada\ROCK\data\game_parm.bin" /B/Y 

rem Copia os binários commitados pelo Solid One
copy "..\graficos\face.bin" "ROM Modificada\ROCK\data\face.bin" /B/Y 
copy "..\graficos\font_pal.bin" "ROM Modificada\ROCK\data\font_pal.bin" /B/Y 
copy "..\graficos\g_back.bin" "ROM Modificada\ROCK\data\g_back.bin" /B/Y 
copy "..\graficos\g_over.bin" "ROM Modificada\ROCK\data\g_over.bin" /B/Y 
copy "..\graficos\miss.bin" "ROM Modificada\ROCK\data\miss.bin" /B/Y 
copy "..\graficos\repair.bin" "ROM Modificada\ROCK\data\repair.bin" /B/Y 
copy "..\graficos\sec_disk.bin" "ROM Modificada\ROCK\data\sec_disk.bin" /B/Y 
copy "..\scripts\reinseridos\m_back_en.bin" "ROM Modificada\ROCK\data\m_back_en.bin" /B/Y
copy "..\scripts\reinseridos\m_rep_en.bin" "ROM Modificada\ROCK\data\m_rep_en.bin" /B/Y
copy "..\scripts\reinseridos\m_sdisk_en.bin" "ROM Modificada\ROCK\data\m_sdisk_en.bin" /B/Y
copy "..\scripts\reinseridos\m_sub_en.bin" "ROM Modificada\ROCK\data\m_sub_en.bin" /B/Y
copy "..\scripts\reinseridos\m_sys_en.bin" "ROM Modificada\ROCK\data\m_sys_en.bin" /B/Y
copy "..\scripts\reinseridos\talk_gd1_en1.bin" "ROM Modificada\ROCK\data\talk_gd1_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_gd1_en2.bin" "ROM Modificada\ROCK\data\talk_gd1_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_gd2_en1.bin" "ROM Modificada\ROCK\data\talk_gd2_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_gd2_en2.bin" "ROM Modificada\ROCK\data\talk_gd2_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m01_en1.bin" "ROM Modificada\ROCK\data\talk_m01_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m01_en2.bin" "ROM Modificada\ROCK\data\talk_m01_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m02_en1.bin" "ROM Modificada\ROCK\data\talk_m02_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m02_en2.bin" "ROM Modificada\ROCK\data\talk_m02_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m03_en1.bin" "ROM Modificada\ROCK\data\talk_m03_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m03_en2.bin" "ROM Modificada\ROCK\data\talk_m03_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m04_en1.bin" "ROM Modificada\ROCK\data\talk_m04_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m04_en2.bin" "ROM Modificada\ROCK\data\talk_m04_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m05_en1.bin" "ROM Modificada\ROCK\data\talk_m05_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m05_en2.bin" "ROM Modificada\ROCK\data\talk_m05_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m06_en1.bin" "ROM Modificada\ROCK\data\talk_m06_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m06_en2.bin" "ROM Modificada\ROCK\data\talk_m06_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m07_en1.bin" "ROM Modificada\ROCK\data\talk_m07_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m07_en2.bin" "ROM Modificada\ROCK\data\talk_m07_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m08_en1.bin" "ROM Modificada\ROCK\data\talk_m08_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m08_en2.bin" "ROM Modificada\ROCK\data\talk_m08_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m09_en1.bin" "ROM Modificada\ROCK\data\talk_m09_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m09_en2.bin" "ROM Modificada\ROCK\data\talk_m09_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0a_en1.bin" "ROM Modificada\ROCK\data\talk_m0a_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0a_en2.bin" "ROM Modificada\ROCK\data\talk_m0a_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0b_en1.bin" "ROM Modificada\ROCK\data\talk_m0b_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0b_en2.bin" "ROM Modificada\ROCK\data\talk_m0b_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0c_en1.bin" "ROM Modificada\ROCK\data\talk_m0c_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0c_en2.bin" "ROM Modificada\ROCK\data\talk_m0c_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0d_en1.bin" "ROM Modificada\ROCK\data\talk_m0d_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0d_en2.bin" "ROM Modificada\ROCK\data\talk_m0d_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0e_en1.bin" "ROM Modificada\ROCK\data\talk_m0e_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0e_en2.bin" "ROM Modificada\ROCK\data\talk_m0e_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0f_en1.bin" "ROM Modificada\ROCK\data\talk_m0f_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m0f_en2.bin" "ROM Modificada\ROCK\data\talk_m0f_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_m10_en1.bin" "ROM Modificada\ROCK\data\talk_m10_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_m10_en2.bin" "ROM Modificada\ROCK\data\talk_m10_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q01_en1.bin" "ROM Modificada\ROCK\data\talk_q01_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q01_en2.bin" "ROM Modificada\ROCK\data\talk_q01_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q02_en1.bin" "ROM Modificada\ROCK\data\talk_q02_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q02_en2.bin" "ROM Modificada\ROCK\data\talk_q02_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q03_en1.bin" "ROM Modificada\ROCK\data\talk_q03_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q03_en2.bin" "ROM Modificada\ROCK\data\talk_q03_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q04_en1.bin" "ROM Modificada\ROCK\data\talk_q04_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q04_en2.bin" "ROM Modificada\ROCK\data\talk_q04_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q05_en1.bin" "ROM Modificada\ROCK\data\talk_q05_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q05_en2.bin" "ROM Modificada\ROCK\data\talk_q05_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q06_en1.bin" "ROM Modificada\ROCK\data\talk_q06_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q06_en2.bin" "ROM Modificada\ROCK\data\talk_q06_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q07_en2.bin" "ROM Modificada\ROCK\data\talk_q07_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q08_en1.bin" "ROM Modificada\ROCK\data\talk_q08_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q08_en2.bin" "ROM Modificada\ROCK\data\talk_q08_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q09_en1.bin" "ROM Modificada\ROCK\data\talk_q09_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q09_en2.bin" "ROM Modificada\ROCK\data\talk_q09_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0a_en1.bin" "ROM Modificada\ROCK\data\talk_q0a_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0a_en2.bin" "ROM Modificada\ROCK\data\talk_q0a_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0b_en1.bin" "ROM Modificada\ROCK\data\talk_q0b_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0b_en2.bin" "ROM Modificada\ROCK\data\talk_q0b_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0c_en1.bin" "ROM Modificada\ROCK\data\talk_q0c_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0c_en2.bin" "ROM Modificada\ROCK\data\talk_q0c_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0d_en1.bin" "ROM Modificada\ROCK\data\talk_q0d_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0d_en2.bin" "ROM Modificada\ROCK\data\talk_q0d_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0e_en1.bin" "ROM Modificada\ROCK\data\talk_q0e_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0e_en2.bin" "ROM Modificada\ROCK\data\talk_q0e_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0f_en1.bin" "ROM Modificada\ROCK\data\talk_q0f_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q0f_en2.bin" "ROM Modificada\ROCK\data\talk_q0f_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q10_en1.bin" "ROM Modificada\ROCK\data\talk_q10_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q10_en2.bin" "ROM Modificada\ROCK\data\talk_q10_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q11_en1.bin" "ROM Modificada\ROCK\data\talk_q11_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q11_en2.bin" "ROM Modificada\ROCK\data\talk_q11_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q12_en1.bin" "ROM Modificada\ROCK\data\talk_q12_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q12_en2.bin" "ROM Modificada\ROCK\data\talk_q12_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q13_en1.bin" "ROM Modificada\ROCK\data\talk_q13_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q13_en2.bin" "ROM Modificada\ROCK\data\talk_q13_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q14_en1.bin" "ROM Modificada\ROCK\data\talk_q14_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q14_en2.bin" "ROM Modificada\ROCK\data\talk_q14_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q15_en1.bin" "ROM Modificada\ROCK\data\talk_q15_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q15_en2.bin" "ROM Modificada\ROCK\data\talk_q15_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q16_en1.bin" "ROM Modificada\ROCK\data\talk_q16_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q16_en2.bin" "ROM Modificada\ROCK\data\talk_q16_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q17_en1.bin" "ROM Modificada\ROCK\data\talk_q17_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q17_en2.bin" "ROM Modificada\ROCK\data\talk_q17_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_q18_en1.bin" "ROM Modificada\ROCK\data\talk_q18_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_q18_en2.bin" "ROM Modificada\ROCK\data\talk_q18_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_sys_en.bin" "ROM Modificada\ROCK\data\talk_sys_en.bin" /B/Y
copy "..\scripts\reinseridos\talk_tw1_en1.bin" "ROM Modificada\ROCK\data\talk_tw1_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_tw1_en2.bin" "ROM Modificada\ROCK\data\talk_tw1_en2.bin" /B/Y
copy "..\scripts\reinseridos\talk_tw2_en1.bin" "ROM Modificada\ROCK\data\talk_tw2_en1.bin" /B/Y
copy "..\scripts\reinseridos\talk_tw2_en2.bin" "ROM Modificada\ROCK\data\talk_tw2_en2.bin" /B/Y

echo "Repacking rom"
cd "ROM Modificada"
call empacotar_rom.bat
call do_patch.bat
cd ..
