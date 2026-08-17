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
ffa04ee0: LOAD P1 = [P2 + 0x4]
ffa04ee2: ADD P1 = P4 + (P1 << 2)
ffa04ee4: STORE [P1] = R6
ffa04ee6: JUMP.S 0xffa04930
ffa04ee8: LOAD P1 = [P2 + 0x4]
ffa04eea: LOAD R6 = [P2 + 0x18]
ffa04eec: MOVE R1 = R6
ffa04eee: ADD P0 = P4 + (P1 << 2)
ffa04ef0: LOAD R0 = [P0]
ffa04ef2: CALL 0xffa0165c
ffa04ef6: IF CC JUMP 0xffa04efa (bp)
ffa04ef8: JUMP.S 0xffa04930
ffa04efa: STORE [P0] = R6
ffa04efc: JUMP.S 0xffa04930
ffa04efe: LOAD R0 = [FP + 0x28]
ffa04f00: LOAD R1 = 0x7
ffa04f02: CC = R0 == R1
ffa04f04: IF CC JUMP 0xffa04f08 (bp)
ffa04f06: JUMP.S 0xffa04930
ffa04f08: LOAD P1 = [FP + -0x5c]
ffa04f0a: LOAD P3 = [FP + -0x5c]
ffa04f0c: LOAD R2 = 0xff
ffa04f10: LSH R6 = R2 << 0x17
ffa04f14: LOAD P1 = [P1 + 0x4]
ffa04f16: LOAD R1 = [P3 + 0xc]
ffa04f18: LOAD R0 = [P3 + 0x14]
ffa04f1a: STORE [FP + 0x20] = P1
ffa04f1c: CALL 0xffa018f0
ffa04f20: ROT|| R1 = rot R0 by 0
ffa04f24: _LOAD P1 = [FP + 0x20]
ffa04f26: _NOP
ffa04f28: LOAD P0 = [FP + -0x48]
ffa04f2a: BITCLR (R0,0x1f)
ffa04f2c: CC = R6 < R0
ffa04f2e: LOAD R5 = 0x1
ffa04f30: ADD P1 = P0 + (P1 << 2)
ffa04f32: LOAD R3 = [P1]
ffa04f34: AND R4 = R1 & R3
ffa04f36: LSHIFT R4 >>= 0x1f
ffa04f38: ROT|| R2 = rot R3 by 0
ffa04f3c: _STORE [FP + 0x20] = R4
ffa04f3e: _NOP
ffa04f40: BITCLR (R2,0x1f)
ffa04f42: MOVE R4 = CC
ffa04f44: CC = R6 < R2
ffa04f46: IF !CC R5 = R4
ffa04f48: CC = R3 < R1
ffa04f4a: OR R0 = R0 | R2
ffa04f4c: MOVE R6 = CC
ffa04f4e: SUB|| R4 = R4 - R4 (ns)
ffa04f52: _LOAD R2 = [FP + 0x20]
ffa04f54: _NOP
ffa04f56: CC = R1 == R3
ffa04f58: XOR R2 = R2 ^ R6
ffa04f5a: IF !CC R6 = R2
ffa04f5c: CC = R0 == 0x0
ffa04f5e: IF CC R6 = R0
ffa04f60: CC = BITTST (R5,0x0)
ffa04f62: IF CC R6 = R4
ffa04f64: CC = BITTST (R6,0x0)
ffa04f66: IF CC JUMP 0xffa04f6a (bp)
ffa04f68: JUMP.S 0xffa04930
ffa04f6a: STORE [P1] = R1
ffa04f6c: JUMP.S 0xffa04930
ffa04f6e: LOAD P1 = [FP + -0x5c]
ffa04f70: LOAD R2 = [FP + -0x24]
ffa04f72: LOAD R1 = [P1--]
ffa04f74: ASH R6 = R1 >>> 0xf
ffa04f78: ROT|| R1 = rot R6 by 0
ffa04f7c: _STORE [P1++] = R6
ffa04f7e: _NOP
ffa04f80: LOAD R7 = W [P1 + -0x6] (X)
ffa04f84: CC = R2 == R7
ffa04f86: STORE [FP + -0x1c] = P1
ffa04f88: IF !CC JUMP 0xffa04fe0
ffa04f8a: LOAD R2 = W [P5] (X)
ffa04f8c: MOVE P1 = R2
ffa04f8e: LOAD P0.L = 0x4888
ffa04f92: LOAD P0.H = 0xff80
ffa04f96: ADD R1 += 0x2
ffa04f98: ADD P0 = P0 + (P1 << 2)
ffa04f9a: LOAD R2 = [P0]
ffa04f9c: CC = R1 < R2
ffa04f9e: IF CC JUMP 0xffa04fa8
ffa04fa0: MOVE R1 = R6
ffa04fa2: ADD R1 += -0x2
ffa04fa4: CC = R2 < R1
ffa04fa6: IF !CC JUMP 0xffa04fe0
ffa04fa8: LOAD P0.L = 0x48f4
ffa04fac: LOAD P0.H = 0xff80
ffa04fb0: LOAD P2.L = 0x48ac
ffa04fb4: LOAD P2.H = 0xff80
ffa04fb8: ADD P0 = P0 + (P1 << 2)
ffa04fba: ADD P2 = P2 + (P1 << 2)
ffa04fbc: LOAD P3.L = 0x48d0
ffa04fc0: LOAD P3.H = 0xff80
ffa04fc4: STORE [P0] = R0
ffa04fc6: LOAD P0.L = 0x4918
ffa04fca: LOAD P0.H = 0xff80
ffa04fce: STORE [FP + -0x58] = P2
ffa04fd0: ADD P2 = P3 + (P1 << 2)
ffa04fd2: ADD P3 = P0 + (P1 << 2)
ffa04fd4: LOAD P1 = [FP + -0x1c]
ffa04fd6: LOAD P0 = [FP + -0x58]
ffa04fd8: LOAD R1 = [P1 + 0xc]
ffa04fda: STORE [P2] = R1
ffa04fdc: STORE [P3] = R1
ffa04fde: STORE [P0] = R6
ffa04fe0: LOAD R1 = 0x147a
ffa04fe4: CC = R6 < R1
ffa04fe6: IF CC JUMP 0xffa04fea (bp)
ffa04fe8: JUMP.S 0xffa0489c
ffa04fea: LOAD R1 = W [P5] (X)
ffa04fec: MOVE P2 = R1
ffa04fee: LOAD P1.L = 0x48ac
ffa04ff2: LOAD P1.H = 0xff80
ffa04ff6: ADD P1 = P1 + (P2 << 2)
ffa04ff8: LOAD R1 = [P1]
ffa04ffa: CC = R1 < R6
ffa04ffc: IF !CC JUMP 0xffa052ec
ffa04ffe: NOP
ffa05000: LOAD P1.L = 0x4888
ffa05004: LOAD P1.H = 0xff80
ffa05008: ADD P1 = P1 + (P2 << 2)
ffa0500a: LOAD R3 = [P1]
ffa0500c: CC = R3 < R6
ffa0500e: IF CC JUMP 0xffa05018
ffa05010: MOVE R2 = R6
ffa05012: ADD R2 += 0xa
ffa05014: CC = R2 < R3
ffa05016: IF !CC JUMP 0xffa052ec
ffa05018: LOAD R0 = 0x5
ffa0501a: LOAD R2 = [FP + 0x28]
ffa0501c: CC = R2 == R0
ffa0501e: IF CC JUMP 0xffa05026
ffa05020: LOAD R0 = 0x4
ffa05022: CC = R2 == R0
ffa05024: IF !CC JUMP 0xffa051d4
ffa05026: ASHIFT R1 >>>= 0x3
ffa05028: MOVE P1 = R1
ffa0502a: LOAD P0.L = 0x48d0
ffa0502e: LOAD P0.H = 0xff80
ffa05032: LOAD P3 = [FP + -0x4c]
ffa05034: ADD P0 = P0 + (P2 << 2)
ffa05036: LOAD R4 = [P0]
ffa05038: ADD P1 = P3 + (P1 << 2)
ffa0503a: LOAD R5 = [P1]
ffa0503c: LOAD R7 = [P1 + 0xa3c]
ffa05040: MOVE R1 = R7
ffa05042: MOVE R0 = R5
ffa05044: CALL 0xffa0165c
ffa05048: IF CC R7 = R5
ffa0504a: MOVE R1 = R7
ffa0504c: MOVE R0 = R4
ffa0504e: CALL 0xffa0165c
ffa05052: LOAD P1 = [FP + -0x1c]
ffa05054: IF CC R7 = R4
ffa05056: STORE [P1 + 0x18] = R7
ffa05058: LOAD R0 = W [P5] (X)
ffa0505a: MOVE P1 = R0
ffa0505c: LOAD P0.L = 0x48ac
ffa05060: LOAD P0.H = 0xff80
ffa05064: ASHIFT R6 >>>= 0x3
ffa05066: ADD P0 = P0 + (P1 << 2)
ffa05068: LOAD R2 = [P0]
ffa0506a: ASHIFT R2 >>>= 0x3
ffa0506c: CC = R2 == R6
ffa0506e: IF !CC JUMP 0xffa050e0
ffa05070: LOAD P2.L = 0x4918
ffa05074: LOAD P2.H = 0xff80
ffa05078: LOAD P0.L = 0x48d0
ffa0507c: LOAD P0.H = 0xff80
ffa05080: ADD P2 = P2 + (P1 << 2)
ffa05082: ADD P0 = P0 + (P1 << 2)
ffa05084: LOAD R7 = [P2]
ffa05086: ROT|| R1 = rot R7 by 0
ffa0508a: _LOAD R6 = [P0]
ffa0508c: _NOP
ffa0508e: MOVE R0 = R6
ffa05090: CALL 0xffa0165c
ffa05094: IF CC R6 = R7
ffa05096: STORE [P2] = R6
ffa05098: LOAD R0 = W [P5] (X)
ffa0509a: LOAD P3 = [FP + -0x5c]
ffa0509c: MOVE P1 = R0
ffa0509e: LOAD P2 = [FP + -0x1c]
ffa050a0: LOAD R7 = W [P3 + -0x6] (X)
ffa050a4: LOAD P3.L = 0x48d0
ffa050a8: LOAD P3.H = 0xff80
ffa050ac: ADD P0 = P3 + (P1 << 2)
ffa050ae: LOAD R1 = [P2 + 0xc]
ffa050b0: STORE [P0] = R1
ffa050b2: LOAD P0.L = 0x48ac
ffa050b6: LOAD P0.H = 0xff80
ffa050ba: LOAD R2 = [P2 + 0x14]
ffa050bc: LOAD R3 = [P2 + -0x4]
ffa050c0: ADD P0 = P0 + (P1 << 2)
ffa050c2: LOAD P3.L = 0x4888
ffa050c6: LOAD P3.H = 0xff80
ffa050ca: LOAD P2.L = 0x48f4
ffa050ce: LOAD P2.H = 0xff80
ffa050d2: ADD P3 = P3 + (P1 << 2)
ffa050d4: ADD P2 = P2 + (P1 << 2)
ffa050d6: LOAD R0 = [P0]
ffa050d8: STORE [P2] = R2
ffa050da: STORE [P0] = R3
ffa050dc: STORE [P3] = R0
ffa050de: JUMP.S 0xffa0489c
ffa050e0: LOAD P2 = [FP + -0x1c]
ffa050e2: LOAD R7 = 0x0
ffa050e4: STORE [FP + 0x20] = R2
ffa050e6: LOAD R7.H = 0x4100
ffa050ea: LOAD R1 = [P2 + 0x1c]
ffa050ec: MOVE R0 = R7
ffa050ee: CALL 0xffa018f0
ffa050f2: LOAD P1 = [FP + 0x20]
ffa050f4: LOAD P3 = [FP + -0x50]
ffa050f6: ADD P1 = P3 + (P1 << 2)
ffa050f8: STORE [FP + 0x20] = P1
ffa050fa: LOAD P3 = [FP + 0x20]
ffa050fc: LOAD R1 = [P1]
ffa050fe: CALL 0xffa018f0
ffa05102: LOAD P2.L = 0x4918
ffa05106: LOAD P2.H = 0xff80
ffa0510a: STORE [P3] = R0
ffa0510c: LOAD R0 = W [P5] (X)
ffa0510e: MOVE P1 = R0
ffa05110: LOAD P3 = [FP + -0x50]
ffa05112: ADD P1 = P2 + (P1 << 2)
ffa05114: LOAD R0 = [P1]
ffa05116: BITCLR (R0,0x1f)
ffa05118: CALL 0xffa0248c
ffa0511c: LOAD R1 = W [P5] (X)
ffa0511e: MOVE P1 = R1
ffa05120: LOAD P0.L = 0x48ac
ffa05124: LOAD P0.H = 0xff80
ffa05128: ADD P1 = P0 + (P1 << 2)
ffa0512a: LOAD R2 = [P1]
ffa0512c: ASHIFT R2 >>>= 0x3
ffa0512e: MOVE P1 = R2
ffa05130: ADD P1 = P3 + (P1 << 2)
ffa05132: LOAD R1 = [P1]
ffa05134: STORE [FP + 0x20] = P1
ffa05136: CALL 0xffa01716
ffa0513a: LOAD P0 = [FP + 0x20]
ffa0513c: MOVE R1 = R7
ffa0513e: LOAD P2 = [FP + -0x1c]
ffa05140: STORE [P0] = R0
ffa05142: LOAD R3 = W [P5] (X)
ffa05144: LOAD R0 = [P2 + 0x1c]
ffa05146: STORE [FP + 0x20] = R3
ffa05148: CALL 0xffa018f0
ffa0514c: LOAD R1 = 0x0
ffa0514e: LOAD R1.H = 0x3f80
ffa05152: CALL 0xffa01716
ffa05156: LOAD P0 = [FP + 0x20]
ffa05158: MOVE R1 = R0
ffa0515a: LOAD P1.L = 0x48ac
ffa0515e: LOAD P1.H = 0xff80
ffa05162: LOAD P2.L = 0x48ac
ffa05166: LOAD P2.H = 0xff80
ffa0516a: ADD P1 = P1 + (P0 << 2)
ffa0516c: LOAD R2 = [P1]
ffa0516e: ASHIFT R2 >>>= 0x3
ffa05170: MOVE P1 = R2
ffa05172: ADD P0 = P3 + (P1 << 2)
ffa05174: LOAD R0 = [P0]
ffa05176: CALL 0xffa01814
ffa0517a: STORE [P0] = R0
ffa0517c: LOAD R0 = W [P5] (X)
ffa0517e: MOVE P1 = R0
ffa05180: LOAD P3 = [FP + -0x4c]
ffa05182: LOAD P0.L = 0x48ac
ffa05186: LOAD P0.H = 0xff80
ffa0518a: ADD P1 = P2 + (P1 << 2)
ffa0518c: LOAD R0 = [P1]
ffa0518e: ASHIFT R0 >>>= 0x3
ffa05190: MOVE P1 = R0
ffa05192: LOAD P2.L = 0x4918
ffa05196: LOAD P2.H = 0xff80
ffa0519a: ADD P1 = P3 + (P1 << 2)
ffa0519c: LOAD R0 = [P1]
ffa0519e: STORE [P1 + 0xa3c] = R0
ffa051a2: LOAD R0 = W [P5] (X)
ffa051a4: MOVE P1 = R0
ffa051a6: ADD P0 = P0 + (P1 << 2)
ffa051a8: LOAD R0 = [P0]
ffa051aa: ASHIFT R0 >>>= 0x3
ffa051ac: MOVE P0 = R0
ffa051ae: ADD P2 = P2 + (P1 << 2)
ffa051b0: LOAD R1 = [P2]
ffa051b2: LOAD P2.L = 0x4918
ffa051b6: LOAD P2.H = 0xff80
ffa051ba: ADD P0 = P3 + (P0 << 2)
ffa051bc: STORE [P0] = R1
ffa051be: LOAD R0 = W [P5] (X)
ffa051c0: MOVE P1 = R0
ffa051c2: LOAD P3.L = 0x48d0
ffa051c6: LOAD P3.H = 0xff80
ffa051ca: ADD P0 = P3 + (P1 << 2)
ffa051cc: ADD P2 = P2 + (P1 << 2)
ffa051ce: LOAD R0 = [P0]
ffa051d0: STORE [P2] = R0
ffa051d2: JUMP.S 0xffa05098
ffa051d4: ASHIFT R1 >>>= 0x3
ffa051d6: LOAD P3.L = 0x48d0
ffa051da: LOAD P3.H = 0xff80
ffa051de: MOVE P1 = R1
ffa051e0: ADD P2 = P3 + (P2 << 2)
ffa051e2: LOAD P3 = [FP + -0x4c]
ffa051e4: LOAD R0 = W [P5] (X)
ffa051e6: LOAD R1 = 0x5cfc
ffa051ea: MULT R0 = R0.L * R1.L (is)
ffa051ee: LOAD R5 = [P2]
ffa051f0: MOVE P0 = R0
ffa051f2: ADD P3 = P3 + (P1 << 2)
ffa051f4: LOAD P2 = [FP + 0xc]
ffa051f6: MOVE R7 = R5
ffa051f8: LOAD R2 = [P3]
ffa051fa: LOAD R3 = [P3 + 0xa3c]
ffa051fe: STORE [FP + -0x34] = R3
ffa05200: STORE [FP + 0x20] = R2
ffa05202: ADD P0 = P2 + P0
ffa05204: LOAD P2 = 0x42ce
ffa05208: ADD P0 = P0 + P2
ffa0520a: LOAD R0 = [FP + 0x20]
ffa0520c: LOAD R1 = [FP + -0x34]
ffa0520e: ADD P0 = P0 + P1
ffa05210: CALL 0xffa0165c
ffa05214: LOAD R4 = -0x3333
ffa05218: LOAD R2 = [FP + 0x20]
ffa0521a: LOAD R4.H = 0x3fb4
ffa0521e: LOAD R0 = [FP + -0x34]
ffa05220: MOVE R1 = R4
ffa05222: IF CC R0 = R2
ffa05224: STORE [FP + -0x38] = P0
ffa05226: CALL 0xffa018f0
ffa0522a: STORE [FP + 0x20] = R0
ffa0522c: MOVE R1 = R5
ffa0522e: CALL 0xffa0165c
ffa05232: LOAD P1 = [FP + -0x1c]
ffa05234: MOVE R1 = R4
ffa05236: LOAD R2 = [FP + 0x20]
ffa05238: IF CC R7 = R2
ffa0523a: MOVE R0 = R7
ffa0523c: STORE [P1 + 0x18] = R7
ffa0523e: CALL 0xffa018f0
ffa05242: MOVE R1 = R5
ffa05244: CALL 0xffa01630
ffa05248: IF !CC JUMP 0xffa052d8
ffa0524a: LOAD P1 = [FP + -0x38]
ffa0524c: LOAD R0 = 0x0
ffa0524e: STORE B [P1] = R0
ffa05250: LOAD R1 = W [P5] (X)
ffa05252: MOVE P1 = R1
ffa05254: LOAD P3 = [FP + -0x1c]
ffa05256: LOAD P0.L = 0x48ac
ffa0525a: LOAD P0.H = 0xff80
ffa0525e: ADD P1 = P0 + (P1 << 2)
ffa05260: LOAD R5 = [P3 + 0x1c]
ffa05262: LOAD P1 = [P1]
ffa05264: MOVE R0 = R5
ffa05266: LOAD P3 = [FP + -0x44]
ffa05268: ADD P1 = P3 + (P1 << 2)
ffa0526a: STORE [FP + 0x20] = P1
ffa0526c: LOAD P3 = [FP + 0x20]
ffa0526e: LOAD R1 = [P1]
ffa05270: CALL 0xffa018f0
ffa05274: LOAD P0.L = 0x48ac
ffa05278: LOAD P0.H = 0xff80
ffa0527c: STORE [P3] = R0
ffa0527e: MOVE R1 = R7
ffa05280: LOAD R0 = W [P5] (X)
ffa05282: MOVE P1 = R0
ffa05284: LOAD P2.L = 0x48f4
ffa05288: LOAD P2.H = 0xff80
ffa0528c: ADD P0 = P0 + (P1 << 2)
ffa0528e: ADD P2 = P2 + (P1 << 2)
ffa05290: LOAD P0 = [P0]
ffa05292: LOAD R0 = [P2]
ffa05294: STORE [FP + 0x20] = P0
ffa05296: CALL 0xffa018f0
ffa0529a: LOAD P3 = [FP + 0x20]
ffa0529c: LOAD P1 = [FP + -0x44]
ffa0529e: ADD P3 = P1 + (P3 << 2)
ffa052a0: LOAD R1 = [P3]
ffa052a2: CALL 0xffa01716
ffa052a6: STORE [P3] = R0
ffa052a8: MOVE R1 = R5
ffa052aa: STORE [FP + 0x20] = P3
ffa052ac: LOAD R2 = W [P5] (X)
ffa052ae: LOAD R0 = 0x0
ffa052b0: LOAD R0.H = 0x3f80
ffa052b4: STORE [FP + 0x20] = R2
ffa052b6: CALL 0xffa01716
ffa052ba: LOAD P0 = [FP + 0x20]
ffa052bc: MOVE R1 = R0
ffa052be: LOAD P1.L = 0x48ac
ffa052c2: LOAD P1.H = 0xff80
ffa052c6: LOAD P2 = [FP + -0x44]
ffa052c8: ADD P1 = P1 + (P0 << 2)
ffa052ca: LOAD P1 = [P1]
ffa052cc: ADD P0 = P2 + (P1 << 2)
ffa052ce: LOAD R0 = [P0]
ffa052d0: CALL 0xffa01814
ffa052d4: STORE [P0] = R0
ffa052d6: JUMP.S 0xffa05058
ffa052d8: LOAD P1 = [FP + -0x38]
ffa052da: LOAD R1 = 0xff
ffa052de: LOAD R0 = B [P1] (Z)
ffa052e0: CC = R0 < R1
ffa052e2: IF !CC JUMP 0xffa05250
ffa052e4: ADD R0 += 0x1
ffa052e6: STORE B [P1] = R0
ffa052e8: JUMP.S 0xffa05250
ffa052ec: LOAD P1.L = 0x48f4
ffa052f0: LOAD P1.H = 0xff80
ffa052f4: LOAD R6 = 0xff
ffa052f8: LSHIFT R6 <<= 0x17
ffa052fa: ADD P1 = P1 + (P2 << 2)
ffa052fc: LOAD P0.L = 0x48d0
ffa05300: LOAD P0.H = 0xff80
ffa05304: ROT|| R1 = rot R0 by 0
ffa05308: _STORE [FP + 0x20] = R6
ffa0530a: _NOP
ffa0530c: ADD P0 = P0 + (P2 << 2)
ffa0530e: LOAD R3 = [P1]
ffa05310: ROT|| R2 = rot R3 by 0
ffa05314: _LOAD P2 = [FP + -0x1c]
ffa05316: _NOP
ffa05318: AND R5 = R3 & R0
ffa0531a: BITCLR (R1,0x1f)
ffa0531c: BITCLR (R2,0x1f)
ffa0531e: LSH|| R5 = R5 >> 0x1f
ffa05322: _LOAD R6 = [P0]
ffa05324: _NOP
ffa05326: OR R4 = R2 | R1
ffa05328: ROT|| R1 = rot R6 by 0
ffa0532c: _STORE [FP + -0x38] = R1
ffa0532e: _NOP
ffa05330: STORE [FP + -0x3c] = R5
ffa05332: STORE [FP + -0x20] = R4
ffa05334: BITCLR (R6,0x1f)
ffa05336: LOAD R5 = [FP + 0x20]
ffa05338: LOAD R4 = [P2 + 0xc]
ffa0533a: CC = R5 < R6
ffa0533c: MOVE R5 = R4
ffa0533e: BITCLR (R5,0x1f)
ffa05340: OR R6 = R6 | R5
ffa05342: STORE [FP + -0x30] = R6
ffa05344: AND R6 = R1 & R4
ffa05346: LSHIFT R6 >>= 0x1f
ffa05348: STORE [FP + -0x34] = R6
ffa0534a: MOVE R6 = CC
ffa0534c: STORE [FP + -0x1c] = R6
ffa0534e: LOAD R6 = [FP + 0x20]
ffa05350: CC = R6 < R5
ffa05352: LOAD R5 = 0x1
ffa05354: LOAD R6 = [FP + -0x1c]
ffa05356: STORE [FP + -0x58] = R5
ffa05358: IF !CC R5 = R6
ffa0535a: CC = R4 < R1
ffa0535c: STORE [FP + -0x58] = R5
ffa0535e: MOVE R6 = CC
ffa05360: LOAD R5 = [FP + -0x34]
ffa05362: CC = R1 == R4
ffa05364: XOR R5 = R5 ^ R6
ffa05366: IF !CC R6 = R5
ffa05368: STORE [FP + -0x1c] = R5
ffa0536a: LOAD R5 = [FP + -0x30]
ffa0536c: CC = R5 == 0x0
ffa0536e: IF CC R6 = R5
ffa05370: LOAD R5 = [FP + -0x58]
ffa05372: CC = BITTST (R5,0x0)
ffa05374: LOAD R5 = 0x0
ffa05376: IF CC R6 = R5
ffa05378: CC = BITTST (R6,0x0)
ffa0537a: IF CC R4 = R1
ffa0537c: LOAD R1 = [FP + 0x20]
ffa0537e: CC = R1 < R2
ffa05380: STORE [P0] = R4
ffa05382: LOAD R4 = [FP + -0x38]
ffa05384: MOVE R2 = CC
ffa05386: CC = R1 < R4
ffa05388: LOAD R5 = 0x1
ffa0538a: IF !CC R5 = R2
ffa0538c: CC = R0 < R3
ffa0538e: MOVE R1 = CC
ffa05390: LOAD R2 = [FP + -0x3c]
ffa05392: CC = R3 == R0
ffa05394: XOR R6 = R2 ^ R1
ffa05396: SUB|| R2 = R2 - R2 (ns)
ffa0539a: _LOAD R4 = [FP + -0x20]
ffa0539c: _NOP
ffa0539e: IF !CC R1 = R6
ffa053a0: CC = R4 == 0x0
ffa053a2: IF CC R1 = R4
ffa053a4: CC = BITTST (R5,0x0)
ffa053a6: IF CC R1 = R2
ffa053a8: CC = BITTST (R1,0x0)
ffa053aa: IF CC R0 = R3
ffa053ac: STORE [P1] = R0
ffa053ae: JUMP.S 0xffa0489c
ffa053b0: LOAD R3 = W [P5] (X)
ffa053b2: LOAD R0 = 0x5cfc
ffa053b6: MULT|| R0 = R3.L * R0.L (is)
ffa053ba: STORE [SP + 0x10] = R3
ffa053bc: NOP
ffa053be: LOAD R2 = W [P1 + -0x6] (X)
ffa053c2: LOAD P0 = [FP + 0x1c]
ffa053c4: MOVE P1 = R0
ffa053c6: STORE [SP + 0x18] = P0
ffa053c8: LOAD P0 = [FP + 0xc]
ffa053ca: LOAD R1 = 0xc5e8
ffa053ce: LOAD R4 = [FP + 0x14]
ffa053d0: BITSET (R1,0x11)
ffa053d2: ADD P1 = P0 + P1
ffa053d4: LOAD R5 = B [P1 + 0x2] (Z)
ffa053d8: LOAD R6 = [FP + 0x24]
ffa053da: CC = R5 <= R4
ffa053dc: LOAD R7 = 0x85e8
ffa053e0: ADD|| R6 = R6 + R1 (ns)
ffa053e4: _LOAD R0 = [FP + 0x24]
ffa053e6: _NOP
ffa053e8: MOVE R1 = CC
ffa053ea: ADD|| R7 = R0 + R7 (ns)
ffa053ee: _LOAD P2 = [FP + 0x18]
ffa053f0: _NOP
ffa053f2: ROT|| R0 = rot R6 by 0
ffa053f6: _STORE [SP + 0x1c] = R1
ffa053f8: _NOP
ffa053fa: ROT|| R1 = rot R7 by 0
ffa053fe: _STORE [SP + 0xc] = R4
ffa05400: _NOP
ffa05402: STORE [SP + 0x14] = P2
ffa05404: CALL 0xffa043c4
ffa05408: LOAD P1 = [FP + -0x5c]
ffa0540a: LOAD R1 = W [P1 + 0x8] (X)
ffa0540c: LOAD R2 = W [P1 + -0x6] (X)
ffa05410: CC = R1 < R2
ffa05412: STORE [P1 + 0xc] = R0
ffa05414: IF CC JUMP 0xffa05418 (bp)
ffa05416: JUMP.S 0xffa0486a
ffa05418: LOAD R0 = W [P5] (X)
ffa0541a: LOAD R1 = 0x5cfc
ffa0541e: MULT R0 = R0.L * R1.L (is)
ffa05422: MOVE P1 = R0
ffa05424: LOAD P0 = [FP + 0xc]
ffa05426: ADD P1 = P0 + P1
ffa05428: LOAD R0 = B [P1 + 0x1] (Z)
ffa0542c: CC = R0 == 0x1
ffa0542e: IF CC JUMP 0xffa05432
ffa05430: JUMP.S 0xffa0486a
ffa05432: LOAD R3 = W [P5] (X)
ffa05434: MOVE R1 = R7
ffa05436: LOAD P0 = [FP + 0x1c]
ffa05438: MOVE R0 = R6
ffa0543a: LOAD P1 = 0x1
ffa0543c: LOAD P2 = [FP + 0x18]
ffa0543e: STORE [SP + 0x10] = R3
ffa05440: STORE [SP + 0x1c] = P1
ffa05442: STORE [SP + 0x14] = P2
ffa05444: STORE [SP + 0xc] = R4
ffa05446: STORE [SP + 0x18] = P0
ffa05448: CALL 0xffa043c4
ffa0544c: LOAD P0 = [FP + -0x5c]
ffa0544e: MOVE R6 = R0
ffa05450: LOAD R5 = W [P0 + 0x8] (X)
ffa05452: LOAD R1 = W [P0 + -0x6] (X)
ffa05456: STORE [P0 + 0x10] = R0
ffa05458: SUB R0 = R1 - R5
ffa0545a: CALL 0xffa01688
ffa0545e: LOAD R2 = [FP + 0x8]
ffa05460: MOVE R7 = R0
ffa05462: SUB R0 = R2 - R5
ffa05464: CALL 0xffa01688
ffa05468: MOVE R1 = R0
ffa0546a: MOVE R0 = R7
ffa0546c: CALL 0xffa01814
ffa05470: MOVE R7 = R0
ffa05472: MOVE R0 = R6
ffa05474: MOVE R1 = R7
ffa05476: STORE [P0 + 0x20] = R7
ffa05478: CALL 0xffa018f0
ffa0547c: MOVE R6 = R0
ffa0547e: MOVE R1 = R7
ffa05480: LOAD R0 = 0x0
ffa05482: LOAD R0.H = 0x3f80
ffa05486: CALL 0xffa01714
ffa0548a: LOAD P1 = [FP + -0x5c]
ffa0548c: LOAD R1 = [P1 + 0xc]
ffa0548e: CALL 0xffa018f0
ffa05492: MOVE R1 = R6
ffa05494: CALL 0xffa01716
ffa05498: LOAD P0 = [FP + -0x5c]
ffa0549a: STORE [P0 + 0xc] = R0
ffa0549c: JUMP.S 0xffa0486a
ffa0549e: LOAD R0 = 0x624e
ffa054a2: BITSET (R0,0x14)
ffa054a4: LOAD R1 = [FP + -0x40]
ffa054a6: CALL 0xffa05896
ffa054aa: LOAD R2 = 0xa028
ffa054ae: MAC A1 = R2.L * R0.L (fu)
ffa054b2: LOAD R1 = [FP + 0x8]
ffa054b4: LSH A1 = A1 >> 0x10
ffa054b8: MAC A1 += R0.H * R2.L (m)
ffa054bc: ASH A1 = A1 >>> 0xf
ffa054c0: MOVE R0 = A1.W
