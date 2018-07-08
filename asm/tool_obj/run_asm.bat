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

REM O arquivo 145.bin foi copiado da ROM Americana. Não deve ser gerado um novo!
copy "asm_obj_dat_145\145.bin" "new_obj_dat\145.bin" /B/Y
copy "asm_obj_fnt_145\145.bin" "new_obj_fnt\145.bin" /B/Y

REM echo Running asm_obj_dat_145...
REM cd asm_obj_dat_145
REM ..\..\armips.exe 145.asm
REM cd ..

REM echo Running asm_obj_fnt_145...
REM cd asm_obj_fnt_145
REM ..\..\armips.exe 145.asm
REM cd ..
