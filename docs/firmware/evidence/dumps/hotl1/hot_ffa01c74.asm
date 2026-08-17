ffa01c74: LINK 0x20
ffa01c78: MOVE R2 = R0
ffa01c7a: BITCLR (R0,0x1f)
ffa01c7c: PUSH [--SP] = (R7:4,P5:4)
ffa01c7e: CC = R0 == 0x0
ffa01c80: MOVE R4 = R1
ffa01c82: ADD SP += -0xc
ffa01c84: IF !CC JUMP 0xffa01cbc
ffa01c86: MOVE R0 = R4
ffa01c88: BITCLR (R0,0x1f)
ffa01c8a: CC = R0 == 0x0
ffa01c8c: LOAD R0 = 0x0
ffa01c8e: LOAD R0.H = 0x3f80
ffa01c92: IF CC JUMP 0xffa01cb2
ffa01c94: CC = !BITTST (R4,0x1f)
ffa01c96: LOAD R2 = 0x0
ffa01c98: LOAD R2.H = 0x7f80
ffa01c9c: MOVE R1 = CC
ffa01c9e: CC = R4 <= R2
ffa01ca0: LOAD R0 = 0x0
ffa01ca2: IF !CC R1 = R0
ffa01ca4: CC = R4 == 0x0
ffa01ca6: IF CC R1 = R4
ffa01ca8: CC = BITTST (R1,0x0)
ffa01caa: LOAD R3 = -0x1
ffa01cac: LOAD R3.H = 0x7f7f
ffa01cb0: IF !CC R0 = R3
ffa01cb2: ADD SP += 0xc
ffa01cb4: POP (R7:4,P5:4) = [SP++]
ffa01cb6: UNLINK
ffa01cba: RTS
ffa01cbc: LOAD R0 = -0x1
ffa01cbe: LSHIFT R0 <<= 0x17
ffa01cc0: MOVE R7 = R2
ffa01cc2: CC = R2 <= R0
ffa01cc4: LSH R1 = R2 >> 0x1f
ffa01cc8: LOAD R3 = 0x0
ffa01cca: BITTGL (R7,0x1f)
ffa01ccc: IF !CC R1 = R3
ffa01cce: CC = R7 == 0x0
ffa01cd0: IF CC R1 = R7
ffa01cd2: LOAD R0 = 0x0
ffa01cd4: CC = BITTST (R1,0x0)
ffa01cd6: STORE [SP + 0x34] = R0
ffa01cd8: IF !CC JUMP 0xffa01cf8
ffa01cda: MOVE R0 = R4
ffa01cdc: CALL 0xffa014dc
ffa01ce0: MOVE R6 = R0
ffa01ce2: CALL 0xffa01688
ffa01ce6: MOVE R1 = R4
ffa01ce8: CALL 0xffa01618
ffa01cec: LOAD R0 = 0x0
ffa01cee: IF !CC JUMP 0xffa01cb2 (bp)
ffa01cf0: LOAD R0 = 0x1
ffa01cf2: AND R0 = R6 & R0
ffa01cf4: STORE [SP + 0x34] = R0
ffa01cf6: MOVE R2 = R7
ffa01cf8: LOAD R6 = -0x1
ffa01cfa: STORE W [SP + 0x28] = R6
ffa01cfe: LOAD R0 = -0x7f81
ffa01d02: STORE W [SP + 0x2a] = R0
ffa01d06: MOVE R1 = FP
ffa01d08: ADD R1 += 0xc
ffa01d0a: STORE [SP + 0x2c] = R1
ffa01d0c: LOAD R3 = 0x0
ffa01d0e: LOAD R3.H = 0x3f00
ffa01d12: LOAD P4.L = 0x359c
ffa01d16: LOAD P4.H = 0xff80
ffa01d1a: LOAD R7 = [SP + 0x28]
ffa01d1c: AND R0 = R2 & R7
ffa01d1e: OR R3 = R0 | R3
ffa01d20: STORE [SP + 0x3c] = R3
ffa01d22: ASH R7 = R2 >>> 0x17
ffa01d26: LOAD R0 = [P4 + 0x24]
ffa01d28: LOAD R6 = 0x1
ffa01d2a: LOAD P0.L = 0x35e4
ffa01d2e: LOAD P0.H = 0xff80
ffa01d32: LOAD R1 = [SP + 0x3c]
ffa01d34: CALL 0xffa01630
ffa01d38: LOAD R2 = 0x9
ffa01d3a: IF CC R6 = R2
ffa01d3c: MOVE R0 = R6
ffa01d3e: ADD R0 += 0x4
ffa01d40: STORE [FP + -0x4] = R0
ffa01d42: LOAD P1 = [FP + -0x4]
ffa01d44: LOAD R3 = -0x7e
ffa01d48: LOAD R1 = -0x5713
ffa01d4c: ADD R2 = R7 + R3
ffa01d4e: ADD P1 = P4 + (P1 << 2)
ffa01d50: STORE [SP + 0x38] = R1
ffa01d52: LSHIFT R2 <<= 0x4
ffa01d54: LOAD R1 = [SP + 0x3c]
ffa01d56: LOAD R0 = [P1]
ffa01d58: STORE [SP + 0x30] = R2
ffa01d5a: CALL 0xffa01630
ffa01d5e: LOAD R2 = [FP + -0x4]
ffa01d60: IF CC R6 = R2
ffa01d62: MOVE R2 = R6
ffa01d64: ADD R2 += 0x2
ffa01d66: STORE [FP + -0x4] = R2
ffa01d68: LOAD P1 = [FP + -0x4]
ffa01d6a: LOAD R1 = [SP + 0x3c]
ffa01d6c: LOAD R5 = 0x3ee2
ffa01d70: LOAD R7 = 0x0
ffa01d72: ADD P1 = P4 + (P1 << 2)
ffa01d74: LOAD R0 = [P1]
ffa01d76: CALL 0xffa01630
ffa01d7a: LOAD R3 = [FP + -0x4]
ffa01d7c: IF CC R6 = R3
ffa01d7e: MOVE P1 = R6
ffa01d80: LOAD R0 = [SP + 0x3c]
ffa01d82: LOAD R5.H = 0x3d80
ffa01d86: LOAD R7.H = 0x4180
ffa01d8a: ADD P1 += 0x1
ffa01d8c: ADD P2 = P4 + (P1 << 2)
ffa01d8e: LOAD R2 = [P2]
ffa01d90: STORE [FP + -0x4] = R2
ffa01d92: LSHIFT P5 = P1 >> 1
ffa01d94: ADD P5 = P0 + (P5 << 2)
ffa01d96: LOAD R1 = [FP + -0x4]
ffa01d98: CALL 0xffa01714
ffa01d9c: LOAD R1 = [P5]
ffa01d9e: CALL 0xffa01714
ffa01da2: STORE [SP + 0x24] = R0
ffa01da4: LOAD R1 = [FP + -0x4]
ffa01da6: LOAD R0 = [SP + 0x3c]
ffa01da8: CALL 0xffa01716
ffa01dac: MOVE R1 = R0
ffa01dae: LOAD R0 = [SP + 0x24]
ffa01db0: CALL 0xffa01814
ffa01db4: LOAD R1 = 0x0
ffa01db6: BITSET (R1,0x1e)
ffa01db8: CALL 0xffa018f0
ffa01dbc: MOVE R1 = R0
ffa01dbe: STORE [FP + -0x4] = R0
ffa01dc0: CALL 0xffa018f0
ffa01dc4: STORE [SP + 0x3c] = R0
ffa01dc6: LOAD R1 = -0x1800
ffa01dca: LOAD R1.H = 0x3c4c
ffa01dce: CALL 0xffa018f0
ffa01dd2: LOAD R1 = -0x5556
ffa01dd6: LOAD R1.H = 0x3daa
ffa01dda: CALL 0xffa01716
ffa01dde: LOAD R1 = [SP + 0x3c]
ffa01de0: CALL 0xffa018f0
ffa01de4: LOAD R1 = [FP + -0x4]
ffa01de6: CALL 0xffa018f0
ffa01dea: LOAD R2 = -0x5713
ffa01dee: STORE W [SP + 0x3c] = R2
ffa01df2: STORE W [SP + 0x3e] = R5
ffa01df6: STORE [SP + 0x38] = R0
ffa01df8: PACK R5 = pack(R5.H,R7.L)
ffa01dfc: LOAD R1 = [SP + 0x3c]
ffa01dfe: CALL 0xffa018f0
ffa01e02: LOAD R1 = [SP + 0x38]
ffa01e04: CALL 0xffa01716
ffa01e08: STORE [SP + 0x38] = R0
ffa01e0a: LOAD R1 = [SP + 0x3c]
ffa01e0c: LOAD R0 = [FP + -0x4]
ffa01e0e: CALL 0xffa018f0
ffa01e12: LOAD R1 = [SP + 0x38]
ffa01e14: CALL 0xffa01716
ffa01e18: LOAD R1 = [FP + -0x4]
ffa01e1a: CALL 0xffa01716
ffa01e1e: LOAD R2 = [SP + 0x30]
ffa01e20: STORE [SP + 0x38] = R0
ffa01e22: SUB R0 = R2 - R6
ffa01e24: CALL 0xffa01688
ffa01e28: MOVE R1 = R5
ffa01e2a: CALL 0xffa018f0
ffa01e2e: STORE [SP + 0x30] = R0
ffa01e30: MOVE R1 = R4
ffa01e32: MOVE R6 = R0
ffa01e34: MOVE R0 = R7
ffa01e36: CALL 0xffa018f0
ffa01e3a: MOVE R1 = FP
ffa01e3c: ADD R1 += 0x10
ffa01e3e: CALL 0xffa01bbc
ffa01e42: MOVE R1 = R5
ffa01e44: LOAD R0 = [FP + 0x10]
ffa01e46: CALL 0xffa018f0
ffa01e4a: STORE [FP + 0x10] = R0
ffa01e4c: MOVE R1 = R0
ffa01e4e: MOVE R0 = R4
ffa01e50: CALL 0xffa01714
ffa01e54: MOVE R1 = R6
ffa01e56: CALL 0xffa018f0
ffa01e5a: MOVE R6 = R0
ffa01e5c: MOVE R0 = R4
ffa01e5e: LOAD R1 = [SP + 0x38]
ffa01e60: CALL 0xffa018f0
ffa01e64: MOVE R1 = R6
ffa01e66: CALL 0xffa01716
ffa01e6a: MOVE R1 = R7
ffa01e6c: STORE [FP + 0x8] = R0
ffa01e6e: CALL 0xffa018f0
ffa01e72: LOAD R1 = [SP + 0x2c]
ffa01e74: CALL 0xffa01bbc
ffa01e78: MOVE R0 = R5
ffa01e7a: LOAD R1 = [FP + 0xc]
ffa01e7c: CALL 0xffa018f0
ffa01e80: STORE [FP + 0xc] = R0
ffa01e82: MOVE R1 = R0
ffa01e84: MOVE R6 = R0
ffa01e86: LOAD R0 = [FP + 0x8]
ffa01e88: CALL 0xffa01714
ffa01e8c: MOVE R4 = R0
ffa01e8e: LOAD R1 = [FP + 0x10]
ffa01e90: LOAD R0 = [SP + 0x30]
ffa01e92: CALL 0xffa018f0
ffa01e96: MOVE R1 = R6
ffa01e98: CALL 0xffa01716
ffa01e9c: MOVE R1 = R7
ffa01e9e: STORE [FP + 0x8] = R0
ffa01ea0: CALL 0xffa018f0
ffa01ea4: LOAD R1 = [SP + 0x2c]
ffa01ea6: CALL 0xffa01bbc
ffa01eaa: MOVE R1 = R5
ffa01eac: LOAD R0 = [FP + 0xc]
ffa01eae: CALL 0xffa018f0
ffa01eb2: STORE [FP + 0xc] = R0
ffa01eb4: MOVE R1 = R0
ffa01eb6: LOAD R0 = [FP + 0x8]
ffa01eb8: CALL 0xffa01714
ffa01ebc: MOVE R1 = R4
ffa01ebe: CALL 0xffa01716
ffa01ec2: MOVE R1 = R7
ffa01ec4: MOVE R4 = R0
ffa01ec6: CALL 0xffa018f0
ffa01eca: MOVE R1 = FP
ffa01ecc: ADD R1 += 0x8
ffa01ece: CALL 0xffa01bbc
ffa01ed2: MOVE R0 = R5
ffa01ed4: LOAD R1 = [FP + 0x8]
ffa01ed6: CALL 0xffa018f0
ffa01eda: LOAD R1 = [FP + 0xc]
ffa01edc: MOVE R6 = R0
ffa01ede: CALL 0xffa01716
ffa01ee2: MOVE R1 = R7
ffa01ee4: CALL 0xffa018f0
ffa01ee8: CALL 0xffa014dc
ffa01eec: MOVE R7 = R0
ffa01eee: MOVE R1 = R6
ffa01ef0: MOVE R0 = R4
ffa01ef2: CALL 0xffa01714
ffa01ef6: LOAD R1 = 0x7fe
ffa01efa: CC = R1 < R7
ffa01efc: IF !CC JUMP 0xffa01f10
ffa01efe: LOAD R2 = [SP + 0x34]
ffa01f00: LOAD R1 = -0x1
ffa01f02: CC = R2 == 0x1
ffa01f04: BITCLR (R1,0x17)
ffa01f06: LOAD R0 = -0x1
ffa01f08: LOAD R0.H = 0x7f7f
ffa01f0c: IF CC R0 = R1
ffa01f0e: JUMP.S 0xffa01cb2
ffa01f10: CC = !BITTST (R0,0x1f)
ffa01f12: LOAD R2 = 0x0
ffa01f14: LOAD R2.H = 0x7f80
ffa01f18: MOVE R1 = CC
ffa01f1a: CC = R0 <= R2
ffa01f1c: LOAD R6 = 0x0
ffa01f1e: IF !CC R1 = R6
ffa01f20: CC = R0 == 0x0
ffa01f22: IF CC R1 = R0
ffa01f24: CC = BITTST (R1,0x0)
ffa01f26: MOVE R4 = R0
ffa01f28: IF !CC JUMP 0xffa01f34
ffa01f2a: MOVE R1 = R5
ffa01f2c: CALL 0xffa01714
ffa01f30: ADD R7 += 0x1
ffa01f32: MOVE R4 = R0
ffa01f34: LOAD R0 = -0x7df
ffa01f38: CC = R7 < R0
ffa01f3a: LOAD R0 = 0x0
ffa01f3c: IF !CC JUMP 0xffa01f40 (bp)
ffa01f3e: JUMP.S 0xffa01cb2
ffa01f40: ASH R0 = R7 >>> 0x1f
ffa01f44: LSHIFT R0 >>= 0x1c
ffa01f46: ADD R3 = R7 + R0
ffa01f48: ASHIFT R3 >>>= 0x4
ffa01f4a: MOVE R2 = R3
ffa01f4c: CC = R7 < 0x0
ffa01f4e: ADD R3 += 0x1
ffa01f50: IF CC R3 = R2
ffa01f52: MOVE R6 = R3
ffa01f54: LSHIFT R3 <<= 0x4
ffa01f56: MOVE R1 = R4
ffa01f58: LOAD R0 = 0x1518
ffa01f5c: LOAD R0.H = 0x3aab
ffa01f60: SUB R7 = R3 - R7
ffa01f62: CALL 0xffa018f0
ffa01f66: LOAD R1 = -0x72b5
ffa01f6a: LOAD R1.H = 0x3c1d
ffa01f6e: CALL 0xffa01716
ffa01f72: MOVE R1 = R4
ffa01f74: CALL 0xffa018f0
ffa01f78: LOAD R1 = 0x5837
ffa01f7c: LOAD R1.H = 0x3d63
ffa01f80: CALL 0xffa01716
ffa01f84: MOVE R1 = R4
ffa01f86: CALL 0xffa018f0
ffa01f8a: ADD R7 += 0x1
ffa01f8c: LOAD R1 = -0x210
ffa01f90: LOAD R1.H = 0x3e75
ffa01f94: MOVE P5 = R7
ffa01f96: CALL 0xffa01716
ffa01f9a: MOVE R1 = R4
ffa01f9c: CALL 0xffa018f0
ffa01fa0: LOAD R1 = 0x7218
ffa01fa4: LOAD R1.H = 0x3f31
ffa01fa8: CALL 0xffa01716
ffa01fac: ADD P5 = P4 + (P5 << 2)
ffa01fae: MOVE R1 = R4
ffa01fb0: CALL 0xffa018f0
ffa01fb4: LOAD R7 = [P5]
ffa01fb6: MOVE R1 = R7
ffa01fb8: CALL 0xffa018f0
ffa01fbc: MOVE R1 = R7
ffa01fbe: CALL 0xffa01716
ffa01fc2: LOAD R5 = 0x1708
ffa01fc6: EXTRACT R1 = extract(R0,R5.L) (z)
ffa01fca: LOAD R2 = [SP + 0x28]
ffa01fcc: LOAD R5.H = 0xff81
