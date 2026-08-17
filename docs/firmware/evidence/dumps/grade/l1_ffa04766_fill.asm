ffa04750: STORE [FP + 0xc] = P0
ffa04752: LOAD P1.L = 0xd05e
ffa04756: LOAD P1.H = 0x2022
ffa0475a: CALL (P1)
ffa0475c: LOAD R2 = [FP + 0x28]
ffa0475e: LOAD R3 = 0x7
ffa04760: CC = R2 == R3
ffa04762: IF CC JUMP 0xffa04766 (bp)
ffa04764: JUMP.S 0xffa054c6
ffa04766: LOAD R0 = 0x578
ffa0476a: LOAD R1 = [FP + -0x40]
ffa0476c: LOAD P1 = 0x147
ffa04770: ADD R6 = R1 + R0
ffa04772: MOVE I0 = P4
ffa04774: LOAD P3 = [FP + -0x48]
ffa04776: LOAD R7 = 0x0
ffa04778: LSETUP (0xffa0477c,0xffa047c4) LC0 = P1
ffa0477c: LOAD R0 = W [P5] (X)
ffa0477e: LOAD R1 = 0x5cfc
ffa04782: MULT R0 = R0.L * R1.L (is)
ffa04786: ADD R0 = R6 + R0
ffa04788: LOAD R2 = 0x5a26
ffa0478c: ADD R0 = R0 + R2
ffa0478e: ADD R0 = R0 + R7
ffa04790: MOVE P1 = R0
ffa04792: LOAD R0 = W [P1] (X)
ffa04794: CALL 0xffa01688
ffa04798: MOVE R1 = R4
ffa0479a: CALL 0xffa018f0
ffa0479e: STORE [I0++] = R0
ffa047a0: LOAD R0 = W [P5] (X)
ffa047a2: LOAD R1 = 0x5cfc
ffa047a6: MULT R0 = R0.L * R1.L (is)
ffa047aa: ADD R0 = R6 + R0
ffa047ac: LOAD R2 = 0x5798
ffa047b0: ADD R0 = R0 + R2
ffa047b2: ADD R0 = R0 + R7
ffa047b4: MOVE P1 = R0
ffa047b6: ADD R7 += 0x2
ffa047b8: LOAD R0 = W [P1] (X)
ffa047ba: CALL 0xffa01688
ffa047be: MOVE R1 = R5
ffa047c0: CALL 0xffa018f0
ffa047c4: STORE [P3++] = R0
ffa047c6: LOAD P1 = [FP + -0x5c]
ffa047c8: LOAD R0 = 0x147
ffa047cc: ADD P1 += -0x6
ffa047ce: STORE W [P1] = R0.L
ffa047d0: LOAD P0 = [FP + 0x18]
ffa047d2: LOAD P2 = [FP + -0x5c]
ffa047d4: LOAD R0 = W [P0 + 0x46] (Z)
ffa047d8: CALL 0xffa016d4
ffa047dc: LOAD P1 = [FP + 0x1c]
ffa047de: STORE [P2 + 0x1c] = R0
ffa047e0: LOAD R1 = B [P1 + 0x521] (Z)
ffa047e4: CC = R1 == 0x0
ffa047e6: IF !CC JUMP 0xffa047f4
ffa047e8: LOAD R1 = 0x0
ffa047ea: LOAD R1.H = 0x4040
ffa047ee: CALL 0xffa01814
ffa047f2: STORE [P2 + 0x1c] = R0
ffa047f4: LOAD R0 = [FP + 0x14]
ffa047f6: CC = R0 == 0x0
ffa047f8: IF !CC JUMP 0xffa047fc (bp)
ffa047fa: JUMP.S 0xffa0549e
ffa047fc: LOAD R0 = [FP + 0x8]
ffa047fe: ADD R0 += 0x1
ffa04800: LOAD P3 = [FP + -0x44]
ffa04802: LOAD P1 = 0x7ad8
ffa04806: LOAD P0 = [FP + -0x5c]
ffa04808: LOAD R1 = [FP + -0x24]
ffa0480a: ADD P1 = P3 + P1
ffa0480c: STORE [FP + -0x50] = P1
ffa0480e: LOAD P1 = [FP + -0x44]
ffa04810: STORE W [P0 + 0x8] = R0
ffa04812: STORE W [P0 + -0x6] = R1
ffa04816: LOAD P2 = 0x6660
ffa0481a: LOAD P0 = 0x709c
ffa0481e: LOAD R2 = [FP + 0x8]
ffa04820: ADD P2 = P1 + P2
ffa04822: ADD P0 = P3 + P0
ffa04824: CC = R1 <= R2
ffa04826: STORE [FP + -0x4c] = P2
ffa04828: STORE [FP + -0x54] = P0
ffa0482a: IF !CC JUMP 0xffa04940
ffa0482c: LOAD P1 = [FP + -0x5c]
ffa0482e: LOAD R1 = 0xa028
ffa04832: LOAD R7 = [FP + 0x10]
ffa04834: LOAD R0 = W [P1 + -0x6] (X)
ffa04838: CALL 0xffa05ee4
ffa0483c: ADD|| R0 = R7 + R0 (ns)
ffa04840: _LOAD R1 = [FP + -0x40]
ffa04842: _NOP
ffa04844: CALL 0xffa0586c
ffa04848: LOAD P1 = [FP + -0x5c]
ffa0484a: LOAD R2 = [FP + 0x28]
ffa0484c: LOAD R3 = 0x7
ffa0484e: CC = R2 == R3
ffa04850: STORE [P1] = R0
ffa04852: IF CC JUMP 0xffa04858 (bp)
ffa04854: JUMP.S 0xffa053b0
ffa04858: ASH|| R0 = R0 >>> 0x13
ffa0485c: _LOAD P0 = [FP + -0x5c]
ffa0485e: _NOP
ffa04860: MOVE P1 = R0
ffa04862: STORE [P0 + 0x4] = R0
ffa04864: ADD P1 = P4 + (P1 << 2)
ffa04866: LOAD R1 = [P1]
ffa04868: STORE [P0 + 0xc] = R1
ffa0486a: LOAD P1 = [FP + -0x5c]
ffa0486c: LOAD R1 = [FP + -0x28]
ffa0486e: LOAD R2 = [FP + -0x40]
ffa04870: LOAD R0 = [P1]
ffa04872: LOAD P1.L = 0x2a64
ffa04876: LOAD P1.H = 0x2021
ffa0487a: CALL (P1)
ffa0487c: LOAD P0 = [FP + -0x5c]
ffa0487e: LOAD R3 = [FP + 0x28]
ffa04880: CC = R3 == 0x3
ffa04882: STORE [P0 + 0x14] = R0
ffa04884: IF !CC JUMP 0xffa04888 (bp)
ffa04886: JUMP.S 0xffa04f6e
ffa04888: LOAD R1 = 0x5
ffa0488a: CC = R3 == R1
ffa0488c: IF !CC JUMP 0xffa04890 (bp)
ffa0488e: JUMP.S 0xffa04f6e
ffa04890: LOAD R1 = 0x4
ffa04892: CC = R3 == R1
ffa04894: LOAD R7 = W [P0 + -0x6] (X)
ffa04898: IF !CC JUMP 0xffa0489c (bp)
ffa0489a: JUMP.S 0xffa04f6e
ffa0489c: LOAD R0 = 0x5
ffa0489e: LOAD R1 = [FP + 0x28]
ffa048a0: CC = R1 == R0
ffa048a2: IF CC JUMP 0xffa048a6 (bp)
ffa048a4: JUMP.S 0xffa04efe
ffa048a6: LOAD P1 = [FP + 0x2c]
ffa048a8: LOAD P0 = [FP + 0x18]
ffa048aa: LOAD P2 = [FP + -0x5c]
ffa048ac: LOAD R0 = [P1 + 0xc]
ffa048ae: LOAD R1 = [P0 + 0x18]
ffa048b0: SUB R0 = R0 - R1
ffa048b2: LOAD R4 = [P2]
ffa048b4: CC = R0 <= R4
ffa048b6: IF !CC JUMP 0xffa04930
ffa048b8: ASH|| R2 = R4 >>> 0x13
ffa048bc: _LOAD R0 = [P1 + 0x8]
ffa048be: _NOP
ffa048c0: SUB R0 = R0 - R1
ffa048c2: ASHIFT R0 >>>= 0x13
ffa048c4: CC = R2 < R0
ffa048c6: IF !CC JUMP 0xffa04930
ffa048c8: LOAD R0 = B [P1 + 0x4] (Z)
ffa048cc: CC = R0 == 0x0
ffa048ce: STORE [P2 + 0x4] = R2
ffa048d0: IF !CC JUMP 0xffa048d4 (bp)
ffa048d2: JUMP.S 0xffa04ee8
ffa048d4: LOAD R5 = [P2 + 0x14]
ffa048d6: CC = !BITTST (R5,0x1f)
ffa048d8: LOAD R1 = 0x0
ffa048da: LOAD R1.H = 0x7f80
ffa048de: MOVE R0 = CC
ffa048e0: CC = R5 <= R1
ffa048e2: LOAD R6 = 0x0
ffa048e4: IF !CC R0 = R6
ffa048e6: CC = R5 == 0x0
ffa048e8: IF CC R0 = R5
ffa048ea: CC = BITTST (R0,0x0)
ffa048ec: IF CC JUMP 0xffa048f0 (bp)
ffa048ee: JUMP.S 0xffa04ee0
ffa048f0: LOAD R0 = B [P1 + 0x2] (Z)
ffa048f4: CC = R0 == 0x0
ffa048f6: IF CC JUMP 0xffa04920
ffa048f8: LOAD R0 = W [P5] (X)
ffa048fa: LOAD R1 = 0x5cfc
ffa048fe: MULT R0 = R0.L * R1.L (is)
ffa04902: MOVE P1 = R0
ffa04904: LOAD P3 = [FP + 0xc]
ffa04906: LOAD P2.L = 0x2cdc
ffa0490a: LOAD P2.H = 0xff80
ffa0490e: LOAD P0.L = 0x2cf0
ffa04912: LOAD P0.H = 0xff80
ffa04916: STORE [FP + -0x38] = P2
ffa04918: ADD P1 = P3 + P1
ffa0491a: LOAD R0 = [P1 + 0x4]
ffa0491c: JUMP.L 0xffa072e0
ffa04920: LOAD P0 = [P2 + 0x4]
ffa04922: MOVE R1 = R5
ffa04924: LOAD P2 = [FP + 0x2c]
ffa04926: LOAD R0 = [P2 + 0x10]
ffa04928: CALL 0xffa01814
ffa0492c: ADD P1 = P4 + (P0 << 2)
ffa0492e: STORE [P1] = R0
ffa04930: LOAD P1 = [FP + -0x5c]
ffa04932: ADD R7 += 0x1
ffa04934: MOVE R0 = R7.L (X)
ffa04936: LOAD R1 = [FP + 0x8]
ffa04938: CC = R0 <= R1
ffa0493a: STORE W [P1 + -0x6] = R7
ffa0493e: IF CC JUMP 0xffa0482c (bp)
ffa04940: LOAD R2 = 0x1
ffa04942: LOAD R1 = 0x0
ffa04944: LOAD R0 = 0x1
ffa04946: CALL 0xffa06008
ffa0494a: LOAD P1 = [FP + 0x18]
ffa0494c: LOAD P0 = [FP + -0x5c]
ffa0494e: LOAD R7 = 0x0
ffa04950: LOAD R0 = [P1 + 0xc]
ffa04952: ASH|| R6 = R0 >>> 0xf
ffa04956: _STORE [FP + 0x8] = R0
ffa04958: _NOP
ffa0495a: ADD R6 += 0x1
ffa0495c: CC = R6 <= 0x0
ffa0495e: STORE W [P0 + -0x6] = R7
ffa04962: IF CC JUMP 0xffa049b4
ffa04964: MOVE P1 = R6
ffa04966: LOAD P0 = [FP + -0x44]
ffa04968: LOAD R3 = 0xff
ffa0496c: LSHIFT R3 <<= 0x17
ffa0496e: LOAD R2 = [FP + -0x2c]
ffa04970: LSETUP (0xffa04974,0xffa049b0) LC0 = P1
ffa04974: ROT|| R6 = rot R2 by 0
ffa04978: _LOAD R1 = [P0++]
ffa0497a: _NOP
ffa0497c: MOVE R0 = R1
ffa0497e: BITCLR (R2,0x1f)
ffa04980: BITCLR (R1,0x1f)
ffa04982: CC = R3 < R2
ffa04984: OR R4 = R2 | R1
ffa04986: AND R2 = R6 & R0
ffa04988: LSHIFT R2 >>= 0x1f
ffa0498a: STORE [FP + 0x10] = R2
ffa0498c: MOVE R2 = CC
ffa0498e: CC = R3 < R1
ffa04990: LOAD R5 = 0x1
ffa04992: IF !CC R5 = R2
ffa04994: CC = R0 < R6
ffa04996: MOVE R1 = CC
ffa04998: CC = R6 == R0
ffa0499a: ROT|| R2 = rot R0 by 0
ffa0499e: _LOAD R0 = [FP + 0x10]
ffa049a0: _NOP
ffa049a2: XOR R0 = R0 ^ R1
ffa049a4: IF !CC R1 = R0
ffa049a6: CC = R4 == 0x0
ffa049a8: IF CC R1 = R4
ffa049aa: CC = BITTST (R5,0x0)
ffa049ac: IF CC R1 = R7
ffa049ae: CC = BITTST (R1,0x0)
ffa049b0: IF CC R2 = R6
ffa049b2: STORE [FP + -0x18] = R2
ffa049b4: LOAD R0 = [FP + 0x8]
ffa049b6: ASHIFT R0 >>>= 0x12
ffa049b8: ADD R0 += 0x1
ffa049ba: CC = R0 <= 0x0
ffa049bc: STORE [FP + 0x8] = R0
ffa049be: IF CC JUMP 0xffa04ae8
ffa049c0: LOAD P0 = [FP + -0x54]
ffa049c2: LOAD P2 = [FP + 0x8]
ffa049c4: LOAD P1 = [FP + -0x4c]
ffa049c6: MOVE I0 = P0
ffa049c8: LOAD R0 = [FP + -0x10]
ffa049ca: LOAD R2 = [FP + -0x14]
ffa049cc: LOAD P3 = [FP + -0x50]
ffa049ce: LOAD R3 = [FP + -0xc]
ffa049d0: LSETUP (0xffa049d4,0xffa04ad8) LC0 = P2
ffa049d4: ROT|| R5 = rot R0 by 0
ffa049d8: _LOAD R6 = [P1++]
ffa049da: _LOAD R1 = [I0++]
ffa049dc: STORE [FP + -0x58] = R6
ffa049de: STORE [FP + -0x28] = R2
ffa049e0: ROT|| R0 = rot R1 by 0
ffa049e4: _STORE [FP + -0x24] = R0
ffa049e6: _NOP
ffa049e8: BITCLR (R5,0x1f)
ffa049ea: STORE [FP + 0x10] = R5
ffa049ec: LOAD R4 = [FP + -0x58]
ffa049ee: LOAD R5 = [FP + -0x28]
ffa049f0: AND R5 = R5 & R4
ffa049f2: LSH|| R5 = R5 >> 0x1f
ffa049f6: _LOAD R4 = [FP + -0x24]
ffa049f8: _NOP
ffa049fa: AND R4 = R4 & R0
ffa049fc: LSH|| R4 = R4 >> 0x1f
ffa04a00: _STORE [FP + 0x20] = R5
ffa04a02: _NOP
ffa04a04: BITCLR (R2,0x1f)
ffa04a06: BITCLR (R6,0x1f)
ffa04a08: STORE [FP + -0x38] = R4
ffa04a0a: OR R5 = R2 | R6
ffa04a0c: BITCLR (R1,0x1f)
ffa04a0e: LOAD R4 = [FP + 0x10]
ffa04a10: STORE [FP + -0x1c] = R5
ffa04a12: OR R4 = R4 | R1
ffa04a14: LOAD R5 = 0xff
ffa04a18: LSH|| R5 = R5 << 0x17
ffa04a1c: _STORE [FP + -0x34] = R4
ffa04a1e: _NOP
ffa04a20: LOAD R4 = [P3++]
ffa04a22: CC = R5 < R2
ffa04a24: STORE [FP + -0x20] = R4
ffa04a26: MOVE R4 = CC
ffa04a28: CC = R5 < R6
ffa04a2a: LOAD R6 = 0x1
ffa04a2c: STORE [SP + 0x3c] = R6
ffa04a2e: LOAD R2 = [FP + -0x20]
ffa04a30: BITCLR (R2,0x1f)
ffa04a32: STORE [FP + -0x30] = R2
ffa04a34: LOAD R2 = 0x1
ffa04a36: IF !CC R2 = R4
ffa04a38: LOAD R4 = [FP + -0x58]
ffa04a3a: LOAD R6 = [FP + -0x28]
ffa04a3c: CC = R4 < R6
ffa04a3e: LOAD R4 = [FP + 0x20]
ffa04a40: MOVE R6 = CC
ffa04a42: XOR R4 = R4 ^ R6
ffa04a44: STORE [FP + 0x20] = R4
ffa04a46: STORE [SP + 0x3c] = R2
ffa04a48: LOAD R4 = [FP + -0x58]
ffa04a4a: LOAD R2 = [FP + -0x28]
ffa04a4c: CC = R2 == R4
ffa04a4e: LOAD R2 = [FP + 0x20]
ffa04a50: LOAD R4 = [FP + -0x1c]
ffa04a52: IF !CC R6 = R2
ffa04a54: CC = R4 == 0x0
ffa04a56: LOAD R2 = [SP + 0x3c]
ffa04a58: IF CC R6 = R4
ffa04a5a: CC = BITTST (R2,0x0)
ffa04a5c: IF CC R6 = R7
ffa04a5e: LOAD R2 = [FP + -0x58]
ffa04a60: CC = BITTST (R6,0x0)
ffa04a62: LOAD R4 = [FP + -0x28]
ffa04a64: IF CC R2 = R4
ffa04a66: LOAD R4 = [FP + 0x10]
ffa04a68: CC = R5 < R4
ffa04a6a: MOVE R6 = CC
ffa04a6c: CC = R5 < R1
ffa04a6e: LOAD R4 = 0x1
ffa04a70: IF !CC R4 = R6
ffa04a72: LOAD R6 = [FP + -0x24]
ffa04a74: CC = R0 < R6
ffa04a76: MOVE R6 = CC
ffa04a78: LOAD R1 = [FP + -0x38]
ffa04a7a: XOR R1 = R1 ^ R6
ffa04a7c: STORE [FP + -0x58] = R1
ffa04a7e: LOAD R1 = [FP + -0x24]
ffa04a80: CC = R1 == R0
ffa04a82: STORE [FP + -0x2c] = R3
ffa04a84: LOAD R1 = [FP + -0x58]
ffa04a86: IF !CC R6 = R1
ffa04a88: LOAD R1 = [FP + -0x34]
ffa04a8a: CC = R1 == 0x0
ffa04a8c: IF CC R6 = R1
ffa04a8e: CC = BITTST (R4,0x0)
ffa04a90: IF CC R6 = R7
ffa04a92: CC = BITTST (R6,0x0)
ffa04a94: LOAD R4 = [FP + -0x24]
ffa04a96: IF CC R0 = R4
ffa04a98: BITCLR (R3,0x1f)
ffa04a9a: LOAD R4 = [FP + -0x30]
ffa04a9c: CC = R5 < R3
ffa04a9e: OR R4 = R3 | R4
ffa04aa0: LOAD R1 = [FP + -0x20]
ffa04aa2: LOAD R3 = [FP + -0x2c]
ffa04aa4: AND R3 = R3 & R1
ffa04aa6: LSH|| R3 = R3 >> 0x1f
ffa04aaa: _LOAD R1 = [FP + -0x30]
ffa04aac: _NOP
ffa04aae: STORE [FP + -0x58] = R3
ffa04ab0: MOVE R6 = CC
ffa04ab2: CC = R5 < R1
ffa04ab4: LOAD R1 = 0x1
ffa04ab6: LOAD R3 = [FP + -0x2c]
ffa04ab8: LOAD R5 = [FP + -0x20]
ffa04aba: IF !CC R1 = R6
ffa04abc: CC = R5 < R3
ffa04abe: LOAD R3 = [FP + -0x20]
ffa04ac0: LOAD R6 = [FP + -0x2c]
ffa04ac2: MOVE R5 = CC
ffa04ac4: CC = R6 == R3
ffa04ac6: LOAD R6 = [FP + -0x58]
ffa04ac8: XOR R6 = R6 ^ R5
ffa04aca: IF !CC R5 = R6
ffa04acc: CC = R4 == 0x0
ffa04ace: IF CC R5 = R4
ffa04ad0: CC = BITTST (R1,0x0)
ffa04ad2: IF CC R5 = R7
ffa04ad4: CC = BITTST (R5,0x0)
ffa04ad6: LOAD R6 = [FP + -0x2c]
ffa04ad8: IF CC R3 = R6
ffa04ada: LOAD P1 = [FP + -0x5c]
ffa04adc: LOAD R1 = [FP + 0x8]
ffa04ade: STORE [FP + -0x14] = R2
ffa04ae0: STORE [FP + -0x10] = R0
ffa04ae2: STORE W [P1 + -0x6] = R1
ffa04ae6: STORE [FP + -0xc] = R3
ffa04ae8: LOAD R0 = W [P5] (X)
ffa04aea: LOAD R6.H = 0x5cfc
ffa04aee: MULT|| R0 = R0.L * R6.H (is)
ffa04af2: LOAD P2 = [FP + 0xc]
ffa04af4: NOP
ffa04af6: MOVE P1 = R0
ffa04af8: LOAD R1 = [FP + -0x18]
ffa04afa: LOAD R2 = [FP + -0x10]
ffa04afc: STORE [FP + 0x10] = R2
ffa04afe: LOAD R2 = 0x5cfc
ffa04b02: ADD P1 = P2 + P1
ffa04b04: STORE [P1 + 0x5cd4] = R1
ffa04b08: LOAD R0 = W [P5] (X)
ffa04b0a: MULT|| R0 = R0.L * R2.L (is)
ffa04b0e: LOAD R5 = [FP + -0x14]
ffa04b10: NOP
ffa04b12: MOVE P1 = R0
ffa04b14: STORE [FP + 0x8] = R1
ffa04b16: BITCLR (R1,0x1f)
ffa04b18: CC = R1 == 0x0
ffa04b1a: LOAD R1.H = 0x5cfc
ffa04b1e: ADD P1 = P2 + P1
ffa04b20: STORE [P1 + 0x5cdc] = R5
ffa04b24: LOAD R0 = W [P5] (X)
ffa04b26: MULT|| R0 = R0.L * R1.H (is)
ffa04b2a: LOAD P3 = [FP + 0xc]
ffa04b2c: NOP
ffa04b2e: MOVE P1 = R0
ffa04b30: LOAD R2 = [FP + 0x10]
ffa04b32: LOAD R1 = 0x5cfc
ffa04b36: LOAD R3 = [FP + -0xc]
ffa04b38: LOAD P0 = -0x9d0
ffa04b3c: LOAD P0.H = 0x4
ffa04b40: ADD P1 = P3 + P1
ffa04b42: STORE [P1 + 0x5ce0] = R2
ffa04b46: LOAD R0 = W [P5] (X)
ffa04b48: MULT|| R0 = R0.L * R1.L (is)
ffa04b4c: STORE [FP + -0x24] = R3
ffa04b4e: NOP
ffa04b50: MOVE P1 = R0
ffa04b52: ADD P0 = P2 + P0
ffa04b54: LOAD M0 = 0x4690
ffa04b58: LOAD M0.H = 0x3
ffa04b5c: ADD P1 = P3 + P1
ffa04b5e: STORE [P1 + 0x5ce4] = R3
ffa04b62: LOAD R0 = W [P5] (X)
ffa04b64: MOVE P1 = R0
ffa04b66: MULT R1 = R0.L * R1.L (is)
ffa04b6a: MOVE P2 = R1
ffa04b6c: ADD P1 = P0 + (P1 << 2)
ffa04b6e: LOAD R2 = [P1]
ffa04b70: ADD P2 = P3 + P2
ffa04b72: STORE [P2 + 0x5ce8] = R2
ffa04b76: IF CC JUMP 0xffa04be2
ffa04b78: NOP
ffa04b7a: LOAD P1 = [FP + 0x18]
ffa04b7c: LOAD P0 = [FP + -0x5c]
ffa04b7e: LOAD R0 = [P1 + 0xc]
ffa04b80: ASHIFT R0 >>>= 0xf
ffa04b82: ADD R0 += 0x1
ffa04b84: CC = R0 <= 0x0
ffa04b86: STORE W [P0 + -0x6] = R7
ffa04b8a: IF CC JUMP 0xffa04be2
ffa04b8c: LOAD P0 = 0x0
ffa04b8e: LOAD R6 = 0x0
ffa04b90: LOAD P2 = 0x44
ffa04b94: LOAD P1 = [FP + -0x44]
ffa04b96: MOVE I0 = P1
ffa04b98: LOAD P1 = -0x1
ffa04b9a: LSETUP (0xffa04b9e,0xffa04bd6) LC1 = P1
ffa04b9e: MNOP||
ffa04ba2: _LOAD R1 = [FP + 0x8]
ffa04ba4: _LOAD R0 = [I0++]
ffa04ba6: CALL 0xffa01814
ffa04baa: CALL 0xffa0290c
ffa04bae: LOAD R4 = W [P5] (X)
ffa04bb0: LOAD R1 = 0x5cfc
ffa04bb4: MULT|| R1 = R4.L * R1.L (is)
ffa04bb8: LOAD P3 = [FP + 0xc]
ffa04bba: NOP
ffa04bbc: MOVE P1 = R1
ffa04bbe: ADD R6 += 0x1
ffa04bc0: MOVE R2 = R6.L (X)
ffa04bc2: ADD P1 = P3 + P1
ffa04bc4: LOAD P3 = [FP + 0x18]
ffa04bc6: ADD P1 = P1 + P2
ffa04bc8: ADD P1 = P1 + P0
ffa04bca: STORE W [P1] = R0.L
ffa04bcc: LOAD R0 = [P3 + 0xc]
ffa04bce: ASHIFT R0 >>>= 0xf
ffa04bd0: ADD R0 += 0x1
ffa04bd2: CC = R2 < R0
ffa04bd4: ADD P0 += 0x2
ffa04bd6: IF !CC JUMP 0xffa04bdc
ffa04bd8: MOVE P1 = I0
ffa04bda: JUMP.S 0xffa04b96
ffa04bdc: LOAD P1 = [FP + -0x5c]
ffa04bde: STORE W [P1 + -0x6] = R6
ffa04be2: MOVE R6 = R5
ffa04be4: BITCLR (R5,0x1f)
ffa04be6: CC = R5 == 0x0
ffa04be8: IF CC JUMP 0xffa04c54
ffa04bea: NOP
ffa04bec: LOAD P1 = [FP + 0x18]
ffa04bee: LOAD P0 = [FP + -0x5c]
ffa04bf0: LOAD R0 = [P1 + 0xc]
ffa04bf2: ASHIFT R0 >>>= 0x12
ffa04bf4: ADD R0 += 0x1
ffa04bf6: CC = R0 <= 0x0
ffa04bf8: STORE W [P0 + -0x6] = R7
ffa04bfc: IF CC JUMP 0xffa04c54
ffa04bfe: LOAD P0 = 0x0
