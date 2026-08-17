ffa04dde: _LOAD R0 = [P4++]
ffa04de0: _LOAD R1.L = W [I0]
ffa04de2: LOAD R2 = 0x5cfc
ffa04de6: MULT R1 = R1.L * R2.L (is)
ffa04dea: ADD R1 = R5 + R1
ffa04dec: LOAD R3 = 0x5a26
ffa04df0: ADD R1 = R1 + R3
ffa04df2: ADD R1 = R1 + R6
ffa04df4: MOVE P0 = R1
ffa04df6: MOVE R1 = R4
ffa04df8: CALL 0xffa01814
ffa04dfc: CALL 0xffa0290c
ffa04e00: ADD R6 += 0x2
ffa04e02: STORE W [P0] = R0.L
ffa04e04: LOAD R0 = [FP + 0x28]
ffa04e06: LOAD R1 = 0x7
ffa04e08: CC = R0 == R1
ffa04e0a: IF !CC JUMP 0xffa04ed4
ffa04e0c: LOAD P0 = [FP + -0x48]
ffa04e0e: LOAD R0 = 0xff
ffa04e12: LSHIFT R0 <<= 0x17
ffa04e14: STORE [FP + 0x8] = R0
ffa04e16: LOAD P2 = 0x147
ffa04e1a: MOVE P1 = P0
ffa04e1c: LOAD R1 = [FP + -0x4]
ffa04e1e: LSETUP (0xffa04e22,0xffa04e6a) LC0 = P2
ffa04e22: ROT|| R0 = rot R1 by 0
ffa04e26: _LOAD R3 = [P1++]
ffa04e28: _NOP
ffa04e2a: AND R4 = R0 & R3
ffa04e2c: LSH|| R4 = R4 >> 0x1f
ffa04e30: _LOAD R5 = [FP + 0x8]
ffa04e32: _NOP
ffa04e34: ROT|| R2 = rot R3 by 0
ffa04e38: _STORE [FP + -0x58] = R4
ffa04e3a: _NOP
ffa04e3c: BITCLR (R1,0x1f)
