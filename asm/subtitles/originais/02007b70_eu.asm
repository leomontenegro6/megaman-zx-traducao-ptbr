; essa rotina está incluida na rotina principal na rom japonesa ( ver 0201be70_jp.asm )
; porém, essa daqui faz mas coisa
02007B70 B530     push    r4,r5,r14
02007B72 B085     add     sp,-14h
02007B74 4D33     ldr     r5,=20BF26Ch         ; na rom jp, apontar para 0s20C1074h
02007B76 AC00     add     r4,sp,0h
02007B78 2310     mov     r3,10h
02007B7A 782A     ldrb    r2,[r5]
02007B7C 1C6D     add     r5,r5,1
02007B7E 7022     strb    r2,[r4]
02007B80 1C64     add     r4,r4,1
02007B82 1E5B     sub     r3,r3,1
02007B84 2B00     cmp     r3,0h
02007B86 D1F8     bne     2007B7Ah
02007B88 1C0B     mov     r3,r1
02007B8A 3330     add     r3,30h
02007B8C AA00     add     r2,sp,0h
02007B8E 71D3     strb    r3,[r2,7h]
02007B90 2904     cmp     r1,4h
02007B92 D202     bcs     2007B9Ah
02007B94 79D1     ldrb    r1,[r2,7h]
02007B96 1808     add     r0,r1,r0
02007B98 71D0     strb    r0,[r2,7h]
02007B9A F7FFFF51 bl      2007A40h              ; na rom jp, apontar para 200784Ch
02007B9E 482A     ldr     r0,=22D0000h
02007BA0 492A     ldr     r1,=74000h
02007BA2 2201     mov     r2,1h
02007BA4 2303     mov     r3,3h
02007BA6 F7FFFF5F bl      2007A68h              ; (2007874h) verificar se essa função existe na rom jp (ok)
02007BAA A800     add     r0,sp,0h              ; r0 aponta para o topo da stack
02007BAC F7FFFD2E bl      200760Ch              ; (20074A4h) verificar se essa função existe na rom jp (ok) .. mas existe coisa a mais na rotina EU
; daqui para baixo, não existe na rom jp
02007BB0 A800     add     r0,sp,0h              ; r0 aponta para o topo da stack
02007BB2 79C0     ldrb    r0,[r0,7h]
02007BB4 3830     sub     r0,30h
02007BB6 4926     ldr     r1,=20F92F8h          ; não existe na jp
02007BB8 7008     strb    r0,[r1]
02007BBA 2200     mov     r2,0h
02007BBC 4825     ldr     r0,=20F92FCh          ; não existe na jp
02007BBE 7002     strb    r2,[r0]
02007BC0 4825     ldr     r0,=20F9324h          ; na jp, apontar para 20F915Ch
02007BC2 6800     ldr     r0,[r0]               ; r0 = 01 [20f9324]
02007BC4 2800     cmp     r0,0h
02007BC6 D03A     beq     2007C3Eh
02007BC8 7809     ldrb    r1,[r1]               ; [20f92f8] .. r1 seleciona o arquivo de legenda
02007BCA 2904     cmp     r1,4h                 
02007BCC D037     beq     2007C3Eh              ; se r1 == 4h , salta para saida. Os valores permitidos são 0, 1, 2, 3, 5 e 6
02007BCE 1E43     sub     r3,r0,1
02007BD0 201C     mov     r0,1Ch
02007BD2 4343     mul     r3,r0
02007BD4 4821     ldr     r0,=20CAE24h          ; ponteiro para a tabela dos arquivos da legenda .. não existe na jp
02007BD6 0089     lsl     r1,r1,2h
02007BD8 18C0     add     r0,r0,r3
02007BDA 5808     ldr     r0,[r1,r0]            ; r0 = src
02007BDC 4920     ldr     r1,=22CD000h          ; r1 = dst
02007BDE F7FAF8F7 bl      2001DD0h              ; (2001E04h) verificar se essa função existe na rom jp (ok) - lê um arquivo da rom para a ram
02007BE2 F7FAF9DD bl      2001FA0h              ; (2001FD4h) verificar se essa função existe na rom jp (ok)
02007BE6 2800     cmp     r0,0h
02007BE8 D1FB     bne     2007BE2h
02007BEA 481E     ldr     r0,=20F89B0h          ; na jp, apontar para 20F87F0h
02007BEC 6804     ldr     r4,[r0]
02007BEE 2100     mov     r1,0h
02007BF0 6001     str     r1,[r0]
02007BF2 4B1D     ldr     r3,=20F8930h          ; na jp, apontar para 20F8770h
02007BF4 018A     lsl     r2,r1,6h
02007BF6 189A     add     r2,r3,r2
02007BF8 6042     str     r2,[r0,4h]
02007BFA 481C     ldr     r0,=1F00h
02007BFC 8110     strh    r0,[r2,8h]
02007BFE 2001     mov     r0,1h
02007C00 2230     mov     r2,30h
02007C02 F7FDF843 bl      2004C8Ch              ; (2004AF8h) verificar se essa função existe na rom jp (ok)
02007C06 2100     mov     r1,0h
02007C08 4816     ldr     r0,=20F89B0h          ; na jp, apontar para 20F87F0h
02007C0A 6840     ldr     r0,[r0,4h]
02007C0C 6101     str     r1,[r0,10h]
02007C0E 2001     mov     r0,1h
02007C10 F7FCFF6A bl      2004AE8h              ; (2004954h) verificar se essa função existe na rom jp (ok)
02007C14 1C01     mov     r1,r0
02007C16 4816     ldr     r0,=22CD004h
02007C18 6800     ldr     r0,[r0]
02007C1A 0040     lsl     r0,r0,1h
02007C1C 0840     lsr     r0,r0,1h
02007C1E F7FAFFE1 bl      2002BE4h              ; (2002A50h) verificar se essa função existe na rom jp (ok)
02007C22 4813     ldr     r0,=22CD004h
02007C24 6800     ldr     r0,[r0]
02007C26 0040     lsl     r0,r0,1h
02007C28 0840     lsr     r0,r0,1h
02007C2A 300C     add     r0,0Ch
02007C2C 2100     mov     r1,0h
02007C2E F7FCE840 blx     2003CB0h              ; na jp, apontar para 2003B1Ch verificar se essa função existe na rom jp (arm)
02007C32 480C     ldr     r0,=20F89B0h          ; na jp, apontar para 20F87F0h
02007C34 6004     str     r4,[r0]
02007C36 4A0C     ldr     r2,=20F8930h          ; na jp, apontar para 20F8770h
02007C38 01A1     lsl     r1,r4,6h
02007C3A 1851     add     r1,r2,r1
02007C3C 6041     str     r1,[r0,4h]
; saida
02007C3E B005     add     sp,14h
02007C40 BD30     pop     r4,r5,r15
.pool
02007C42 46C0     nop
02007C44 F26C     ????
02007C46 020B     lsl     r3,r1,8h
02007C48 0000     lsl     r0,r0,0h
02007C4A 022D     lsl     r5,r5,8h
02007C4C 4000     and     r0,r0
02007C4E 0007     lsl     r7,r0,0h
02007C50 92F8     str     r2,[sp,3E0h]
02007C52 020F     lsl     r7,r1,8h
02007C54 92FC     str     r2,[sp,3F0h]
02007C56 020F     lsl     r7,r1,8h
02007C58 9324     str     r3,[sp,90h]
02007C5A 020F     lsl     r7,r1,8h
02007C5C AE24     add     r6,sp,90h
02007C5E 020C     lsl     r4,r1,8h
02007C60 D000     beq     2007C64h
02007C62 022C     lsl     r4,r5,8h
02007C64 89B0     ldrh    r0,[r6,0Ch]
02007C66 020F     lsl     r7,r1,8h
02007C68 8930     ldrh    r0,[r6,8h]
02007C6A 020F     lsl     r7,r1,8h
02007C6C 1F00     sub     r0,r0,4
02007C6E 0000     lsl     r0,r0,0h
02007C70 D004     beq     2007C7Ch
02007C72 022C     lsl     r4,r5,8h