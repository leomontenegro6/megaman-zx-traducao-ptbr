; essa rotina não existe na rom japonesa
02007A9C B530     push    r4,r5,r14
02007A9E B081     add     sp,-4h
02007AA0 4827     ldr     r0,=27E00FCh          ; ok
02007AA2 6800     ldr     r0,[r0]
02007AA4 2801     cmp     r0,1h
02007AA6 DB40     blt     2007B2Ah
02007AA8 2803     cmp     r0,3h
02007AAA DC3E     bgt     2007B2Ah
02007AAC 4825     ldr     r0,=20F9324h          ; na jp, apontar para 20F915Ch
02007AAE 6800     ldr     r0,[r0]
02007AB0 2800     cmp     r0,0h
02007AB2 D03A     beq     2007B2Ah
02007AB4 4824     ldr     r0,=20F92F8h          ; não existe
02007AB6 7802     ldrb    r2,[r0]
02007AB8 2A04     cmp     r2,4h
02007ABA D036     beq     2007B2Ah
02007ABC 4823     ldr     r0,=20F92FCh          ; não existe
02007ABE 7800     ldrb    r0,[r0]
02007AC0 0081     lsl     r1,r0,2h
02007AC2 0150     lsl     r0,r2,5h
02007AC4 4A22     ldr     r2,=20CAEB0h          ; não existe
02007AC6 1812     add     r2,r2,r0
02007AC8 5E8B     ldsh    r3,[r1,r2]
02007ACA 4A22     ldr     r2,=27E027Ch          ; ok
02007ACC 6B12     ldr     r2,[r2,30h]
02007ACE 4293     cmp     r3,r2
02007AD0 D82B     bhi     2007B2Ah
02007AD2 4A21     ldr     r2,=20CAEB2h          ; não existe
02007AD4 1810     add     r0,r2,r0
02007AD6 5E0A     ldsh    r2,[r1,r0]
02007AD8 4820     ldr     r0,=20F89B0h          ; na jp, apontar para 20F87F0h
02007ADA 6804     ldr     r4,[r0]
02007ADC 2300     mov     r3,0h
02007ADE 6003     str     r3,[r0]
02007AE0 4D1F     ldr     r5,=20F8930h          ; na jp, apontar para 20F8770h
02007AE2 0199     lsl     r1,r3,6h
02007AE4 186D     add     r5,r5,r1
02007AE6 6045     str     r5,[r0,4h]
02007AE8 2A00     cmp     r2,0h
02007AEA DB10     blt     2007B0Eh
02007AEC 9300     str     r3,[sp]
02007AEE 2001     mov     r0,1h
02007AF0 491C     ldr     r1,=22CD008h          ; não existe
02007AF2 6809     ldr     r1,[r1]
02007AF4 0049     lsl     r1,r1,1h
02007AF6 0849     lsr     r1,r1,1h
02007AF8 0612     lsl     r2,r2,18h
02007AFA 0E12     lsr     r2,r2,18h
02007AFC F7FDFC92 bl      2005424h              ; (02005290h) verificar se essa função existe na rom jp (ok)
02007B00 4816     ldr     r0,=20F89B0h          ; na jp, apontar para 20F87F0h
02007B02 6842     ldr     r2,[r0,4h]
02007B04 6811     ldr     r1,[r2]
02007B06 4818     ldr     r0,=100h
02007B08 4301     orr     r1,r0
02007B0A 6011     str     r1,[r2]
02007B0C E003     b       2007B16h
02007B0E 6829     ldr     r1,[r5]
02007B10 4816     ldr     r0,=0FFFFFEFFh
02007B12 4001     and     r1,r0
02007B14 6029     str     r1,[r5]
02007B16 480D     ldr     r0,=20F92FCh          ; não existe
02007B18 7801     ldrb    r1,[r0]
02007B1A 1C49     add     r1,r1,1
02007B1C 7001     strb    r1,[r0]
02007B1E 480F     ldr     r0,=20F89B0h          ; na jp, apontar para 20F87F0h
02007B20 6004     str     r4,[r0]
02007B22 4A0F     ldr     r2,=20F8930h          ; na jp, apontar para 20F8770h
02007B24 01A1     lsl     r1,r4,6h
02007B26 1851     add     r1,r2,r1
02007B28 6041     str     r1,[r0,4h]
02007B2A 2000     mov     r0,0h
02007B2C 4904     ldr     r1,=27E00FCh          ; ok
02007B2E 6809     ldr     r1,[r1]
02007B30 2901     cmp     r1,1h
02007B32 DB02     blt     2007B3Ah
02007B34 2903     cmp     r1,3h
02007B36 DC00     bgt     2007B3Ah
02007B38 2001     mov     r0,1h
02007B3A B001     add     sp,4h
02007B3C BD30     pop     r4,r5,r15
.pool
02007B3E 46C0     nop
02007B40 00FC     lsl     r4,r7,3h
02007B42 027E     lsl     r6,r7,9h
02007B44 9324     str     r3,[sp,90h]
02007B46 020F     lsl     r7,r1,8h
02007B48 92F8     str     r2,[sp,3E0h]
02007B4A 020F     lsl     r7,r1,8h
02007B4C 92FC     str     r2,[sp,3F0h]
02007B4E 020F     lsl     r7,r1,8h
02007B50 AEB0     add     r6,sp,2C0h
02007B52 020C     lsl     r4,r1,8h
02007B54 027C     lsl     r4,r7,9h
02007B56 027E     lsl     r6,r7,9h
02007B58 AEB2     add     r6,sp,2C8h
02007B5A 020C     lsl     r4,r1,8h
02007B5C 89B0     ldrh    r0,[r6,0Ch]
02007B5E 020F     lsl     r7,r1,8h
02007B60 8930     ldrh    r0,[r6,8h]
02007B62 020F     lsl     r7,r1,8h
02007B64 D008     beq     2007B78h
02007B66 022C     lsl     r4,r5,8h
02007B68 0100     lsl     r0,r0,4h
02007B6A 0000     lsl     r0,r0,0h
02007B6C FEFF     bl      lr+0DFEh
02007B6E FFFF     bl      lr+0FFEh