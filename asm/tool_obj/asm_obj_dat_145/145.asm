; Tradução Rockman ZX (J) para pt-BR
;
; Alteração nos tilesets e número de tiles copiados para a VRAM dos seguintes gráficos
;   MEGAMAN durante a introdução
;
; Escrito por Diego Hahn (DiegoHH) - Fevereiro de 2018
;

; NÃO É NECESSÁRIO EXECUTAR. COPIEI O ARQUIVO DA ROM AMERICANA

; .nds

; .open "..\old_obj_dat\145.bin", "..\new_obj_dat\145.bin", 0x0

; .arm                                                    ; ARM code
                                    
; .thumb                                                  ; THUMB code

; .org 0x0

; .align

; .dw Label_TblPtr_0, Label_TblPtr_1

; .align
; Label_TblPtr_0:
; .dw 0x00000004

; ; Tabela de Ponteiros
; .dh Label_Generic0_0 - Label_TblPtr_0 - 4 , 0x0001   ; 0x00
; .dh Label_Generic0_1 - Label_TblPtr_0 - 4 , 0x0001   ; 0x01
; .dh Label_Generic0_2 - Label_TblPtr_0 - 4 , 0x0001   ; 0x02
; .dh Label_Generic0_3 - Label_TblPtr_0 - 4 , 0x0001   ; 0x03
; .dh Label_Generic0_4 - Label_TblPtr_0 - 4 , 0x0001   ; 0x04

; .align
; ; OAMs dos caracteres... TileNu, Formato do sprite, 
; Label_Generic0_0:
; .db 0x00, 0x20, 0xF0, 0xF0  ; N - MEGAMAN
; Label_Generic0_1:
; .db 0x04, 0x20, 0xF0, 0xF0  ; M - MEGAMAN
; Label_Generic0_2:
; .db 0x08, 0x20, 0xF0, 0xF0  ; E - MEGAMAN
; Label_Generic0_3:
; .db 0x0C, 0x20, 0xF0, 0xF0  ; G - MEGAMAN
; Label_Generic0_4:
; .db 0x10, 0x20, 0xF0, 0xF0  ; A - MEGAMAN

; Label_TblPtr_1:
; .dw 0x00000004

; .dh Label_Generic1_0 - Label_TblPtr_1 - 4       ; 0x00: 00    - N
; .dh Label_Generic1_1 - Label_TblPtr_1 - 4       ; 0x01: 01    - M
; .dh Label_Generic1_2 - Label_TblPtr_1 - 4       ; 0x02: 02    - E
; .dh Label_Generic1_3 - Label_TblPtr_1 - 4       ; 0x03: 03    - G
; .dh Label_Generic1_4 - Label_TblPtr_1 - 4       ; 0x04: 04    - A

; .align
; Label_Generic1_0:
; .db 0x00, 0x01, 0x00, 0xFF
; Label_Generic1_1:
; .db 0x01, 0x01, 0x00, 0xFF
; Label_Generic1_2:
; .db 0x02, 0x01, 0x00, 0xFF
; Label_Generic1_3:
; .db 0x03, 0x01, 0x00, 0xFF
; Label_Generic1_4:
; .db 0x04, 0x01, 0x00, 0xFF

; .dh 0 ; PADDING