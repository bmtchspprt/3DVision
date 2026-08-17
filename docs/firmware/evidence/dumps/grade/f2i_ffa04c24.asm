ffa04c04: LOAD P1 = -0x1
ffa04c06: LOAD R1 = W [P5] (X)
ffa04c08: LSETUP (0xffa04c0c,0xffa04c4a) LC1 = P1
ffa04c0c: LOAD R1.H = 0x5cfc
ffa04c10: MULT|| R1 = R1.L * R1.H (is)
ffa04c14: LOAD R0 = [P2++]
ffa04c16: NOP
ffa04c18: ROT|| R1 = rot R6 by 0
ffa04c1c: _STORE [FP + -0x58] = R1
ffa04c1e: _NOP
ffa04c20: CALL 0xffa01814
ffa04c24: CALL 0xffa0290c
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
