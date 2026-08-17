######## FFA07BDE..FFA08200 DMA IRQ/handlers
ffa07bde: LOAD P1 = [P5++]
ffa07be0: LOAD R2 = 0x2
ffa07be2: LOAD R1 = W [P1] (X)
ffa07be4: BITSET (R1,0x0)
ffa07be6: STORE W [P1] = R1.L
ffa07be8: STORE [P5 + 0x3c] = R2 **
ffa07bea: JUMP.S 0xffa07bc8
ffa07bec: LOAD R0 = B [P5 + 0x46] (Z)
ffa07bf0: CC = R0 == 0x0
ffa07bf2: IF CC JUMP 0xffa07ca8
ffa07bf4: LOAD R1 = [P5 + 0x58]
ffa07bf8: CC = R1 == 0x0
ffa07bfa: IF CC JUMP 0xffa07ca0
ffa07bfc: MOVE R0 = R6
ffa07bfe: CALL 0xffa0763c **
ffa07c02: LOAD P1 = [P5 + 0x4]
ffa07c04: LOAD R0 = [P5 + 0x3c]
ffa07c06: LOAD R1 = [P5 + 0x58]
ffa07c0a: LOAD R2 = 0x4
ffa07c0c: STORE [P1] = R1 **
ffa07c0e: CC = R0 == R2
ffa07c10: LOAD P1 = [P5 + 0x58]
ffa07c14: LOAD P0 = [P5 + 0x8]
ffa07c16: IF !CC JUMP 0xffa07c5a
ffa07c18: LOAD R0 = W [P1 + 0x4] (X)
ffa07c1a: LSH|| R1 = R0 << 0x10
ffa07c1e: _LOAD R0 = W [P1 + 0x2] (Z)
ffa07c20: _NOP
ffa07c22: OR R0 = R1 | R0
ffa07c24: STORE [P0] = R0 **
ffa07c26: LOAD P1 = [P5 + 0x58]
ffa07c2a: LOAD P0 = [P5 + 0xc]
ffa07c2c: LOAD R0 = W [P1 + 0x8] (X)
ffa07c2e: STORE W [P0] = R0.L
ffa07c30: LOAD P1 = [P5 + 0x58]
ffa07c34: LOAD P0 = [P5 + 0x14]
ffa07c36: LOAD R0 = W [P1 + 0xa] (X)
ffa07c38: STORE W [P0] = R0.L
ffa07c3a: LOAD P1 = [P5 + 0x58]
ffa07c3e: LOAD P0 = [P5 + 0x10]
ffa07c40: LOAD R0 = W [P1 + 0xc] (X)
ffa07c42: STORE W [P0] = R0.L
ffa07c44: LOAD P1 = [P5 + 0x58]
ffa07c48: LOAD P0 = [P5 + 0x18]
ffa07c4a: LOAD R0 = W [P1 + 0xe] (X)
ffa07c4c: STORE W [P0] = R0.L
ffa07c4e: LOAD P1 = [P5 + 0x58]
ffa07c52: LOAD P0 = [P5]
ffa07c54: LOAD R0 = W [P1 + 0x6] (X)
ffa07c56: STORE W [P0] = R0.L
ffa07c58: JUMP.S 0xffa07c96
ffa07c5a: LOAD R0 = W [P1 + 0x6] (X)
ffa07c5c: LOAD R1 = W [P1 + 0x4] (X)
ffa07c5e: PACK R0 = pack(R0.L,R1.L)
ffa07c62: STORE [P0] = R0 **
ffa07c64: LOAD P1 = [P5 + 0x58]
ffa07c68: LOAD P0 = [P5 + 0xc]
ffa07c6a: LOAD R0 = W [P1 + 0xa] (X)
ffa07c6c: STORE W [P0] = R0.L
ffa07c6e: LOAD P1 = [P5 + 0x58]
ffa07c72: LOAD P0 = [P5 + 0x14]
ffa07c74: LOAD R0 = W [P1 + 0xc] (X)
ffa07c76: STORE W [P0] = R0.L
ffa07c78: LOAD P1 = [P5 + 0x58]
ffa07c7c: LOAD P0 = [P5 + 0x10]
ffa07c7e: LOAD R0 = W [P1 + 0xe] (X)
ffa07c80: STORE W [P0] = R0.L
ffa07c82: LOAD P1 = [P5 + 0x58]
ffa07c86: LOAD P0 = [P5 + 0x18]
ffa07c88: LOAD R0 = W [P1 + 0x10] (X)
ffa07c8a: STORE W [P0] = R0.L
ffa07c8c: LOAD P1 = [P5 + 0x58]
ffa07c90: LOAD P0 = [P5]
ffa07c92: LOAD R0 = W [P1 + 0x8] (X)
ffa07c94: STORE W [P0] = R0.L
ffa07c96: MOVE R0 = R7
ffa07c98: LOAD R1 = 0x2
ffa07c9a: STORE [P5 + 0x40] = R1 **
ffa07c9e: JUMP.S 0xffa07bc8
ffa07ca0: STORE [P5 + 0x40] = R5 **
ffa07ca4: MOVE R0 = R7
ffa07ca6: JUMP.S 0xffa07bc8
ffa07ca8: LOAD R1 = [P5 + 0x60]
ffa07cac: CC = R1 == 0x0
ffa07cae: IF CC JUMP 0xffa07cc8
ffa07cb0: STORE [P5 + 0x58] = R1 **
ffa07cb4: LOAD R0 = [P5 + 0x64]
ffa07cb8: STORE [P5 + 0x5c] = R0 **
ffa07cbc: LOAD R0 = 0x0
ffa07cbe: STORE [P5 + 0x60] = R0 **
ffa07cc2: STORE [P5 + 0x64] = R0 **
ffa07cc6: JUMP.S 0xffa07bfc
ffa07cc8: STORE [P5 + 0x40] = R5 **
ffa07ccc: MOVE R0 = R7
ffa07cce: JUMP.S 0xffa07bc8
ffa07cd0: LINK 0x0
ffa07cd4: PUSH [--SP] = (R7:6,P5:3)
ffa07cd6: MOVE P1 = R1
ffa07cd8: MOVE P4 = R0
ffa07cda: MOVE R6 = R0
ffa07cdc: MOVE P5 = R2
ffa07cde: ADD SP += -0xc
ffa07ce0: LOAD P0 = -0x1
ffa07ce2: LOAD P0.H = 0xfffc
ffa07ce6: LOAD P2.L = 0x37b4
ffa07cea: LOAD P2.H = 0xff80
ffa07cee: LOAD R3.L = 0x3680
ffa07cf2: LOAD R3.H = 0xff80
ffa07cf6: LOAD P3 = -0x1
ffa07cf8: LSETUP (0xffa07cfe,0xffa07d30) LC0 = P3
ffa07cfc: LOAD P3 = 0xb
ffa07cfe: ADD P1 = P1 + P0
ffa07d00: CC = P1 < P3 (IU)
ffa07d02: IF !CC JUMP 0xffa07d0e
ffa07d04: NOP
ffa07d06: NOP
ffa07d08: ADD P1 = P2 + (P1 << 2)
ffa07d0a: LOAD P1 = [P1]
ffa07d0c: JUMP (P1)
ffa07d0e: ADD SP += 0xc
ffa07d10: LOAD P0 = [FP + 0x4]
ffa07d12: POP (R7:6,P5:3) = [SP++]
ffa07d14: UNLINK
ffa07d18: LOAD R0 = 0xd
ffa07d1a: LOAD R0.H = 0x3
ffa07d1e: JUMP (P0)
ffa07d20: LOAD R0 = 0x0
ffa07d22: ADD SP += 0xc
ffa07d24: LOAD P0 = [FP + 0x4]
ffa07d26: POP (R7:6,P5:3) = [SP++]
ffa07d28: UNLINK
ffa07d2c: JUMP (P0)
ffa07d2e: LOAD P1 = [P5]
ffa07d30: LOAD P5 = [P5 + 0x4]
ffa07d32: JUMP.S 0xffa07cf6
ffa07d34: LOAD R7 = 0x1
ffa07d36: LOAD R7.H = 0x3
ffa07d3a: LOAD R0 = [P5]
ffa07d3c: CC = R0 == R7
ffa07d3e: IF CC JUMP 0xffa07d5e
ffa07d40: ROT|| R0 = rot R6 by 0
ffa07d44: _LOAD R1 = [P5++]
ffa07d46: _NOP
ffa07d48: LOAD R2 = [P5++]
ffa07d4a: CALL 0xffa07cd0 **
ffa07d4e: CC = R0 == 0x0
ffa07d50: IF CC JUMP 0xffa07d3a (bp)
ffa07d52: ADD SP += 0xc
ffa07d54: LOAD P0 = [FP + 0x4]
ffa07d56: POP (R7:6,P5:3) = [SP++]
ffa07d58: UNLINK
ffa07d5c: JUMP (P0)
ffa07d5e: ADD SP += 0xc
ffa07d60: SUB|| R0 = R0 - R0 (ns)
ffa07d64: _LOAD P0 = [FP + 0x4]
ffa07d66: _NOP
ffa07d68: POP (R7:6,P5:3) = [SP++]
ffa07d6a: UNLINK
ffa07d6e: JUMP (P0)
ffa07d70: LOAD R0 = [P4 + 0x40]
ffa07d74: CC = R0 == 0x0
ffa07d76: IF CC JUMP 0xffa07d8a
ffa07d78: ADD SP += 0xc
ffa07d7a: LOAD P0 = [FP + 0x4]
ffa07d7c: POP (R7:6,P5:3) = [SP++]
ffa07d7e: UNLINK
ffa07d82: LOAD R0 = 0x3
ffa07d84: LOAD R0.H = 0x3
ffa07d88: JUMP (P0)
ffa07d8a: MOVE R1 = P5
ffa07d8c: STORE B [P4 + 0x45] = R1
ffa07d90: ADD SP += 0xc
ffa07d92: LOAD P0 = [FP + 0x4]
ffa07d94: POP (R7:6,P5:3) = [SP++]
ffa07d96: UNLINK
ffa07d9a: JUMP (P0)
ffa07d9c: LOAD R0 = [P4 + 0x40]
ffa07da0: CC = R0 == 0x0
ffa07da2: IF CC JUMP 0xffa07db6
ffa07da4: ADD SP += 0xc
ffa07da6: LOAD P0 = [FP + 0x4]
ffa07da8: POP (R7:6,P5:3) = [SP++]
ffa07daa: UNLINK
ffa07dae: LOAD R0 = 0x3
ffa07db0: LOAD R0.H = 0x3
ffa07db4: JUMP (P0)
ffa07db6: MOVE R1 = P5
ffa07db8: STORE B [P4 + 0x46] = R1
ffa07dbc: ADD SP += 0xc
ffa07dbe: LOAD P0 = [FP + 0x4]
ffa07dc0: POP (R7:6,P5:3) = [SP++]
ffa07dc2: UNLINK
ffa07dc6: JUMP (P0)
ffa07dc8: MOVE R1 = P5
ffa07dca: CALL 0xffa07b64 **
ffa07dce: ADD SP += 0xc
ffa07dd0: LOAD P0 = [FP + 0x4]
ffa07dd2: POP (R7:6,P5:3) = [SP++]
ffa07dd4: UNLINK
ffa07dd8: JUMP (P0)
ffa07dda: LOAD P1 = [P4 + 0x30]
ffa07ddc: LOAD R7 = 0x3
ffa07dde: LOAD R7.H = 0x3
ffa07de2: LOAD R0 = [P1 + 0x4]
ffa07de4: CALL 0xffa08cea **
ffa07de8: LOAD R2 = [P4 + 0x40]
ffa07dec: CC = R2 == 0x0
ffa07dee: IF !CC JUMP 0xffa07e0a
ffa07df0: STORE B [P4 + 0x47] = R2
ffa07df4: STORE [P4 + 0x54] = R2 **
ffa07df8: STORE [P4 + 0x58] = R2 **
ffa07dfc: STORE [P4 + 0x5c] = R2 **
ffa07e00: STORE [P4 + 0x60] = R2 **
ffa07e04: STORE [P4 + 0x64] = R2 **
ffa07e08: LOAD R7 = 0x0
ffa07e0a: CALL 0xffa08d0c **
ffa07e0e: ADD SP += 0xc
ffa07e10: ROT|| R0 = rot R7 by 0
ffa07e14: _LOAD P0 = [FP + 0x4]
ffa07e16: _NOP
ffa07e18: POP (R7:6,P5:3) = [SP++]
ffa07e1a: UNLINK
ffa07e1e: JUMP (P0)
ffa07e20: LOAD P1 = [P4 + 0x28]
ffa07e22: LOAD R0 = 0x301
ffa07e26: LOAD R1 = W [P1] (X)
ffa07e28: EXTRACT R0 = extract(R1,R0.L) (z)
ffa07e2c: CC = R0 == 0x1
ffa07e2e: IF !CC JUMP 0xffa07e44
ffa07e30: SUB|| R0 = R0 - R0 (ns)
ffa07e34: _STORE [P5] = R0 **
ffa07e36: _NOP
ffa07e38: ADD SP += 0xc
ffa07e3a: LOAD P0 = [FP + 0x4]
ffa07e3c: POP (R7:6,P5:3) = [SP++]
ffa07e3e: UNLINK
ffa07e42: JUMP (P0)
ffa07e44: LOAD R0 = 0x0
ffa07e46: STORE [P5] = R0 **
ffa07e48: ADD SP += 0xc
ffa07e4a: LOAD P0 = [FP + 0x4]
ffa07e4c: POP (R7:6,P5:3) = [SP++]
ffa07e4e: UNLINK
ffa07e52: JUMP (P0)
ffa07e58: SUB|| R0 = R0 - R0 (ns)
ffa07e5c: _LOAD R1 = W [P5 + 0x4] (Z)
ffa07e5e: _NOP
ffa07e60: LSH|| R1 = R1 << 0x3
ffa07e64: _LOAD R2 = [P5]
ffa07e66: _NOP
ffa07e68: ADD|| R1 = R3 + R1 (ns)
ffa07e6c: _LOAD P0 = [P5]
ffa07e6e: _NOP
ffa07e70: MOVE P1 = R1
ffa07e72: CC = R2 < 0x4 (IU)
ffa07e74: LOAD P2.L = 0x37e0
ffa07e78: LOAD P2.H = 0xff80
ffa07e7c: LOAD P1 = [P1]
ffa07e7e: IF !CC JUMP 0xffa07d22
ffa07e80: NOP
ffa07e82: NOP
ffa07e84: ADD P0 = P2 + (P0 << 2)
ffa07e86: LOAD P0 = [P0]
ffa07e88: LOAD R3 = 0x4
ffa07e8a: JUMP (P0)
ffa07e90: SUB|| R0 = R0 - R0 (ns)
ffa07e94: _LOAD R1 = W [P1 + 0x4] (Z)
ffa07e96: _NOP
ffa07e98: LSH|| R1 = R1 << 0x3
ffa07e9c: _LOAD R2 = [P5]
ffa07e9e: _NOP
ffa07ea0: ADD|| R1 = R3 + R1 (ns)
ffa07ea4: _LOAD P0 = [P5]
ffa07ea6: _NOP
ffa07ea8: MOVE P1 = R1
ffa07eaa: CC = R2 < 0x4 (IU)
ffa07eac: LOAD P2.L = 0x37f0
ffa07eb0: LOAD P2.H = 0xff80
ffa07eb4: LOAD P1 = [P1 + 0x4]
ffa07eb6: IF !CC JUMP 0xffa07d22
ffa07eb8: NOP
ffa07eba: NOP
ffa07ebc: ADD P0 = P2 + (P0 << 2)
ffa07ebe: LOAD P0 = [P0]
ffa07ec0: LOAD R1 = 0xf
ffa07ec2: LOAD R2 = 0xb05
ffa07ec6: JUMP (P0)
ffa07ec8: SUB|| R0 = R0 - R0 (ns)
ffa07ecc: _LOAD P1 = [P4 + 0x1c]
ffa07ece: _NOP
ffa07ed0: LOAD R1 = [P1]
ffa07ed2: STORE [P5] = R1 **
ffa07ed4: LOAD P1 = [P4 + 0x1c]
ffa07ed6: LOAD R1 = [P1]
ffa07ed8: STORE [P5] = R1 **
ffa07eda: ADD SP += 0xc
ffa07edc: LOAD P0 = [FP + 0x4]
ffa07ede: POP (R7:6,P5:3) = [SP++]
ffa07ee0: UNLINK
ffa07ee4: JUMP (P0)
ffa07ee6: LOAD R2 = W [P5 + 0x6] (X)
ffa07ee8: PACK|| R1 = pack(R2.L,R3.L)
ffa07eec: _LOAD R7 = W [P1] (Z)
ffa07eee: _NOP
ffa07ef0: DEPOSIT R1 = deposit(R7,R1)
ffa07ef4: STORE W [P1] = R1.L
ffa07ef6: ADD SP += 0xc
ffa07ef8: LOAD P0 = [FP + 0x4]
ffa07efa: POP (R7:6,P5:3) = [SP++]
ffa07efc: UNLINK
ffa07f00: JUMP (P0)
ffa07f02: LOAD R1 = W [P5 + 0x6] (X)
ffa07f04: LSH|| R1.H = R1.L << 0x0
ffa07f08: LOAD R2 = W [P1] (Z)
ffa07f0a: NOP
ffa07f0c: LOAD R1.L = 0x404
ffa07f10: DEPOSIT R1 = deposit(R2,R1)
ffa07f14: STORE W [P1] = R1.L
ffa07f16: ADD SP += 0xc
ffa07f18: LOAD P0 = [FP + 0x4]
ffa07f1a: POP (R7:6,P5:3) = [SP++]
ffa07f1c: UNLINK
ffa07f20: JUMP (P0)
ffa07f22: LOAD R1 = W [P5 + 0x6] (X)
ffa07f24: LSH|| R1.H = R1.L << 0x0
ffa07f28: LOAD R2 = W [P1] (Z)
ffa07f2a: NOP
ffa07f2c: LOAD R1.L = 0x803
ffa07f30: DEPOSIT R1 = deposit(R2,R1)
ffa07f34: STORE W [P1] = R1.L
ffa07f36: ADD SP += 0xc
ffa07f38: LOAD P0 = [FP + 0x4]
ffa07f3a: POP (R7:6,P5:3) = [SP++]
ffa07f3c: UNLINK
ffa07f40: JUMP (P0)
ffa07f42: LOAD R1 = W [P5 + 0x6] (X)
ffa07f44: LSH|| R1.H = R1.L << 0x0
ffa07f48: LOAD R2 = W [P1] (Z)
ffa07f4a: NOP
ffa07f4c: LOAD R1.L = 0xb05
ffa07f50: DEPOSIT R1 = deposit(R2,R1)
ffa07f54: STORE W [P1] = R1.L
ffa07f56: ADD SP += 0xc
ffa07f58: LOAD P0 = [FP + 0x4]
ffa07f5a: POP (R7:6,P5:3) = [SP++]
ffa07f5c: UNLINK
ffa07f60: JUMP (P0)
ffa07f62: LOAD R0 = W [P1] (X)
ffa07f64: LOAD P1 = [P5 + 0x8]
ffa07f66: AND R1 = R0 & R1
ffa07f68: LOAD R0 = 0x0
ffa07f6a: STORE W [P1] = R1.L
ffa07f6c: ADD SP += 0xc
ffa07f6e: LOAD P0 = [FP + 0x4]
ffa07f70: POP (R7:6,P5:3) = [SP++]
ffa07f72: UNLINK
ffa07f76: JUMP (P0)
ffa07f78: LOAD R1 = W [P1] (X)
ffa07f7a: LOAD P1 = [P5 + 0x8]
ffa07f7c: LOAD R2 = 0x404
ffa07f80: EXTRACT R1 = extract(R1,R2.L) (z)
ffa07f84: STORE W [P1] = R1.L
ffa07f86: ADD SP += 0xc
ffa07f88: LOAD P0 = [FP + 0x4]
ffa07f8a: POP (R7:6,P5:3) = [SP++]
ffa07f8c: UNLINK
ffa07f90: JUMP (P0)
ffa07f92: LOAD R1 = W [P1] (X)
ffa07f94: LOAD P1 = [P5 + 0x8]
ffa07f96: LOAD R2 = 0x803
ffa07f9a: EXTRACT R1 = extract(R1,R2.L) (z)
ffa07f9e: STORE W [P1] = R1.L
ffa07fa0: ADD SP += 0xc
ffa07fa2: LOAD P0 = [FP + 0x4]
ffa07fa4: POP (R7:6,P5:3) = [SP++]
ffa07fa6: UNLINK
ffa07faa: JUMP (P0)
ffa07fac: LOAD R1 = W [P1] (X)
ffa07fae: LOAD P1 = [P5 + 0x8]
ffa07fb0: EXTRACT R1 = extract(R1,R2.L) (z)
ffa07fb4: STORE W [P1] = R1.L
ffa07fb6: ADD SP += 0xc
ffa07fb8: LOAD P0 = [FP + 0x4]
ffa07fba: POP (R7:6,P5:3) = [SP++]
ffa07fbc: UNLINK
ffa07fc0: JUMP (P0)
ffa07fc2: MOVE P1 = R0
ffa07fc4: LINK 0x18
ffa07fc8: LOAD R0 = 0x101
ffa07fcc: LOAD P0 = [P1 + 0x28]
ffa07fce: LOAD R1 = W [P0] (X)
ffa07fd0: EXTRACT|| R0 = extract(R1,R0.L) (z)
ffa07fd4: LOAD P0 = [FP + 0x4]
ffa07fd6: NOP
ffa07fd8: CC = R0 == 0x1
ffa07fda: IF CC JUMP 0xffa07fe4
ffa07fdc: UNLINK
ffa07fe0: LOAD R0 = 0x1
ffa07fe2: JUMP (P0)
ffa07fe4: LOAD P0 = [P1 + 0x28]
ffa07fe6: LOAD R0 = 0x2
ffa07fe8: STORE W [P0] = R0.L
ffa07fea: LOAD R2 = [P1 + 0x6c]
ffa07fee: CC = R2 == 0x0
ffa07ff0: LOAD P0 = [P1 + 0x6c]
ffa07ff4: IF CC JUMP 0xffa0801a
ffa07ff6: LOAD R0 = [P1 + 0x68]
ffa07ffa: CC = R0 == 0x0
ffa07ffc: LOAD R1 = [P1 + 0x50]
ffa08000: IF CC JUMP 0xffa08028
ffa08002: SUB|| R1 = R1 - R1 (ns)
ffa08006: _STORE [SP + 0xc] = R1
ffa08008: _NOP
ffa0800a: LOAD P1 = 0x0
ffa0800c: STORE [SP + 0x14] = P1
ffa0800e: LOAD P1 = 0x4
ffa08010: LOAD P1.H = 0x3
ffa08014: STORE [SP + 0x10] = P1
ffa08016: CALL 0xffa07394 **
ffa0801a: SUB|| R0 = R0 - R0 (ns)
ffa0801e: _LOAD P0 = [FP + 0x4]
ffa08020: _NOP
ffa08022: UNLINK
ffa08026: JUMP (P0)
ffa08028: MOVE R0 = R1
ffa0802a: LOAD R2 = 0x0
ffa0802c: LOAD R1 = 0x4
ffa0802e: LOAD R1.H = 0x3
ffa08032: CALL (P0) **
ffa08034: SUB|| R0 = R0 - R0 (ns)
ffa08038: _LOAD P0 = [FP + 0x4]
ffa0803a: _NOP
ffa0803c: UNLINK
ffa08040: JUMP (P0)
ffa08044: LINK 0x0
ffa08048: PUSH [--SP] = (R7:4,P5:4)
ffa0804a: MOVE P4 = R0
ffa0804c: ADD SP += -0x18
ffa0804e: MOVE R5 = R1
ffa08050: LOAD R4 = 0x1
ffa08052: LOAD P1 = [P4 + 0x3c]
ffa08054: LOAD P5 = [P4 + 0x54]
ffa08058: LOAD R6 = [P4 + 0x50]
ffa0805c: LOAD R4.H = 0x3
ffa08060: ADD P1 += -0x1
ffa08062: CC = P1 < 0x5 (IU)
ffa08064: LOAD R7 = 0x1
ffa08066: IF !CC JUMP 0xffa08096
ffa08068: NOP
ffa0806a: LOAD P0.L = 0x3800
ffa0806e: LOAD P0.H = 0xff80
ffa08072: ADD P1 = P0 + (P1 << 2)
ffa08074: LOAD P1 = [P1]
ffa08076: LOAD R2 = 0x701
ffa0807a: LOAD R3 = -0x1
ffa0807c: JUMP (P1)
ffa0807e: MOVE P1 = P4
ffa08080: SUB|| R7 = R7 - R7 (ns)
ffa08084: _LOAD P0 = [P1++]
ffa08086: _NOP
ffa08088: LOAD R3 = W [P0] (X)
ffa0808a: EXTRACT R2 = extract(R3,R2.L) (z)
ffa0808e: CC = R2 == 0x1
ffa08090: LOAD R3 = 0x0
ffa08092: STORE [P1 + 0x3c] = R3 **
ffa08094: IF CC R7 = R2
ffa08096: CALL 0xffa0763c **
ffa0809a: CC = R7 == 0x0
ffa0809c: IF CC JUMP 0xffa080c6
ffa0809e: CC = R5 == 0x0
ffa080a0: IF CC JUMP 0xffa080c6
ffa080a2: LOAD R2 = [P4 + 0x6c]
ffa080a6: CC = R2 == 0x0
ffa080a8: LOAD P1 = [P4 + 0x6c]
ffa080ac: IF CC JUMP 0xffa080c6
ffa080ae: LOAD R0 = [P4 + 0x68]
ffa080b2: CC = R0 == 0x0
ffa080b4: IF CC JUMP 0xffa080d2
ffa080b6: STORE [SP + 0x10] = R4
ffa080b8: STORE [SP + 0xc] = R6
ffa080ba: SUB|| R1 = R1 - R1 (ns)
ffa080be: _STORE [SP + 0x14] = P5
ffa080c0: _NOP
ffa080c2: CALL 0xffa07394 **
ffa080c6: ADD SP += 0x18
ffa080c8: LOAD P0 = [FP + 0x4]
ffa080ca: POP (R7:4,P5:4) = [SP++]
ffa080cc: UNLINK
ffa080d0: JUMP (P0)
ffa080d2: MOVE R2 = P5
ffa080d4: MOVE R1 = R4
ffa080d6: MOVE R0 = R6
ffa080d8: CALL (P1) **
ffa080da: ADD SP += 0x18
ffa080dc: LOAD P0 = [FP + 0x4]
ffa080de: POP (R7:4,P5:4) = [SP++]
ffa080e0: UNLINK
ffa080e4: JUMP (P0)
ffa080e6: LOAD P1 = [P4]
ffa080e8: LOAD R2 = 0x3
ffa080ea: STORE [SP + 0x38] = R2
ffa080ec: LOAD R2 = 0x601
ffa080f0: LOAD R3 = W [P1] (X)
ffa080f2: EXTRACT|| R3 = extract(R3,R2.L) (z)
ffa080f6: LOAD P5 = [P4 + 0x8]
ffa080f8: NOP
ffa080fa: CC = R3 == 0x0
ffa080fc: LOAD R4 = 0x2
ffa080fe: LOAD R3 = [SP + 0x38]
ffa08100: LOAD R4.H = 0x3
ffa08104: LOAD R3.H = 0x3
ffa08108: IF CC R4 = R3
ffa0810a: JUMP.S 0xffa08096
ffa0810c: LOAD R1 = B [P4 + 0x46] (Z)
ffa08110: CC = R1 == 0x0
ffa08112: LOAD R2 = B [P4 + 0x45] (Z)
ffa08116: LOAD R1 = W [P5] (Z)
ffa08118: IF !CC JUMP 0xffa081b4
ffa0811a: CC = R2 == 0x0
ffa0811c: IF !CC JUMP 0xffa081a6
ffa0811e: CC = R1 == 0x0
ffa08120: STORE [P4 + 0x58] = R1 **
ffa08124: IF CC JUMP 0xffa081a0
ffa08126: LOAD R1 = [P4 + 0x60]
ffa0812a: CC = R1 == 0x0
ffa0812c: IF CC JUMP 0xffa0814e
ffa0812e: LOAD R2 = [P4 + 0x58]
ffa08132: CC = R2 == 0x0
ffa08134: IF CC JUMP 0xffa08198
ffa08136: LOAD P1 = [P4 + 0x5c]
ffa0813a: STORE W [P1] = R1.L
ffa0813c: LOAD R1 = [P4 + 0x64]
ffa08140: STORE [P4 + 0x5c] = R1 **
ffa08144: LOAD R1 = 0x0
ffa08146: STORE [P4 + 0x60] = R1 **
ffa0814a: STORE [P4 + 0x64] = R1 **
ffa0814e: LOAD P1 = [P4 + 0x58]
ffa08152: CC = P1 == 0x0
ffa08154: IF CC JUMP 0xffa08190
ffa08156: LOAD P0 = [P4 + 0x4]
ffa08158: MOVE R1 = P1
ffa0815a: STORE [P0] = P1 **
ffa0815c: LOAD P0 = [P4 + 0x8]
ffa0815e: LOAD R2 = W [P1 + 0x4] (X)
ffa08160: LSH|| R3 = R2 << 0x10
ffa08164: _LOAD R2 = W [P1 + 0x2] (Z)
ffa08166: _NOP
ffa08168: OR R2 = R3 | R2
ffa0816a: STORE [P0] = R2 **
ffa0816c: LOAD P0 = [P4 + 0xc]
ffa0816e: LOAD R2 = W [P1 + 0x8] (X)
ffa08170: STORE W [P0] = R2.L
ffa08172: LOAD P0 = [P4 + 0x14]
ffa08174: LOAD R2 = W [P1 + 0xa] (X)
ffa08176: STORE W [P0] = R2.L
ffa08178: LOAD P0 = [P4 + 0x10]
ffa0817a: LOAD R2 = W [P1 + 0xc] (X)
ffa0817c: STORE W [P0] = R2.L
ffa0817e: LOAD P0 = [P4 + 0x18]
ffa08180: LOAD R2 = W [P1 + 0xe] (X)
ffa08182: STORE W [P0] = R2.L
ffa08184: LOAD P0 = [P4]
ffa08186: LOAD R2 = W [P1 + 0x6] (X)
ffa08188: STORE W [P0] = R2.L
ffa0818a: LOAD R7 = W [P5 + 0x10] (Z)
ffa0818c: JUMP.S 0xffa08096
ffa08190: STORE [P4 + 0x40] = R7 **
ffa08194: LOAD R1 = 0x0
ffa08196: JUMP.S 0xffa0818a
ffa08198: STORE [P4 + 0x58] = R1 **
ffa0819c: JUMP.S 0xffa0813c
ffa081a0: STORE [P4 + 0x5c] = R1 **
ffa081a4: JUMP.S 0xffa08126
ffa081a6: MOVE R2 = P5
ffa081a8: LOAD R3 = -0x1
ffa081aa: LSHIFT R3 <<= 0x10
ffa081ac: AND R2 = R2 & R3
ffa081ae: OR R1 = R1 | R2
ffa081b0: MOVE P1 = R1
ffa081b2: JUMP.S 0xffa08152
ffa081b4: CC = R2 == 0x0
ffa081b6: IF !CC JUMP 0xffa081c6
ffa081b8: CC = R1 == 0x0
ffa081ba: STORE [P4 + 0x58] = R1 **
ffa081be: IF !CC JUMP 0xffa0818a (bp)
ffa081c0: STORE [P4 + 0x5c] = R1 **
ffa081c4: JUMP.S 0xffa0818a
ffa081c6: MOVE R2 = P5
ffa081c8: LSHIFT R3 <<= 0x10
ffa081ca: AND R2 = R2 & R3
ffa081cc: OR R1 = R1 | R2
ffa081ce: JUMP.S 0xffa0818a
ffa081d0: LOAD R1 = B [P4 + 0x46] (Z)
ffa081d4: CC = R1 == 0x0
ffa081d6: LOAD R1 = B [P4 + 0x45] (Z)
ffa081da: IF !CC JUMP 0xffa08276
ffa081dc: CC = R1 == 0x0
ffa081de: LOAD R1 = W [P5 + 0x2] (X)
ffa081e0: PACK R1 = pack(R1.L,R1.L)
ffa081e4: LOAD R1.L = W [P5]
ffa081e6: IF !CC JUMP 0xffa08272
ffa081e8: CC = R1 == 0x0
ffa081ea: STORE [P4 + 0x58] = R1 **
ffa081ee: IF CC JUMP 0xffa0826c
ffa081f0: LOAD R1 = [P4 + 0x60]
ffa081f4: CC = R1 == 0x0
ffa081f6: IF CC JUMP 0xffa0821e
ffa081f8: LOAD R2 = [P4 + 0x58]
ffa081fc: CC = R2 == 0x0
ffa081fe: IF CC JUMP 0xffa08264
ffa08200: LOAD P1 = [P4 + 0x5c]
ffa08204: PACK R2 = pack(R2.H,R1.H)
ffa08208: STORE W [P1 + 0x2] = R2
ffa0820a: STORE W [P1] = R1.L
ffa0820c: LOAD R1 = [P4 + 0x64]
ffa08210: STORE [P4 + 0x5c] = R1 **
ffa08214: LOAD R1 = 0x0
ffa08216: STORE [P4 + 0x60] = R1 **
ffa0821a: STORE [P4 + 0x64] = R1 **
ffa0821e: LOAD P1 = [P4 + 0x58]

######## FFA08CEA
ffa08cea: CLI R1
ffa08cec: LOAD P1.L = 0x1ad4
ffa08cf0: LOAD P1.H = 0xff80
ffa08cf4: LOAD R0 = [P1]
ffa08cf6: CC = R0 == 0x0
ffa08cf8: ADD R0 += 0x1
ffa08cfa: STORE [P1] = R0 **
ffa08cfc: LOAD P1.L = 0x7624
ffa08d00: LOAD P1.H = 0xff80
ffa08d04: IF !CC JUMP 0xffa08d08
ffa08d06: STORE [P1] = R1 **
ffa08d08: LOAD R0 = [P1]
ffa08d0a: RTS
ffa08d0c: LOAD P1.L = 0x1ad4
ffa08d10: LOAD P1.H = 0xff80
ffa08d14: LOAD R0 = [P1]
ffa08d16: ADD R0 += -0x1
ffa08d18: CC = R0 == 0x0
ffa08d1a: STORE [P1] = R0 **
ffa08d1c: IF !CC JUMP 0xffa08d2e
ffa08d1e: NOP
ffa08d20: NOP
ffa08d22: LOAD P1.L = 0x7624
ffa08d26: LOAD P1.H = 0xff80
ffa08d2a: LOAD R0 = [P1]
ffa08d2c: STI R0
ffa08d2e: RTS
ffa08d30: LINK 0xc
ffa08d34: LOAD P1.L = 0x1ad4
ffa08d38: LOAD P1.H = 0xff80
ffa08d3c: ROT|| R2 = rot R0 by 0
ffa08d40: _LOAD R0 = [P1]
ffa08d42: _NOP
ffa08d44: CC = R0 == 0x0
ffa08d46: LOAD P0.L = 0x7624
ffa08d4a: LOAD P0.H = 0xff80
ffa08d4e: IF CC JUMP 0xffa08d60
ffa08d50: LOAD R0 = [P0]
ffa08d52: OR R0 = R2 | R0
ffa08d54: STORE [P0] = R0 **
ffa08d56: LOAD P0 = [FP + 0x4]
ffa08d58: UNLINK
ffa08d5c: JUMP (P0)
ffa08d60: LOAD P1.L = 0x7628
ffa08d64: LOAD P1.H = 0xff80
ffa08d68: LOAD R0 = [P1]
ffa08d6a: CALL 0xffa08cea **
ffa08d6e: LOAD R1 = [P0]
ffa08d70: OR R1 = R2 | R1
ffa08d72: STORE [P0] = R1 **
ffa08d74: CALL 0xffa08d0c **
ffa08d78: LOAD P0 = [FP + 0x4]
ffa08d7a: UNLINK
ffa08d7e: JUMP (P0)
ffa08d80: LINK 0xc
ffa08d84: LOAD P1.L = 0x1ad4
ffa08d88: LOAD P1.H = 0xff80
ffa08d8c: LOAD R1 = [P1]
ffa08d8e: CC = R1 == 0x0
ffa08d90: LOAD P0.L = 0x7624
ffa08d94: LOAD P0.H = 0xff80
ffa08d98: IF CC JUMP 0xffa08dac
ffa08d9a: LOAD R1 = [P0]
ffa08d9c: NOT R0 = ~R0
ffa08d9e: AND R0 = R0 & R1
ffa08da0: STORE [P0] = R0 **
ffa08da2: LOAD P0 = [FP + 0x4]
ffa08da4: UNLINK
ffa08da8: JUMP (P0)
ffa08dac: LOAD P1.L = 0x7628
ffa08db0: LOAD P1.H = 0xff80
ffa08db4: NOT R2 = ~R0
ffa08db6: LOAD R0 = [P1]
ffa08db8: CALL 0xffa08cea **
ffa08dbc: LOAD R1 = [P0]
ffa08dbe: AND R1 = R2 & R1
ffa08dc0: STORE [P0] = R1 **
ffa08dc2: CALL 0xffa08d0c **
ffa08dc6: LOAD P0 = [FP + 0x4]
ffa08dc8: UNLINK
ffa08dcc: JUMP (P0)
ffa08dd0: LINK 0x0
ffa08dd4: PUSH [--SP] = (R7:4,P5:5)
ffa08dd6: MOVE R6 = R0
ffa08dd8: LSH R0 = R6 << 0x4
ffa08ddc: MOVE P1 = R0
ffa08dde: LOAD P5.L = 0x7628
ffa08de2: LOAD P5.H = 0xff80
ffa08de6: MOVE P0 = P5
ffa08de8: ADD SP += -0xc
ffa08dea: ADD P0 += 0x8
ffa08dec: ROT|| R7 = rot R1 by 0
ffa08df0: _LOAD R0 = [P5]
ffa08df2: _NOP
ffa08df4: ADD P2 = P0 + P1
ffa08df6: CALL 0xffa08cea **
ffa08dfa: ROT|| R3 = rot R0 by 0
ffa08dfe: _LOAD R5 = [P2]
ffa08e00: _NOP

######## FFA08D0C
ffa08d0c: LOAD P1.L = 0x1ad4
ffa08d10: LOAD P1.H = 0xff80
ffa08d14: LOAD R0 = [P1]
ffa08d16: ADD R0 += -0x1
ffa08d18: CC = R0 == 0x0
ffa08d1a: STORE [P1] = R0 **
ffa08d1c: IF !CC JUMP 0xffa08d2e
ffa08d1e: NOP
ffa08d20: NOP
ffa08d22: LOAD P1.L = 0x7624
ffa08d26: LOAD P1.H = 0xff80
ffa08d2a: LOAD R0 = [P1]
ffa08d2c: STI R0
ffa08d2e: RTS
ffa08d30: LINK 0xc
ffa08d34: LOAD P1.L = 0x1ad4
ffa08d38: LOAD P1.H = 0xff80
ffa08d3c: ROT|| R2 = rot R0 by 0
ffa08d40: _LOAD R0 = [P1]
ffa08d42: _NOP
ffa08d44: CC = R0 == 0x0
ffa08d46: LOAD P0.L = 0x7624
ffa08d4a: LOAD P0.H = 0xff80
ffa08d4e: IF CC JUMP 0xffa08d60
ffa08d50: LOAD R0 = [P0]
ffa08d52: OR R0 = R2 | R0
ffa08d54: STORE [P0] = R0 **
ffa08d56: LOAD P0 = [FP + 0x4]
ffa08d58: UNLINK
ffa08d5c: JUMP (P0)
ffa08d60: LOAD P1.L = 0x7628
ffa08d64: LOAD P1.H = 0xff80
ffa08d68: LOAD R0 = [P1]
ffa08d6a: CALL 0xffa08cea **
ffa08d6e: LOAD R1 = [P0]
ffa08d70: OR R1 = R2 | R1
ffa08d72: STORE [P0] = R1 **
ffa08d74: CALL 0xffa08d0c **
ffa08d78: LOAD P0 = [FP + 0x4]
ffa08d7a: UNLINK
ffa08d7e: JUMP (P0)
ffa08d80: LINK 0xc
ffa08d84: LOAD P1.L = 0x1ad4
ffa08d88: LOAD P1.H = 0xff80
ffa08d8c: LOAD R1 = [P1]
ffa08d8e: CC = R1 == 0x0
ffa08d90: LOAD P0.L = 0x7624
ffa08d94: LOAD P0.H = 0xff80
ffa08d98: IF CC JUMP 0xffa08dac
ffa08d9a: LOAD R1 = [P0]
ffa08d9c: NOT R0 = ~R0
ffa08d9e: AND R0 = R0 & R1
ffa08da0: STORE [P0] = R0 **
ffa08da2: LOAD P0 = [FP + 0x4]
ffa08da4: UNLINK
ffa08da8: JUMP (P0)
ffa08dac: LOAD P1.L = 0x7628
ffa08db0: LOAD P1.H = 0xff80
ffa08db4: NOT R2 = ~R0
ffa08db6: LOAD R0 = [P1]
ffa08db8: CALL 0xffa08cea **
ffa08dbc: LOAD R1 = [P0]
ffa08dbe: AND R1 = R2 & R1
ffa08dc0: STORE [P0] = R1 **
ffa08dc2: CALL 0xffa08d0c **
ffa08dc6: LOAD P0 = [FP + 0x4]
ffa08dc8: UNLINK
ffa08dcc: JUMP (P0)
ffa08dd0: LINK 0x0
ffa08dd4: PUSH [--SP] = (R7:4,P5:5)
ffa08dd6: MOVE R6 = R0
ffa08dd8: LSH R0 = R6 << 0x4
ffa08ddc: MOVE P1 = R0
ffa08dde: LOAD P5.L = 0x7628
ffa08de2: LOAD P5.H = 0xff80
ffa08de6: MOVE P0 = P5
ffa08de8: ADD SP += -0xc
ffa08dea: ADD P0 += 0x8
ffa08dec: ROT|| R7 = rot R1 by 0
ffa08df0: _LOAD R0 = [P5]
ffa08df2: _NOP
ffa08df4: ADD P2 = P0 + P1
ffa08df6: CALL 0xffa08cea **
ffa08dfa: ROT|| R3 = rot R0 by 0
ffa08dfe: _LOAD R5 = [P2]
ffa08e00: _NOP
ffa08e02: CC = R5 == 0x0
ffa08e04: LOAD R4 = [SP + 0x34]
ffa08e06: IF CC JUMP 0xffa08e82
ffa08e08: MOVE P1 = P2
ffa08e0a: LOAD P0 = -0x1
ffa08e0c: LSETUP (0xffa08e10,0xffa08e20) LC0 = P0
ffa08e10: CC = P1 == 0x0
ffa08e12: IF CC JUMP 0xffa08e7e
ffa08e14: NOP
ffa08e16: NOP
ffa08e18: NOP
ffa08e1a: LOAD R0 = [P1]
ffa08e1c: CC = R7 == R0
ffa08e1e: IF CC JUMP 0xffa08e24
ffa08e20: LOAD P1 = [P1 + 0xc]
ffa08e22: JUMP.S 0xffa08e0c
ffa08e24: LOAD R0 = [P1 + 0x4]
ffa08e26: CC = R2 == R0
ffa08e28: IF !CC JUMP 0xffa08e20 (bp)
ffa08e2a: LOAD R0 = [P1 + 0x8]
ffa08e2c: ADD R0 += 0x1
ffa08e2e: STORE [P1 + 0x8] = R0 **
ffa08e30: LOAD R0 = 0x1
ffa08e32: CC = R0 == 0x0
ffa08e34: LOAD R5 = 0x0
ffa08e36: IF !CC JUMP 0xffa08e66
ffa08e38: LOAD R0 = 0x4
ffa08e3a: PACK|| R5 = pack(R5.H,R0.L)
ffa08e3e: _LOAD P1 = [P5 + 0x4]
ffa08e40: _NOP
ffa08e42: LOAD R5.H = 0x5
ffa08e46: LOAD R0 = [P5 + 0x4]
ffa08e48: CC = R0 == 0x0
ffa08e4a: IF CC JUMP 0xffa08e66
ffa08e4c: NOP
ffa08e4e: NOP
ffa08e50: NOP
ffa08e52: LOAD R0 = [P1 + 0xc]
ffa08e54: STORE [P5 + 0x4] = R0 **
ffa08e56: STORE [P1] = R7 **
ffa08e58: STORE [P1 + 0x4] = R2 **
ffa08e5a: LOAD R0 = 0x1
ffa08e5c: STORE [P1 + 0x8] = R0 **
ffa08e5e: LOAD R0 = [P2 + 0xc]
ffa08e60: STORE [P1 + 0xc] = R0 **
ffa08e62: STORE [P2 + 0xc] = P1 **
ffa08e64: LOAD R5 = 0x0
ffa08e66: MOVE R0 = R3
ffa08e68: CALL 0xffa08d0c **
ffa08e6c: ADD SP += 0xc
ffa08e6e: ROT|| R0 = rot R5 by 0
ffa08e72: _LOAD P0 = [FP + 0x4]
ffa08e74: _NOP
ffa08e76: POP (R7:4,P5:5) = [SP++]
ffa08e78: UNLINK
ffa08e7c: JUMP (P0)
ffa08e7e: LOAD R0 = 0x0
ffa08e80: JUMP.S 0xffa08e32
