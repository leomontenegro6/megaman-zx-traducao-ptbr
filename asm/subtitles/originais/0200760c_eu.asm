0200760C B570     push    r4-r6,r14
0200760E B084     add     sp,-10h
02007610 1C04     mov     r4,r0
02007612 482C     ldr     r0,=27E00FCh
02007614 6800     ldr     r0,[r0]
02007616 2800     cmp     r0,0h
02007618 D001     beq     200761Eh
0200761A F7FFFE71 bl      2007300h              ; na jp, apontar para 2007198h
0200761E 2000     mov     r0,0h
02007620 43C0     mvn     r0,r0
02007622 F0A8E870 blx     20AF704h              ; na jp, apontar para 20AE848h
02007626 1C20     mov     r0,r4
02007628 F7FFFEB2 bl      2007390h              ; na jp, apontar para 2007228h
0200762C 2800     cmp     r0,0h
0200762E DB42     blt     20076B6h
02007630 2101     mov     r1,1h
02007632 4824     ldr     r0,=27E00FCh      
02007634 6001     str     r1,[r0]
02007636 4924     ldr     r1,=27E01FCh
02007638 68CD     ldr     r5,[r1,0Ch]
0200763A 4C24     ldr     r4,=20F751Ch          ; na jp, apontar para 20F735Ch
0200763C 2380     mov     r3,80h
0200763E 5563     strb    r3,[r4,r5]
02007640 5D62     ldrb    r2,[r4,r5]
02007642 4823     ldr     r0,=4000240h
02007644 542A     strb    r2,[r5,r0]
02007646 690A     ldr     r2,[r1,10h]
02007648 54A3     strb    r3,[r4,r2]
0200764A 5CA1     ldrb    r1,[r4,r2]
0200764C 5411     strb    r1,[r2,r0]
0200764E 2000     mov     r0,0h
; a partir daqui, foi acrescentado
02007650 4920     ldr     r1,=4000Eh
02007652 F7FBFB91 bl      2002D78h              ; na jp, apontar para 2002BE4h
02007656 4820     ldr     r0,=20F89B0h          ; na jp, apontar para 20F87F0h
02007658 6804     ldr     r4,[r0]
0200765A 2200     mov     r2,0h
0200765C 6002     str     r2,[r0]
0200765E 4D1F     ldr     r5,=20F8930h          ; na jp, apontar para 20F8770h
02007660 0193     lsl     r3,r2,6h
02007662 18E9     add     r1,r5,r3
02007664 6041     str     r1,[r0,4h]
02007666 58E9     ldr     r1,[r5,r3]
02007668 2607     mov     r6,7h
0200766A 43B1     bic     r1,r6
0200766C 2605     mov     r6,5h
0200766E 4331     orr     r1,r6
02007670 50E9     str     r1,[r5,r3]
02007672 6845     ldr     r5,[r0,4h]
02007674 682B     ldr     r3,[r5]
02007676 491A     ldr     r1,=0FFFFF0FFh
02007678 400B     and     r3,r1
0200767A 491A     ldr     r1,=400h
0200767C 430B     orr     r3,r1
0200767E 602B     str     r3,[r5]
02007680 4919     ldr     r1,=4002h
02007682 6840     ldr     r0,[r0,4h]
02007684 8181     strh    r1,[r0,0Ch]
02007686 2024     mov     r0,24h
02007688 2184     mov     r1,84h
0200768A F7FDFAFF bl      2004C8Ch              ; na jp, apontar para 2004AF8h
0200768E 2100     mov     r1,0h
02007690 9100     str     r1,[sp]
02007692 9101     str     r1,[sp,4h]
02007694 9102     str     r1,[sp,8h]
02007696 2024     mov     r0,24h
02007698 4A14     ldr     r2,=100h
0200769A 1C0B     mov     r3,r1
0200769C F7FDFD2A bl      20050F4h              ; na jp, apontar para 2004F60h
020076A0 480D     ldr     r0,=20F89B0h          ; na jp, apontar para 20F87F0h
020076A2 6004     str     r4,[r0]
020076A4 4A0D     ldr     r2,=20F8930h          ; na jp, apontar para 20F8770h
020076A6 01A1     lsl     r1,r4,6h
020076A8 1851     add     r1,r2,r1
020076AA 6041     str     r1,[r0,4h]
; daqui para baixo é equivalente na rom jp
020076AC F7F1FC0E bl      1FF8ECCh
020076B0 2001     mov     r0,1h
020076B2 B004     add     sp,10h
020076B4 BD70     pop     r4-r6,r15
020076B6 2000     mov     r0,0h
020076B8 43C0     mvn     r0,r0
020076BA F0A8E824 blx     20AF704h              ; na jp, apontar para 20AE848h
020076BE 2000     mov     r0,0h
020076C0 B004     add     sp,10h
020076C2 BD70     pop     r4-r6,r15
.pool
020076C4 00FC     lsl     r4,r7,3h
020076C6 027E     lsl     r6,r7,9h
020076C8 01FC     lsl     r4,r7,7h
020076CA 027E     lsl     r6,r7,9h
020076CC 751C     strb    r4,[r3,14h]
020076CE 020F     lsl     r7,r1,8h
020076D0 0240     lsl     r0,r0,9h
020076D2 0400     lsl     r0,r0,10h
020076D4 000E     lsl     r6,r1,0h
020076D6 0004     lsl     r4,r0,0h
020076D8 89B0     ldrh    r0,[r6,0Ch]
020076DA 020F     lsl     r7,r1,8h
020076DC 8930     ldrh    r0,[r6,8h]
020076DE 020F     lsl     r7,r1,8h
020076E0 F0FFFFFF bl      21076E2h
020076E4 0400     lsl     r0,r0,10h
020076E6 0000     lsl     r0,r0,0h
020076E8 4002     and     r2,r0
020076EA 0000     lsl     r0,r0,0h
020076EC 0100     lsl     r0,r0,4h
020076EE 0000     lsl     r0,r0,0h