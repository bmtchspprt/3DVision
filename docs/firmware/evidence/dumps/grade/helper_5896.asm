######## FFA05896
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
ffa05a00: ABS R0 = abs R0 (v)
ffa05a04: MOVE R5 = R0.L (X)
ffa05a06: LOAD R0 = 0x0
ffa05a08: IF CC JUMP 0xffa05a22
ffa05a0a: MOVE P1 = P5
ffa05a0c: LOAD R2 = 0x0
ffa05a0e: LSETUP (0xffa05a12,0xffa05a1e) LC0 = P4
ffa05a12: ROT|| R0 = rot R2 by 0
ffa05a16: _LOAD R4 = [P1++]
ffa05a18: _NOP
ffa05a1a: CC = R5 <= R4
ffa05a1c: ADD R2 += 0x1
ffa05a1e: IF CC JUMP 0xffa05a22
ffa05a20: MOVE R0 = R2
ffa05a22: MOVE R0 = R0.L (X)
ffa05a24: CC = R0 <= 0x0
ffa05a26: IF CC JUMP 0xffa05a42
ffa05a28: MOVE P1 = R0
ffa05a2a: MOVE I0 = P3
ffa05a2c: ADD P1 += -0x1
ffa05a2e: CC = P1 <= 0x0
ffa05a30: IF CC JUMP 0xffa05a3e
ffa05a32: NOP
ffa05a34: NOP
ffa05a36: LSETUP (0xffa05a3a,0xffa05a3c) LC0 = P1
ffa05a3a: LOAD R0 = [I0--]
ffa05a3c: STORE [I0 ++ M0] = R0
ffa05a3e: ADD P1 = P5 + (P1 << 2)
ffa05a40: STORE [P1] = R5
ffa05a42: NOP
ffa05a44: ADD R7 += -0x1
ffa05a46: CC = R7 == 0x0
ffa05a48: ADD P2 += 0x6
ffa05a4a: IF !CC JUMP 0xffa059e4 (bp)
ffa05a4c: ADD SP += 0xc
ffa05a4e: POP (R7:4,P5:3) = [SP++]
ffa05a50: UNLINK
ffa05a54: RTS
ffa05a56: LINK 0x0
ffa05a5a: PUSH [--SP] = (R7:4,P5:3)
ffa05a5c: ADD SP += -0xc
ffa05a5e: LOAD P1 = [SP + 0x3c]
ffa05a60: LOAD P0.L = 0x2850
ffa05a64: LOAD P0.H = 0x202d
ffa05a68: LOAD R3 = [FP + 0x18]
ffa05a6a: CC = R3 == 0x0
ffa05a6c: ADD P1 = P0 + (P1 << 2)
ffa05a6e: LOAD P1 = [P1]
ffa05a70: STORE [SP + 0x30] = R1
ffa05a72: MOVE P4 = R2
ffa05a74: MOVE P5 = R0
ffa05a76: LOAD R7 = W [P1 + 0x5776] (X)
ffa05a7a: IF CC JUMP 0xffa05bb4
ffa05a7c: CC = R7 <= 0x0
ffa05a7e: LOAD R1 = 0x0
ffa05a80: IF CC JUMP 0xffa05b00
ffa05a82: LOAD P3 = [SP + 0x30]
ffa05a84: MOVE P1 = P5
ffa05a86: MOVE P0 = R7
ffa05a88: LOAD R3 = W [P1++] (X)
ffa05a8a: MOVE P2 = P4
ffa05a8c: NEG R0 = -R3
ffa05a8e: LOAD R6 = W [P2++] (X)
ffa05a90: LOAD R1 = W [P2++] (X)
ffa05a92: MULT R3 = R3.L * R6.L (is)
ffa05a96: LOAD R5 = W [P3++] (X)
ffa05a98: MULT R0 *= R1
ffa05a9a: MULT R1 = R5.L * R1.L (is)
ffa05a9e: MULT R5 = R6.L * R5.L (is)
ffa05aa2: ADD R3 = R3 + R1
ffa05aa4: ADD R0 = R0 + R5
ffa05aa6: ADD P0 += -0x1
ffa05aa8: NEG R1 = -R3
ffa05aaa: NEG R5 = -R0
ffa05aac: CC = P0 == 0x0
ffa05aae: MAX R3 = max(R1,R3)
ffa05ab2: MAX R0 = max(R5,R0)
ffa05ab6: LOAD R2 = 0x0
ffa05ab8: IF CC JUMP 0xffa05af8
ffa05aba: LSETUP (0xffa05abe,0xffa05af4) LC0 = P0
ffa05abe: MAX|| R1 = max(R2,R3)
ffa05ac2: _LOAD R3 = W [P3++] (X)
ffa05ac4: _NOP
ffa05ac6: MAX|| R2 = max(R1,R0)
ffa05aca: _LOAD R0 = W [P1++] (X)
ffa05acc: _NOP
ffa05ace: NEG|| R1 = -R0 (ns)
ffa05ad2: _LOAD R5 = W [P2++] (X)
ffa05ad4: _NOP
ffa05ad6: MULT R6 = R5.L * R3.L (is)
ffa05ada: MULT|| R5 = R0.L * R5.L (is)
ffa05ade: LOAD R0 = W [P2++] (X)
ffa05ae0: NOP
ffa05ae2: MULT R3 = R3.L * R0.L (is)
ffa05ae6: MULT R0 *= R1
ffa05ae8: ADD R1 = R5 + R3
ffa05aea: ADD R0 = R0 + R6
ffa05aec: NEG R3 = -R1
ffa05aee: NEG R6 = -R0
ffa05af0: MAX R3 = max(R3,R1)
ffa05af4: MAX R0 = max(R6,R0)
ffa05af8: MAX R1 = max(R2,R3)
ffa05afc: MAX R1 = max(R1,R0)
ffa05b00: CC = R1 == 0x0

######## FFA03358
ffa03358: LINK 0x0
ffa0335c: PUSH [--SP] = (R7:4)
ffa0335e: MOVE R7 = R1
ffa03360: MOVE R4 = R2
ffa03362: MOVE R5 = R0
ffa03364: MOVE R6 = R0
ffa03366: ADD SP += -0xc
ffa03368: MOVE R1 = R4
ffa0336a: MOVE R0 = R7
ffa0336c: CALL 0xffa0165c
ffa03370: IF !CC JUMP 0xffa033b2
ffa03372: MOVE R1 = R5
ffa03374: MOVE R0 = R7
ffa03376: CALL 0xffa01630
ffa0337a: LOAD R0 = 0x0
ffa0337c: IF CC JUMP 0xffa033a8
ffa0337e: MOVE R0 = R6
ffa03380: MOVE R1 = R4
ffa03382: CALL 0xffa01630
ffa03386: LOAD R0 = 0x0
ffa03388: LOAD R0.H = 0x3f80
ffa0338c: IF CC JUMP 0xffa033a8
ffa0338e: MOVE R1 = R7
ffa03390: MOVE R0 = R6
ffa03392: CALL 0xffa01714
ffa03396: MOVE R6 = R0
ffa03398: MOVE R1 = R7
ffa0339a: MOVE R0 = R4
ffa0339c: CALL 0xffa01714
ffa033a0: MOVE R1 = R0
ffa033a2: MOVE R0 = R6
ffa033a4: CALL 0xffa01814
ffa033a8: ADD SP += 0xc
ffa033aa: POP (R7:4) = [SP++]
ffa033ac: UNLINK
ffa033b0: RTS
ffa033b2: MOVE R1 = R7
ffa033b4: MOVE R0 = R4
ffa033b6: LOAD R6 = 0x0
ffa033b8: CALL 0xffa0165c
ffa033bc: LOAD R6.H = 0x3f80
ffa033c0: MOVE R0 = R6
ffa033c2: IF !CC JUMP 0xffa033a8
ffa033c4: MOVE R1 = R7
ffa033c6: MOVE R0 = R5
ffa033c8: CALL 0xffa01630
ffa033cc: LOAD R0 = 0x0
ffa033ce: IF CC JUMP 0xffa033a8
ffa033d0: MOVE R1 = R5
ffa033d2: MOVE R0 = R4
ffa033d4: CALL 0xffa01630
ffa033d8: MOVE R0 = R6
ffa033da: IF CC JUMP 0xffa033a8
ffa033dc: MOVE R1 = R5
ffa033de: MOVE R0 = R7
ffa033e0: CALL 0xffa01714
ffa033e4: MOVE R6 = R0
ffa033e6: MOVE R1 = R4
ffa033e8: MOVE R0 = R7
ffa033ea: CALL 0xffa01714
ffa033ee: MOVE R1 = R0
ffa033f0: MOVE R0 = R6
ffa033f2: CALL 0xffa01814
ffa033f6: JUMP.S 0xffa033a8
ffa033f8: LINK 0x14
ffa033fc: PUSH [--SP] = (P5:3)
ffa033fe: STORE W [FP + 0xc] = R1
ffa03400: STORE [FP + 0x8] = R0
ffa03402: LOAD R2 = 0x0
ffa03404: STORE W [FP + -0x8] = R2
ffa03408: MOVE P0 = FP
ffa0340a: ADD P0 += -0x8
ffa0340c: LOAD R0 = W [P0] (X)
ffa0340e: MOVE P1 = FP
ffa03410: ADD P1 += 0xc
ffa03412: LOAD R1 = W [P1] (X)
ffa03414: CC = R1 <= R0
ffa03416: IF CC JUMP 0xffa03430
ffa03418: MOVE P1 = R0
ffa0341a: LOAD P2.L = 0xa340
ffa0341e: LOAD P2.H = 0x2022
ffa03422: ADD P1 = P2 + (P1 << 1)
ffa03424: STORE W [P1] = R0.L
ffa03426: LOAD R0 = W [P0] (X)
ffa03428: ADD R0 += 0x1
ffa0342a: STORE W [FP + -0x8] = R0
ffa0342e: JUMP.S 0xffa03408
ffa03430: LOAD R0 = W [FP + 0xc] (X)
ffa03432: LOAD R1 = 0x1000
ffa03436: CC = R1 < R0
ffa03438: IF CC JUMP 0xffa0343e
ffa0343a: CC = R0 == 0x0
ffa0343c: IF !CC JUMP 0xffa0344a (bp)
ffa0343e: LOAD R0.L = 0xa340
ffa03442: LOAD R0.H = 0x2022
ffa03446: STORE [FP + -0xc] = R0
ffa03448: JUMP.S 0xffa03610
ffa0344a: LOAD P2.L = 0x5f40
ffa0344e: LOAD P2.H = 0x2022
ffa03452: STORE W [P2] = R2.L
ffa03454: LOAD P0.L = 0x8140
ffa03458: LOAD P0.H = 0x2022
ffa0345c: STORE W [P0] = R0.L
ffa0345e: STORE W [FP + -0x8] = R2
ffa03462: LOAD R0 = W [FP + -0x8] (X)
ffa03466: CC = R0 < 0x0
ffa03468: IF CC JUMP 0xffa03606
ffa0346a: NOP
ffa0346c: MOVE P1 = R0
ffa0346e: ADD P5 = P2 + (P1 << 1)
ffa03470: LOAD R2.L = W [P5]
ffa03472: STORE W [FP + -0x6] = R2
ffa03476: ADD P4 = P0 + (P1 << 1)
ffa03478: LOAD R1 = W [P4] (X)
ffa0347a: ADD R1 += -0x1
ffa0347c: STORE W [FP + -0x4] = R1
ffa03480: SUB R1.H = R2.L - R1.L (s)
ffa03484: MOVE CC = an
ffa03486: IF !CC JUMP 0xffa035fe
ffa03488: LOAD R0 = W [FP + -0x6] (X)
ffa0348c: MOVE P1 = R0
ffa0348e: LOAD P5.L = 0xa340
ffa03492: LOAD P5.H = 0x2022
ffa03496: ADD P1 = P5 + (P1 << 1)
ffa03498: LOAD R0 = W [P1] (X)
ffa0349a: STORE W [FP + 0x12] = R0
ffa0349c: LOAD P4 = [FP + 0x8]
ffa0349e: MOVE P1 = R0
ffa034a0: ADD P1 = P4 + (P1 << 1)
ffa034a2: LOAD R0.L = W [P1]
ffa034a4: STORE W [FP + 0x10] = R0
ffa034a6: LOAD R2 = W [FP + -0x6] (X)
ffa034aa: LOAD R0 = W [FP + -0x4] (X)
ffa034ae: CC = R0 <= R2
ffa034b0: IF CC JUMP 0xffa03550
ffa034b2: LOAD P4 = [FP + 0x8]
ffa034b4: MOVE P1 = FP
ffa034b6: ADD P1 += -0x4
ffa034b8: STORE [FP + -0x14] = P1
ffa034ba: LOAD R0 = W [P1] (X)
ffa034bc: MOVE P1 = R0
ffa034be: ADD P1 = P5 + (P1 << 1)
ffa034c0: LOAD R1 = W [P1] (X)
ffa034c2: MOVE P1 = R1
ffa034c4: ADD P1 = P4 + (P1 << 1)
ffa034c6: LOAD R1 = W [P1] (X)
ffa034c8: MOVE P4 = FP
ffa034ca: ADD P4 += 0x10
ffa034cc: LOAD R3 = W [P4] (X)
ffa034ce: CC = R3 < R1
ffa034d0: IF CC JUMP 0xffa034de
ffa034d2: CC = R0 <= R2
ffa034d4: IF CC JUMP 0xffa034de
ffa034d6: ADD R0 += -0x1
ffa034d8: STORE W [FP + -0x4] = R0
ffa034dc: JUMP.S 0xffa034b2
ffa034de: LOAD R0 = W [FP + -0x4] (X)
ffa034e2: CC = R0 <= R2
ffa034e4: IF CC JUMP 0xffa034fc
ffa034e6: NOP
ffa034e8: MOVE P1 = R0
ffa034ea: ADD P1 = P5 + (P1 << 1)
ffa034ec: LOAD R0.L = W [P1]
ffa034ee: MOVE P1 = R2
ffa034f0: ADD P1 = P5 + (P1 << 1)
ffa034f2: STORE W [P1] = R0.L
ffa034f4: ADD R2 += 0x1
ffa034f6: STORE W [FP + -0x6] = R2
ffa034fa: JUMP.S 0xffa034fc
ffa034fc: MOVE P1 = FP
ffa034fe: ADD P1 += -0x6
ffa03500: LOAD R0 = W [P1] (X)

######## ffa00ca4
ffa00ca4: LINK 0x0
ffa00ca8: PUSH [--SP] = (R7:6)
ffa00caa: ADD SP += -0xc
ffa00cac: MOVE R7 = R0
ffa00cae: CALL 0xffa00da4
ffa00cb2: MOVE R6 = R0
ffa00cb4: MOVE R0 = R7
ffa00cb6: CALL 0xffa020d4
ffa00cba: ADD SP += 0xc
ffa00cbc: MOVE R1 = R0
ffa00cbe: MOVE R0 = R6
ffa00cc0: POP (R7:6) = [SP++]
ffa00cc2: UNLINK
ffa00cc6: RTS
ffa00cc8: PUSH [--SP] = (R7:6)
ffa00cca: LOAD R3 = [SP + 0x14]
ffa00ccc: CC = R3 <= 0x0
ffa00cce: IF CC JUMP 0xffa00d7a
ffa00cd0: CC = R1 <= 0x0
ffa00cd2: IF CC JUMP 0xffa00d7a
ffa00cd4: MOVE R6 = R0
ffa00cd6: MOVE R7 = R1
ffa00cd8: CC = R1 < R3
ffa00cda: IF CC R0 = R2
ffa00cdc: IF CC R1 = R3
ffa00cde: IF CC R2 = R6
ffa00ce0: IF CC R3 = R7
ffa00ce2: LSH R7 = R1 << 0x1
ffa00ce6: MOVE B0 = R0
ffa00ce8: MOVE I0 = R0
ffa00cea: MOVE L0 = R7
ffa00cec: LSH R6 = R3 << 0x1
ffa00cf0: MOVE B1 = R2
ffa00cf2: MOVE I1 = R2
ffa00cf4: MOVE L1 = R6
ffa00cf6: ADD R3 += -0x1
ffa00cf8: SUB R6 = R1 - R3
ffa00cfa: LOAD R2 = -0x3
ffa00cfc: ADD R2 = (R2 + R6) << 1
ffa00cfe: MOVE M1 = R2
ffa00d00: LOAD R0 = [SP + 0x18]
ffa00d02: ADD R7 = R0 + R7
ffa00d04: MOVE I3 = R7
ffa00d06: MOVE I2 = R0
ffa00d08: MOVE P0 = R3
ffa00d0a: LOAD P1 = 0x1
ffa00d0c: MOVE P2 = R6
ffa00d0e: CC = R3 == 0x0
ffa00d10: IF CC JUMP 0xffa00d86
ffa00d12: LSH R6 = R6 << 0x1
ffa00d16: MOVE M0 = R6
ffa00d18: LSETUP (0xffa00d1c,0xffa00d48) LC0 = P0
ffa00d1c: CLR|| A1 = A0 = 0
ffa00d20: _LOAD R0.L = W [I0--]
ffa00d22: _LOAD R1.L = W [I1++]
ffa00d24: LSETUP (0xffa00d28,0xffa00d28) LC1 = P1
ffa00d28: MAC|| R2.L = (A0 += R0.L * R1.L) 
ffa00d2c: LOAD R0.L = W [I0--]
ffa00d2e: LOAD R1.L = W [I1++]
ffa00d30: ADD P1 += 0x1
ffa00d32: LSETUP (0xffa00d36,0xffa00d36) LC1 = P0
ffa00d36: MAC|| R3.H = (A1 += R0.L * R1.L) 
ffa00d3a: LOAD R0.L = W [I0--]
ffa00d3c: LOAD R1.L = W [I1++]
ffa00d3e: ADD P0 += -0x1
ffa00d40: MNOP||
ffa00d44: _SUB I1 -= 2
ffa00d46: _STORE W [I2++] = R2.L
ffa00d48: MNOP||
ffa00d4c: _SUB I0 -= M1
ffa00d4e: _STORE W [I3++] = R3.H
ffa00d50: ADD P1 += -0x1
ffa00d52: MOVE I0 = B0
ffa00d54: SUB I1 -= 2
ffa00d56: LSETUP (0xffa00d5a,0xffa00d72) LC0 = P2
ffa00d5a: CLR|| A0 = 0
ffa00d5e: _LOAD R0.L = W [I0++]
ffa00d60: _LOAD R1.L = W [I1--]
ffa00d62: LSETUP (0xffa00d66,0xffa00d66) LC1 = P1
ffa00d66: MAC|| A0 += R0.L * R1.L 
ffa00d6a: LOAD R0.L = W [I0++]
ffa00d6c: LOAD R1.L = W [I1--]
ffa00d6e: MAC R2.L = (A0 += R0.L * R1.L) 
ffa00d72: MNOP||
ffa00d76: _ADD I0 += M0
ffa00d78: _STORE W [I2++] = R2.L
ffa00d7a: POP (R7:6) = [SP++]
ffa00d7c: LOAD L0 = 0x0
ffa00d80: LOAD L1 = 0x0
ffa00d84: RTS
ffa00d86: MNOP||
ffa00d8a: _LOAD R0.L = W [I0++]
ffa00d8c: _LOAD R1.L = W [I1]
ffa00d8e: MAC|| R2.L = (A0 = R0.L * R1.L) 
ffa00d92: LOAD R0.L = W [I0++]
ffa00d94: NOP
ffa00d96: LSETUP (0xffa00d9a,0xffa00d9a) LC0 = P2
ffa00d9a: MAC|| R2.L = (A0 = R0.L * R1.L) 
ffa00d9e: LOAD R0.L = W [I0++]
ffa00da0: STORE W [I2++] = R2.L
ffa00da2: JUMP.S 0xffa00d7a
ffa00da4: LINK 0x8
ffa00da8: PUSH [--SP] = (R7:4,P5:5)
ffa00daa: MOVE R7 = R0
ffa00dac: LOAD R1 = 0xe00
ffa00db0: BITCLR (R7,0x1f)
ffa00db2: MOVE R0 = R1
ffa00db4: LOAD R0.H = 0x47c9
ffa00db8: CC = R7 <= R0
ffa00dba: ADD SP += -0x10
ffa00dbc: IF !CC JUMP 0xffa00f84
ffa00dbe: MOVE R1 = R7
ffa00dc0: LOAD R0 = -0x67d
ffa00dc4: LOAD R0.H = 0x3ea2

######## ffa00ae4
ffa00ae4: LINK 0x0
ffa00ae8: MOVE R2 = R0
ffa00aea: MOVE R3 = R1
ffa00aec: PUSH [--SP] = (R7:4)
ffa00aee: MOVE R7 = R2
ffa00af0: BITCLR (R3,0x1f)
ffa00af2: BITCLR (R7,0x1f)
ffa00af4: CC = R3 == 0x0
ffa00af6: ADD SP += -0xc
ffa00af8: MOVE R0 = R7
ffa00afa: IF CC JUMP 0xffa00b7a
ffa00afc: CC = R7 == 0x0
ffa00afe: MOVE R0 = R3
ffa00b00: IF CC JUMP 0xffa00b7a
ffa00b02: LOAD R5 = 0x0
ffa00b04: LOAD R5.H = 0x7f80
ffa00b08: MOVE R0 = R7
ffa00b0a: AND R6 = R2 & R5
ffa00b0c: AND R7 = R1 & R5
ffa00b0e: LOAD R4 = 0x0
ffa00b10: ADDSUB R7 = R6 + R7,R6 = R6 - R7 (ns)
ffa00b14: LOAD R4.H = 0x680
ffa00b18: CC = R4 < R6
ffa00b1a: IF CC JUMP 0xffa00b7a
ffa00b1c: MOVE R0 = R3
ffa00b1e: LOAD R4 = 0x0
ffa00b20: LOAD R4.H = 0xf980
ffa00b24: CC = R6 < R4
ffa00b26: IF CC JUMP 0xffa00b7a (bp)
ffa00b28: LSHIFT R7 >>= 0x1
ffa00b2a: AND R4 = R7 & R5
ffa00b2c: AND R3 = R2 & R5
ffa00b2e: SUB R3 = R3 - R4
ffa00b30: STORE [SP + 0x2c] = R3
ffa00b32: LOAD R6 = -0x1
ffa00b34: AND R0 = R1 & R5
ffa00b36: LOAD R6.H = 0x807f
ffa00b3a: SUB R7 = R0 - R4
ffa00b3c: AND R0 = R1 & R6
ffa00b3e: LOAD R3 = 0x0
ffa00b40: LOAD R1 = [SP + 0x2c]
ffa00b42: LOAD R3.H = 0x3f80
ffa00b46: ADD R1 = R1 + R3
ffa00b48: AND R2 = R2 & R6
ffa00b4a: ADD R7 = R7 + R3
ffa00b4c: OR R1 = R1 | R2
ffa00b4e: OR R7 = R7 | R0
ffa00b50: MOVE R0 = R1
ffa00b52: CALL 0xffa018f0
ffa00b56: STORE [SP + 0x2c] = R0
ffa00b58: MOVE R1 = R7
ffa00b5a: MOVE R0 = R7
ffa00b5c: CALL 0xffa018f0
ffa00b60: LOAD R1 = [SP + 0x2c]
ffa00b62: CALL 0xffa01716
ffa00b66: CALL 0xffa0248c
ffa00b6a: LOAD R2 = 0x0
ffa00b6c: LOAD R2.H = 0xc080
ffa00b70: AND R1 = R0 & R5
ffa00b72: ADD R2 = R4 + R2
ffa00b74: AND R3 = R0 & R6
ffa00b76: ADD R1 = R1 + R2
ffa00b78: OR R0 = R1 | R3
ffa00b7a: ADD SP += 0xc
ffa00b7c: POP (R7:4) = [SP++]
ffa00b7e: UNLINK
ffa00b82: RTS
ffa00b84: LINK 0xc
ffa00b88: PUSH [--SP] = (R7:4)
ffa00b8a: MOVE R5 = R2
ffa00b8c: BITCLR (R2,0x1f)
ffa00b8e: CC = R2 == 0x0
ffa00b90: MOVE R6 = R1
ffa00b92: MOVE R4 = R0
ffa00b94: ADD SP += -0xc
ffa00b96: IF !CC JUMP 0xffa00bb4
ffa00b98: LOAD R1 = [SP + 0x3c]
ffa00b9a: BITCLR (R1,0x1f)
ffa00b9c: CC = R1 == 0x0
ffa00b9e: IF !CC JUMP 0xffa00bb4
ffa00ba0: LOAD R0 = 0x0
ffa00ba2: STORE [SP + 0x20] = R0
ffa00ba4: STORE [SP + 0x24] = R0
ffa00ba6: LOAD R0 = [SP + 0x20]
ffa00ba8: LOAD R1 = [SP + 0x24]
ffa00baa: ADD SP += 0xc
ffa00bac: POP (R7:4) = [SP++]
ffa00bae: UNLINK
ffa00bb2: RTS
ffa00bb4: CC = R2 == 0x0
ffa00bb6: LOAD R7 = [SP + 0x3c]
ffa00bb8: IF !CC JUMP 0xffa00bd2
ffa00bba: MOVE R0 = R6
ffa00bbc: MOVE R1 = R7
ffa00bbe: CALL 0xffa01814
ffa00bc2: STORE [SP + 0x20] = R0
ffa00bc4: MOVE R1 = R7
ffa00bc6: MOVE R0 = R4
ffa00bc8: CALL 0xffa01814
ffa00bcc: BITTGL (R0,0x1f)
ffa00bce: STORE [SP + 0x24] = R0
ffa00bd0: JUMP.S 0xffa00ba6
ffa00bd2: MOVE R1 = R7
ffa00bd4: BITCLR (R1,0x1f)
ffa00bd6: CC = R1 == 0x0
ffa00bd8: IF !CC JUMP 0xffa00bee
ffa00bda: MOVE R1 = R5
ffa00bdc: CALL 0xffa01814
ffa00be0: STORE [SP + 0x20] = R0
ffa00be2: MOVE R1 = R5
ffa00be4: MOVE R0 = R6
ffa00be6: CALL 0xffa01814
ffa00bea: STORE [SP + 0x24] = R0
ffa00bec: JUMP.S 0xffa00ba6
ffa00bee: MOVE R0 = R2
ffa00bf0: CALL 0xffa01630
ffa00bf4: IF !CC JUMP 0xffa00c4e
ffa00bf6: MOVE R1 = R5
ffa00bf8: MOVE R0 = R7
ffa00bfa: CALL 0xffa01814
ffa00bfe: STORE [SP + 0x1c] = R0
ffa00c00: MOVE R0 = R7
ffa00c02: LOAD R1 = [SP + 0x1c]
ffa00c04: CALL 0xffa018f0

######## ffa00b84
ffa00b84: LINK 0xc
ffa00b88: PUSH [--SP] = (R7:4)
ffa00b8a: MOVE R5 = R2
ffa00b8c: BITCLR (R2,0x1f)
ffa00b8e: CC = R2 == 0x0
ffa00b90: MOVE R6 = R1
ffa00b92: MOVE R4 = R0
ffa00b94: ADD SP += -0xc
ffa00b96: IF !CC JUMP 0xffa00bb4
ffa00b98: LOAD R1 = [SP + 0x3c]
ffa00b9a: BITCLR (R1,0x1f)
ffa00b9c: CC = R1 == 0x0
ffa00b9e: IF !CC JUMP 0xffa00bb4
ffa00ba0: LOAD R0 = 0x0
ffa00ba2: STORE [SP + 0x20] = R0
ffa00ba4: STORE [SP + 0x24] = R0
ffa00ba6: LOAD R0 = [SP + 0x20]
ffa00ba8: LOAD R1 = [SP + 0x24]
ffa00baa: ADD SP += 0xc
ffa00bac: POP (R7:4) = [SP++]
ffa00bae: UNLINK
ffa00bb2: RTS
ffa00bb4: CC = R2 == 0x0
ffa00bb6: LOAD R7 = [SP + 0x3c]
ffa00bb8: IF !CC JUMP 0xffa00bd2
ffa00bba: MOVE R0 = R6
ffa00bbc: MOVE R1 = R7
ffa00bbe: CALL 0xffa01814
ffa00bc2: STORE [SP + 0x20] = R0
ffa00bc4: MOVE R1 = R7
ffa00bc6: MOVE R0 = R4
ffa00bc8: CALL 0xffa01814
ffa00bcc: BITTGL (R0,0x1f)
ffa00bce: STORE [SP + 0x24] = R0
ffa00bd0: JUMP.S 0xffa00ba6
ffa00bd2: MOVE R1 = R7
ffa00bd4: BITCLR (R1,0x1f)
ffa00bd6: CC = R1 == 0x0
ffa00bd8: IF !CC JUMP 0xffa00bee
ffa00bda: MOVE R1 = R5
ffa00bdc: CALL 0xffa01814
ffa00be0: STORE [SP + 0x20] = R0
ffa00be2: MOVE R1 = R5
ffa00be4: MOVE R0 = R6
ffa00be6: CALL 0xffa01814
ffa00bea: STORE [SP + 0x24] = R0
ffa00bec: JUMP.S 0xffa00ba6
ffa00bee: MOVE R0 = R2
ffa00bf0: CALL 0xffa01630
ffa00bf4: IF !CC JUMP 0xffa00c4e
ffa00bf6: MOVE R1 = R5
ffa00bf8: MOVE R0 = R7
ffa00bfa: CALL 0xffa01814
ffa00bfe: STORE [SP + 0x1c] = R0
ffa00c00: MOVE R0 = R7
ffa00c02: LOAD R1 = [SP + 0x1c]
ffa00c04: CALL 0xffa018f0
ffa00c08: MOVE R1 = R5
ffa00c0a: CALL 0xffa01716
ffa00c0e: MOVE R1 = R0
ffa00c10: LOAD R0 = 0x0
ffa00c12: LOAD R0.H = 0x3f80
ffa00c16: CALL 0xffa01814
ffa00c1a: MOVE R7 = R0
ffa00c1c: MOVE R5 = R0
ffa00c1e: MOVE R0 = R6
ffa00c20: LOAD R1 = [SP + 0x1c]
ffa00c22: CALL 0xffa018f0
ffa00c26: MOVE R1 = R4
ffa00c28: CALL 0xffa01716
ffa00c2c: MOVE R1 = R7
ffa00c2e: CALL 0xffa018f0
ffa00c32: STORE [SP + 0x20] = R0
ffa00c34: MOVE R0 = R4
ffa00c36: LOAD R1 = [SP + 0x1c]
ffa00c38: CALL 0xffa018f0
ffa00c3c: MOVE R1 = R0
ffa00c3e: MOVE R0 = R6
ffa00c40: CALL 0xffa01714
ffa00c44: MOVE R1 = R5
ffa00c46: CALL 0xffa018f0
ffa00c4a: STORE [SP + 0x24] = R0
ffa00c4c: JUMP.S 0xffa00ba6
ffa00c4e: MOVE R1 = R7
ffa00c50: MOVE R0 = R5
ffa00c52: CALL 0xffa01814
ffa00c56: STORE [SP + 0x1c] = R0
ffa00c58: MOVE R0 = R5
ffa00c5a: LOAD R1 = [SP + 0x1c]
ffa00c5c: CALL 0xffa018f0
ffa00c60: MOVE R1 = R7
ffa00c62: CALL 0xffa01716
ffa00c66: MOVE R1 = R0
ffa00c68: LOAD R0 = 0x0
ffa00c6a: LOAD R0.H = 0x3f80
ffa00c6e: CALL 0xffa01814
ffa00c72: MOVE R7 = R0
ffa00c74: MOVE R5 = R0
ffa00c76: MOVE R1 = R4
ffa00c78: LOAD R0 = [SP + 0x1c]
ffa00c7a: CALL 0xffa018f0
ffa00c7e: MOVE R1 = R6
ffa00c80: CALL 0xffa01716
ffa00c84: MOVE R1 = R7
ffa00c86: CALL 0xffa018f0
ffa00c8a: STORE [SP + 0x20] = R0
ffa00c8c: MOVE R0 = R6
ffa00c8e: LOAD R1 = [SP + 0x1c]
ffa00c90: CALL 0xffa018f0
ffa00c94: MOVE R1 = R4
ffa00c96: CALL 0xffa01714
ffa00c9a: MOVE R1 = R5
ffa00c9c: CALL 0xffa018f0
ffa00ca0: STORE [SP + 0x24] = R0
ffa00ca2: JUMP.S 0xffa00ba6
ffa00ca4: LINK 0x0

######## ffa01150
ffa01150: LOAD R3 = [SP + 0xc]
ffa01152: CC = R3 < 0x0
ffa01154: IF CC JUMP 0xffa0118a
ffa01156: CC = R1 < 0x0
ffa01158: IF CC JUMP 0xffa0115c
ffa0115a: JUMP.S 0xffa0125a
ffa0115c: STORE [SP + 0x8] = R7
ffa0115e: MOVE P2 = RETS
ffa01160: NEG R0 = -R0
ffa01162: MOVE CC = az
ffa01164: MOVE R7 = CC
ffa01166: NOT R1 = ~R1
ffa01168: ADD R1 = R1 + R7
ffa0116a: CALL 0xffa0125a
ffa0116e: NEG R0 = -R0
ffa01170: MOVE CC = az
ffa01172: MOVE R7 = CC
ffa01174: NOT R1 = ~R1
ffa01176: ADD R1 = R1 + R7
ffa01178: NEG R2 = -R2
ffa0117a: MOVE CC = az
ffa0117c: MOVE R7 = CC
ffa0117e: NOT R3 = ~R3
ffa01180: ADD|| R3 = R3 + R7 (ns)
ffa01184: _LOAD R7 = [SP + 0x8]
ffa01186: _NOP
ffa01188: JUMP (P2)
ffa0118a: STORE [SP + 0x8] = R7
ffa0118c: MOVE P2 = RETS
ffa0118e: NEG R2 = -R2
ffa01190: MOVE CC = az
ffa01192: MOVE R7 = CC
ffa01194: NOT R3 = ~R3
ffa01196: ADD R3 = R3 + R7
ffa01198: CC = R1 < 0x0
ffa0119a: IF !CC JUMP 0xffa011bc
ffa0119c: NEG R0 = -R0
ffa0119e: MOVE CC = az
ffa011a0: MOVE R7 = CC
ffa011a2: NOT R1 = ~R1
ffa011a4: ADD R1 = R1 + R7
ffa011a6: CALL 0xffa0125a
ffa011aa: NEG R2 = -R2
ffa011ac: MOVE CC = az
ffa011ae: MOVE R7 = CC
ffa011b0: NOT R3 = ~R3
ffa011b2: ADD|| R3 = R3 + R7 (ns)
ffa011b6: _LOAD R7 = [SP + 0x8]
ffa011b8: _NOP
ffa011ba: JUMP (P2)
ffa011bc: CALL 0xffa0125a
ffa011c0: NEG R0 = -R0
ffa011c2: MOVE CC = az
ffa011c4: MOVE R7 = CC
ffa011c6: NOT R1 = ~R1
ffa011c8: ADD|| R1 = R1 + R7 (ns)
ffa011cc: _LOAD R7 = [SP + 0x8]
ffa011ce: _NOP
ffa011d0: JUMP (P2)
ffa011d4: LSH R2 = R0 >> 0x1
ffa011d8: CC = R2 < R1 (IU)
ffa011da: IF CC JUMP 0xffa01248
ffa011dc: LSH R3 = R1 >> 0x1
ffa011e0: SIGN R2.L = signbits R2
ffa011e4: SIGN R3.L = signbits R3
ffa011e8: MOVE R2 = R2.L (Z)
ffa011ea: MOVE R3 = R3.L (Z)
ffa011ec: LSHIFT R0 <<= R2
ffa011ee: LSHIFT R1 <<= R3
ffa011f0: SUB R2 = R3 - R2
ffa011f2: MOVE P1 = R2
ffa011f4: SUB R0 = R0 - R1
ffa011f6: LSH R2 = R1 << 0xf
ffa011fa: MOVE CC = R2
ffa011fc: IF CC JUMP 0xffa01224
ffa011fe: CC = BITTST (R0,0x1f)
ffa01200: MOVE aq = CC
ffa01202: LSH R2 = R1 >> 0x11
ffa01206: LSETUP (0xffa0120a,0xffa0120a) LC0 = P1
ffa0120a: DIVQ (R0,R2)
ffa0120c: NOT CC = !CC
ffa0120e: MOVE R2 = CC
ffa01210: MOVE CC = aq
ffa01212: ADD R1 = R0 + R1
ffa01214: IF !CC R1 = R0
ffa01216: LSHIFT R1 >>= R3
ffa01218: EXTRACT R0 = extract(R0,R3.L) (z)
ffa0121c: MOVE R3 = P1
ffa0121e: LSHIFT R2 <<= R3
ffa01220: OR R0 = R0 | R2
ffa01222: RTS
ffa01224: CC = !BITTST (R0,0x1f)
ffa01226: ASHIFT R1 >>>= 0x1
ffa01228: LSETUP (0xffa0122c,0xffa01232) LC0 = P1
ffa0122c: ADDSUB R0 = R0 + R1,R2 = R0 - R1 (ns)
ffa01230: IF CC R0 = R2
ffa01232: ROT R0 = rot R0 by 0x1
ffa01236: LSHIFT R1 <<= 0x1
ffa01238: ADD R1 = R0 + R1
ffa0123a: IF CC R1 = R0
ffa0123c: LSHIFT R1 >>= R3
ffa0123e: EXTRACT R0 = extract(R0,R3.L) (z)
ffa01242: ROT R0 = rot R0 by 0x1
ffa01246: RTS
ffa01248: CC = R1 <= R0 (IU)
ffa0124a: SUB R1 = R0 - R1
ffa0124c: IF !CC R1 = R0
ffa0124e: MOVE R0 = CC
ffa01250: RTS
ffa01258: LOAD R3 = [SP + 0xc]
ffa0125a: CC = R3 == 0x0
ffa0125c: IF !CC JUMP 0xffa012f0
ffa0125e: CC = R1 == 0x0
ffa01260: IF CC JUMP 0xffa01378
ffa01262: POPCNT|| R3.L = ones R2
ffa01266: STORE [SP] = R4
ffa01268: NOP
ffa0126a: CC = R3 == 0x1
ffa0126c: IF CC JUMP 0xffa012cc
ffa0126e: LSH R4 = R2 >> 0x1

######## ffa06ccc
ffa06ccc: ADD R0 = R0 + R1
ffa06cce: CC = R2 <= R0
ffa06cd0: LINK 0x0
ffa06cd4: IF !CC JUMP 0xffa06ce4
ffa06cd6: LOAD P1 = -0x1
ffa06cd8: LSETUP (0xffa06cdc,0xffa06ce0) LC0 = P1
ffa06cdc: SUB R0 = R0 - R2
ffa06cde: CC = R2 <= R0
ffa06ce0: IF !CC JUMP 0xffa06ce4
ffa06ce2: JUMP.S 0xffa06cd8
ffa06ce4: CC = R0 < 0x0
ffa06ce6: IF !CC JUMP 0xffa06cf6
ffa06ce8: LOAD P1 = -0x1
ffa06cea: LSETUP (0xffa06cee,0xffa06cf2) LC0 = P1
ffa06cee: ADD R0 = R2 + R0
ffa06cf0: CC = R0 < 0x0
ffa06cf2: IF !CC JUMP 0xffa06cf6
ffa06cf4: JUMP.S 0xffa06cea
ffa06cf6: UNLINK
ffa06cfa: RTS
ffa06cfc: LINK 0x28
ffa06d00: PUSH [--SP] = (R7:4,P5:3)
ffa06d02: ADD SP += -0x14
ffa06d04: LOAD R7.L = 0x6f30
ffa06d08: LOAD R7.H = 0xff80
ffa06d0c: ROT|| R1 = rot R2 by 0
ffa06d10: _STORE [SP + 0x34] = R1
ffa06d12: _NOP
ffa06d14: STORE [FP + -0x18] = R7
ffa06d16: LOAD R5 = [FP + 0x14]
ffa06d18: LSH|| R2 = R5 << 0x1
ffa06d1c: _LOAD R6 = [FP + 0x1c]
ffa06d1e: _NOP
ffa06d20: LOAD R3 = [SP + 0x34]
ffa06d22: PACK|| R6 = pack(R3.L,R6.L)
ffa06d26: _STORE [SP + 0x3c] = R0
ffa06d28: _NOP
ffa06d2a: LOAD R0 = [FP + -0x18]
ffa06d2c: CALL 0xffa05f92
ffa06d30: LOAD R4 = [FP + 0x18]
ffa06d32: CC = R4 <= 0x0
ffa06d34: LOAD P5 = [FP + 0x18]
ffa06d36: IF CC JUMP 0xffa06ec2
ffa06d38: LOAD R0 = 0x1000
ffa06d3c: SUB R0 = R0 - R5
ffa06d3e: LOAD R1.L = 0x6f20
ffa06d42: LOAD R1.H = 0xff80
ffa06d46: MULT R0 *= R4
ffa06d48: LOAD P0 = [SP + 0x3c]
ffa06d4a: LOAD R2 = 0x0
ffa06d4c: STORE [SP + 0x30] = R1
ffa06d4e: STORE [FP + -0x10] = R0
ffa06d50: STORE [SP + 0x38] = P0
ffa06d52: STORE [FP + -0x8] = R2
ffa06d54: LOAD P1 = [SP + 0x30]
ffa06d56: LOAD R7 = [FP + -0x8]
ffa06d58: LOAD R0 = [SP + 0x34]
ffa06d5a: LOAD R5 = [FP + -0x10]
ffa06d5c: ADD|| R1 = R5 + R7 (ns)
ffa06d60: _STORE [P1] = R7
ffa06d62: _NOP
ffa06d64: ADD R0 += -0x1
ffa06d66: MIN|| R2 = min(R0,R1)
ffa06d6a: _STORE [FP + 0xc] = R0
ffa06d6c: _NOP
ffa06d6e: LOAD R0.L = 0xc0
ffa06d72: LOAD R0.H = 0xff90
ffa06d76: CC = R7 <= R2
ffa06d78: SUB|| R7 = R7 - R7 (ns)
ffa06d7c: _STORE [P1 + 0x4] = R2
ffa06d7e: _NOP
ffa06d80: ADD|| R0 = R4 + R4 (ns)
ffa06d84: _STORE [FP + -0xc] = R0
ffa06d86: _NOP
ffa06d88: IF !CC JUMP 0xffa06db2
ffa06d8a: LOAD P0 = [FP + -0xc]
ffa06d8c: MOVE P1 = R0
ffa06d8e: LOAD P4 = -0x1
ffa06d90: LOAD P2 = [SP + 0x38]
ffa06d92: LOAD R1 = [FP + -0x8]
ffa06d94: LSETUP (0xffa06d98,0xffa06dae) LC0 = P4
ffa06d98: ADD R7 += 0x1
ffa06d9a: NOP
ffa06d9c: NOP
ffa06d9e: ADD|| R1 = R4 + R1 (ns)
ffa06da2: _LOAD R0.L = W [P2 ++ P1]
ffa06da4: _NOP
ffa06da6: CC = R1 <= R2
ffa06da8: MULT R0 = R6.L * R0.L (fu)
ffa06dac: STORE W [P0++] = R0
ffa06dae: IF !CC JUMP 0xffa06db2
ffa06db0: JUMP.S 0xffa06d94
ffa06db2: LOAD P1 = [FP + -0xc]
ffa06db4: LOAD P0.L = 0x20c0
ffa06db8: LOAD P0.H = 0xff90
ffa06dbc: STORE [FP + -0x14] = P1
ffa06dbe: STORE [FP + -0x4] = P0
ffa06dc0: SUB|| R5 = R5 - R5 (ns)
ffa06dc4: _LOAD P0 = [SP + 0x30]
ffa06dc6: _NOP
ffa06dc8: LOAD R0 = [FP + 0x14]
ffa06dca: STORE [SP + 0xc] = R0
ffa06dcc: LOAD R3 = [FP + 0x14]
ffa06dce: LOAD R1 = [P0 + 0x4]
ffa06dd0: LOAD P1 = [FP + -0x4]
ffa06dd2: ADD R3 += -0x1
ffa06dd4: ROT|| R1 = rot R7 by 0
ffa06dd8: _STORE [FP + 0x10] = R1
ffa06dda: _NOP
ffa06ddc: STORE [SP + 0x10] = P1
ffa06dde: LOAD R2 = [FP + -0x18]
ffa06de0: LOAD R0 = [FP + -0x14]
ffa06de2: STORE [FP + 0x8] = R3
ffa06de4: CALL 0xffa00cc8
ffa06de8: LOAD P1 = [SP + 0x30]
ffa06dea: LOAD R3 = [FP + -0x8]
ffa06dec: LOAD R0 = [FP + 0x8]

######## ffa058ac
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

