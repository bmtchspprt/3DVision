ffa053b0: LOAD R3 = W [P5] (X)
ffa053b2: LOAD R0 = 0x5cfc
ffa053b6: MULT|| R0 = R3.L * R0.L (is)
ffa053ba: STORE [SP + 0x10] = R3
ffa053bc: NOP
ffa053be: LOAD R2 = W [P1 + -0x6] (X)
ffa053c2: LOAD P0 = [FP + 0x1c]
ffa053c4: MOVE P1 = R0
ffa053c6: STORE [SP + 0x18] = P0
ffa053c8: LOAD P0 = [FP + 0xc]
ffa053ca: LOAD R1 = 0xc5e8
ffa053ce: LOAD R4 = [FP + 0x14]
ffa053d0: BITSET (R1,0x11)
ffa053d2: ADD P1 = P0 + P1
ffa053d4: LOAD R5 = B [P1 + 0x2] (Z)
ffa053d8: LOAD R6 = [FP + 0x24]
ffa053da: CC = R5 <= R4
ffa053dc: LOAD R7 = 0x85e8
ffa053e0: ADD|| R6 = R6 + R1 (ns)
ffa053e4: _LOAD R0 = [FP + 0x24]
ffa053e6: _NOP
ffa053e8: MOVE R1 = CC
ffa053ea: ADD|| R7 = R0 + R7 (ns)
ffa053ee: _LOAD P2 = [FP + 0x18]
ffa053f0: _NOP
ffa053f2: ROT|| R0 = rot R6 by 0
ffa053f6: _STORE [SP + 0x1c] = R1
ffa053f8: _NOP
ffa053fa: ROT|| R1 = rot R7 by 0
ffa053fe: _STORE [SP + 0xc] = R4
ffa05400: _NOP
ffa05402: STORE [SP + 0x14] = P2
ffa05404: CALL 0xffa043c4
ffa05408: LOAD P1 = [FP + -0x5c]
ffa0540a: LOAD R1 = W [P1 + 0x8] (X)
ffa0540c: LOAD R2 = W [P1 + -0x6] (X)
ffa05410: CC = R1 < R2
ffa05412: STORE [P1 + 0xc] = R0
ffa05414: IF CC JUMP 0xffa05418 (bp)
ffa05416: JUMP.S 0xffa0486a
ffa05418: LOAD R0 = W [P5] (X)
ffa0541a: LOAD R1 = 0x5cfc
ffa0541e: MULT R0 = R0.L * R1.L (is)
ffa05422: MOVE P1 = R0
ffa05424: LOAD P0 = [FP + 0xc]
ffa05426: ADD P1 = P0 + P1
ffa05428: LOAD R0 = B [P1 + 0x1] (Z)
ffa0542c: CC = R0 == 0x1
ffa0542e: IF CC JUMP 0xffa05432
ffa05430: JUMP.S 0xffa0486a
ffa05432: LOAD R3 = W [P5] (X)
ffa05434: MOVE R1 = R7
ffa05436: LOAD P0 = [FP + 0x1c]
ffa05438: MOVE R0 = R6
ffa0543a: LOAD P1 = 0x1
ffa0543c: LOAD P2 = [FP + 0x18]
ffa0543e: STORE [SP + 0x10] = R3
ffa05440: STORE [SP + 0x1c] = P1
ffa05442: STORE [SP + 0x14] = P2
ffa05444: STORE [SP + 0xc] = R4
ffa05446: STORE [SP + 0x18] = P0
ffa05448: CALL 0xffa043c4
ffa0544c: LOAD P0 = [FP + -0x5c]
ffa0544e: MOVE R6 = R0
ffa05450: LOAD R5 = W [P0 + 0x8] (X)
ffa05452: LOAD R1 = W [P0 + -0x6] (X)
ffa05456: STORE [P0 + 0x10] = R0
ffa05458: SUB R0 = R1 - R5
ffa0545a: CALL 0xffa01688
ffa0545e: LOAD R2 = [FP + 0x8]
ffa05460: MOVE R7 = R0
ffa05462: SUB R0 = R2 - R5
ffa05464: CALL 0xffa01688
ffa05468: MOVE R1 = R0
ffa0546a: MOVE R0 = R7
ffa0546c: CALL 0xffa01814
ffa05470: MOVE R7 = R0
ffa05472: MOVE R0 = R6
ffa05474: MOVE R1 = R7
ffa05476: STORE [P0 + 0x20] = R7
ffa05478: CALL 0xffa018f0
ffa0547c: MOVE R6 = R0
ffa0547e: MOVE R1 = R7
ffa05480: LOAD R0 = 0x0
ffa05482: LOAD R0.H = 0x3f80
ffa05486: CALL 0xffa01714
ffa0548a: LOAD P1 = [FP + -0x5c]
ffa0548c: LOAD R1 = [P1 + 0xc]
ffa0548e: CALL 0xffa018f0
ffa05492: MOVE R1 = R6
ffa05494: CALL 0xffa01716
ffa05498: LOAD P0 = [FP + -0x5c]
ffa0549a: STORE [P0 + 0xc] = R0
ffa0549c: JUMP.S 0xffa0486a
ffa0549e: LOAD R0 = 0x624e
ffa054a2: BITSET (R0,0x14)
ffa054a4: LOAD R1 = [FP + -0x40]
ffa054a6: CALL 0xffa05896
ffa054aa: LOAD R2 = 0xa028
ffa054ae: MAC A1 = R2.L * R0.L (fu)
ffa054b2: LOAD R1 = [FP + 0x8]
ffa054b4: LSH A1 = A1 >> 0x10
ffa054b8: MAC A1 += R0.H * R2.L (m)
ffa054bc: ASH A1 = A1 >>> 0xf
ffa054c0: MOVE R0 = A1.W
