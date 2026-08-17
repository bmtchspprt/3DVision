######## FFA0467E region
ffa0467e: LINK 0x60
ffa04682: PUSH [--SP] = (R7:4,P5:3)
ffa04684: ADD SP += -0x20
ffa04686: LOAD P5 = [FP + 0x1c]
ffa04688: LOAD P1.L = 0x5060 **FLOATBUF**
ffa0468c: LOAD P1.H = 0x2021
ffa04690: LOAD P2 = 0x8514
ffa04694: LOAD P4 = 0x8a30
ffa04698: ADD P2 = P1 + P2
ffa0469a: STORE [FP + -0x44] = P1 **+44** **ST32**
ffa0469c: ADD P4 = P1 + P4
ffa0469e: LOAD P1 = 0x4c08
ffa046a2: LOAD P1.H = 0x3
ffa046a6: ADD P5 = P5 + P1
ffa046a8: STORE [FP + 0x10] = R0 **ST32**
ffa046aa: STORE [FP + 0x8] = R2 **ST32**
ffa046ac: LOAD R2 = W [P5] (X)
ffa046ae: LOAD R0 = 0x5cfc **BEAM**
ffa046b2: LOAD P3.L = 0x4864
ffa046b6: LOAD P3.H = 0xff80
ffa046ba: MULT|| R0 = R2.L * R0.L (is)
ffa046be: STORE [FP + -0x5c] = P3 **ST32**
ffa046c0: NOP
ffa046c2: MOVE P1 = R0
ffa046c4: LOAD P3 = [FP + 0x1c]
ffa046c6: LOAD P0 = 0x578 **BEAM**
ffa046ca: STORE [FP + -0x24] = R1 **ST32**
ffa046cc: LOAD R1 = 0x0
ffa046ce: ADD P0 = P3 + P0
ffa046d0: PACK|| R7 = pack(R7.H,R1.L)
ffa046d4: _STORE [FP + -0x48] = P2 **ST32**
ffa046d6: _NOP
ffa046d8: ADD P2 = P0 + P1
ffa046da: LOAD R7.H = 0x4700
ffa046de: LOAD R0 = [P2 + 0x5cd4]
ffa046e2: MOVE R1 = R7
ffa046e4: CALL 0xffa01814 **CALL**
ffa046e8: ROT|| R1 = rot R7 by 0
ffa046ec: _STORE [FP + -0x2c] = R0 **ST32**
ffa046ee: _NOP
ffa046f0: LOAD R0 = [P2 + 0x5cdc]
ffa046f4: CALL 0xffa01814 **CALL**
ffa046f8: ROT|| R1 = rot R7 by 0
ffa046fc: _STORE [FP + -0x14] = R0 **ST32**
ffa046fe: _NOP
ffa04700: LOAD R0 = [P2 + 0x5ce0]
ffa04704: CALL 0xffa01814 **CALL**
ffa04708: ROT|| R1 = rot R7 by 0
ffa0470c: _STORE [FP + -0x10] = R0 **ST32**
ffa0470e: _NOP
ffa04710: LOAD R0 = [P2 + 0x5ce4]
ffa04714: CALL 0xffa01814 **CALL**
ffa04718: ROT|| R1 = rot R7 by 0
ffa0471c: _LOAD P1 = [FP + 0x18]
ffa0471e: _NOP
ffa04720: LOAD R2 = [FP + -0x2c]
ffa04722: STORE [FP + -0xc] = R0 **ST32**
ffa04724: LOAD R0 = [P2 + 0x5cf8]
ffa04728: STORE [FP + -0x28] = P1 **ST32**
ffa0472a: STORE [FP + -0x40] = P3 **ST32**
ffa0472c: STORE [FP + -0x18] = R2 **ST32**
ffa0472e: CALL 0xffa01814 **CALL**
ffa04732: ROT|| R4 = rot R0 by 0
ffa04736: _STORE [FP + -0x8] = R0 **ST32**
ffa04738: _NOP
ffa0473a: LOAD R0 = [P2 + 0x5cf4]
ffa0473e: MOVE R1 = R7
ffa04740: CALL 0xffa01814 **CALL**
ffa04744: ROT|| R5 = rot R0 by 0
ffa04748: _STORE [FP + -0x4] = R0 **ST32**
ffa0474a: _NOP
ffa0474c: LOAD R1 = [FP + -0x40]
ffa0474e: LOAD R0 = [FP + -0x28]
ffa04750: STORE [FP + 0xc] = P0 **ST32**
ffa04752: LOAD P1.L = 0xd05e
ffa04756: LOAD P1.H = 0x2022
ffa0475a: CALL (P1) **CALL**
ffa0475c: LOAD R2 = [FP + 0x28]
ffa0475e: LOAD R3 = 0x7
ffa04760: CC = R2 == R3
ffa04762: IF CC JUMP 0xffa04766 (bp)
ffa04764: JUMP.S 0xffa054c6
ffa04766: LOAD R0 = 0x578 **BEAM**
ffa0476a: LOAD R1 = [FP + -0x40]
ffa0476c: LOAD P1 = 0x147
ffa04770: ADD R6 = R1 + R0
ffa04772: MOVE I0 = P4
ffa04774: LOAD P3 = [FP + -0x48]
ffa04776: LOAD R7 = 0x0
ffa04778: LSETUP (0xffa0477c,0xffa047c4) LC0 = P1
ffa0477c: LOAD R0 = W [P5] (X)
ffa0477e: LOAD R1 = 0x5cfc **BEAM**
ffa04782: MULT R0 = R0.L * R1.L (is)
ffa04786: ADD R0 = R6 + R0
ffa04788: LOAD R2 = 0x5a26
ffa0478c: ADD R0 = R0 + R2
ffa0478e: ADD R0 = R0 + R7
ffa04790: MOVE P1 = R0
ffa04792: LOAD R0 = W [P1] (X)
ffa04794: CALL 0xffa01688 **CALL**
ffa04798: MOVE R1 = R4
ffa0479a: CALL 0xffa018f0 **CALL**
ffa0479e: STORE [I0++] = R0 **ST32**
ffa047a0: LOAD R0 = W [P5] (X)
ffa047a2: LOAD R1 = 0x5cfc **BEAM**
ffa047a6: MULT R0 = R0.L * R1.L (is)
ffa047aa: ADD R0 = R6 + R0
ffa047ac: LOAD R2 = 0x5798
ffa047b0: ADD R0 = R0 + R2
ffa047b2: ADD R0 = R0 + R7
ffa047b4: MOVE P1 = R0
ffa047b6: ADD R7 += 0x2
ffa047b8: LOAD R0 = W [P1] (X)
ffa047ba: CALL 0xffa01688 **CALL**
ffa047be: MOVE R1 = R5
ffa047c0: CALL 0xffa018f0 **CALL**
ffa047c4: STORE [P3++] = R0 **ST32**
ffa047c6: LOAD P1 = [FP + -0x5c]
ffa047c8: LOAD R0 = 0x147
ffa047cc: ADD P1 += -0x6
ffa047ce: STORE W [P1] = R0.L
ffa047d0: LOAD P0 = [FP + 0x18]
ffa047d2: LOAD P2 = [FP + -0x5c]
ffa047d4: LOAD R0 = W [P0 + 0x46] (Z)
ffa047d8: CALL 0xffa016d4 **CALL**
ffa047dc: LOAD P1 = [FP + 0x1c]
ffa047de: STORE [P2 + 0x1c] = R0 **ST32**
ffa047e0: LOAD R1 = B [P1 + 0x521] (Z)
ffa047e4: CC = R1 == 0x0
ffa047e6: IF !CC JUMP 0xffa047f4
ffa047e8: LOAD R1 = 0x0
ffa047ea: LOAD R1.H = 0x4040
ffa047ee: CALL 0xffa01814 **CALL**
ffa047f2: STORE [P2 + 0x1c] = R0 **ST32**
ffa047f4: LOAD R0 = [FP + 0x14]
ffa047f6: CC = R0 == 0x0
ffa047f8: IF !CC JUMP 0xffa047fc (bp)
ffa047fa: JUMP.S 0xffa0549e
ffa047fc: LOAD R0 = [FP + 0x8]
ffa047fe: ADD R0 += 0x1
ffa04800: LOAD P3 = [FP + -0x44] **+44**
ffa04802: LOAD P1 = 0x7ad8
ffa04806: LOAD P0 = [FP + -0x5c]
ffa04808: LOAD R1 = [FP + -0x24]
ffa0480a: ADD P1 = P3 + P1
ffa0480c: STORE [FP + -0x50] = P1 **ST32**
ffa0480e: LOAD P1 = [FP + -0x44] **+44**
ffa04810: STORE W [P0 + 0x8] = R0
ffa04812: STORE W [P0 + -0x6] = R1
ffa04816: LOAD P2 = 0x6660
ffa0481a: LOAD P0 = 0x709c
ffa0481e: LOAD R2 = [FP + 0x8]
ffa04820: ADD P2 = P1 + P2
ffa04822: ADD P0 = P3 + P0
ffa04824: CC = R1 <= R2
ffa04826: STORE [FP + -0x4c] = P2 **ST32**
ffa04828: STORE [FP + -0x54] = P0 **ST32**
ffa0482a: IF !CC JUMP 0xffa04940
ffa0482c: LOAD P1 = [FP + -0x5c]
ffa0482e: LOAD R1 = 0xa028
ffa04832: LOAD R7 = [FP + 0x10]
ffa04834: LOAD R0 = W [P1 + -0x6] (X)
ffa04838: CALL 0xffa05ee4 **CALL**
ffa0483c: ADD|| R0 = R7 + R0 (ns)
ffa04840: _LOAD R1 = [FP + -0x40]
ffa04842: _NOP
ffa04844: CALL 0xffa0586c **CALL**
ffa04848: LOAD P1 = [FP + -0x5c]
ffa0484a: LOAD R2 = [FP + 0x28]
ffa0484c: LOAD R3 = 0x7
ffa0484e: CC = R2 == R3
ffa04850: STORE [P1] = R0 **ST32**
ffa04852: IF CC JUMP 0xffa04858 (bp)
ffa04854: JUMP.S 0xffa053b0
ffa04858: ASH|| R0 = R0 >>> 0x13
ffa0485c: _LOAD P0 = [FP + -0x5c]
ffa0485e: _NOP
ffa04860: MOVE P1 = R0
ffa04862: STORE [P0 + 0x4] = R0 **ST32**
ffa04864: ADD P1 = P4 + (P1 << 2)
ffa04866: LOAD R1 = [P1]
ffa04868: STORE [P0 + 0xc] = R1 **ST32**
ffa0486a: LOAD P1 = [FP + -0x5c]
ffa0486c: LOAD R1 = [FP + -0x28]
ffa0486e: LOAD R2 = [FP + -0x40]
ffa04870: LOAD R0 = [P1]
ffa04872: LOAD P1.L = 0x2a64
ffa04876: LOAD P1.H = 0x2021
ffa0487a: CALL (P1) **CALL**
ffa0487c: LOAD P0 = [FP + -0x5c]
ffa0487e: LOAD R3 = [FP + 0x28]
ffa04880: CC = R3 == 0x3
ffa04882: STORE [P0 + 0x14] = R0 **ST32**
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
ffa048ce: STORE [P2 + 0x4] = R2 **ST32**
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
ffa048fa: LOAD R1 = 0x5cfc **BEAM**
ffa048fe: MULT R0 = R0.L * R1.L (is)
ffa04902: MOVE P1 = R0
ffa04904: LOAD P3 = [FP + 0xc]
ffa04906: LOAD P2.L = 0x2cdc
ffa0490a: LOAD P2.H = 0xff80
ffa0490e: LOAD P0.L = 0x2cf0
ffa04912: LOAD P0.H = 0xff80
ffa04916: STORE [FP + -0x38] = P2 **ST32**
ffa04918: ADD P1 = P3 + P1
ffa0491a: LOAD R0 = [P1 + 0x4]
ffa0491c: JUMP.L 0xffa072e0
ffa04920: LOAD P0 = [P2 + 0x4]
ffa04922: MOVE R1 = R5
ffa04924: LOAD P2 = [FP + 0x2c]
ffa04926: LOAD R0 = [P2 + 0x10]
ffa04928: CALL 0xffa01814 **CALL**
ffa0492c: ADD P1 = P4 + (P0 << 2)
ffa0492e: STORE [P1] = R0 **ST32**
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
ffa04946: CALL 0xffa06008 **CALL**
ffa0494a: LOAD P1 = [FP + 0x18]
ffa0494c: LOAD P0 = [FP + -0x5c]
ffa0494e: LOAD R7 = 0x0
ffa04950: LOAD R0 = [P1 + 0xc]
ffa04952: ASH|| R6 = R0 >>> 0xf
ffa04956: _STORE [FP + 0x8] = R0 **ST32**
ffa04958: _NOP
ffa0495a: ADD R6 += 0x1
ffa0495c: CC = R6 <= 0x0
ffa0495e: STORE W [P0 + -0x6] = R7
ffa04962: IF CC JUMP 0xffa049b4
ffa04964: MOVE P1 = R6
ffa04966: LOAD P0 = [FP + -0x44] **+44**
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
ffa0498a: STORE [FP + 0x10] = R2 **ST32**
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
ffa049b2: STORE [FP + -0x18] = R2 **ST32**
ffa049b4: LOAD R0 = [FP + 0x8]
ffa049b6: ASHIFT R0 >>>= 0x12
ffa049b8: ADD R0 += 0x1
ffa049ba: CC = R0 <= 0x0
ffa049bc: STORE [FP + 0x8] = R0 **ST32**
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
ffa049dc: STORE [FP + -0x58] = R6 **ST32**
ffa049de: STORE [FP + -0x28] = R2 **ST32**
ffa049e0: ROT|| R0 = rot R1 by 0
ffa049e4: _STORE [FP + -0x24] = R0 **ST32**
ffa049e6: _NOP
ffa049e8: BITCLR (R5,0x1f)
ffa049ea: STORE [FP + 0x10] = R5 **ST32**
ffa049ec: LOAD R4 = [FP + -0x58]
ffa049ee: LOAD R5 = [FP + -0x28]
ffa049f0: AND R5 = R5 & R4
ffa049f2: LSH|| R5 = R5 >> 0x1f
ffa049f6: _LOAD R4 = [FP + -0x24]
ffa049f8: _NOP
ffa049fa: AND R4 = R4 & R0
ffa049fc: LSH|| R4 = R4 >> 0x1f
ffa04a00: _STORE [FP + 0x20] = R5 **ST32**
ffa04a02: _NOP
ffa04a04: BITCLR (R2,0x1f)
ffa04a06: BITCLR (R6,0x1f)
ffa04a08: STORE [FP + -0x38] = R4 **ST32**
ffa04a0a: OR R5 = R2 | R6
ffa04a0c: BITCLR (R1,0x1f)
ffa04a0e: LOAD R4 = [FP + 0x10]
ffa04a10: STORE [FP + -0x1c] = R5 **ST32**
ffa04a12: OR R4 = R4 | R1
ffa04a14: LOAD R5 = 0xff
ffa04a18: LSH|| R5 = R5 << 0x17
ffa04a1c: _STORE [FP + -0x34] = R4 **ST32**
ffa04a1e: _NOP
ffa04a20: LOAD R4 = [P3++]
ffa04a22: CC = R5 < R2
ffa04a24: STORE [FP + -0x20] = R4 **ST32**
ffa04a26: MOVE R4 = CC
ffa04a28: CC = R5 < R6
ffa04a2a: LOAD R6 = 0x1
ffa04a2c: STORE [SP + 0x3c] = R6 **ST32**
ffa04a2e: LOAD R2 = [FP + -0x20]
ffa04a30: BITCLR (R2,0x1f)
ffa04a32: STORE [FP + -0x30] = R2 **ST32**
ffa04a34: LOAD R2 = 0x1
ffa04a36: IF !CC R2 = R4
ffa04a38: LOAD R4 = [FP + -0x58]
ffa04a3a: LOAD R6 = [FP + -0x28]
ffa04a3c: CC = R4 < R6
ffa04a3e: LOAD R4 = [FP + 0x20]
ffa04a40: MOVE R6 = CC
ffa04a42: XOR R4 = R4 ^ R6
ffa04a44: STORE [FP + 0x20] = R4 **ST32**
ffa04a46: STORE [SP + 0x3c] = R2 **ST32**
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
ffa04a7c: STORE [FP + -0x58] = R1 **ST32**
ffa04a7e: LOAD R1 = [FP + -0x24]
ffa04a80: CC = R1 == R0
ffa04a82: STORE [FP + -0x2c] = R3 **ST32**
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
ffa04aae: STORE [FP + -0x58] = R3 **ST32**
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
ffa04ade: STORE [FP + -0x14] = R2 **ST32**
ffa04ae0: STORE [FP + -0x10] = R0 **ST32**
ffa04ae2: STORE W [P1 + -0x6] = R1
ffa04ae6: STORE [FP + -0xc] = R3 **ST32**
ffa04ae8: LOAD R0 = W [P5] (X)
ffa04aea: LOAD R6.H = 0x5cfc **BEAM**
ffa04aee: MULT|| R0 = R0.L * R6.H (is)
ffa04af2: LOAD P2 = [FP + 0xc]
ffa04af4: NOP
ffa04af6: MOVE P1 = R0
ffa04af8: LOAD R1 = [FP + -0x18]
ffa04afa: LOAD R2 = [FP + -0x10]
ffa04afc: STORE [FP + 0x10] = R2 **ST32**
ffa04afe: LOAD R2 = 0x5cfc **BEAM**
ffa04b02: ADD P1 = P2 + P1
ffa04b04: STORE [P1 + 0x5cd4] = R1 **ST32**
ffa04b08: LOAD R0 = W [P5] (X)
ffa04b0a: MULT|| R0 = R0.L * R2.L (is)
ffa04b0e: LOAD R5 = [FP + -0x14]
ffa04b10: NOP
ffa04b12: MOVE P1 = R0
ffa04b14: STORE [FP + 0x8] = R1 **ST32**
ffa04b16: BITCLR (R1,0x1f)
ffa04b18: CC = R1 == 0x0
ffa04b1a: LOAD R1.H = 0x5cfc **BEAM**
ffa04b1e: ADD P1 = P2 + P1
ffa04b20: STORE [P1 + 0x5cdc] = R5 **ST32**
ffa04b24: LOAD R0 = W [P5] (X)
ffa04b26: MULT|| R0 = R0.L * R1.H (is)
ffa04b2a: LOAD P3 = [FP + 0xc]
ffa04b2c: NOP
ffa04b2e: MOVE P1 = R0
ffa04b30: LOAD R2 = [FP + 0x10]
ffa04b32: LOAD R1 = 0x5cfc **BEAM**
ffa04b36: LOAD R3 = [FP + -0xc]
ffa04b38: LOAD P0 = -0x9d0
ffa04b3c: LOAD P0.H = 0x4
ffa04b40: ADD P1 = P3 + P1
ffa04b42: STORE [P1 + 0x5ce0] = R2 **ST32**
ffa04b46: LOAD R0 = W [P5] (X)
ffa04b48: MULT|| R0 = R0.L * R1.L (is)
ffa04b4c: STORE [FP + -0x24] = R3 **ST32**
ffa04b4e: NOP
ffa04b50: MOVE P1 = R0
ffa04b52: ADD P0 = P2 + P0
ffa04b54: LOAD M0 = 0x4690
ffa04b58: LOAD M0.H = 0x3
ffa04b5c: ADD P1 = P3 + P1
ffa04b5e: STORE [P1 + 0x5ce4] = R3 **ST32**
ffa04b62: LOAD R0 = W [P5] (X)
ffa04b64: MOVE P1 = R0
ffa04b66: MULT R1 = R0.L * R1.L (is)
ffa04b6a: MOVE P2 = R1
ffa04b6c: ADD P1 = P0 + (P1 << 2)
ffa04b6e: LOAD R2 = [P1]
ffa04b70: ADD P2 = P3 + P2
ffa04b72: STORE [P2 + 0x5ce8] = R2 **ST32**
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
ffa04b90: LOAD P2 = 0x44 **+44**
ffa04b94: LOAD P1 = [FP + -0x44] **+44**
ffa04b96: MOVE I0 = P1
ffa04b98: LOAD P1 = -0x1
ffa04b9a: LSETUP (0xffa04b9e,0xffa04bd6) LC1 = P1
ffa04b9e: MNOP||
ffa04ba2: _LOAD R1 = [FP + 0x8]
ffa04ba4: _LOAD R0 = [I0++]
ffa04ba6: CALL 0xffa01814 **CALL**
ffa04baa: CALL 0xffa0290c **CALL** **F2I**
ffa04bae: LOAD R4 = W [P5] (X)
ffa04bb0: LOAD R1 = 0x5cfc **BEAM**
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
ffa04c00: LOAD R5 = 0x0
ffa04c02: LOAD P2 = [FP + -0x4c]
ffa04c04: LOAD P1 = -0x1
ffa04c06: LOAD R1 = W [P5] (X)
ffa04c08: LSETUP (0xffa04c0c,0xffa04c4a) LC1 = P1
ffa04c0c: LOAD R1.H = 0x5cfc **BEAM**
ffa04c10: MULT|| R1 = R1.L * R1.H (is)
ffa04c14: LOAD R0 = [P2++]
ffa04c16: NOP
ffa04c18: ROT|| R1 = rot R6 by 0
ffa04c1c: _STORE [FP + -0x58] = R1 **ST32**
ffa04c1e: _NOP
ffa04c20: CALL 0xffa01814 **CALL**
ffa04c24: CALL 0xffa0290c **CALL** **F2I**
ffa04c28: LOAD P3 = [FP + -0x58]
ffa04c2a: LOAD P1 = [FP + 0xc]
ffa04c2c: ADD R5 += 0x1
ffa04c2e: MOVE R1 = R5.L (X)
ffa04c30: ADD P1 = P1 + P3
ffa04c32: LOAD P3 = 0x3374
ffa04c36: ADD P1 = P1 + P3
ffa04c38: LOAD P3 = [FP + 0x18]
ffa04c3a: ADD P1 = P1 + P0
ffa04c3c: STORE W [P1] = R0.L
ffa04c3e: ADD P0 += 0x2
ffa04c40: LOAD R0 = [P3 + 0xc]
ffa04c42: ASHIFT R0 >>>= 0x12
ffa04c44: ADD R0 += 0x1
ffa04c46: CC = R1 < R0
ffa04c48: IF !CC JUMP 0xffa04c4e
ffa04c4a: LOAD R1 = W [P5] (X)
ffa04c4c: JUMP.S 0xffa04c04
ffa04c4e: LOAD P1 = [FP + -0x5c]
ffa04c50: STORE W [P1 + -0x6] = R5
ffa04c54: LOAD R0 = [FP + 0x10]
ffa04c56: BITCLR (R0,0x1f)
ffa04c58: CC = R0 == 0x0
ffa04c5a: IF CC JUMP 0xffa04cc6
ffa04c5c: NOP
ffa04c5e: LOAD P1 = [FP + 0x18]
ffa04c60: LOAD P0 = [FP + -0x5c]
ffa04c62: LOAD R0 = [P1 + 0xc]
ffa04c64: ASHIFT R0 >>>= 0x12
ffa04c66: ADD R0 += 0x1
ffa04c68: CC = R0 <= 0x0
ffa04c6a: STORE W [P0 + -0x6] = R7
ffa04c6e: IF CC JUMP 0xffa04cc6
ffa04c70: LOAD P0 = 0x0
ffa04c72: LOAD R6 = 0x0
ffa04c74: LOAD P2 = 0x3892
ffa04c78: LOAD P1 = [FP + -0x54]
ffa04c7a: MOVE I0 = P1
ffa04c7c: LOAD P1 = -0x1
ffa04c7e: LSETUP (0xffa04c82,0xffa04cba) LC1 = P1
ffa04c82: MNOP||
ffa04c86: _LOAD R1 = [FP + 0x10]
ffa04c88: _LOAD R0 = [I0++]
ffa04c8a: CALL 0xffa01814 **CALL**
ffa04c8e: CALL 0xffa0290c **CALL** **F2I**
ffa04c92: LOAD R5 = W [P5] (X)
ffa04c94: LOAD R1 = 0x5cfc **BEAM**
ffa04c98: MULT|| R1 = R5.L * R1.L (is)
ffa04c9c: LOAD P3 = [FP + 0xc]
ffa04c9e: NOP
ffa04ca0: MOVE P1 = R1
ffa04ca2: ADD R6 += 0x1
ffa04ca4: MOVE R2 = R6.L (X)
ffa04ca6: ADD P1 = P3 + P1
ffa04ca8: LOAD P3 = [FP + 0x18]
ffa04caa: ADD P1 = P1 + P2
ffa04cac: ADD P1 = P1 + P0
ffa04cae: STORE W [P1] = R0.L
ffa04cb0: LOAD R0 = [P3 + 0xc]
ffa04cb2: ASHIFT R0 >>>= 0x12
ffa04cb4: ADD R0 += 0x1
ffa04cb6: CC = R2 < R0
ffa04cb8: ADD P0 += 0x2
ffa04cba: IF !CC JUMP 0xffa04cc0
ffa04cbc: MOVE P1 = I0
ffa04cbe: JUMP.S 0xffa04c7a
ffa04cc0: LOAD P1 = [FP + -0x5c]
ffa04cc2: STORE W [P1 + -0x6] = R6
ffa04cc6: LOAD R0 = [FP + -0x24]
ffa04cc8: BITCLR (R0,0x1f)
ffa04cca: CC = R0 == 0x0
ffa04ccc: LOAD R5 = [FP + -0x24]
ffa04cce: IF CC JUMP 0xffa04d38
ffa04cd0: NOP
ffa04cd2: LOAD P1 = [FP + 0x18]
ffa04cd4: LOAD P0 = [FP + -0x5c]
ffa04cd6: LOAD R0 = [P1 + 0xc]
ffa04cd8: ASHIFT R0 >>>= 0x12
ffa04cda: ADD R0 += 0x1
ffa04cdc: CC = R0 <= 0x0
ffa04cde: STORE W [P0 + -0x6] = R7
ffa04ce2: IF CC JUMP 0xffa04d38
ffa04ce4: LOAD P0 = 0x0
ffa04ce6: LOAD R6 = 0x0
ffa04ce8: LOAD P2 = 0x3db0
ffa04cec: LOAD P1 = [FP + -0x50]
ffa04cee: MOVE I0 = P1
ffa04cf0: LOAD P1 = -0x1
ffa04cf2: LSETUP (0xffa04cf6,0xffa04d2c) LC1 = P1
ffa04cf6: ROT|| R1 = rot R5 by 0
ffa04cfa: _LOAD R4 = W [P5] (X)
ffa04cfc: _LOAD R0 = [I0++]
ffa04cfe: CALL 0xffa01814 **CALL**

######## invoker 2022E200
2022e200: IF CC JUMP 0x2022e308
2022e202: LOAD R0 = 0x7
2022e204: CC = R4 == R0
2022e206: IF CC JUMP 0x2022e308
2022e208: LOAD R0 = [P3 + 0x14]
2022e20a: LOAD R2 = [P3 + 0xc]
2022e20c: MIN R3 = min(R2,R1)
2022e210: STORE [FP + 0x10] = R3 **ST32**
2022e212: LOAD R3 = [P5 + 0xc]
2022e214: MAX R0 = max(R0,R3)
2022e218: LOAD R2 = [P3 + 0x68]
2022e21c: MAX R2 = max(R0,R2)
2022e220: LOAD R1 = 0x70a3
2022e224: SUB R0 = R2 - R3
2022e226: LOAD R1.H = 0xa35
2022e22a: LOAD R3 = [FP + 0x10]
2022e22c: MIN|| R3 = min(R3,R1)
2022e230: _STORE [P5] = R2 **ST32**
2022e232: _NOP
2022e234: STORE [P5 + 0x4] = R3 **ST32**
2022e236: LOAD R1 = [FP + 0x14]
2022e238: LOAD P1.L = 0x5896
2022e23c: LOAD P1.H = 0xffa0
2022e240: CALL (P1) **CALL**
2022e242: ROT|| R3 = rot R0 by 0
2022e246: _LOAD R2 = [P5 + 0xc]
2022e248: _NOP
2022e24a: LOAD R0 = [P5 + 0x4]
2022e24c: MAC|| A1 = R7.L * R3.L (fu)
2022e250: LOAD R1 = [FP + 0x14]
2022e252: NOP
2022e254: LSH A1 = A1 >> 0x10
2022e258: MAC A1 += R3.H * R7.L (m)
2022e25c: ASH A1 = A1 >>> 0xf
2022e260: MOVE R3 = A1.W
2022e262: STORE [P5 + 0x14] = R3 **ST32**
2022e264: SUB R0 = R0 - R2
2022e266: LOAD P1.L = 0x5896
2022e26a: LOAD P1.H = 0xffa0
2022e26e: CALL (P1) **CALL**
2022e270: MAC|| A1 = R7.L * R0.L (fu)
2022e274: LOAD R1 = [P5 + 0x14]
2022e276: NOP
2022e278: LSH A1 = A1 >> 0x10
2022e27c: MAC A1 += R0.H * R7.L (m)
2022e280: ASH A1 = A1 >>> 0xf
2022e284: MOVE R2 = A1.W
2022e286: CC = R2 <= R1
2022e288: STORE [P5 + 0x18] = R2 **ST32**
2022e28a: LOAD R0 = 0x1
2022e28c: IF CC JUMP 0x2022e2fe (bp)
2022e28e: LOAD P1 = [P4 + 0x4d0]
2022e292: LOAD P2 = [FP + 0x8]
2022e294: MOVE R1 = R7
2022e296: LOAD P0 = [P4 + 0x4cc]
2022e29a: LOAD P4 = [FP + 0xc]
2022e29c: ADD P1 = P1 + (P2 << 1)
2022e29e: LOAD R0 = W [P1] (Z)
2022e2a0: MOVE P1 = R0
2022e2a2: LOAD R7 = [FP + 0x18]
2022e2a4: ADD P1 = P0 + (P1 << 2)
2022e2a6: LOAD P1 = [P1]
2022e2a8: LOAD R0 = [P1 + 0x57c0]
2022e2ac: LOAD P1.L = 0x5ee4
2022e2b0: LOAD P1.H = 0xffa0
2022e2b4: CALL (P1) **CALL**
2022e2b6: LOAD R2 = [P4]
2022e2b8: LOAD R3 = [FP + 0x1c]
2022e2ba: ADD R0 = R0 + R2
2022e2bc: STORE [SP + 0x1c] = R3 **ST32**
2022e2be: LOAD R1 = [P5 + 0x14]
2022e2c0: LOAD R2 = [P5 + 0x18]
2022e2c2: LOAD P2 = [FP + 0x24]
2022e2c4: LOAD R3 = [FP + 0x14]
2022e2c6: STORE [SP + 0x20] = R4 **ST32**
2022e2c8: STORE [SP + 0x10] = R6 **ST32**
2022e2ca: STORE [SP + 0x24] = P2 **ST32**
2022e2cc: STORE [SP + 0xc] = R5 **ST32**
2022e2ce: STORE [SP + 0x18] = R7 **ST32**
2022e2d0: STORE [SP + 0x14] = R3 **ST32**
2022e2d2: MOVE R1 = R1.L (X)
2022e2d4: MOVE R2 = R2.L (X)
2022e2d6: LOAD P1.L = 0x467e
2022e2da: LOAD P1.H = 0xffa0
2022e2de: CALL (P1) **CALL**
2022e2e0: STORE [SP + 0x20] = R4 **ST32**
2022e2e2: MOVE R0 = R5
2022e2e4: STORE [SP + 0x10] = R6 **ST32**
2022e2e6: LOAD R3 = [FP + 0x14]
2022e2e8: LOAD R4 = [FP + 0x1c]
2022e2ea: LOAD R6 = [FP + -0x4]
2022e2ec: STORE [SP + 0x18] = R7 **ST32**
2022e2ee: STORE [SP + 0x14] = R3 **ST32**
2022e2f0: STORE [SP + 0x1c] = R4 **ST32**
2022e2f2: STORE [SP + 0xc] = R6 **ST32**
2022e2f4: LOAD R1 = [P5]
2022e2f6: LOAD R2 = [P5 + 0x4]
2022e2f8: CALL 0x2022d6dc **CALL**
2022e2fc: LOAD R0 = 0x0
2022e2fe: ADD SP += 0x28
2022e300: POP (R7:4,P5:3) = [SP++]
2022e302: UNLINK
2022e306: RTS
2022e308: LOAD R0 = 0x7
2022e30a: CC = R4 == R0
2022e30c: IF !CC JUMP 0x2022e314
2022e30e: LOAD R0 = [P3 + 0x14]
2022e310: LOAD R2 = [P3 + 0xc]
2022e312: JUMP.S 0x2022e20c
2022e314: LOAD P1 = [FP + 0x24]
2022e316: LOAD R3 = [P3 + 0x18]
2022e318: LOAD R0 = [P1 + 0xc]
2022e31a: LOAD R2 = [P1 + 0x8]
2022e31c: SUB R0 = R0 - R3
2022e31e: SUB R2 = R2 - R3
2022e320: JUMP.S 0x2022e20c
2022e322: LOAD R3 = 0x18
2022e324: MOVE P1 = R2
2022e326: MULT R0 = R0.L * R3.L (is)
2022e32a: MOVE P0 = R0
2022e32c: MULT R0 = R1.L * R3.L (is)
2022e330: MOVE P2 = R0
2022e332: LINK 0x10
2022e336: STORE [SP + 0xc] = P5 **ST32**
2022e338: LOAD P5 = 0x4c10
2022e33c: LOAD P5.H = 0x3
2022e340: ADD P1 = P1 + P5
2022e342: ADD P0 = P1 + P0
2022e344: ADD P1 = P1 + P2
2022e346: LOAD R0 = [P0 + 0x4]
2022e348: STORE [P1 + 0x4] = R0 **ST32**
2022e34a: LOAD R0 = [P0 + 0xc]
2022e34c: STORE [P1 + 0xc] = R0 **ST32**
2022e34e: LOAD R0 = [P0 + 0x8]
2022e350: STORE [P1 + 0x8] = R0 **ST32**
2022e352: LOAD R0 = W [P0] (X)
2022e354: STORE W [P1] = R0.L
2022e356: LOAD R0 = W [P0 + 0x2] (X)
2022e358: STORE W [P1 + 0x2] = R0
2022e35a: LOAD R0 = [P0 + 0x14]
2022e35c: STORE [P1 + 0x14] = R0 **ST32**
2022e35e: LOAD R0 = [P0 + 0x10]
2022e360: STORE [P1 + 0x10] = R0 **ST32**
2022e362: LOAD R2 = 0x1
2022e364: LOAD R1 = 0x0
2022e366: LOAD R0 = 0x1
2022e368: LOAD P1.L = 0x6008
2022e36c: LOAD P1.H = 0xffa0
2022e370: CALL (P1) **CALL**
2022e372: LOAD P5 = [SP + 0xc]
2022e374: UNLINK
2022e378: RTS
2022e37a: LINK 0x0
2022e37e: PUSH [--SP] = (R7:4,P5:4)
2022e380: ADD SP += -0xc
2022e382: LOAD P1.L = 0x4840
2022e386: LOAD P1.H = 0xff80
2022e38a: LOAD P1 = [P1]
2022e38c: LOAD P4.L = 0x5d80
2022e390: LOAD P4.H = 0x2022
2022e394: MOVE P5 = R0
2022e396: LOAD R4 = 0x0
2022e398: LOAD P0 = [P1 + 0x8c]
2022e39c: STORE [P4] = P0 **ST32**
2022e39e: CC = P0 == 0x0
2022e3a0: IF CC JUMP 0x2022e51e
2022e3a2: NOP
2022e3a4: NOP
2022e3a6: NOP
2022e3a8: LOAD R0 = B [P0] (Z)
2022e3aa: CC = R0 == 0x0
2022e3ac: IF CC JUMP 0x2022e51e
2022e3ae: CC = R0 <= 0x0
2022e3b0: STORE [P4 + 0x4] = R4 **ST32**
2022e3b2: STORE [P4 + 0x8] = R4 **ST32**
2022e3b4: STORE W [P4 + 0xc] = R4
2022e3b6: IF CC JUMP 0x2022e410
2022e3b8: LOAD R2 = 0x0
2022e3ba: MOVE P1 = R0
2022e3bc: MOVE I0 = P0
2022e3be: ADD I0 += 4
2022e3c0: LOAD R7 = [I0++]
2022e3c2: LOAD M0 = 0x8
2022e3c6: ADD P1 += -0x1
2022e3c8: CC = P1 == 0x0
2022e3ca: LOAD R1 = [I0 ++ M0]
2022e3cc: NEG R3 = -R1
2022e3ce: MAX R1 = max(R3,R1)
2022e3d2: MAX R1 = max(R4,R1)
2022e3d6: NEG R3 = -R7
2022e3d8: MAX R3 = max(R3,R7)
2022e3dc: IF CC JUMP 0x2022e404
2022e3de: NOP
2022e3e0: NOP
2022e3e2: LSETUP (0x2022e3e6,0x2022e400) LC0 = P1
2022e3e6: MAX|| R2 = max(R2,R3)
2022e3ea: _LOAD R5 = [I0++]
2022e3ec: _NOP
2022e3ee: NEG|| R6 = -R5 (ns)
2022e3f2: _LOAD R3 = [I0 ++ M0]
2022e3f4: _NOP
2022e3f6: NEG R7 = -R3
2022e3f8: MAX R7 = max(R7,R3)
2022e3fc: MAX R3 = max(R6,R5)
2022e400: MAX R1 = max(R1,R7)

######## 2022D05E int16tofloat
2022d05e: LINK 0x28
2022d062: PUSH [--SP] = (R7:4,P5:3)
2022d064: ADD SP += -0xc
2022d066: STORE [SP + 0x28] = R1 **ST32**
2022d068: LOAD P0 = [SP + 0x28]
2022d06a: LOAD P2 = 0x4c08
2022d06e: LOAD P2.H = 0x3
2022d072: LOAD R5.H = 0x5cfc **BEAM**
2022d076: LOAD P1 = 0x578 **BEAM**
2022d07a: ADD P4 = P0 + P2
2022d07c: LOAD R2 = W [P4] (X)
2022d07e: MULT|| R2 = R2.L * R5.H (is)
2022d082: STORE [FP + 0x8] = R0 **ST32**
2022d084: NOP
2022d086: MOVE P2 = R2
2022d088: ADD P1 = P0 + P1
2022d08a: LOAD R7 = 0x0
2022d08c: LOAD R7.H = 0x4700
2022d090: ADD P0 = P1 + P2
2022d092: MOVE R1 = R7
2022d094: LOAD R0 = [P0 + 0x5cd4]
2022d098: LOAD P1.L = 0x1814
2022d09c: LOAD P1.H = 0xffa0
2022d0a0: CALL (P1) **CALL**
2022d0a2: ROT|| R1 = rot R7 by 0
2022d0a6: _STORE [SP + 0x30] = R0 **ST32**
2022d0a8: _NOP
2022d0aa: LOAD R0 = [P0 + 0x5cdc]
2022d0ae: LOAD P1.L = 0x1814
2022d0b2: LOAD P1.H = 0xffa0
2022d0b6: CALL (P1) **CALL**
2022d0b8: ROT|| R1 = rot R7 by 0
2022d0bc: _STORE [SP + 0x34] = R0 **ST32**
2022d0be: _NOP
2022d0c0: LOAD R0 = [P0 + 0x5ce0]
2022d0c4: LOAD P1.L = 0x1814
2022d0c8: LOAD P1.H = 0xffa0
2022d0cc: CALL (P1) **CALL**
2022d0ce: ROT|| R1 = rot R7 by 0
2022d0d2: _LOAD P1 = [FP + 0x8]
2022d0d4: _NOP
2022d0d6: STORE [FP + 0x10] = R0 **ST32**
2022d0d8: LOAD R0 = [P0 + 0x5ce4]
2022d0dc: LOAD I0.L = 0x485c
2022d0e0: LOAD I0.H = 0xff80
2022d0e4: LOAD R4 = [P1 + 0xc]
2022d0e6: ASHIFT R4 >>>= 0xf
2022d0e8: LOAD P1.L = 0x1814
2022d0ec: LOAD P1.H = 0xffa0
2022d0f0: CALL (P1) **CALL**
2022d0f2: ADD R4 += 0x1
2022d0f4: LOAD R6 = 0x0
2022d0f6: CC = R4 <= 0x0
2022d0f8: STORE W [I0] = R6.L
2022d0fa: STORE [FP + 0xc] = R0 **ST32**
2022d0fc: LOAD P5.L = 0x5060 **FLOATBUF**
2022d100: LOAD P5.H = 0x2021
2022d104: IF CC JUMP 0x2022d160
2022d106: LOAD R0 = 0x578 **BEAM**
2022d10a: LOAD R1 = [SP + 0x28]
2022d10c: ADD R0 = R1 + R0
2022d10e: STORE [SP + 0x2c] = R0 **ST32**
2022d110: MOVE P3 = P5
2022d112: LOAD R7 = 0x0
2022d114: LOAD R4 = 0x0
2022d116: LOAD P1 = -0x1
2022d118: LSETUP (0x2022d11c,0x2022d15c) LC0 = P1
2022d11c: LOAD R0 = W [P4] (X)
2022d11e: MULT|| R0 = R0.L * R5.H (is)
2022d122: LOAD R2 = [SP + 0x2c]
2022d124: NOP
2022d126: ADD R0 = R2 + R0
2022d128: LOAD R1 = 0x44 **+44**
2022d12c: ADD R0 = R0 + R1
2022d12e: ADD R0 = R0 + R4
2022d130: MOVE P1 = R0
2022d132: ADD R7 += 0x1
2022d134: ADD R4 += 0x2
2022d136: LOAD R0 = W [P1] (X)
2022d138: LOAD P1.L = 0x1688
2022d13c: LOAD P1.H = 0xffa0
2022d140: CALL (P1) **CALL**
2022d142: LOAD R1 = [SP + 0x30]
2022d144: LOAD P1.L = 0x18f0
2022d148: LOAD P1.H = 0xffa0
2022d14c: CALL (P1) **CALL**
2022d14e: LOAD P1 = [FP + 0x8]
2022d150: STORE [P3++] = R0 **ST32**
2022d152: MOVE R1 = R7.L (X)
2022d154: LOAD R0 = [P1 + 0xc]
2022d156: ASHIFT R0 >>>= 0xf
2022d158: ADD R0 += 0x1
2022d15a: CC = R1 < R0
2022d15c: IF !CC JUMP 0x2022d160
2022d15e: JUMP.S 0x2022d116
2022d160: LOAD P1 = [FP + 0x8]
2022d162: LOAD R0 = [P1 + 0xc]
2022d164: ASHIFT R0 >>>= 0x12
2022d166: ADD R0 += 0x1
2022d168: CC = R0 <= 0x0
2022d16a: IF CC JUMP 0x2022d22c
2022d16c: LOAD P0 = 0x6660
2022d170: LOAD P1 = 0x709c
2022d174: LOAD R0 = 0x578 **BEAM**
2022d178: LOAD R1 = [SP + 0x28]
2022d17a: LOAD P2 = 0x7ad8
2022d17e: ADD P3 = P5 + P0
2022d180: ADD P1 = P5 + P1
2022d182: ADD R4 = R1 + R0
2022d184: ADD P5 = P5 + P2
2022d186: LOAD R7 = 0x0
2022d188: MOVE I1 = P1
2022d18a: LOAD P1 = -0x1
2022d18c: LSETUP (0x2022d190,0x2022d224) LC0 = P1
2022d190: LOAD R0 = W [P4] (X)
2022d192: MULT R0 = R0.L * R5.H (is)
2022d196: ADD R0 = R4 + R0
2022d198: LOAD R2 = 0x3374
2022d19c: ADD R0 = R0 + R2
2022d19e: ADD R0 = R0 + R7
2022d1a0: MOVE P1 = R0
2022d1a2: ADD R6 += 0x1
2022d1a4: LOAD R0 = W [P1] (X)
2022d1a6: LOAD P1.L = 0x1688
2022d1aa: LOAD P1.H = 0xffa0
2022d1ae: CALL (P1) **CALL**
2022d1b0: LOAD R1 = [SP + 0x34]
2022d1b2: LOAD P1.L = 0x18f0
2022d1b6: LOAD P1.H = 0xffa0
2022d1ba: CALL (P1) **CALL**
2022d1bc: STORE [P3++] = R0 **ST32**
2022d1be: LOAD R0 = W [P4] (X)
2022d1c0: MULT R0 = R0.L * R5.H (is)
2022d1c4: ADD R0 = R4 + R0
2022d1c6: LOAD R2 = 0x3892
2022d1ca: ADD R0 = R0 + R2
2022d1cc: ADD R0 = R0 + R7
2022d1ce: MOVE P1 = R0
2022d1d0: LOAD R0 = W [P1] (X)
2022d1d2: LOAD P1.L = 0x1688
2022d1d6: LOAD P1.H = 0xffa0
2022d1da: CALL (P1) **CALL**
2022d1dc: LOAD R1 = [FP + 0x10]
2022d1de: LOAD P1.L = 0x18f0
2022d1e2: LOAD P1.H = 0xffa0
2022d1e6: CALL (P1) **CALL**
2022d1e8: STORE [I1++] = R0 **ST32**
2022d1ea: LOAD R0 = W [P4] (X)
2022d1ec: MULT R0 = R0.L * R5.H (is)
2022d1f0: ADD R0 = R4 + R0
2022d1f2: LOAD R2 = 0x3db0
2022d1f6: ADD R0 = R0 + R2
2022d1f8: ADD R0 = R0 + R7
2022d1fa: MOVE P1 = R0
2022d1fc: ADD R7 += 0x2
2022d1fe: LOAD R0 = W [P1] (X)
2022d200: LOAD P1.L = 0x1688

######## 2022D6C0 modifier
2022d6c0: ADD R1 = R1 + R2
2022d6c2: MOVE P1 = R1
2022d6c4: LOAD P0 = [SP + 0x30]
2022d6c6: LOAD R4 = [P5 + 0x20]
2022d6c8: LOAD R0 = W [P5 + 0x6] (Z)
2022d6ca: LOAD R1 = [P1]
2022d6cc: SUB R1 = R1 - R5
2022d6ce: NEG R2 = -R1
2022d6d0: MAX R1 = max(R2,R1)
2022d6d4: CC = R1 < R4
2022d6d6: MOVE R1 = CC
2022d6d8: STORE B [P0] = R1
2022d6da: JUMP.S 0x2022d67e
2022d6dc: LINK 0x40
2022d6e0: PUSH [--SP] = (R7:4,P5:3)
2022d6e2: ADD SP += -0x24
2022d6e4: ROT|| R5 = rot R2 by 0
2022d6e8: _LOAD P2 = [FP + 0x1c]
2022d6ea: _NOP
2022d6ec: STORE [FP + -0x18] = P2 **ST32**
2022d6ee: LOAD P1 = 0x4c08
2022d6f2: LOAD P1.H = 0x3
2022d6f6: LOAD R6 = 0x0
2022d6f8: ADD P4 = P2 + P1
2022d6fa: LOAD R4 = 0xa028
2022d6fe: STORE [FP + -0x10] = R6 **ST32**
2022d700: LOAD R7 = W [P4] (X)
2022d702: LOAD R4.H = 0x5cfc **BEAM**
2022d706: LOAD R3 = 0x578 **BEAM**
2022d70a: LOAD R6 = [FP + -0x18]
2022d70c: MULT|| R0 = R7.L * R4.H (is)
2022d710: STORE [FP + -0x8] = R0 **ST32**
2022d712: NOP
2022d714: ADD R3 = R6 + R3
2022d716: ADD R0 = R3 + R0
2022d718: MOVE P1 = R0
2022d71a: ASH|| R7 = R5 >>> 0xf
2022d71e: _LOAD R2 = [FP + -0x8]
2022d720: _NOP
2022d722: STORE [FP + -0xc] = R3 **ST32**
2022d724: STORE [FP + -0x28] = R2 **ST32**
2022d726: MOVE R6 = R1
2022d728: LOAD R0 = [P1 + 0x3c]
2022d72a: LOAD P1.L = 0x1688
2022d72e: LOAD P1.H = 0xffa0
2022d732: CALL (P1) **CALL**
2022d734: LOAD R1 = [P4 + 0x19fec]
2022d738: LOAD P1.L = 0x18f0
2022d73c: LOAD P1.H = 0xffa0
2022d740: CALL (P1) **CALL**
2022d742: LOAD P1.L = 0x14dc
2022d746: LOAD P1.H = 0xffa0
2022d74a: CALL (P1) **CALL**
2022d74c: MOVE R0 = R0.L (X)
2022d74e: LOAD P3.L = 0x5d1c
2022d752: LOAD P3.H = 0x2022
2022d756: LSH|| R0 = R0 << 0xf
2022d75a: _STORE W [P3 + 0x6] = R0
2022d75c: _NOP
2022d75e: LOAD R1 = [FP + -0x18]
2022d760: LOAD P1.L = 0x5896
2022d764: LOAD P1.H = 0xffa0
2022d768: CALL (P1) **CALL**
2022d76a: LOAD P1 = [FP + 0x18]
2022d76c: LOAD R3 = W [P3 + 0x6] (X)
2022d76e: ADD R1 = R3 + R7
2022d770: STORE [P3 + 0x10] = R7 **ST32**
2022d772: LOAD R7 = [P1 + 0xc]
2022d774: STORE [FP + -0x3c] = R0 **ST32**
2022d776: ASHIFT R7 >>>= 0xf
2022d778: MIN|| R7 = min(R1,R7)
2022d77c: _LOAD R0 = W [P4] (X)
2022d77e: _NOP
2022d780: MULT|| R0 = R0.L * R4.H (is)
2022d784: LOAD R1 = [FP + -0xc]
2022d786: NOP
2022d788: ADD R0 = R1 + R0
2022d78a: LOAD R1 = 0x44 **+44**
2022d78e: ADD R1 = R0 + R1
2022d790: ASH|| R0 = R6 >>> 0xf
2022d794: _LOAD R2 = [P1 + 0x14]
2022d796: _NOP
2022d798: STORE [FP + -0x1c] = R1 **ST32**
2022d79a: SUB R1 = R0 - R3
2022d79c: ASHIFT R2 >>>= 0xf
2022d79e: MAX|| R2 = max(R1,R2)
2022d7a2: _STORE [P3 + 0x18] = R7 **ST32**
2022d7a4: _NOP
2022d7a6: SUB R7 = R7 - R2
2022d7a8: ADD R7 += 0x1
2022d7aa: LOAD R1 = 0x1100
2022d7ae: MIN|| R1 = min(R7,R1)
2022d7b2: _STORE [P3 + 0xc] = R0 **ST32**
2022d7b4: _NOP
2022d7b6: LOAD R0 = W [SP + 0x46] (Z)
2022d7ba: LSH|| R1.H = R0.L << 0x0
2022d7be: LOAD R3 = [FP + -0x3c]
2022d7c0: NOP
2022d7c2: MAC|| A1 = R4.L * R3.L (fu)
2022d7c6: STORE W [P3 + 0x1c] = R1
2022d7c8: NOP
2022d7ca: LSH|| A1 = A1 >> 0x10
2022d7ce: STORE [P3 + 0x14] = R2 **ST32**
2022d7d0: NOP
2022d7d2: MAC|| A1 += R1.H * R4.L (m)
2022d7d6: LOAD R7 = [FP + -0x1c]
2022d7d8: NOP
2022d7da: ASH A1 = A1 >>> 0xf
2022d7de: MOVE R3 = R1.L (X)
2022d7e0: MOVE R1 = A1.W
2022d7e2: LSHIFT R2 <<= 0x1
2022d7e4: ROT|| R1 = rot R3 by 0
2022d7e8: _STORE W [P3 + 0x8] = R1
2022d7ea: _NOP
2022d7ec: ADD R0 = R7 + R2
2022d7ee: LOAD P1.L = 0x33f8
2022d7f2: LOAD P1.H = 0xffa0
2022d7f6: CALL (P1) **CALL**
2022d7f8: LOAD R2 = W [P3 + 0x1c] (X)
2022d7fa: LOAD R7 = 0x0
2022d7fc: CC = R2 <= 0x0
2022d7fe: STORE [P3 + 0x20] = R0 **ST32**
2022d800: STORE W [P3] = R7.L
2022d802: IF CC JUMP 0x2022d84e
2022d804: LSH|| R1 = R0 << 0x1e
2022d808: _LOAD R3 = [P3 + 0x14]
2022d80a: _NOP
2022d80c: MOVE CC = az
2022d80e: MOVE P2 = R0
2022d810: MOVE P0 = R2
2022d812: IF CC JUMP 0x2022d816 (bp)
2022d814: JUMP.S 0x2022e0fa
2022d816: CC = R2 == 0x1
2022d818: IF !CC JUMP 0x2022d81c (bp)
2022d81a: JUMP.S 0x2022e0f2
2022d81c: ASH R0 = R2 >>> 0x1
2022d820: MOVE P1 = R0
2022d822: MOVE P0 = P2
2022d824: PACK R3 = pack(R3.L,R3.L)
2022d828: LOAD R0 = [P2++]
2022d82a: ADD P1 += -0x1
2022d82c: CC = P1 == 0x0
2022d82e: IF CC JUMP 0x2022d83e
2022d830: LSETUP (0x2022d834,0x2022d83c) LC0 = P1
2022d834: ADD|| R1 = R3 +|+ R0
2022d838: _LOAD R0 = [P2++]
2022d83a: _NOP
2022d83c: STORE [P0++] = R1 **ST32**
2022d83e: ADD R0 = R3 +|+ R0
2022d842: STORE [P0++] = R0 **ST32**
2022d844: CC = BITTST (R2,0x0)
2022d846: MOVE P2 = P0
2022d848: IF !CC JUMP 0x2022d84c (bp)
2022d84a: JUMP.S 0x2022e0f2
2022d84c: STORE W [P3 + 0x0] = R2
2022d84e: LOAD R0 = W [P4] (X)
2022d850: MULT|| R0 = R0.L * R4.H (is)
2022d854: LOAD P2 = [FP + 0x1c]
2022d856: NOP
2022d858: MOVE P1 = R0
2022d85a: LOAD P0 = 0x578 **BEAM**
2022d85e: ADD P0 = P2 + P0
2022d860: ADD P2 = P0 + P1
2022d862: LOAD R0 = [P2 + 0x5cb8]
2022d866: CC = R5 <= R0
2022d868: IF !CC JUMP 0x2022d884
2022d86a: LOAD P5 = [FP + 0x1c]
2022d86c: LOAD R0 = W [P4] (X)
2022d86e: LOAD P1 = -0x1d10
2022d872: LOAD P1.H = 0x4
2022d876: STORE [FP + -0x3c] = R0 **ST32**
2022d878: ADD P1 = P5 + P1
2022d87a: LOAD P5 = [FP + -0x3c]
2022d87c: ADD P1 = P1 + (P5 << 1)
2022d87e: STORE W [P1] = R7.L
2022d880: STORE [P2 + 0x5cb4] = R6 **ST32**
2022d884: ROT|| R0 = rot R6 by 0
2022d888: _LOAD P5 = [FP + 0x1c]
2022d88a: _NOP
2022d88c: LOAD P1 = [FP + 0x14]
2022d88e: LOAD P2 = -0x4c08
2022d892: LOAD P2.H = 0xfffc
2022d896: STORE [FP + -0x14] = P0 **ST32**
2022d898: SUB P2 -= P5
2022d89a: ADD P2 = P2 + P1
2022d89c: LOAD P1 = -0x4690
2022d8a0: LOAD P1.H = 0xfffc
2022d8a4: MOVE P5 = P4
2022d8a6: LOAD R2.L = W [P4 ++ P1]
2022d8a8: MULT|| R2 = R2.L * R4.H (is)
2022d8ac: STORE [FP + -0x1c] = P2 **ST32**
2022d8ae: NOP
2022d8b0: LOAD P2 = [FP + -0x28]
2022d8b2: MOVE P1 = R2
2022d8b4: ADD P0 += -0x34
2022d8b6: LOAD R3 = 0x0
2022d8b8: ADD P2 = P0 + (P2 << 2)
2022d8ba: LOAD P0 = [FP + 0x14]
2022d8bc: ADD P1 = P4 + P1
2022d8be: STORE [P1 + 0x5cb8] = R5 **ST32**
2022d8c2: LOAD R1 = [FP + -0x18]
2022d8c4: STORE [P0] = R3 **ST32**
2022d8c6: LOAD P1 = [P4 + -0xa8]
2022d8ca: LOAD P0 = [FP + -0x28]
2022d8cc: LOAD R3 = [P2]
2022d8ce: LOAD P2 = [P4 + -0xac]
2022d8d2: MAC A1 = R4.L * R3.L (fu)
2022d8d6: ADD P1 = P1 + (P0 << 1)
2022d8d8: LSH|| A1 = A1 >> 0x10
2022d8dc: LOAD R2 = W [P1] (Z)
2022d8de: NOP
2022d8e0: MOVE P1 = R2
2022d8e2: MOVE P0 = P5
2022d8e4: MAC A1 += R3.H * R4.L (m)
2022d8e8: ASH A1 = A1 >>> 0xf
2022d8ec: MOVE R3 = A1.W
2022d8ee: ADD P1 = P2 + (P1 << 2)
2022d8f0: LOAD P2 = [FP + 0x14]
2022d8f2: LOAD P1 = [P1]
2022d8f4: LOAD P4 = 0x4bc2
2022d8f8: LOAD P4.H = 0x3
2022d8fc: LOAD R7.H = 0x2908
2022d900: SUB P0 -= P2
2022d902: LOAD P2 = [FP + 0x18]
2022d904: LOAD R2 = [P1 + 0x57c0]
2022d908: ADD R2 = R3 + R2
2022d90a: STORE [P3 + 0x38] = R2 **ST32**
2022d90c: SUB P4 -= P2
2022d90e: STORE [FP + -0x20] = P0 **ST32**
2022d910: LOAD P1.L = 0x5896
2022d914: LOAD P1.H = 0xffa0
2022d918: CALL (P1) **CALL**
2022d91a: MAC|| A1 = R4.L * R0.L (fu)
2022d91e: LOAD P0 = [FP + 0x1c]
2022d920: NOP
2022d922: LSH|| A1 = A1 >> 0x10
2022d926: LOAD R2 = [P3 + 0x38]
2022d928: NOP
2022d92a: MAC|| A1 += R0.H * R4.L (m)
2022d92e: LOAD R1 = [FP + -0x18]
2022d930: NOP
2022d932: ASH A1 = A1 >>> 0xf
2022d936: MOVE R3 = A1.W
2022d938: SUB R2 = R3 - R2
2022d93a: ADD P1 = P0 + P4
2022d93c: ROT|| R0 = rot R5 by 0
2022d940: _STORE [P3 + 0x30] = R2 **ST32**
2022d942: _NOP
2022d944: STORE [FP + -0x34] = P1 **ST32**
2022d946: LOAD P1.L = 0x5896
2022d94a: LOAD P1.H = 0xffa0
2022d94e: CALL (P1) **CALL**
2022d950: MAC|| A1 = R4.L * R0.L (fu)
2022d954: LOAD P4 = [FP + -0x34]
2022d956: NOP
2022d958: LSH|| A1 = A1 >> 0x10
2022d95c: LOAD R1 = [P3 + 0x38]
2022d95e: NOP
2022d960: MAC|| A1 += R0.H * R4.L (m)
2022d964: STORE W [P3] = R7.L
2022d966: NOP
2022d968: LOAD P1 = 0x0
2022d96a: ASH A1 = A1 >>> 0xf
2022d96e: SUB P1 -= P4
2022d970: LOAD P0 = -0x6918
2022d974: LOAD P0.H = 0x1
2022d978: LOAD P2 = 0x25a0
2022d97c: MOVE R0 = A1.W
2022d97e: LOAD P4 = -0x1b0
