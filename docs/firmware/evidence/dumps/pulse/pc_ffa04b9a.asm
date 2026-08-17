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
ffa04c00: LOAD R5 = 0x0
ffa04c02: LOAD P2 = [FP + -0x4c]
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
ffa04d44: LSHIFT R0 <<= 0x17
ffa04d46: STORE [FP + 0x8] = R0
ffa04d48: LOAD P1 = 0x147
ffa04d4c: MOVE P0 = P4
ffa04d4e: LOAD R1 = [FP + -0x8]
ffa04d50: LSETUP (0xffa04d54,0xffa04d98) LC0 = P1
ffa04d54: ROT|| R0 = rot R1 by 0
ffa04d58: _LOAD R2 = [P0++]
ffa04d5a: _NOP
ffa04d5c: AND R4 = R1 & R2
ffa04d5e: LSH|| R4 = R4 >> 0x1f
ffa04d62: _LOAD R5 = [FP + 0x8]
ffa04d64: _NOP
ffa04d66: ROT|| R3 = rot R2 by 0
ffa04d6a: _STORE [FP + -0x58] = R4
ffa04d6c: _NOP
ffa04d6e: BITCLR (R0,0x1f)
ffa04d70: BITCLR (R3,0x1f)
ffa04d72: CC = R5 < R0
ffa04d74: LOAD R4 = [FP + 0x8]
ffa04d76: OR R5 = R0 | R3
ffa04d78: MOVE R0 = CC
ffa04d7a: CC = R4 < R3
ffa04d7c: LOAD R6 = 0x1
ffa04d7e: IF !CC R6 = R0
ffa04d80: CC = R2 < R1
ffa04d82: MOVE R4 = CC
ffa04d84: LOAD R3 = [FP + -0x58]
ffa04d86: CC = R1 == R2
ffa04d88: XOR R0 = R3 ^ R4
ffa04d8a: IF !CC R4 = R0
ffa04d8c: CC = R5 == 0x0
ffa04d8e: IF CC R4 = R5
ffa04d90: CC = BITTST (R6,0x0)
ffa04d92: IF CC R4 = R7
ffa04d94: CC = BITTST (R4,0x0)
ffa04d96: IF CC R2 = R1
ffa04d98: MOVE R1 = R2
ffa04d9a: LOAD R0 = W [P5] (X)
ffa04d9c: LOAD R3 = 0x5cfc
ffa04da0: MULT|| R0 = R0.L * R3.L (is)
ffa04da4: STORE [FP + -0x8] = R2
ffa04da6: NOP
ffa04da8: MOVE P0 = R0
ffa04daa: LOAD P2 = [FP + -0x5c]
ffa04dac: LOAD P3 = [FP + 0xc]
ffa04dae: LOAD R1 = [FP + -0x8]
ffa04db0: BITCLR (R1,0x1f)
ffa04db2: ADD P2 += -0x6
ffa04db4: ADD P0 = P3 + P0
ffa04db6: LOAD R0 = 0x147
ffa04dba: LOAD R4 = [FP + -0x8]
ffa04dbc: CC = R1 == 0x0
ffa04dbe: STORE [P0 + 0x5cf8] = R4
ffa04dc2: STORE W [P2] = R0.L
ffa04dc4: IF CC JUMP 0xffa04e04
ffa04dc6: LOAD P0 = [FP + 0xc]
ffa04dc8: LOAD R0 = 0x578
ffa04dcc: LOAD R6 = 0x0
ffa04dce: LOAD R1 = [FP + -0x40]
ffa04dd0: MOVE I0 = P0
ffa04dd2: ADD R5 = R1 + R0
ffa04dd4: ADD I0 += M0
ffa04dd6: LSETUP (0xffa04dda,0xffa04e02) LC1 = P1
ffa04dda: MNOP||
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
ffa04e3e: BITCLR (R2,0x1f)
ffa04e40: CC = R5 < R1
ffa04e42: LOAD R4 = [FP + 0x8]
ffa04e44: OR R5 = R1 | R2
ffa04e46: MOVE R1 = CC
ffa04e48: CC = R4 < R2
ffa04e4a: LOAD R6 = 0x1
ffa04e4c: IF !CC R6 = R1
ffa04e4e: CC = R3 < R0
ffa04e50: MOVE R4 = CC
ffa04e52: ROT|| R1 = rot R3 by 0
ffa04e56: _LOAD R2 = [FP + -0x58]
ffa04e58: _NOP
ffa04e5a: CC = R0 == R3
ffa04e5c: XOR R2 = R2 ^ R4
ffa04e5e: IF !CC R4 = R2
ffa04e60: CC = R5 == 0x0
ffa04e62: IF CC R4 = R5
ffa04e64: CC = BITTST (R6,0x0)
ffa04e66: IF CC R4 = R7
ffa04e68: CC = BITTST (R4,0x0)
ffa04e6a: IF CC R1 = R0
ffa04e6c: LOAD R0 = W [P5] (X)
ffa04e6e: LOAD R2 = 0x5cfc
ffa04e72: MULT|| R0 = R0.L * R2.L (is)
ffa04e76: STORE [FP + -0x4] = R1
ffa04e78: NOP
ffa04e7a: MOVE P1 = R0
ffa04e7c: LOAD P4 = [FP + -0x5c]
ffa04e7e: LOAD P5 = [FP + 0xc]
ffa04e80: LOAD R1 = [FP + -0x4]
ffa04e82: BITCLR (R1,0x1f)
ffa04e84: ADD P4 += -0x6
ffa04e86: ADD P1 = P5 + P1
ffa04e88: LOAD R2.H = 0x147
ffa04e8c: LOAD R5 = [FP + -0x4]
ffa04e8e: CC = R1 == 0x0
ffa04e90: STORE [P1 + 0x5cf4] = R5
ffa04e94: STORE W [P4] = R2.H
ffa04e96: IF CC JUMP 0xffa04ed4
ffa04e98: LOAD P1 = [FP + 0xc]
ffa04e9a: LOAD R0 = 0x578
ffa04e9e: LOAD R6 = 0x5798
ffa04ea2: LOAD R1 = [FP + -0x40]
ffa04ea4: MOVE I0 = P1
ffa04ea6: ADD R4 = R1 + R0
ffa04ea8: ADD I0 += M0
ffa04eaa: LSETUP (0xffa04eae,0xffa04ed2) LC1 = P2
ffa04eae: MNOP||
ffa04eb2: _LOAD R0 = [P0++]
ffa04eb4: _LOAD R1.L = W [I0]
ffa04eb6: LOAD R2 = 0x5cfc
ffa04eba: MULT R1 = R1.L * R2.L (is)
ffa04ebe: ADD R1 = R4 + R1
ffa04ec0: ADD R1 = R1 + R6
ffa04ec2: ADD R1 = R1 + R7
ffa04ec4: MOVE P2 = R1
ffa04ec6: MOVE R1 = R5
ffa04ec8: CALL 0xffa01814
ffa04ecc: CALL 0xffa0290c
ffa04ed0: ADD R7 += 0x2
ffa04ed2: STORE W [P2] = R0.L
ffa04ed4: ADD SP += 0x20
ffa04ed6: POP (R7:4,P5:3) = [SP++]
ffa04ed8: UNLINK
ffa04edc: LOAD R0 = 0x0
ffa04ede: RTS
