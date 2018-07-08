; Tradução Rockman ZX (J) para pt-BR
;
; Alteração nos tilesets e número de tiles copiados para a VRAM dos seguintes gráficos
;   MEGAMAN durante a introdução
;
; Escrito por Diego Hahn (DiegoHH) - Fevereiro de 2018
;

; NÃO É NECESSÁRIO EXECUTAR. COPIEI O ARQUIVO DA ROM AMERICANA

; .nds

; .open "..\old_obj_fnt\145.bin", "..\new_obj_fnt\145.bin", 0x0

; .arm                                                    ; ARM code
                                    
; .thumb                                                  ; THUMB code

; .org 0x0

; .align

; ;
; Label_Info_Tileset0:
; .dw Label_Tileset0_Ptr - Label_Info_Tileset0    ; Ponteiro para o Tileset de MISSION FAILED
; .dw 0x00180A00                                  ; Tamanho do tileset (bytes) na parte baixa da palavra
; .dh 0x0280, 0x8020                              ; ??
; Label_Info_Palette0:
; .dw Label_Palette0_Ptr - Label_Info_Palette0
; .dh 0x0020, 0x0008 

; ; Não vai ser necessário expandir, visto que temos um espaço em branco + as letras M E G A. O espaço em branco pode virar um N e o M e A serem reusados.

; Label_Tileset0_Ptr:
; .import "include_tileset0.bin"
; Label_Palette0_Ptr:
; .import "include_palette0.bin"
