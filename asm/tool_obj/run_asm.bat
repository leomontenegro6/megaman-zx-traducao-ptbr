@echo off

REM ir adicionando mais chamadas asm conforme o necessário
echo Running asm_obj_dat_053...
cd asm_obj_dat_053
..\..\armips.exe 053.asm
cd ..

echo Running asm_obj_fnt_053...
cd asm_obj_fnt_053
..\..\armips.exe 053.asm
cd ..
