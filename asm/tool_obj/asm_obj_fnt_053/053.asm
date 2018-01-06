; Tradução Rockman ZX (J) para pt-BR
;
; Alteração nos tilesets e número de tiles copiados para a VRAM dos seguintes gráficos
;   MISSION START
;   MISSION FAILED
;   MISSION COMPLETE
;   GAME OVER
;
; Escrito por Diego Hahn (DiegoHH) - Janeiro de 2018
;

.nds

.open "..\old_obj_fnt\053.bin", "..\new_obj_fnt\053.bin", 0x0

.arm                                                    ; ARM code
                                    
.thumb                                                  ; THUMB code

.org 0x0

.align

; 
Label_Info_Tileset0:
.dw Label_Tileset0_Ptr - Label_Info_Tileset0    ; Ponteiro para o Tileset de MISSION FAILED
.dw 0x00180B00                                  ; Tamanho do tileset (bytes) na parte baixa da palavra
.dh 0x02C0, 0x8020                              ; ??
Label_Info_Palette0:
.dw Label_Palette0_Ptr - Label_Info_Palette0
.dh 0x0020, 0x0008                              ; ??

Label_Info_Tileset1:
.dw Label_Tileset1_Ptr - Label_Info_Tileset1    ; Ponteiro para o Tileset de MISSION START
.dw 0x00180A00                                  ; Tamanho do tileset (bytes) na parte baixa da palavra (+100h por causa da letra C)
.dh 0x0240, 0x8020                              ; ??
Label_Info_Palette1:
.dw Label_Palette1_Ptr - Label_Info_Palette1
.dh 0x0020, 0x0008                              ; ??

Label_Info_Tileset2:
.dw Label_Tileset2_Ptr - Label_Info_Tileset2    ; Ponteiro para o Tileset de GAME OVER
.dw 0x00180B00                                  ; Tamanho do tileset (bytes) na parte baixa da palavra
.dh 0x02C0, 0x8020                              ; ??
Label_Info_Palette2:
.dw Label_Palette2_Ptr - Label_Info_Palette2
.dh 0x0020, 0x0008                              ; ??

Label_Info_Tileset3:
.dw Label_Tileset3_Ptr - Label_Info_Tileset3    ; Ponteiro para o Tileset de MISSION COMPLETE
.dw 0x00180D00                                  ; Tamanho do tileset (bytes) na parte baixa da palavra (+200h por causa das letras DA)
.dh 0x02C0, 0x8020                              ; ??
Label_Info_Palette3:
.dw Label_Palette3_Ptr - Label_Info_Palette3
.dh 0x0020, 0x0008                              ; ??

Label_Tileset0_Ptr:
.import "include_tileset0.bin"
Label_Palette0_Ptr:
.import "include_palette0.bin"

Label_Tileset1_Ptr:
.import "include_tileset1.bin"
Label_Palette1_Ptr:
.import "include_palette1.bin"

Label_Tileset2_Ptr:
.import "include_tileset2.bin"
Label_Palette2_Ptr:
.import "include_palette2.bin"

Label_Tileset3_Ptr:
.import "include_tileset3.bin"
Label_Palette3_Ptr:
.import "include_palette3.bin"
