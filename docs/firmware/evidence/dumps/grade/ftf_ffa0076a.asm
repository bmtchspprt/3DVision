ffa0073c: ADD R3 = R0 + R3 (s)
ffa00740: ASH R4 = R1 >>> 0x1
ffa00744: MOVE R2 = R7
ffa00746: LOAD R2.H = 0x376c
ffa0074a: ADD R2 = R4 + R2 (s)
ffa0074e: ASH R1 = R3 >>> 0x1f
ffa00752: CC = BITTST (R1,0x0)
ffa00754: ASH R7 = R2 >>> 0x1f
ffa00758: LSH|| R0 = R3 << 0x1f
ffa0075c: _STORE [SP + 0xc] = R7
ffa0075e: _NOP
ffa00760: ROT R1 = rot R3 by -0x1
ffa00764: CALL 0xffa01150
ffa00768: MOVE R7 = R0
ffa0076a: CALL 0xffa02894
ffa0076e: ADD P5 += 0x1
ffa00770: MOVE R4 = R0
ffa00772: ABS R1 = abs R7
ffa00776: LOAD R2 = 0xb505
ffa0077a: CC = R2 <= R1
ffa0077c: MOVE R0 = R4
ffa0077e: IF !CC JUMP 0xffa00860
ffa00780: MAC A1 = R7.L * R7.L (fu)
ffa00784: LOAD R2 = 0x80
ffa00788: MAC A1 += R2.L * R2.L 
ffa0078c: LSH A1 = A1 >> 0x10
ffa00790: MAC A1 += R7.H * R7.L (m),A0 = R7.H * R7.H 
ffa00794: MAC A1 += R7.H * R7.L (m)
ffa00798: MAC A1 += R2.L * R2.L (fu)
ffa0079c: ASH A1 = A1 >>> 0xf
ffa007a0: LOAD P1.L = 0x345c
ffa007a4: LOAD P1.H = 0xff80
ffa007a8: MOVE|| R1 = (A0 += A1)
ffa007ac: LOAD R3 = [P1]
ffa007ae: NOP
ffa007b0: MAC|| A1 = R3.L * R1.L (fu)
ffa007b4: LOAD R7 = [P1 + 0x4]
ffa007b6: NOP
ffa007b8: MAC|| A1 += R2.L * R2.L 
