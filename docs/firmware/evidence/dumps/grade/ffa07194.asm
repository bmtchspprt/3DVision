ffa07194: LOAD R1 = -0x1
ffa07196: LINK 0x0
ffa0719a: LSHIFT R1 <<= 0x1c
ffa0719c: PUSH [--SP] = R7
ffa0719e: AND R1 = R0 & R1
ffa071a0: SUB R1 = R0 - R1
ffa071a2: LOAD R2 = 0x0
ffa071a4: LOAD R2.H = 0xc00
ffa071a8: CC = R2 < R1
ffa071aa: LOAD R3 = 0x0
ffa071ac: LOAD R3.H = 0x1800
ffa071b0: SUB R2 = R3 - R1 (s)
ffa071b4: IF CC R1 = R2
ffa071b6: MOVE R1.L = R1 (rnd)
ffa071ba: MOVE R1 = R1.L (X)
ffa071bc: LOAD R2 = 0xc00
ffa071c0: LOAD R0 = 0x0
ffa071c2: CC = R1 < R2
ffa071c4: BITSET (R0,0x1f)
ffa071c6: IF !CC JUMP 0xffa071d8
ffa071c8: MOVE P1 = R1
ffa071ca: LOAD P0.L = 0x100
ffa071ce: LOAD P0.H = 0xff80
ffa071d2: ADD P1 = P0 + (P1 << 1)
ffa071d4: LOAD R0 = W [P1] (X)
ffa071d6: LSHIFT R0 <<= 0x10
ffa071d8: LOAD R7 = [SP++]
ffa071da: UNLINK
ffa071de: RTS
ffa07280: MOVE P0 = R0
ffa07282: MOVE P2 = R2
ffa07284: ADD R3 = R0 + R2
ffa07286: CC = R2 <= 0x7 (IU)
ffa07288: IF CC JUMP 0xffa072b8
ffa0728a: MOVE R1 = R1.B (Z)
ffa0728c: LOAD R2 = 0x3
ffa0728e: AND R2 = R0 & R2
ffa07290: CC = R2 == 0x0
ffa07292: IF !CC JUMP 0xffa072c4
ffa07294: LSHIFT P1 = P2 >> 2
ffa07296: LSH R2 = R1 << 0x8
ffa0729a: ADD R2.L = R2.L + R1.L (ns)
ffa0729e: ADD R2.H = R2.L + R1.H (ns)
ffa072a2: MOVE P2 = R3
ffa072a4: LSETUP (0xffa072a8,0xffa072a8) LC0 = P1
ffa072a8: STORE [P0++] = R2
ffa072aa: CC = P0 == P2
ffa072ac: IF !CC JUMP 0xffa072b0
ffa072ae: RTS
ffa072b0: MOVE R2 = R3
ffa072b2: MOVE R3 = P0
ffa072b4: SUB R2 = R2 - R3
ffa072b6: MOVE P2 = R2
ffa072b8: CC = P2 == 0x0
ffa072ba: IF CC JUMP 0xffa072c2
ffa072bc: LSETUP (0xffa072c0,0xffa072c0) LC0 = P2
ffa072c0: STORE B [P0++] = R1
ffa072c2: RTS
ffa072c4: CC = BITTST (R0,0x0)
ffa072c6: LOAD R0 = 0x4
ffa072c8: SUB R0 = R0 - R2
ffa072ca: MOVE P1 = R0
ffa072cc: MOVE R0 = P0
ffa072ce: IF !CC JUMP 0xffa072d2
ffa072d0: STORE B [P0++] = R1
ffa072d2: CC = R2 <= 0x2
ffa072d4: SUB P2 -= P1
ffa072d6: IF !CC JUMP 0xffa07294
ffa072d8: STORE B [P0++] = R1
ffa072da: STORE B [P0++] = R1
ffa072dc: JUMP.S 0xffa07294
ffa072e0: PUSH [--SP] = (P5:3)
ffa072e2: LOAD P1 = [P0++]
ffa072e4: LOAD P2 = 0x0
ffa072e6: ADD P4 = P0 + (P1 << 2)
ffa072e8: ADD P4 += 0x4
ffa072ea: LSETUP (0xffa072ee,0xffa07304) LC0 = P1
ffa072ee: CC = P1 <= P2
ffa072f0: IF CC JUMP 0xffa07306
ffa072f2: ADD P3 = P1 + P2
ffa072f4: LSHIFT P3 = P3 >> 1
ffa072f6: ADD P5 = P0 + (P3 << 2)
ffa072f8: LOAD R1 = [P5]
ffa072fa: CC = R1 == R0
ffa072fc: IF CC JUMP 0xffa07308
ffa072fe: CC = R1 < R0 (IU)
ffa07300: IF !CC P1 = P3
