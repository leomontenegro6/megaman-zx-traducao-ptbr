01FF8ECC B410     push    r4
01FF8ECE B081     add     sp,-4h
01FF8ED0 4817     ldr     r0,=27E00FCh              ; ok
01FF8ED2 6800     ldr     r0,[r0]
01FF8ED4 2802     cmp     r0,2h
01FF8ED6 D127     bne     1FF8F28h
01FF8ED8 4B16     ldr     r3,=27E029Ch              ; ok
01FF8EDA 7E99     ldrb    r1,[r3,1Ah]
01FF8EDC 7E58     ldrb    r0,[r3,19h]
01FF8EDE 4281     cmp     r1,r0
01FF8EE0 D022     beq     1FF8F28h
01FF8EE2 7E58     ldrb    r0,[r3,19h]
01FF8EE4 7698     strb    r0,[r3,1Ah]
01FF8EE6 7E58     ldrb    r0,[r3,19h]
01FF8EE8 4A13     ldr     r2,=20F89B0h              ; na jp, apontar para 20F87F0h
01FF8EEA 6811     ldr     r1,[r2]
01FF8EEC 2000     mov     r0,0h
01FF8EEE 6010     str     r0,[r2]
01FF8EF0 4C12     ldr     r4,=20F8930h              ; na jp, apontar para 20F8770h
01FF8EF2 0180     lsl     r0,r0,6h
01FF8EF4 1820     add     r0,r4,r0
01FF8EF6 6050     str     r0,[r2,4h]
01FF8EF8 7E5A     ldrb    r2,[r3,19h]
01FF8EFA 2A00     cmp     r2,0h
01FF8EFC D006     beq     1FF8F0Ch
01FF8EFE 8983     ldrh    r3,[r0,0Ch]
01FF8F00 4A0F     ldr     r2,=0FFFFE0FFh
01FF8F02 4013     and     r3,r2
01FF8F04 4A0F     ldr     r2,=600h
01FF8F06 4313     orr     r3,r2
01FF8F08 8183     strh    r3,[r0,0Ch]
01FF8F0A E003     b       1FF8F14h
01FF8F0C 8983     ldrh    r3,[r0,0Ch]
01FF8F0E 4A0C     ldr     r2,=0FFFFE0FFh
01FF8F10 4013     and     r3,r2
01FF8F12 8183     strh    r3,[r0,0Ch]
01FF8F14 4808     ldr     r0,=20F89B0h              ; na jp, apontar para 20F87F0h
01FF8F16 6842     ldr     r2,[r0,4h]
01FF8F18 8993     ldrh    r3,[r2,0Ch]
01FF8F1A 4A0B     ldr     r2,=400000Ch
01FF8F1C 8013     strh    r3,[r2]
01FF8F1E 6001     str     r1,[r0]
01FF8F20 4A06     ldr     r2,=20F8930h              ; na jp, apontar para 20F8770h
01FF8F22 0189     lsl     r1,r1,6h
01FF8F24 1851     add     r1,r2,r1
01FF8F26 6041     str     r1,[r0,4h]
01FF8F28 B001     add     sp,4h
01FF8F2A BC10     pop     r4
01FF8F2C 4770     bx      r14
.pool
01FF8F2E 46C0     nop
01FF8F30 00FC     lsl     r4,r7,3h
01FF8F32 027E     lsl     r6,r7,9h
01FF8F34 029C     lsl     r4,r3,0Ah
01FF8F36 027E     lsl     r6,r7,9h
01FF8F38 89B0     ldrh    r0,[r6,0Ch]
01FF8F3A 020F     lsl     r7,r1,8h
01FF8F3C 8930     ldrh    r0,[r6,8h]
01FF8F3E 020F     lsl     r7,r1,8h
01FF8F40 E0FF     b       1FF9142h
01FF8F42 FFFF     bl      lr+0FFEh
01FF8F44 0600     lsl     r0,r0,18h
01FF8F46 0000     lsl     r0,r0,0h
01FF8F48 000C     lsl     r4,r1,0h
01FF8F4A 0400     lsl     r0,r0,10h
