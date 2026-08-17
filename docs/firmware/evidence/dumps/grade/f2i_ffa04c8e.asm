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
ffa04c8a: CALL 0xffa01814
ffa04c8e: CALL 0xffa0290c
ffa04c92: LOAD R5 = W [P5] (X)
ffa04c94: LOAD R1 = 0x5cfc
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
