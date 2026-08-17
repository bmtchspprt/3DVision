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
