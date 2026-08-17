ffa02c00: ADD SP += -0xc
ffa02c02: STORE [FP + 0x10] = R2
ffa02c04: STORE [FP + 0xc] = R1
ffa02c06: STORE [FP + 0x8] = R0
ffa02c08: LOAD P5.L = 0x47
ffa02c0c: LOAD P5.H = 0xff80
ffa02c10: LOAD R3 = B [P5] (Z)
ffa02c12: CC = R3 == 0x0
ffa02c14: IF CC JUMP 0xffa02c1c (bp)
ffa02c16: LOAD R0 = 0x0
ffa02c18: STORE B [P5] = R0
ffa02c1a: JUMP.S 0xffa02eca
ffa02c1c: LOAD P2.L = 0x48
ffa02c20: LOAD P2.H = 0xff80
ffa02c24: LOAD P1 = [P2]
ffa02c26: LOAD R0 = [P1 + 0x8]
ffa02c28: CC = R0 == 0x1
ffa02c2a: IF !CC JUMP 0xffa02c4c (bp)
ffa02c2c: LOAD R2 = 0x1
ffa02c2e: STORE B [P5] = R2
ffa02c30: LOAD R1 = 0x0
ffa02c32: LOAD R0 = 0x5
ffa02c34: LOAD R0.H = 0x7
ffa02c38: CALL 0xffa0add0
ffa02c3c: LOAD P1.L = 0x6ee0
ffa02c40: LOAD P1.H = 0xff80
ffa02c44: LOAD R0 = [P1]
ffa02c46: BITSET (R0,0x1)
ffa02c48: STORE [P1] = R0
ffa02c4a: JUMP.S 0xffa02eca
ffa02c4c: LOAD P0 = [P1 + 0x4]
ffa02c4e: LOAD R0 = B [P0] (Z)
ffa02c50: STORE W [FP + -0x4] = R0
ffa02c54: LOAD R0 = [P1 + 0x4]
ffa02c56: ADD R0 += 0x1
ffa02c58: STORE [P1 + 0x4] = R0
ffa02c5a: LOAD P1 = [P2]
ffa02c5c: LOAD R0 = [P1 + 0x8]
ffa02c5e: ADD R0 += -0x1
ffa02c60: STORE [P1 + 0x8] = R0
ffa02c62: LOAD R0 = W [FP + -0x4] (Z)
ffa02c66: LSH R0 = R0 << 0x6
ffa02c6a: MOVE R0 = R0.L (Z)
ffa02c6c: STORE W [FP + -0x4] = R0
ffa02c70: LOAD P4.L = 0x44
ffa02c74: LOAD P4.H = 0xff80
ffa02c78: LOAD R1 = W [P4] (Z)
ffa02c7a: LSH R1 = R1 << 0xe
ffa02c7e: OR R1 = R0 | R1
ffa02c80: STORE W [FP + -0x4] = R1
ffa02c84: LOAD P1.L = 0x4c
ffa02c88: LOAD P1.H = 0xff80
ffa02c8c: LOAD R2 = B [P1] (Z)
ffa02c8e: CC = R2 == 0x0
ffa02c90: IF CC JUMP 0xffa02cf4
ffa02c92: NOP
ffa02c94: NOP
ffa02c96: LOAD P1 = 0x500
ffa02c9a: LOAD P1.H = 0xffc0
ffa02c9e: LOAD R0 = W [P1] (Z)
ffa02ca0: BITSET (R0,0xe)
ffa02ca2: STORE W [P1] = R0.L
ffa02ca4: LOAD R0 = W [FP + -0x4] (X)
ffa02ca8: LOAD P0 = 0x50c
ffa02cac: LOAD P0.H = 0xffc0
ffa02cb0: STORE W [P0] = R0.L
ffa02cb2: LOAD R1 = 0x0
ffa02cb4: STORE [FP + -0x8] = R1
ffa02cb6: LOAD R0 = [FP + -0x8]
ffa02cb8: LOAD R1 = 0x3c
ffa02cba: CC = R1 <= R0
ffa02cbc: IF CC JUMP 0xffa02cda
ffa02cbe: NOP
ffa02cc0: NOP
ffa02cc2: LOAD P0 = 0x508
ffa02cc6: LOAD P0.H = 0xffc0
ffa02cca: LOAD R0 = W [P0] (Z)
ffa02ccc: CC = !BITTST (R0,0x5)
ffa02cce: IF CC JUMP 0xffa02cd2 (bp)
ffa02cd0: JUMP.S 0xffa02cda
ffa02cd2: LOAD R0 = [FP + -0x8]
ffa02cd4: ADD R0 += 0x1
ffa02cd6: STORE [FP + -0x8] = R0
ffa02cd8: JUMP.S 0xffa02cb6
ffa02cda: LOAD R0 = W [P1] (Z)
ffa02cdc: LOAD R1 = 0xbfff
ffa02ce0: AND R0 = R0 & R1
ffa02ce2: STORE W [P1] = R0.L
ffa02ce4: LOAD P0 = 0x510
ffa02ce8: LOAD P0.H = 0xffc0
ffa02cec: LOAD R0 = W [P0] (X)
ffa02cee: STORE W [FP + -0x2] = R0
ffa02cf2: JUMP.S 0xffa02eca
ffa02cf4: LOAD P1.L = 0x3c
ffa02cf8: LOAD P1.H = 0xff80
ffa02cfc: STORE [FP + -0x14] = P1
ffa02cfe: LOAD R1 = 0x0
ffa02d00: STORE B [P1] = R1
ffa02d02: LOAD P0 = 0x504
ffa02d06: LOAD P0.H = 0xffc0
ffa02d0a: STORE [FP + -0xc] = P0
ffa02d0c: LOAD R2 = 0x2
ffa02d0e: STORE W [P0] = R2.L
ffa02d10: LOAD P0 = 0x500
ffa02d14: LOAD P0.H = 0xffc0
ffa02d18: LOAD R0 = W [P0] (Z)
ffa02d1a: BITSET (R0,0xe)
ffa02d1c: STORE W [P0] = R0.L
ffa02d1e: LOAD R0 = W [FP + -0x4] (X)
ffa02d22: LOAD P1 = 0x50c
ffa02d26: LOAD P1.H = 0xffc0
ffa02d2a: STORE [FP + -0x10] = P1
ffa02d2c: STORE W [P1] = R0.L
ffa02d2e: STORE [FP + -0x8] = R1
ffa02d30: LOAD R0 = [FP + -0x8]
ffa02d32: LOAD R7 = 0x3c
ffa02d34: CC = R7 <= R0
ffa02d36: IF CC JUMP 0xffa02d54
ffa02d38: NOP
ffa02d3a: NOP
ffa02d3c: LOAD P1 = 0x508
ffa02d40: LOAD P1.H = 0xffc0
ffa02d44: LOAD R0 = W [P1] (Z)
ffa02d46: CC = !BITTST (R0,0x5)
ffa02d48: IF CC JUMP 0xffa02d4c (bp)
ffa02d4a: JUMP.S 0xffa02d54
ffa02d4c: LOAD R0 = [FP + -0x8]
ffa02d4e: ADD R0 += 0x1
ffa02d50: STORE [FP + -0x8] = R0
ffa02d52: JUMP.S 0xffa02d30
ffa02d54: LOAD R0 = W [P0] (Z)
ffa02d56: LOAD R3 = 0xbfff
ffa02d5a: AND R0 = R0 & R3
ffa02d5c: STORE W [P0] = R0.L
ffa02d5e: LOAD P1 = 0x510
ffa02d62: LOAD P1.H = 0xffc0
ffa02d66: STORE [FP + -0x1c] = P1
ffa02d68: LOAD R0 = W [P1] (X)
ffa02d6a: STORE W [FP + -0x2] = R0
ffa02d6e: LOAD R6 = [FP + -0x8]
ffa02d70: CC = R6 == R7
ffa02d72: IF !CC JUMP 0xffa02d84 (bp)
ffa02d74: LOAD R0 = 0x5
ffa02d76: LOAD R0.H = 0x7
ffa02d7a: CALL 0xffa0add0
ffa02d7e: LOAD R2 = 0x1
ffa02d80: STORE B [P5] = R2
ffa02d82: JUMP.S 0xffa02eca
ffa02d84: LOAD P1.L = 0x46
ffa02d88: LOAD P1.H = 0xff80
ffa02d8c: STORE [FP + -0x18] = P1
ffa02d8e: LOAD R0 = B [P1] (Z)
ffa02d90: CC = R0 == 0x0
ffa02d92: IF CC JUMP 0xffa02dcc
ffa02d94: NOP
ffa02d96: NOP
ffa02d98: LOAD P1 = [P2]
ffa02d9a: LOAD P3 = [P1 + 0x4]
ffa02d9c: LOAD R0 = B [P3] (Z)
ffa02d9e: STORE W [FP + -0x4] = R0
ffa02da2: LOAD R0 = [P1 + 0x4]
ffa02da4: ADD R0 += 0x1
ffa02da6: STORE [P1 + 0x4] = R0
ffa02da8: LOAD P1 = [P2]
ffa02daa: LOAD R0 = [P1 + 0x8]
ffa02dac: ADD R0 += -0x1
ffa02dae: STORE [P1 + 0x8] = R0
ffa02db0: LOAD R0 = W [FP + -0x4] (Z)
ffa02db4: LSH R0 = R0 << 0x6
ffa02db8: MOVE R0 = R0.L (Z)
ffa02dba: STORE W [FP + -0x4] = R0
ffa02dbe: LOAD R6 = W [P4] (Z)
ffa02dc0: LSH R6 = R6 << 0xe
ffa02dc4: OR R6 = R0 | R6
ffa02dc6: STORE W [FP + -0x4] = R6
ffa02dca: JUMP.S 0xffa02dcc
ffa02dcc: LOAD R6 = 0x1
ffa02dce: LOAD P3 = [FP + -0x14]
ffa02dd0: STORE B [P3] = R6
ffa02dd2: LOAD R0 = 0x4
ffa02dd4: LOAD P1 = [FP + -0xc]
ffa02dd6: STORE W [P1] = R0.L
ffa02dd8: LOAD R0 = W [P0] (Z)
ffa02dda: BITSET (R0,0xe)
ffa02ddc: STORE W [P0] = R0.L
ffa02dde: LOAD R0 = W [FP + -0x4] (X)
ffa02de2: LOAD P3 = [FP + -0x10]
ffa02de4: STORE W [P3] = R0.L
ffa02de6: STORE [FP + -0x8] = R1
ffa02de8: LOAD R0 = [FP + -0x8]
ffa02dea: CC = R7 <= R0
ffa02dec: IF CC JUMP 0xffa02e0a
ffa02dee: NOP
ffa02df0: NOP
ffa02df2: LOAD P1 = 0x508
ffa02df6: LOAD P1.H = 0xffc0
ffa02dfa: LOAD R0 = W [P1] (Z)
ffa02dfc: CC = !BITTST (R0,0x5)
ffa02dfe: IF CC JUMP 0xffa02e02 (bp)
ffa02e00: JUMP.S 0xffa02e0a
ffa02e02: LOAD R0 = [FP + -0x8]
ffa02e04: ADD R0 += 0x1
ffa02e06: STORE [FP + -0x8] = R0
ffa02e08: JUMP.S 0xffa02de8
ffa02e0a: LOAD R0 = W [P0] (Z)
ffa02e0c: AND R0 = R0 & R3
ffa02e0e: STORE W [P0] = R0.L
ffa02e10: LOAD P1 = [FP + -0x1c]
ffa02e12: LOAD R0 = W [P1] (X)
ffa02e14: STORE W [FP + -0x2] = R0
ffa02e18: LOAD R0 = [FP + -0x8]
ffa02e1a: CC = R0 == R7
ffa02e1c: IF !CC JUMP 0xffa02e2c (bp)
ffa02e1e: LOAD R0 = 0x5
ffa02e20: LOAD R0.H = 0x7
ffa02e24: CALL 0xffa0add0
ffa02e28: STORE B [P5] = R6
ffa02e2a: JUMP.S 0xffa02eca
ffa02e2c: LOAD P1 = [FP + -0x18]
ffa02e2e: LOAD R0 = B [P1] (Z)
ffa02e30: CC = R0 == 0x0
ffa02e32: IF CC JUMP 0xffa02e6c
ffa02e34: NOP
ffa02e36: NOP
ffa02e38: LOAD P1 = [P2]
ffa02e3a: LOAD P3 = [P1 + 0x4]
ffa02e3c: LOAD R0 = B [P3] (Z)
ffa02e3e: STORE W [FP + -0x4] = R0
ffa02e42: LOAD R0 = [P1 + 0x4]
ffa02e44: ADD R0 += 0x1
ffa02e46: STORE [P1 + 0x4] = R0
ffa02e48: LOAD P1 = [P2]
ffa02e4a: LOAD R0 = [P1 + 0x8]
ffa02e4c: ADD R0 += -0x1
ffa02e4e: STORE [P1 + 0x8] = R0
ffa02e50: LOAD R0 = W [FP + -0x4] (Z)
ffa02e54: LSH R0 = R0 << 0x6
ffa02e58: MOVE R0 = R0.L (Z)
ffa02e5a: STORE W [FP + -0x4] = R0
ffa02e5e: LOAD R5 = W [P4] (Z)
ffa02e60: LSH R5 = R5 << 0xe
ffa02e64: OR R0 = R0 | R5
ffa02e66: STORE W [FP + -0x4] = R0
ffa02e6a: JUMP.S 0xffa02e6c
ffa02e6c: LOAD P2 = [FP + -0x14]
ffa02e6e: STORE B [P2] = R2
ffa02e70: LOAD R0 = 0x8
ffa02e72: LOAD P1 = [FP + -0xc]
ffa02e74: STORE W [P1] = R0.L
ffa02e76: LOAD R0 = W [P0] (Z)
ffa02e78: BITSET (R0,0xe)
ffa02e7a: STORE W [P0] = R0.L
ffa02e7c: LOAD R0 = W [FP + -0x4] (X)
ffa02e80: LOAD P2 = [FP + -0x10]
ffa02e82: STORE W [P2] = R0.L
ffa02e84: STORE [FP + -0x8] = R1
ffa02e86: LOAD R0 = [FP + -0x8]
ffa02e88: CC = R7 <= R0
ffa02e8a: IF CC JUMP 0xffa02ea8
ffa02e8c: NOP
ffa02e8e: NOP
ffa02e90: LOAD P1 = 0x508
ffa02e94: LOAD P1.H = 0xffc0
ffa02e98: LOAD R0 = W [P1] (Z)
ffa02e9a: CC = !BITTST (R0,0x5)
ffa02e9c: IF CC JUMP 0xffa02ea0 (bp)
ffa02e9e: JUMP.S 0xffa02ea8
ffa02ea0: LOAD R0 = [FP + -0x8]
ffa02ea2: ADD R0 += 0x1
ffa02ea4: STORE [FP + -0x8] = R0
ffa02ea6: JUMP.S 0xffa02e86
ffa02ea8: LOAD R0 = W [P0] (Z)
ffa02eaa: AND R0 = R0 & R3
ffa02eac: STORE W [P0] = R0.L
ffa02eae: LOAD P1 = [FP + -0x1c]
ffa02eb0: LOAD R0 = W [P1] (X)
ffa02eb2: STORE W [FP + -0x2] = R0
ffa02eb6: LOAD R2 = [FP + -0x8]
ffa02eb8: CC = R2 == R7
ffa02eba: IF !CC JUMP 0xffa02eca (bp)
ffa02ebc: LOAD R0 = 0x5
ffa02ebe: LOAD R0.H = 0x7
ffa02ec2: CALL 0xffa0add0
ffa02ec6: STORE B [P5] = R6
ffa02ec8: JUMP.S 0xffa02eca
ffa02eca: ADD SP += 0xc
ffa02ecc: POP (R7:5,P5:3) = [SP++]
ffa02ece: UNLINK
ffa02ed2: RTS
ffa02ed4: LINK 0x0
ffa02ed8: LOAD P1.L = 0x6ee0
ffa02edc: LOAD P1.H = 0xff80
ffa02ee0: LOAD R1 = [P1]
ffa02ee2: BITSET (R1,0x4)
ffa02ee4: STORE [P1] = R1
ffa02ee6: LOAD P1.L = 0xc824
ffa02eea: LOAD P1.H = 0x2020
ffa02eee: STORE [P1] = R0
ffa02ef0: UNLINK
ffa02ef4: RTS
ffa02ef6: LINK 0x10
ffa02efa: LOAD R2 = 0x1f4
ffa02efe: STORE [SP + 0xc] = R7
ffa02f00: MOVE R7 = R0
ffa02f02: MULT R0 *= R2
ffa02f04: LOAD R1.L = 0x42b8
ffa02f08: LOAD R1.H = 0xff80
ffa02f0c: ADD R0 = R1 + R0
ffa02f0e: LOAD R1 = 0x0
ffa02f10: CALL 0xffa05f2e
ffa02f14: MOVE P1 = FP
ffa02f16: ADD P1 += 0x8
ffa02f18: MOVE R2 = CYCLES
ffa02f1a: MOVE R1 = CYCLES2
ffa02f1c: STORE [P1] = R2
ffa02f1e: STORE [P1 + 0x4] = R1
ffa02f20: LOAD R1 = [SP + 0x18]
ffa02f22: LOAD R2 = [SP + 0x1c]
ffa02f24: LSH R0 = R7 << 0x3
ffa02f28: LOAD R3.L = 0x3ec0
ffa02f2c: LOAD R3.H = 0xff80
ffa02f30: ADD R0 = R3 + R0
ffa02f32: MOVE P1 = R0
ffa02f34: CC = R7 == 0x0
ffa02f36: STORE [P1++] = R1
ffa02f38: STORE [P1] = R2
ffa02f3a: IF CC JUMP 0xffa02f52
ffa02f3c: LOAD R0 = 0x2
ffa02f3e: LOAD R0.H = 0xa
ffa02f42: CALL 0xffa08700
ffa02f46: LOAD R0 = 0x2
ffa02f48: LOAD R0.H = 0xb
ffa02f4c: CALL 0xffa08700
ffa02f50: JUMP.S 0xffa02f5c
ffa02f52: LOAD R0 = 0x2
ffa02f54: LOAD R0.H = 0x7
ffa02f58: CALL 0xffa0872a
ffa02f5c: LOAD R7 = [SP + 0xc]
ffa02f5e: UNLINK
ffa02f62: RTS
ffa02f64: CC = R2 == 0x1
ffa02f66: LINK 0x0
ffa02f6a: NOT CC = !CC
ffa02f6c: PUSH [--SP] = (R7:4,P5:4)
ffa02f6e: MOVE R6 = CC
ffa02f70: CC = R2 == 0x3
ffa02f72: NOT CC = !CC
ffa02f74: LOAD R7 = 0x1
ffa02f76: MOVE R0 = CC
ffa02f78: BITSET (R7,0x1e)
ffa02f7a: CC = R1 < R7 (IU)
ffa02f7c: MULT R6 *= R0
ffa02f7e: ADD SP += -0xc
ffa02f80: LOAD P0.L = 0x3e94
ffa02f84: LOAD P0.H = 0xff80
ffa02f88: LOAD R3.L = 0x42b8
ffa02f8c: LOAD R3.H = 0xff80
ffa02f90: IF CC JUMP 0xffa02fd2
ffa02f92: CC = R1 == R7
ffa02f94: IF CC JUMP 0xffa02fbc
ffa02f96: LOAD R0 = -0x1
ffa02f98: LOAD R0.H = 0xbfed
ffa02f9c: ADD R0 = R1 + R0
ffa02f9e: CC = R0 < 0x4 (IU)
ffa02fa0: IF !CC JUMP 0xffa02fd2
ffa02fa2: MOVE P1 = R0
ffa02fa4: LOAD P2.L = 0x2c04
ffa02fa8: LOAD P2.H = 0xff80
ffa02fac: LOAD R0 = 0x1f4
ffa02fb0: ADD P1 = P2 + (P1 << 2)
ffa02fb2: MULT|| R1 = R6.H * R0.L ,R0 = R6.L * R0.L (fu)
ffa02fb6: LOAD P1 = [P1]
ffa02fb8: NOP
ffa02fba: JUMP (P1)
ffa02fbc: ADD R2 += -0x1
ffa02fbe: CC = R2 < 0x4 (IU)
ffa02fc0: IF !CC JUMP 0xffa02ff4
ffa02fc2: MOVE P1 = R2
ffa02fc4: LOAD P2.L = 0x2bf4
ffa02fc8: LOAD P2.H = 0xff80
ffa02fcc: ADD P1 = P2 + (P1 << 2)
ffa02fce: LOAD P1 = [P1]
ffa02fd0: JUMP (P1)
ffa02fd2: MOVE P1 = R6
ffa02fd4: LOAD R0 = 0x1f4
ffa02fd8: MULT R1 = R6.H * R0.L ,R0 = R6.L * R0.L (fu)
ffa02fdc: LSHIFT R1 <<= 0x10
ffa02fde: ADD R0 = R1 + R0
ffa02fe0: ADD P1 = P0 + (P1 << 1)
ffa02fe2: ADD|| R0 = R3 + R0 (ns)
ffa02fe6: _LOAD R1 = W [P1] (Z)
ffa02fe8: _NOP
ffa02fea: ADD R0 = R0 + R1
ffa02fec: MOVE P1 = R0
ffa02fee: LOAD R0 = B [P1] (Z)
ffa02ff0: BITSET (R0,0x4)
ffa02ff2: STORE B [P1] = R0
ffa02ff4: ADD SP += 0xc
ffa02ff6: LOAD P0 = [FP + 0x4]
ffa02ff8: POP (R7:4,P5:4) = [SP++]
ffa02ffa: UNLINK
ffa02ffe: JUMP (P0)
ffa03000: MOVE P1 = R6
ffa03002: LSHIFT R1 <<= 0x10
ffa03004: ADD R0 = R1 + R0
ffa03006: ADD P1 = P0 + (P1 << 1)
ffa03008: ADD|| R0 = R3 + R0 (ns)
ffa0300c: _LOAD R1 = W [P1] (Z)
ffa0300e: _NOP
ffa03010: ADD R0 = R0 + R1
ffa03012: MOVE P1 = R0
ffa03014: LOAD R0 = B [P1] (Z)
ffa03016: BITSET (R0,0x3)
ffa03018: STORE B [P1] = R0
ffa0301a: ADD SP += 0xc
ffa0301c: LOAD P0 = [FP + 0x4]
ffa0301e: POP (R7:4,P5:4) = [SP++]
ffa03020: UNLINK
ffa03024: JUMP (P0)
ffa03026: MOVE P1 = R6
ffa03028: LOAD R0 = 0x1f4
ffa0302c: MULT R1 = R6.H * R0.L ,R0 = R6.L * R0.L (fu)
ffa03030: LSHIFT R1 <<= 0x10
ffa03032: ADD R0 = R1 + R0
ffa03034: ADD P1 = P0 + (P1 << 1)
ffa03036: ADD|| R0 = R3 + R0 (ns)
ffa0303a: _LOAD R1 = W [P1] (Z)
ffa0303c: _NOP
ffa0303e: ADD R0 = R0 + R1
ffa03040: MOVE P1 = R0
ffa03042: LOAD R0 = B [P1] (Z)
ffa03044: BITSET (R0,0x2)
ffa03046: STORE B [P1] = R0
ffa03048: ADD SP += 0xc
ffa0304a: LOAD P0 = [FP + 0x4]
ffa0304c: POP (R7:4,P5:4) = [SP++]
ffa0304e: UNLINK
ffa03052: JUMP (P0)
ffa03054: MOVE P1 = R6
ffa03056: LOAD R0 = 0x1f4
ffa0305a: MULT R1 = R6.H * R0.L ,R0 = R6.L * R0.L (fu)
ffa0305e: LSHIFT R1 <<= 0x10
ffa03060: ADD R0 = R1 + R0
ffa03062: ADD P1 = P0 + (P1 << 1)
ffa03064: ADD|| R0 = R3 + R0 (ns)
ffa03068: _LOAD R1 = W [P1] (Z)
ffa0306a: _NOP
ffa0306c: ADD R0 = R0 + R1
ffa0306e: MOVE P1 = R0
ffa03070: LOAD R0 = B [P1] (Z)
ffa03072: BITSET (R0,0x1)
ffa03074: STORE B [P1] = R0
ffa03076: ADD SP += 0xc
ffa03078: LOAD P0 = [FP + 0x4]
ffa0307a: POP (R7:4,P5:4) = [SP++]
ffa0307c: UNLINK
ffa03080: JUMP (P0)
ffa03082: MOVE P1 = R6
ffa03084: LOAD R0 = 0x1f4
ffa03088: MULT R1 = R6.H * R0.L ,R0 = R6.L * R0.L (fu)
ffa0308c: LSHIFT R1 <<= 0x10
ffa0308e: ADD R0 = R1 + R0
ffa03090: ADD P1 = P0 + (P1 << 1)
ffa03092: ADD|| R0 = R3 + R0 (ns)
ffa03096: _LOAD R1 = W [P1] (Z)
ffa03098: _NOP
ffa0309a: ADD R0 = R0 + R1
ffa0309c: MOVE P1 = R0
ffa0309e: LOAD R0 = B [P1] (Z)
ffa030a0: BITSET (R0,0x0)
ffa030a2: STORE B [P1] = R0
ffa030a4: ADD SP += 0xc
ffa030a6: LOAD P0 = [FP + 0x4]
ffa030a8: POP (R7:4,P5:4) = [SP++]
ffa030aa: UNLINK
ffa030ae: JUMP (P0)
ffa030b0: MOVE P1 = FP
ffa030b2: ADD P1 += 0x8
ffa030b4: MOVE R2 = CYCLES
ffa030b6: MOVE R1 = CYCLES2
ffa030b8: STORE [P1] = R2
ffa030ba: STORE [P1 + 0x4] = R1
ffa030bc: LSH|| R1 = R6 << 0x3
ffa030c0: _LOAD R4 = [SP + 0x2c]
ffa030c2: _NOP
ffa030c4: LOAD R5 = [SP + 0x30]
ffa030c6: MOVE P1 = R6
ffa030c8: LOAD R2 = 0x1f4
ffa030cc: MULT R3 = R6.H * R2.L ,R2 = R6.L * R2.L (fu)
ffa030d0: LSHIFT R3 <<= 0x10
ffa030d2: LOAD R7.L = 0x3ec0
ffa030d6: LOAD R7.H = 0xff80
ffa030da: ADD P4 = P0 + (P1 << 1)
ffa030dc: ADD|| R2 = R3 + R2 (ns)
ffa030e0: _LOAD R3 = W [P4] (Z)
ffa030e2: _NOP
ffa030e4: LOAD R0.L = 0x3ed0
ffa030e8: LOAD R0.H = 0xff80
ffa030ec: ADD R1 = R7 + R1
ffa030ee: MOVE P2 = P0
ffa030f0: ADD R0 = R0 + R2
ffa030f2: MOVE I0 = R1
ffa030f4: ADD P2 += -0x8
ffa030f6: ADD R0 = R0 + R3
ffa030f8: ADD P5 = P2 + (P1 << 2)
ffa030fa: MOVE P2 = R0
ffa030fc: LOAD R2 = 0x34
ffa030fe: ADD P1 = P1 + (P1 << 1)
ffa03100: ADD P0 += 0xc
ffa03102: MULT|| R1 = R6.H * R2.L ,R0 = R6.L * R2.L (fu)
ffa03106: STORE [I0++] = R4
ffa03108: NOP
ffa0310a: ADD P0 = P0 + P1
ffa0310c: LSH|| R6 = R1 << 0x10
ffa03110: _LOAD R4 = B [P0] (Z)
ffa03112: _STORE [I0] = R5
ffa03114: ADD|| R6 = R6 + R0 (ns)
ffa03118: _STORE B [P2] = R4
ffa0311a: _NOP
ffa0311c: LOAD R0 = W [P4] (Z)
ffa0311e: LOAD R2 = 0x1f4
ffa03122: LOAD R1 = 0x1
ffa03124: CALL 0xffa06ccc
ffa03128: LOAD R7.L = 0x46a0
ffa0312c: LOAD R7.H = 0xff80
ffa03130: ADD|| R2 = R7 + R6 (ns)
ffa03134: _STORE W [P4] = R0.L
ffa03136: _NOP
ffa03138: LOAD R0 = [P5]
ffa0313a: LOAD R1 = 0x1
ffa0313c: CALL 0xffa0bf00
ffa03140: ADD SP += 0xc
ffa03142: LOAD P0 = [FP + 0x4]
ffa03144: POP (R7:4,P5:4) = [SP++]
ffa03146: UNLINK
ffa0314a: JUMP (P0)
ffa0314c: CALL 0xffa02ef6
ffa03150: ADD SP += 0xc
ffa03152: LOAD P0 = [FP + 0x4]
ffa03154: POP (R7:4,P5:4) = [SP++]
ffa03156: UNLINK
ffa0315a: JUMP (P0)
ffa0315c: CALL 0xffa02ef6
ffa03160: ADD SP += 0xc
ffa03162: LOAD P0 = [FP + 0x4]
ffa03164: POP (R7:4,P5:4) = [SP++]
ffa03166: UNLINK
ffa0316a: JUMP (P0)
ffa0316c: LINK 0x1c
ffa03170: PUSH [--SP] = (R7:6,P5:3)
ffa03172: ADD SP += -0xc
ffa03174: MOVE P1 = FP
ffa03176: ADD P1 += -0x10
ffa03178: MOVE R2 = CYCLES
ffa0317a: MOVE R1 = CYCLES2
ffa0317c: STORE [P1] = R2
ffa0317e: STORE [P1 + 0x4] = R1
ffa03180: LOAD R6 = [SP + 0x2c]
ffa03182: LOAD R7 = [SP + 0x30]
ffa03184: LOAD P4.L = 0x91f0
ffa03188: LOAD P4.H = 0x2020
ffa0318c: LOAD P5.L = 0x3e94
ffa03190: LOAD P5.H = 0xff80
ffa03194: LOAD R1 = W [P4] (Z)
ffa03196: LOAD R2 = W [P5] (Z)
ffa03198: LOAD R0.L = 0x6ee0
ffa0319c: LOAD R0.H = 0xff80
ffa031a0: LOAD P0.L = 0x2924
ffa031a4: LOAD P0.H = 0xff80
ffa031a8: CC = R1 == R2
ffa031aa: STORE [SP + 0x24] = R0
ffa031ac: STORE [SP + 0x20] = P0
ffa031ae: LOAD P3.L = 0x3ec0
ffa031b2: LOAD P3.H = 0xff80
ffa031b6: IF !CC JUMP 0xffa032ea
ffa031b8: LOAD R0 = W [P4 + 0x2] (Z)
ffa031ba: LOAD R1 = W [P5 + 0x2] (Z)
ffa031bc: LOAD P1.L = 0x280c
ffa031c0: LOAD P1.H = 0xff80
ffa031c4: CC = R0 == R1
ffa031c6: STORE [SP + 0x28] = P1
ffa031c8: IF !CC JUMP 0xffa0326a
ffa031ca: LOAD P1 = [SP + 0x28]
ffa031cc: LOAD R0 = [P5 + 0x20]
ffa031ce: CC = R6 < R0 (IU)
ffa031d0: MOVE R2 = CC
ffa031d2: SUB R1 = R6 - R0
ffa031d4: LOAD R0 = [P1]
ffa031d6: SUB R2 = R7 - R2
ffa031d8: LOAD R3 = [P5 + 0x24]
ffa031da: CC = R0 < R1 (IU)
ffa031dc: SUB R2 = R2 - R3
ffa031de: LOAD R1 = [P1 + 0x4]
ffa031e0: SUB R2 = R1 - R2 (s)
ffa031e4: MOVE CC &= az
ffa031e6: MOVE CC |= an
ffa031e8: IF !CC JUMP 0xffa0320c
ffa031ea: MOVE P1 = P5
ffa031ec: LOAD R0 = 0x0
ffa031ee: STORE W [P4 + -0x4] = R0
ffa031f2: STORE W [P4] = R0.L
ffa031f4: LOAD P0 = 0x20
ffa031f6: STORE W [P1 ++ P0] = R0.L
ffa031f8: MOVE P0 = FP
ffa031fa: ADD P0 += -0x8
ffa031fc: MOVE R2 = CYCLES
ffa031fe: MOVE R1 = CYCLES2
ffa03200: STORE [P0] = R2
ffa03202: STORE [P0 + 0x4] = R1
ffa03204: LOAD R0 = [SP + 0x34]
ffa03206: LOAD R1 = [SP + 0x38]
ffa03208: STORE [P1] = R0
ffa0320a: STORE [P1 + 0x4] = R1
ffa0320c: LOAD P0 = [SP + 0x28]
ffa0320e: LOAD R0 = [P5 + 0x18]
ffa03210: CC = R6 < R0 (IU)
ffa03212: MOVE R2 = CC
ffa03214: SUB R2 = R7 - R2
ffa03216: SUB R1 = R6 - R0
ffa03218: LOAD R3 = [P5 + 0x1c]
ffa0321a: LOAD R7 = [P0]
ffa0321c: CC = R7 < R1 (IU)
ffa0321e: SUB R2 = R2 - R3
ffa03220: LOAD R0 = [P0 + 0x4]
ffa03222: SUB R2 = R0 - R2 (s)
ffa03226: MOVE CC &= az
ffa03228: MOVE CC |= an
ffa0322a: IF !CC JUMP 0xffa03260
ffa0322c: LOAD R0 = 0x0
ffa0322e: STORE W [P5 + 0x2] = R0
ffa03230: STORE W [P4 + -0x2] = R0
ffa03234: STORE W [P4 + 0x2] = R0
ffa03236: MOVE P1 = FP
ffa03238: ADD P1 += 0xc
ffa0323a: MOVE R2 = CYCLES
ffa0323c: MOVE R1 = CYCLES2
ffa0323e: STORE [P1] = R2
ffa03240: STORE [P1 + 0x4] = R1
ffa03242: LOAD R0 = [FP + 0xc]
ffa03244: LOAD R1 = [FP + 0x10]
ffa03246: ADD P5 += 0x18
ffa03248: STORE [P5] = R0
ffa0324a: STORE [P5 + 0x4] = R1
ffa0324c: LOAD R0 = B [P4 + 0x9] (Z)
ffa03250: CC = R0 == 0x0
ffa03252: IF !CC JUMP 0xffa03260
ffa03254: NOP
ffa03256: LOAD P1 = [SP + 0x24]
ffa03258: LOAD P0 = [SP + 0x24]
ffa0325a: LOAD R0 = [P1]
ffa0325c: BITSET (R0,0xe)
ffa0325e: STORE [P0] = R0
ffa03260: ADD SP += 0xc
ffa03262: POP (R7:6,P5:3) = [SP++]
ffa03264: UNLINK
ffa03268: RTS
ffa0326a: MOVE R2 = FP
ffa0326c: ADD R2 += 0x8
ffa0326e: LOAD R0 = [P5 + -0x4]
ffa03272: LOAD R1 = 0x7
ffa03274: LOAD R1.H = 0x4012
ffa03278: CALL 0xffa10684
ffa0327c: LOAD R0 = [FP + 0x8]
ffa0327e: CC = R0 == 0x0
ffa03280: IF CC JUMP 0xffa031ca
ffa03282: ADD P3 += 0x8
ffa03284: LOAD R3 = B [P5 + 0x12] (Z)
ffa03288: CC = R3 == 0x0
ffa0328a: IF CC JUMP 0xffa032c8
ffa0328c: CC = R3 == 0x0
ffa0328e: IF CC JUMP 0xffa031ca
ffa03290: NOP
ffa03292: NOP
ffa03294: LOAD P1 = [SP + 0x28]
ffa03296: LOAD R0 = [P3]
ffa03298: CC = R6 < R0 (IU)
ffa0329a: MOVE R3 = CC
ffa0329c: SUB R1 = R6 - R0
ffa0329e: LOAD R0 = [P1 + -0x8]
ffa032a2: SUB R3 = R7 - R3
ffa032a4: LOAD R2 = [P3 + 0x4]
ffa032a6: CC = R0 < R1 (IU)
ffa032a8: SUB R2 = R3 - R2
ffa032aa: LOAD R1 = [P1 + -0x4]
ffa032ae: SUB R2 = R1 - R2 (s)
ffa032b2: MOVE CC &= az
ffa032b4: MOVE CC |= an
ffa032b6: IF !CC JUMP 0xffa031ca
ffa032b8: LOAD P1 = [SP + 0x24]
ffa032ba: LOAD P0 = [SP + 0x24]
ffa032bc: LOAD R1 = W [P5 + 0x2] (X)
ffa032be: LOAD R0 = [P1]
ffa032c0: BITSET (R0,0x8)
ffa032c2: STORE [P0] = R0
ffa032c4: STORE W [P4 + 0x2] = R1
ffa032c6: JUMP.S 0xffa031ca
ffa032c8: LOAD R0 = [P3]
ffa032ca: LOAD P1 = [SP + 0x20]
ffa032cc: CC = R6 < R0 (IU)
ffa032ce: MOVE R2 = CC
ffa032d0: SUB R2 = R7 - R2
ffa032d2: LOAD R1 = [P3 + 0x4]
ffa032d4: SUB R1 = R2 - R1
ffa032d6: SUB R0 = R6 - R0
ffa032d8: LOAD R2 = [P1 + 0x8]
ffa032da: CC = R2 < R0 (IU)
ffa032dc: LOAD R0 = [P1 + 0xc]
ffa032de: SUB R1 = R0 - R1 (s)
ffa032e2: MOVE CC &= az
ffa032e4: MOVE CC |= an
ffa032e6: IF CC JUMP 0xffa032b8
ffa032e8: JUMP.S 0xffa0328c
ffa032ea: MOVE R2 = FP
ffa032ec: ADD R2 += 0x8
ffa032ee: LOAD R0 = [P5 + -0x8]
ffa032f2: LOAD R1 = 0x7
ffa032f4: LOAD R1.H = 0x4012
ffa032f8: CALL 0xffa10684
ffa032fc: LOAD R0 = [FP + 0x8]
ffa032fe: CC = R0 == 0x0
ffa03300: IF CC JUMP 0xffa031b8
ffa03302: NOP
ffa03304: NOP
ffa03306: LOAD P1 = [SP + 0x20]
ffa03308: LOAD R0 = [P3]
ffa0330a: CC = R6 < R0 (IU)
ffa0330c: MOVE R3 = CC
ffa0330e: SUB R1 = R6 - R0
ffa03310: LOAD R0 = [P1]
ffa03312: SUB R3 = R7 - R3
ffa03314: LOAD R2 = [P3 + 0x4]
ffa03316: CC = R0 < R1 (IU)
ffa03318: SUB R2 = R3 - R2
ffa0331a: LOAD R1 = [P1 + 0x4]
ffa0331c: SUB R2 = R1 - R2 (s)
ffa03320: MOVE CC &= az
ffa03322: MOVE CC |= an
ffa03324: IF !CC JUMP 0xffa031b8
ffa03326: LOAD P1 = [SP + 0x24]
ffa03328: LOAD P0 = [SP + 0x24]
ffa0332a: LOAD R1 = W [P5] (X)
ffa0332c: LOAD R0 = [P1]
ffa0332e: BITSET (R0,0x2)
ffa03330: STORE [P0] = R0
ffa03332: STORE W [P4] = R1.L
ffa03334: JUMP.S 0xffa031b8
ffa03358: LINK 0x0
ffa0335c: PUSH [--SP] = (R7:4)
ffa0335e: MOVE R7 = R1
ffa03360: MOVE R4 = R2
ffa03362: MOVE R5 = R0
ffa03364: MOVE R6 = R0
ffa03366: ADD SP += -0xc
ffa03368: MOVE R1 = R4
ffa0336a: MOVE R0 = R7
ffa0336c: CALL 0xffa0165c
ffa03370: IF !CC JUMP 0xffa033b2
ffa03372: MOVE R1 = R5
ffa03374: MOVE R0 = R7
ffa03376: CALL 0xffa01630
ffa0337a: LOAD R0 = 0x0
ffa0337c: IF CC JUMP 0xffa033a8
ffa0337e: MOVE R0 = R6
ffa03380: MOVE R1 = R4
ffa03382: CALL 0xffa01630
ffa03386: LOAD R0 = 0x0
ffa03388: LOAD R0.H = 0x3f80
ffa0338c: IF CC JUMP 0xffa033a8
ffa0338e: MOVE R1 = R7
ffa03390: MOVE R0 = R6
ffa03392: CALL 0xffa01714
ffa03396: MOVE R6 = R0
ffa03398: MOVE R1 = R7
ffa0339a: MOVE R0 = R4
ffa0339c: CALL 0xffa01714
ffa033a0: MOVE R1 = R0
ffa033a2: MOVE R0 = R6
ffa033a4: CALL 0xffa01814
ffa033a8: ADD SP += 0xc
ffa033aa: POP (R7:4) = [SP++]
ffa033ac: UNLINK
ffa033b0: RTS
ffa033b2: MOVE R1 = R7
ffa033b4: MOVE R0 = R4
ffa033b6: LOAD R6 = 0x0
ffa033b8: CALL 0xffa0165c
ffa033bc: LOAD R6.H = 0x3f80
ffa033c0: MOVE R0 = R6
ffa033c2: IF !CC JUMP 0xffa033a8
ffa033c4: MOVE R1 = R7
ffa033c6: MOVE R0 = R5
ffa033c8: CALL 0xffa01630
ffa033cc: LOAD R0 = 0x0
ffa033ce: IF CC JUMP 0xffa033a8
ffa033d0: MOVE R1 = R5
ffa033d2: MOVE R0 = R4
ffa033d4: CALL 0xffa01630
ffa033d8: MOVE R0 = R6
ffa033da: IF CC JUMP 0xffa033a8
ffa033dc: MOVE R1 = R5
ffa033de: MOVE R0 = R7
ffa033e0: CALL 0xffa01714
ffa033e4: MOVE R6 = R0
ffa033e6: MOVE R1 = R4
ffa033e8: MOVE R0 = R7
ffa033ea: CALL 0xffa01714
ffa033ee: MOVE R1 = R0
ffa033f0: MOVE R0 = R6
ffa033f2: CALL 0xffa01814
ffa033f6: JUMP.S 0xffa033a8
ffa033f8: LINK 0x14
