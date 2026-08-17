ffa05d02: MOVE R6 = R0
ffa05d04: IF CC JUMP 0xffa05e0e
ffa05d06: LOAD P2 = [FP + 0x14]
ffa05d08: LOAD P3 = [FP + 0x14]
ffa05d0a: MOVE P1 = P4
ffa05d0c: STORE [SP + 0x34] = P0
ffa05d0e: SUB P2 -= P4
ffa05d10: SUB P1 -= P3
ffa05d12: STORE [SP + 0x38] = P2
ffa05d14: STORE [SP + 0x3c] = P1
ffa05d16: LOAD R4 = 0x3
ffa05d18: ROT|| R5 = rot R7 by 0
ffa05d1c: _LOAD P4 = [SP + 0x34]
ffa05d1e: _NOP
ffa05d20: ADD R5 += -0x1
ffa05d22: LOAD R0 = W [P4++] (X)
ffa05d24: MULT|| R1 = R0.L * R0.L (is)
ffa05d28: LOAD R0 = W [P4++] (X)
ffa05d2a: NOP
ffa05d2c: MULT R0 = R0.L * R0.L (is)
ffa05d30: ADD R0 = R1 + R0
ffa05d32: CALL 0xffa02894
ffa05d36: LOAD R1 = [P3]
ffa05d38: CALL 0xffa01716
ffa05d3c: CC = R5 == 0x0
ffa05d3e: ROT|| R1 = rot R6 by 0
ffa05d42: _STORE [P3] = R0
ffa05d44: _NOP
ffa05d46: IF !CC JUMP 0xffa05d20 (bp)
ffa05d48: LOAD P0 = [SP + 0x34]
ffa05d4a: LOAD P1 = 0x4000
ffa05d4e: ADD R4 += -0x1
ffa05d50: LOAD R0 = [P3]
ffa05d52: ADD P4 = P0 + P1
ffa05d54: LOAD P2 = [SP + 0x3c]
ffa05d56: CALL 0xffa01814
ffa05d5a: ROT|| R5 = rot R0 by 0
ffa05d5e: _LOAD P1 = [SP + 0x38]
ffa05d60: _NOP
ffa05d62: STORE [SP + 0x34] = P4
ffa05d64: STORE [P3 ++ P2] = R0
ffa05d66: LOAD R0 = [P3 ++ P1]
ffa05d68: MOVE R1 = R0
ffa05d6a: CALL 0xffa018f0
ffa05d6e: MOVE R1 = R5
ffa05d70: CALL 0xffa018f0
ffa05d74: CC = R4 == 0x0
ffa05d76: STORE [P3++] = R0
ffa05d78: IF !CC JUMP 0xffa05d18 (bp)
ffa05d7a: LOAD P4 = [FP + 0x24]
ffa05d7c: LOAD P1 = 0x4c08
ffa05d80: LOAD P1.H = 0x3
