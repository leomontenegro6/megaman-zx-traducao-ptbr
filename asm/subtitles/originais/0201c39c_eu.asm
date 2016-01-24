; r0 = r4 = r5
; r1 não é usado
; r2 não é usado
; 
0201C39C B510     push    r4,r14
0201C39E 1C04     mov     r4,r0
0201C3A0 6AE1     ldr     r1,[r4,2Ch]
0201C3A2 7848     ldrb    r0,[r1,1h]
0201C3A4 2804     cmp     r0,4h                 ; r0 contém o trecho que será executado
0201C3A6 D831     bhi     201C40Ch              ; salta se r0 > 4
0201C3A8 1800     add     r0,r0,r0              ; r0 = r0 + r0             
0201C3AA 4478     add     r0,r15                ; r0 = pc + 8 (manual do arm)
0201C3AC 88C0     ldrh    r0,[r0,6h]            ; [ 0201C3Ae + 2 * r0 + 6h ]
0201C3AE 0400     lsl     r0,r0,10h
0201C3B0 1400     asr     r0,r0,10h
0201C3B2 4487     add     r15,r0                ; pc + r0   ( 0201C3B6 )
0201C3B4 0008     lsl     r0,r1,0h              ; altera o pc ( 8h ) - r0 = 0
0201C3B6 0014     lsl     r4,r2,0h              ; altera o pc ( 14h ) - r0 = 1
0201C3B8 0026     lsl     r6,r4,0h              ; altera o pc ( 26h ) - r0 = 2
0201C3BA 003A     lsl     r2,r7,0h              ; altera o pc ( 3ah ) - r0 = 3
0201C3BC 0040     lsl     r0,r0,1h              ; altera o pc ( 40h ) - r0 = 4
; pc + r0 ( 0201C3B6 + 8h )
0201C3BE 4814     ldr     r0,=2106834h          ; na jp, apontar para 210422Ch
0201C3C0 7940     ldrb    r0,[r0,5h]
0201C3C2 6849     ldr     r1,[r1,4h]
0201C3C4 F7EBFBD4 bl      2007B70h              ; ver 2007b70.asm (carrega o arquivo de legenda)
0201C3C8 E020     b       201C40Ch              ; salta para saída
; pc + r0 ( 0201C3B6 + 14h )
0201C3CA F7EBFB67 bl      2007A9Ch              ; ver 2007a9c.asm
0201C3CE 2800     cmp     r0,0h
0201C3D0 D01C     beq     201C40Ch
0201C3D2 6AE0     ldr     r0,[r4,2Ch]
0201C3D4 3808     sub     r0,8h
0201C3D6 62E0     str     r0,[r4,2Ch]
0201C3D8 2001     mov     r0,1h
0201C3DA BD10     pop     r4,r15                ; retorna alterando o pc
; pc + r0 ( 0201C3B6 + 26h )
0201C3DC F7EBFB5E bl      2007A9Ch              ; ver 2007a9c.asm     
0201C3E0 6AE2     ldr     r2,[r4,2Ch]
0201C3E2 6851     ldr     r1,[r2,4h]
0201C3E4 4288     cmp     r0,r1
0201C3E6 D211     bcs     201C40Ch
0201C3E8 3A08     sub     r2,8h
0201C3EA 62E2     str     r2,[r4,2Ch]
0201C3EC 2001     mov     r0,1h
0201C3EE BD10     pop     r4,r15                ; retorna alterando o pc
; Esse trecho existe na rom jp a partir de 0201BF12h
; pc + r0 ( 0201C3B6 + 3ah )
0201C3F0 F7EBF8FC bl      20075ECh
0201C3F4 E00A     b       201C40Ch              ; salta para saida
; pc + r0 ( 0201C3B6 + 40h )
0201C3F6 4907     ldr     r1,=27E02B8h
0201C3F8 684A     ldr     r2,[r1,4h]
0201C3FA 4807     ldr     r0,=0FFF0FFFFh
0201C3FC 4002     and     r2,r0
0201C3FE 4807     ldr     r0,=10000h
0201C400 4302     orr     r2,r0
0201C402 604A     str     r2,[r1,4h]
0201C404 2000     mov     r0,0h
0201C406 4906     ldr     r1,=4000Eh
0201C408 F7E6FCB6 bl      2002D78h              ; na jp, apontar para 2002BE4h
; saída
0201C40C 2000     mov     r0,0h
0201C40E BD10     pop     r4,r15
.pool
0201C410 6834     ldr     r4,[r6]
0201C412 0210     lsl     r0,r2,8h
0201C414 02B8     lsl     r0,r7,0Ah
0201C416 027E     lsl     r6,r7,9h
0201C418 FFFF     bl      lr+0FFEh
0201C41A FFF0     bl      lr+0FE0h
0201C41C 0000     lsl     r0,r0,0h
0201C41E 0001     lsl     r1,r0,0h
0201C420 000E     lsl     r6,r1,0h
0201C422 0004     lsl     r4,r0,0h