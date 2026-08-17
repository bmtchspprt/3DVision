ffa05802: MOVE R1 = R4
ffa05804: MOVE R6 = R0
ffa05806: CALL 0xffa018f0
ffa0580a: MOVE R1 = R0
ffa0580c: MOVE R0 = R7
ffa0580e: CALL 0xffa01714
ffa05812: MOVE R1 = R0
ffa05814: CALL 0xffa018f0
ffa05818: LOAD R1 = [SP + 0x28]
ffa0581a: CALL 0xffa01716
ffa0581e: MOVE R4 = R0
ffa05820: LOAD R0 = [FP + 0x10]
ffa05822: CALL 0xffa020d4
ffa05826: MOVE R7 = R0
ffa05828: LOAD R0 = [SP + 0x38]
ffa0582a: CALL 0xffa020d4
ffa0582e: MOVE R5 = R0
ffa05830: MOVE R0 = R7
ffa05832: LOAD R1 = [SP + 0x3c]
ffa05834: CALL 0xffa018f0
ffa05838: MOVE R7 = R0
ffa0583a: MOVE R1 = R6
ffa0583c: MOVE R0 = R5
ffa0583e: CALL 0xffa018f0
ffa05842: MOVE R1 = R0
ffa05844: MOVE R0 = R7
ffa05846: CALL 0xffa01714
ffa0584a: MOVE R1 = R0
ffa0584c: STORE [P3 + 0x4] = R0
ffa0584e: CALL 0xffa018f0
ffa05852: MOVE R1 = R4
ffa05854: CALL 0xffa01716
ffa05858: STORE [P3] = R0
ffa0585a: CALL 0xffa0248c
ffa0585e: JUMP.S 0xffa0577c
ffa05860: LOAD R1 = [P4]
ffa05862: SUB R0 = R0 - R1
ffa05864: CALL 0xffa02894
ffa05868: BITCLR (R0,0x1f)
ffa0586a: JUMP.S 0xffa0577c
ffa0586c: MOVE P1 = R1
ffa0586e: LINK 0x0
ffa05872: LOAD R1 = [P1 + 0x4ec]
ffa05876: MAC A1 = R1.L * R0.L (fu)
ffa0587a: LSH A1 = A1 >> 0x10
ffa0587e: UNLINK
ffa05882: MAC A1 += R1.H * R0.L (m),A0 = R1.H * R0.H 
ffa05886: MAC A1 += R0.H * R1.L (m)
ffa0588a: ASH A1 = A1 >>> 0xf
ffa0588e: MOVE R0 = (A0 += A1)
ffa05892: ASHIFT R0 >>>= 0x1
ffa05894: RTS
ffa05896: MOVE P1 = R1
ffa05898: LINK 0xc
ffa0589c: LOAD R1 = [P1 + 0x4ec]
ffa058a0: CALL 0xffa05ee4
ffa058a4: UNLINK
ffa058a8: LSHIFT R0 <<= 0x1
ffa058aa: RTS
ffa058ac: LINK 0x0
ffa058b0: PUSH [--SP] = (R7:6,P5:4)
ffa058b2: ADD SP += -0xc
ffa058b4: ROT|| R7 = rot R2 by 0
ffa058b8: _LOAD P5 = [SP + 0x34]
ffa058ba: _NOP
ffa058bc: MOVE P2 = R7
ffa058be: LSH|| R0 = R0 << 0x1
ffa058c2: _LOAD P1 = [SP + 0x30]
ffa058c4: _NOP
ffa058c6: ADD R0 = R1 + R0
ffa058c8: CC = P5 <= 0x0
ffa058ca: MOVE P0 = R0
ffa058cc: MOVE R6 = P5
ffa058ce: LOAD R0 = 0x0
ffa058d0: IF CC JUMP 0xffa058ea
ffa058d2: ADD P4 = P1 + P1
ffa058d4: MOVE P1 = P2
ffa058d6: LSETUP (0xffa058da,0xffa058e2) LC0 = P5
ffa058da: LOAD R1.L = W [P0 ++ P4]
ffa058dc: LSHIFT R1 <<= 0x4
ffa058de: NEG R2 = -R1
ffa058e0: MOVE R1 = R1.L (X)
ffa058e2: SUB|| R0 = R0 - R1 (ns)
ffa058e6: _STORE W [P1++] = R2
ffa058e8: _NOP
ffa058ea: MOVE R1 = R6
ffa058ec: CALL 0xffa00fb4
ffa058f0: CC = P5 <= 0x0
ffa058f2: IF CC JUMP 0xffa05932
ffa058f4: LSHIFT R7 <<= 0x1e
ffa058f6: MOVE CC = az
ffa058f8: IF !CC JUMP 0xffa0593c
ffa058fa: CC = P5 == 0x1
ffa058fc: IF CC JUMP 0xffa0592a
ffa058fe: ASH R1 = R6 >>> 0x1
ffa05902: MOVE P1 = R1
ffa05904: MOVE P0 = P2
ffa05906: LSH R0.H = R0.L << 0x0
ffa0590a: LOAD R1 = [P0++]
ffa0590c: ADD P1 += -0x1
ffa0590e: CC = P1 == 0x0
ffa05910: IF CC JUMP 0xffa05920
ffa05912: LSETUP (0xffa05916,0xffa0591e) LC0 = P1
ffa05916: SUB|| R2 = R1 -|- R0 (s)
ffa0591a: LOAD R1 = [P0++]
ffa0591c: NOP
ffa0591e: STORE [P2++] = R2
ffa05920: SUB R1 = R1 -|- R0 (s)
ffa05924: CC = BITTST (R6,0x0)
ffa05926: STORE [P2++] = R1
ffa05928: IF !CC JUMP 0xffa05932
ffa0592a: LOAD R1 = W [P2] (X)
ffa0592c: SUB R0.L = R1.L - R0.L (s)
ffa05930: STORE W [P2] = R0.L
ffa05932: ADD SP += 0xc
ffa05934: POP (R7:6,P5:4) = [SP++]
ffa05936: UNLINK
ffa0593a: RTS
ffa0593c: ADD P5 += -0x1
ffa0593e: CC = P5 == 0x0
ffa05940: MOVE P1 = P2
ffa05942: LOAD R1 = W [P2++] (X)
ffa05944: IF CC JUMP 0xffa05954
ffa05946: LSETUP (0xffa0594a,0xffa05952) LC0 = P5
ffa0594a: SUB|| R2.L = R1.L - R0.L (s)
ffa0594e: LOAD R1 = W [P2++] (X)
ffa05950: NOP
ffa05952: STORE W [P1++] = R2
ffa05954: SUB R0.L = R1.L - R0.L (s)
ffa05958: STORE W [P1] = R0.L
ffa0595a: JUMP.S 0xffa05932
ffa0595c: LINK 0x0
ffa05960: PUSH [--SP] = (R7:4,P5:3)
ffa05962: ADD SP += -0xc
ffa05964: MOVE R5 = R2
ffa05966: ROT|| R6 = rot R1 by 0
ffa0596a: _LOAD R2 = [FP + 0x18]
ffa0596c: _NOP
ffa0596e: MOVE P4 = R1
ffa05970: LOAD R3 = 0x3
ffa05972: LOAD R1 = 0x3
ffa05974: CC = R2 < 0x0
ffa05976: STORE [SP + 0x34] = R3
ffa05978: STORE [SP + 0x30] = R1
ffa0597a: MOVE P5 = R0
ffa0597c: LOAD R4 = 0x0
ffa0597e: LOAD R7 = [SP + 0x3c]
ffa05980: IF CC JUMP 0xffa0598e
ffa05982: LOAD R1 = [FP + 0x18]
ffa05984: CC = R2 < 0x3
ffa05986: ADD R1 += 0x1
ffa05988: IF CC R3 = R1
ffa0598a: IF CC R4 = R2
ffa0598c: STORE [SP + 0x30] = R3
ffa0598e: LSH R2 = R6 << 0x2
ffa05992: LOAD R1 = 0x0
ffa05994: CALL 0xffa05f2e
ffa05998: CC = R5 < R7
ffa0599a: IF !CC JUMP 0xffa05a4c
ffa0599c: ROT|| R2 = rot R4 by 0
ffa059a0: _LOAD R0 = [SP + 0x34]
ffa059a2: _NOP
ffa059a4: MULT|| R0 = R5.L * R0.L (is)
ffa059a8: LOAD R1 = [SP + 0x30]
ffa059aa: NOP
ffa059ac: MOVE R2 = R2.L (X)
ffa059ae: MOVE R1 = R1.L (X)
ffa059b0: ADD R0 = R2 + R0
ffa059b2: STORE [SP + 0x30] = R1
ffa059b4: MOVE P1 = R0
ffa059b6: ADD R4 += 0x1
ffa059b8: ADD R5 += 0x1
ffa059ba: MOVE R3 = R4.L (X)
ffa059bc: ADD R7 += 0x1
ffa059be: MOVE R5 = R5.L (X)
ffa059c0: LOAD R4 = [SP + 0x3c]
ffa059c2: CC = R4 <= R5
ffa059c4: SUB R7 = R7 - R5
ffa059c6: LOAD R0 = 0x1
ffa059c8: LOAD R4 = [SP + 0x30]
ffa059ca: IF CC R7 = R0
ffa059cc: LOAD P0.L = 0x2d7c
ffa059d0: LOAD P0.H = 0x202d
ffa059d4: CC = R2 < R4
ffa059d6: ADD P2 = P0 + (P1 << 1)
ffa059d8: ADD R1 += 0x1
ffa059da: IF !CC JUMP 0xffa05a4c
ffa059dc: MOVE P3 = P5
ffa059de: ADD P3 += 0x4
ffa059e0: LOAD M0 = 0x8
ffa059e4: SUB|| R0 = R1 - R3 (ns)
ffa059e8: _LOAD R5 = [SP + 0x30]
ffa059ea: _NOP
ffa059ec: CC = R5 <= R3
ffa059ee: LOAD R2 = 0x1
ffa059f0: IF CC R0 = R2
ffa059f2: MOVE P1 = R0
ffa059f4: MOVE P0 = P2
ffa059f6: LSETUP (0xffa059fa,0xffa05a42) LC1 = P1
ffa059fa: CC = R6 < 0x1
ffa059fc: LOAD R0 = W [P0++] (X)
ffa059fe: LSHIFT R0 <<= 0x4
