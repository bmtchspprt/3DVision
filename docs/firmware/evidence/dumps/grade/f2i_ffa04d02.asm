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
ffa04cfe: CALL 0xffa01814
ffa04d02: CALL 0xffa0290c
ffa04d06: LOAD R1 = 0x5cfc
ffa04d0a: MULT|| R1 = R4.L * R1.L (is)
ffa04d0e: LOAD P3 = [FP + 0xc]
ffa04d10: NOP
ffa04d12: MOVE P1 = R1
ffa04d14: ADD R6 += 0x1
ffa04d16: MOVE R2 = R6.L (X)
ffa04d18: ADD P1 = P3 + P1
ffa04d1a: LOAD P3 = [FP + 0x18]
ffa04d1c: ADD P1 = P1 + P2
ffa04d1e: ADD P1 = P1 + P0
ffa04d20: STORE W [P1] = R0.L
ffa04d22: LOAD R0 = [P3 + 0xc]
ffa04d24: ASHIFT R0 >>>= 0x12
ffa04d26: ADD R0 += 0x1
ffa04d28: CC = R2 < R0
ffa04d2a: ADD P0 += 0x2
ffa04d2c: IF !CC JUMP 0xffa04d32
ffa04d2e: MOVE P1 = I0
ffa04d30: JUMP.S 0xffa04cee
ffa04d32: LOAD P1 = [FP + -0x5c]
ffa04d34: STORE W [P1 + -0x6] = R6
ffa04d38: LOAD R0 = 0x5
ffa04d3a: LOAD R1 = [FP + 0x28]
ffa04d3c: CC = R1 == R0
ffa04d3e: IF !CC JUMP 0xffa04e04
ffa04d40: LOAD R0 = 0xff
