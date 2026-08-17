ffa03c8a: LINK 0xa0
ffa03c8e: PUSH [--SP] = (R7:4,P5:3)
ffa03c90: ADD SP += -0xc
ffa03c92: STORE [SP + 0x30] = R2
ffa03c94: LOAD R3 = 0x5cfc
ffa03c98: LOAD R2 = [FP + 0x28]
ffa03c9a: MULT|| R2 = R2.L * R3.L (is)
ffa03c9e: LOAD P2 = [FP + 0x18]
ffa03ca0: NOP
ffa03ca2: STORE [SP + 0x3c] = P2
ffa03ca4: MOVE P1 = R2
ffa03ca6: LOAD P2 = [FP + 0x30]
ffa03ca8: LOAD P0 = [FP + 0x14]
ffa03caa: STORE [FP + -0x40] = P0
ffa03cac: LOAD P0 = 0x578
ffa03cb0: ADD P0 = P2 + P0
ffa03cb2: ADD P0 = P0 + P1
ffa03cb4: STORE [FP + -0x5c] = R1
ffa03cb6: STORE [SP + 0x34] = R0
ffa03cb8: LOAD R0 = [P0 + 0x5cc4]
ffa03cbc: LOAD R1 = 0xfdb
ffa03cc0: LOAD R1.H = 0x4249
ffa03cc4: CALL 0xffa01814
ffa03cc8: CALL 0xffa028c8
ffa03ccc: LOAD R3 = 0x40c9
ffa03cd0: LOAD R2 = 0xfdb
ffa03cd4: STORE W [SP + 0x3a] = R3
ffa03cd8: STORE W [SP + 0x38] = R2
ffa03cdc: LOAD P3 = -0x143c
ffa03ce0: LOAD P3.H = 0x4
ffa03ce4: ADD P2 = P2 + P3
ffa03ce6: LOAD P3 = [FP + 0x34]
ffa03ce8: STORE [SP + 0x40] = R0
ffa03cec: LOAD R0 = [P0 + 0x38]
ffa03cee: MOVE P5 = FP
ffa03cf0: ADD P5 += -0x18
ffa03cf2: LOAD R1 = [SP + 0x38]
ffa03cf4: CALL 0xffa01814
ffa03cf8: CALL 0xffa028c8
ffa03cfc: LOAD R1 = W [P3 + 0x2] (Z)
ffa03cfe: STORE [SP + 0x48] = R0
ffa03d02: CALL 0xffa00fb4
ffa03d06: LOAD R1 = W [P3 + 0x4] (Z)
ffa03d08: LOAD R2 = [P2]
ffa03d0a: STORE [SP + 0x44] = R0
ffa03d0e: LOAD P3 = [FP + 0x20]
ffa03d10: LOAD R0 = 0x1
ffa03d12: STORE [FP + -0x78] = R2
ffa03d14: CALL 0xffa05ee4
ffa03d18: LOAD P1 = 0x3
ffa03d1a: STORE [FP + -0x7c] = R0
ffa03d1c: LOAD P4 = 0x14
ffa03d1e: LSETUP (0xffa03d22,0xffa03d3c) LC0 = P1
ffa03d22: LOAD R0 = [P3++]
ffa03d24: CALL 0xffa028c8
ffa03d28: ASH|| R7 = R0 >>> 0x5
ffa03d2c: _LOAD R0 = [P3 ++ P4]
ffa03d2e: _NOP
ffa03d30: CALL 0xffa028c8
ffa03d34: ASH|| R0 = R0 >>> 0x5
ffa03d38: _STORE [P5++] = R7
ffa03d3a: _NOP
ffa03d3c: STORE [P5++] = R0
ffa03d3e: LOAD R3 = [SP + 0x48]
ffa03d42: LOAD R0 = 0x0
ffa03d44: LOAD R1 = 0x0
ffa03d46: LOAD R2 = 0x0
ffa03d48: CC = R3 <= 0x0
ffa03d4a: STORE [FP + -0x6c] = R0
ffa03d4c: STORE [FP + -0x74] = R1
ffa03d4e: STORE [FP + -0x48] = R2
ffa03d50: LOAD R6 = 0x0
ffa03d52: LOAD R7 = 0x0
ffa03d54: LOAD R4 = 0x0
ffa03d56: LOAD R5 = 0x0
ffa03d58: IF !CC JUMP 0xffa03d5c (bp)
ffa03d5a: JUMP.S 0xffa042de
ffa03d5c: LOAD R3 = 0x0
ffa03d5e: STORE [SP + 0x28] = R0
ffa03d60: STORE [FP + -0x34] = R1
ffa03d62: STORE [FP + -0x50] = R2
ffa03d64: STORE [FP + -0x4c] = R3
ffa03d66: LOAD R0 = [FP + -0x6c]
ffa03d68: ASH|| R0 = R0 >>> 0x3
ffa03d6c: _LOAD R1 = [FP + -0x7c]
ffa03d6e: _NOP
ffa03d70: STORE [FP + -0x68] = R1
ffa03d72: CALL 0xffa07194
ffa03d76: LOAD R2 = [SP + 0x40]
ffa03d7a: MAC|| A1 = R2.L * R0.L (fu)
ffa03d7e: LOAD R4 = [FP + -0x7c]
ffa03d80: NOP
ffa03d82: LSH A1 = A1 >> 0x10
ffa03d86: LOAD R3 = W [SP + 0x42] (Z)
ffa03d8a: MAC A1 += R3.L * R0.L (m),A0 = R3.L * R0.H 
ffa03d8e: MAC A1 += R0.H * R2.L (m)
ffa03d92: ASH A1 = A1 >>> 0xf
ffa03d96: MOVE R1 = (A0 += A1)
ffa03d9a: CC = R4 < R0
ffa03d9c: ROT|| R1 = rot R0 by 0
ffa03da0: _STORE [FP + -0x74] = R1
ffa03da2: _NOP
ffa03da4: IF !CC JUMP 0xffa03da8 (bp)
ffa03da6: JUMP.S 0xffa043ba
ffa03da8: LOAD R2 = -0x1
ffa03daa: LSHIFT R2 >>= 0x1
ffa03dac: LOAD R3 = [FP + -0x68]
ffa03dae: SUB|| R2 = R2 - R3 (ns)
ffa03db2: _LOAD R3 = [FP + -0x50]
ffa03db4: _NOP
ffa03db6: CC = R2 < 0x0
ffa03db8: STORE [SP + 0x2c] = R3
ffa03dba: STORE [FP + -0x70] = R2
ffa03dbc: LOAD R0 = [SP + 0x28]
ffa03dbe: LOAD R4 = [FP + -0x34]
ffa03dc0: LOAD R1 = [FP + -0x4c]
ffa03dc2: IF !CC JUMP 0xffa03dc6 (bp)
ffa03dc4: JUMP.S 0xffa042b0
ffa03dc6: LOAD R0 = 0x0
ffa03dc8: BITSET (R0,0x1d)
ffa03dca: LOAD R1 = 0x0
ffa03dcc: LOAD R2 = [SP + 0x28]
ffa03dce: STORE [FP + -0x58] = R5
ffa03dd0: STORE [FP + -0x54] = R6
ffa03dd2: STORE [SP + 0x2c] = R7
ffa03dd4: STORE [FP + 0x24] = R0
ffa03dd6: STORE [FP + -0x44] = R1
ffa03dd8: STORE [FP + -0x38] = R2
ffa03dda: LOAD R3 = -0x5556
ffa03dde: LSH|| R2.L = R3.L << 0x0
ffa03de2: LOAD R6 = [FP + 0x24]
ffa03de4: NOP
ffa03de6: LOAD R2.H = 0x2aaa
ffa03dea: LOAD R0 = 0x5554
ffa03dee: ADD R2 = R6 + R2
ffa03df0: LSH|| R1.L = R0.L << 0x0
ffa03df4: STORE [FP + 0xc] = R2
ffa03df6: NOP
ffa03df8: LOAD R1.H = 0x5555
ffa03dfc: ASH R0 = R6 >>> 0x3
ffa03e00: ADD|| R4 = R6 + R1 (ns)
ffa03e04: _LOAD R6 = [FP + -0x74]
ffa03e06: _NOP
ffa03e08: CALL 0xffa07194
ffa03e0c: MOVE R7 = R0
ffa03e0e: ASH R0 = R4 >>> 0x3
ffa03e12: CALL 0xffa07194
ffa03e16: LOAD R1 = [FP + 0xc]
ffa03e18: ASH|| R0 = R1 >>> 0x3
ffa03e1c: _STORE [FP + 0x10] = R0
ffa03e1e: _NOP
ffa03e20: CALL 0xffa07194
ffa03e24: MAC A1 = R6.L * R7.L (fu)
ffa03e28: LSH A1 = A1 >> 0x10
ffa03e2c: LOAD R4 = W [SP + 0x56] (Z)
ffa03e30: MAC A1 += R4.L * R7.L (m),A0 = R4.L * R7.H 
ffa03e34: MAC A1 += R7.H * R6.L (m)
ffa03e38: ASH A1 = A1 >>> 0xf
ffa03e3c: MOVE R1 = (A0 += A1)
ffa03e40: LOAD R5 = 0x0
ffa03e42: ROT|| R7 = rot R0 by 0
ffa03e46: _STORE [FP + 0x8] = R1
ffa03e48: _NOP
ffa03e4a: BITSET (R5,0x1a)
ffa03e4c: SUB R0 = R5 - R1
ffa03e4e: CALL 0xffa07194
ffa03e52: ASH|| R2 = R0 >>> 0x3
ffa03e56: _LOAD R0 = [FP + 0x8]
ffa03e58: _NOP
ffa03e5a: STORE [FP + -0x30] = R2
ffa03e5c: STORE [FP + 0xc] = R2
ffa03e5e: CALL 0xffa07194
ffa03e62: ASH|| R3 = R0 >>> 0x3
ffa03e66: _LOAD R1 = [FP + 0x10]
ffa03e68: _NOP
ffa03e6a: MAC|| A1 = R6.L * R1.L (fu)
ffa03e6e: LOAD R2 = W [FP + 0x12] (Z)
ffa03e70: NOP
ffa03e72: LSH|| A1 = A1 >> 0x10
ffa03e76: STORE [FP + -0x2c] = R3
ffa03e78: NOP
ffa03e7a: MAC|| A1 += R4.L * R1.L (m),A0 = R4.L * R1.H 
ffa03e7e: STORE [FP + 0x10] = R3
ffa03e80: NOP
ffa03e82: MAC A1 += R2.L * R6.L (m)
ffa03e86: ASH A1 = A1 >>> 0xf
ffa03e8a: MOVE R1 = (A0 += A1)
ffa03e8e: SUB|| R0 = R5 - R1 (ns)
ffa03e92: _STORE [FP + 0x8] = R1
ffa03e94: _NOP
ffa03e96: CALL 0xffa07194
ffa03e9a: ASH R2 = R0 >>> 0x3
ffa03e9e: STORE [FP + -0x28] = R2
ffa03ea0: LOAD R0 = [FP + 0x8]
ffa03ea2: CALL 0xffa07194
ffa03ea6: MAC A1 = R6.L * R7.L (fu)
ffa03eaa: LSH A1 = A1 >> 0x10
ffa03eae: MAC A1 += R4.L * R7.L (m),A0 = R4.L * R7.H 
ffa03eb2: MAC A1 += R7.H * R6.L (m)
ffa03eb6: ASH A1 = A1 >>> 0xf
ffa03eba: MOVE R7 = (A0 += A1)
ffa03ebe: ASH R1 = R0 >>> 0x3
ffa03ec2: SUB|| R0 = R5 - R7 (ns)
ffa03ec6: _STORE [FP + -0x24] = R1
ffa03ec8: _NOP
ffa03eca: CALL 0xffa07194
ffa03ece: MOVE P5 = FP
ffa03ed0: ASH R2 = R0 >>> 0x3
ffa03ed4: ADD P5 += -0x30
ffa03ed6: ROT|| R0 = rot R7 by 0
ffa03eda: _STORE [FP + -0x20] = R2
ffa03edc: _NOP
ffa03ede: MOVE P4 = P5
ffa03ee0: CALL 0xffa07194
ffa03ee4: ADD P5 += 0x18
ffa03ee6: MOVE P3 = P4
ffa03ee8: MOVE I0 = P5
ffa03eea: ASH|| R0 = R0 >>> 0x3
ffa03eee: _LOAD R2 = [P3++]
ffa03ef0: _LOAD R3 = [I0++]
ffa03ef2: MAC|| A1 = R2.L * R3.L (fu)
ffa03ef6: LOAD R7 = [P3++]
ffa03ef8: LOAD R1 = [I0++]
ffa03efa: LSH|| A1 = A1 >> 0x10
ffa03efe: STORE [FP + -0x1c] = R0
ffa03f00: NOP
ffa03f02: MAC A1 += R2.H * R3.L (m),A0 = R2.H * R3.H 
ffa03f06: MAC A1 += R3.H * R2.L (m)
ffa03f0a: ASH A1 = A1 >>> 0xf
ffa03f0e: MOVE R6 = (A0 += A1)
ffa03f12: MAC A1 = R7.L * R1.L (fu)
ffa03f16: LSH A1 = A1 >> 0x10
ffa03f1a: MAC A1 += R7.H * R1.L (m),A0 = R7.H * R1.H 
ffa03f1e: MAC A1 += R1.H * R7.L (m)
ffa03f22: ASH A1 = A1 >>> 0xf
ffa03f26: MOVE R0 = (A0 += A1)
ffa03f2a: MAC A1 = R2.L * R1.L (fu)
ffa03f2e: LSH A1 = A1 >> 0x10
ffa03f32: MAC A1 += R2.H * R1.L (m),A0 = R2.H * R1.H 
ffa03f36: MAC A1 += R1.H * R2.L (m)
ffa03f3a: ASH A1 = A1 >>> 0xf
ffa03f3e: MOVE R5 = (A0 += A1)
ffa03f42: MAC A1 = R7.L * R3.L (fu)
ffa03f46: LSH A1 = A1 >> 0x10
ffa03f4a: MAC A1 += R7.H * R3.L (m),A0 = R7.H * R3.H 
ffa03f4e: MAC A1 += R3.H * R7.L (m)
ffa03f52: ASH A1 = A1 >>> 0xf
ffa03f56: MOVE R3 = (A0 += A1)
ffa03f5a: LOAD P1 = 0x2
ffa03f5c: SUB R0 = R6 - R0
ffa03f5e: ADD R5 = R5 + R3
ffa03f60: LOAD R2 = 0x0
ffa03f62: LOAD R1 = 0x0
ffa03f64: LSETUP (0xffa03f68,0xffa03fe4) LC0 = P1
ffa03f68: ADD|| R2 = R2 + R5 (ns)
ffa03f6c: _LOAD R7 = [P3++]
ffa03f6e: _LOAD R6 = [I0++]
ffa03f70: MAC|| A1 = R7.L * R6.L (fu)
ffa03f74: LOAD R5 = [P3++]
ffa03f76: LOAD R3 = [I0++]
ffa03f78: LSH|| A1 = A1 >> 0x10
ffa03f7c: LOAD R4 = [FP + -0x50]
ffa03f7e: NOP
ffa03f80: MAC A1 += R7.H * R6.L (m),A0 = R7.H * R6.H 
ffa03f84: MAC A1 += R6.H * R7.L (m)
ffa03f88: ASH A1 = A1 >>> 0xf
ffa03f8c: ADD R1 = R1 + R0
ffa03f8e: MOVE R0 = (A0 += A1)
ffa03f92: MAC|| A1 = R5.L * R3.L (fu)
ffa03f96: STORE [FP + 0x8] = R0
ffa03f98: NOP
ffa03f9a: LSH A1 = A1 >> 0x10
ffa03f9e: MAC A1 += R5.H * R3.L (m),A0 = R5.H * R3.H 
ffa03fa2: MAC A1 += R3.H * R5.L (m)
ffa03fa6: ASH A1 = A1 >>> 0xf
ffa03faa: MOVE R0 = (A0 += A1)
ffa03fae: MAC A1 = R7.L * R3.L (fu)
ffa03fb2: LSH A1 = A1 >> 0x10
ffa03fb6: MAC A1 += R7.H * R3.L (m),A0 = R7.H * R3.H 
ffa03fba: MAC|| A1 += R3.H * R7.L (m)
ffa03fbe: LOAD R3 = [FP + 0x8]
ffa03fc0: NOP
ffa03fc2: ASH A1 = A1 >>> 0xf
ffa03fc6: MOVE R7 = (A0 += A1)
ffa03fca: MAC A1 = R5.L * R6.L (fu)
ffa03fce: LSH A1 = A1 >> 0x10
ffa03fd2: MAC A1 += R5.H * R6.L (m),A0 = R5.H * R6.H 
ffa03fd6: MAC A1 += R6.H * R5.L (m)
ffa03fda: ASH A1 = A1 >>> 0xf
ffa03fde: MOVE R6 = (A0 += A1)
ffa03fe2: SUB R0 = R3 - R0
ffa03fe4: ADD R5 = R7 + R6
ffa03fe6: ADD|| R0 = R1 + R0 (ns)
ffa03fea: _LOAD P3 = [FP + -0x40]
ffa03fec: _NOP
ffa03fee: ADD R2 = R2 + R5
ffa03ff0: MAC R1 = (A1 = R0.L * R0.L) (fu)
ffa03ff4: LSH A1 = A1 >> 0x10
ffa03ff8: MAC A1 += R0.H * R0.L (m,is)
ffa03ffc: MAC A1 += R0.H * R0.L (m,is)
ffa04000: MOVE R3 = A1.W
ffa04002: ASH A1 = A1 >>> 0x10
ffa04006: MAC R5 = (A1 += R0.H * R0.H) (is)
ffa0400a: MAC R7 = (A1 = R2.L * R2.L) (fu)
ffa0400e: LSH A1 = A1 >> 0x10
ffa04012: MAC A1 += R2.H * R2.L (m,is)
ffa04016: MAC A1 += R2.H * R2.L (m,is)
ffa0401a: MOVE R6 = A1.W
ffa0401c: ASH A1 = A1 >>> 0x10
ffa04020: PACK R1 = pack(R3.L,R1.L)
ffa04024: MAC R3 = (A1 += R2.H * R2.H) (is)
ffa04028: PACK R0 = pack(R6.L,R7.L)
ffa0402c: ADD R0 = R1 + R0
ffa0402e: MOVE CC = ac0
ffa04030: MOVE R1 = CC
ffa04032: ADD|| R1 = R5 + R1 (ns)
ffa04036: _STORE [FP + -0x3c] = R0
ffa04038: _NOP
ffa0403a: ADD|| R1 = R1 + R3 (ns)
ffa0403e: _LOAD R5 = [FP + -0x38]
ffa04040: _NOP
ffa04042: LSH|| R7 = R0 >> 0xc
ffa04046: _STORE [FP + 0x2c] = R1
ffa04048: _NOP
ffa0404a: LSH|| R2 = R1 << 0x14
ffa0404e: _LOAD R0 = [FP + -0x48]
ffa04050: _NOP
ffa04052: OR R2 = R2 | R7
ffa04054: ASH|| R6 = R1 >>> 0xc
ffa04058: _LOAD R7 = [FP + -0x4c]
ffa0405a: _NOP
ffa0405c: ADD|| R2 = R4 + R2 (ns)
ffa04060: _LOAD R4 = [FP + -0x3c]
ffa04062: _NOP
ffa04064: MOVE CC = ac0
ffa04066: MOVE R1 = CC
ffa04068: ADD|| R1 = R7 + R1 (ns)
ffa0406c: _STORE [FP + -0x50] = R2
ffa0406e: _NOP
ffa04070: ADD R0 += 0x1
ffa04072: CC = R5 < R4 (IU)
ffa04074: ADD|| R1 = R1 + R6 (ns)
ffa04078: _LOAD R3 = [FP + -0x34]
ffa0407a: _NOP
ffa0407c: LOAD R2 = [FP + 0x2c]
ffa0407e: SUB|| R0 = R3 - R2 (s)
ffa04082: STORE [FP + -0x48] = R0
ffa04084: NOP
ffa04086: MOVE CC &= az
ffa04088: MOVE CC |= an
ffa0408a: STORE [FP + -0x4c] = R1
ffa0408c: LOAD R7 = [SP + 0x2c]
ffa0408e: IF !CC JUMP 0xffa0422a
ffa04090: LOAD R0 = [FP + -0x5c]
ffa04092: CC = R0 == 0x0
ffa04094: IF CC JUMP 0xffa0422a
ffa04096: LOAD R1 = [FP + 0xc]
ffa04098: LOAD R0 = 0x0
ffa0409a: LSH R4 = R1 << 0x3
ffa0409e: PACK|| R6 = pack(R6.H,R0.L)
ffa040a2: _LOAD R2 = [FP + 0x10]
ffa040a4: _NOP
ffa040a6: MOVE R0 = R4
ffa040a8: LSH R5 = R2 << 0x3
ffa040ac: CALL 0xffa02894
ffa040b0: MOVE R7 = R0
ffa040b2: MOVE R0 = R5
ffa040b4: CALL 0xffa02894
ffa040b8: LOAD P1 = [FP + -0x40]
ffa040ba: ROT|| R0 = rot R7 by 0
ffa040be: _STORE [FP + 0xc] = R0
ffa040c0: _NOP
ffa040c2: MOVE P5 = FP
ffa040c4: ADD P3 += 0x8
ffa040c6: LOAD R1 = [P1]
ffa040c8: CALL 0xffa018f0
ffa040cc: ROT|| R7 = rot R0 by 0
ffa040d0: _LOAD P0 = [FP + -0x40]
ffa040d2: _NOP
ffa040d4: LOAD R0 = [FP + 0xc]
ffa040d6: ADD P5 += -0x28
ffa040d8: LOAD R6.H = 0x3f80
ffa040dc: LOAD R1 = [P0 + 0x4]
ffa040de: CALL 0xffa018f0
ffa040e2: MOVE R1 = R7
ffa040e4: CALL 0xffa01716
ffa040e8: ROT|| R0 = rot R4 by 0
ffa040ec: _STORE [FP + -0x60] = R0
ffa040ee: _NOP
ffa040f0: CALL 0xffa02894
ffa040f4: MOVE R7 = R0
ffa040f6: MOVE R0 = R5
ffa040f8: CALL 0xffa02894
ffa040fc: ROT|| R5 = rot R0 by 0
ffa04100: _LOAD P0 = [FP + -0x40]
ffa04102: _NOP
ffa04104: BITTGL (R7,0x1f)
ffa04106: MOVE R1 = R7
ffa04108: LOAD R0 = [P0 + 0x4]
ffa0410a: CALL 0xffa018f0
ffa0410e: ROT|| R7 = rot R0 by 0
ffa04112: _LOAD P1 = [FP + -0x40]
ffa04114: _NOP
ffa04116: MOVE R1 = R5
ffa04118: LOAD R0 = [P1]
ffa0411a: CALL 0xffa018f0
ffa0411e: MOVE R1 = R7
ffa04120: CALL 0xffa01716
ffa04124: STORE [FP + -0x64] = R0
ffa04126: LOAD R1 = 0x2
ffa04128: ROT|| R5 = rot R6 by 0
ffa0412c: _LOAD R2 = [P5++]
ffa0412e: _NOP
ffa04130: LSH|| R4 = R2 << 0x3
ffa04134: _LOAD R3 = [P5++]
ffa04136: _NOP
ffa04138: LSHIFT R3 <<= 0x3
ffa0413a: LOAD R0 = 0xff
ffa0413e: LSH|| R0 = R0 << 0x17
ffa04142: _STORE [FP + 0xc] = R3
ffa04144: _NOP
ffa04146: ROT|| R0 = rot R4 by 0
ffa0414a: _STORE [FP + 0x8] = R0
ffa0414c: _NOP
ffa0414e: ADD R1 += -0x1
ffa04150: STORE [FP + 0x10] = R1
ffa04152: CALL 0xffa02894
ffa04156: ROT|| R7 = rot R0 by 0
ffa0415a: _LOAD R0 = [FP + 0xc]
ffa0415c: _NOP
ffa0415e: CALL 0xffa02894
ffa04162: MOVE R1 = R7
ffa04164: ROT|| R7 = rot R0 by 0
ffa04168: _LOAD R0 = [P3++]
ffa0416a: _NOP
ffa0416c: CALL 0xffa018f0
ffa04170: ROT|| R0 = rot R7 by 0
ffa04174: _STORE [FP + 0x1c] = R0
ffa04176: _NOP
ffa04178: LOAD R1 = [P3]
ffa0417a: CALL 0xffa018f0
ffa0417e: BITCLR (R5,0x1f)
ffa04180: LOAD R1 = [FP + 0x1c]
ffa04182: CALL 0xffa01716
ffa04186: ROT|| R0 = rot R4 by 0
ffa0418a: _STORE [FP + 0x1c] = R0
ffa0418c: _NOP
ffa0418e: CALL 0xffa02894
ffa04192: ROT|| R7 = rot R0 by 0
ffa04196: _LOAD R0 = [FP + 0xc]
ffa04198: _NOP
ffa0419a: CALL 0xffa02894
ffa0419e: ROT|| R4 = rot R0 by 0
ffa041a2: _LOAD R0 = [P3++]
ffa041a4: _NOP
ffa041a6: MOVE R1 = R7
ffa041a8: CALL 0xffa018f0
ffa041ac: MOVE R7 = R0
ffa041ae: MOVE R1 = R4
ffa041b0: LOAD R0 = [P3 + -0x8]
ffa041b4: CALL 0xffa018f0
ffa041b8: MOVE R1 = R0
ffa041ba: MOVE R0 = R7
ffa041bc: CALL 0xffa01714
ffa041c0: ROT|| R7 = rot R0 by 0
ffa041c4: _LOAD R1 = [FP + -0x60]
ffa041c6: _NOP
ffa041c8: LOAD R0 = [FP + 0x1c]
ffa041ca: CALL 0xffa018f0
ffa041ce: ROT|| R4 = rot R0 by 0
ffa041d2: _LOAD R1 = [FP + -0x64]
ffa041d4: _NOP
ffa041d6: MOVE R0 = R7
ffa041d8: CALL 0xffa018f0
ffa041dc: MOVE R1 = R0
ffa041de: MOVE R0 = R4
ffa041e0: CALL 0xffa01714
ffa041e4: ROT|| R1 = rot R0 by 0
ffa041e8: _LOAD R3 = [FP + 0x8]
ffa041ea: _NOP
ffa041ec: BITCLR (R1,0x1f)
ffa041ee: CC = R3 < R1
ffa041f0: MOVE R4 = CC
ffa041f2: CC = R3 < R5
ffa041f4: LOAD R2 = 0x1
ffa041f6: OR R7 = R1 | R5
ffa041f8: IF !CC R2 = R4
ffa041fa: CC = R6 < R0
ffa041fc: AND R1 = R0 & R6
ffa041fe: LSH|| R1 = R1 >> 0x1f
ffa04202: _LOAD R4 = [FP + 0x10]
ffa04204: _NOP
ffa04206: MOVE R3 = CC
ffa04208: CC = R0 == R6
ffa0420a: XOR R1 = R1 ^ R3
ffa0420c: IF !CC R3 = R1
ffa0420e: CC = R7 == 0x0
ffa04210: IF CC R3 = R7
ffa04212: CC = BITTST (R2,0x0)
ffa04214: LOAD R5 = 0x0
ffa04216: IF CC R3 = R5
ffa04218: CC = BITTST (R3,0x0)
ffa0421a: IF CC R0 = R6
ffa0421c: CC = R4 == 0x0
ffa0421e: ROT|| R6 = rot R0 by 0
ffa04222: _LOAD R1 = [FP + 0x10]
ffa04224: _NOP
ffa04226: IF !CC JUMP 0xffa04128
ffa04228: MOVE R7 = R0
ffa0422a: LOAD R3 = [FP + -0x38]
ffa0422c: LOAD R4 = [FP + -0x3c]
ffa0422e: CC = R3 < R4 (IU)
ffa04230: LOAD R1 = [FP + 0x2c]
ffa04232: LOAD R2 = [FP + -0x34]
ffa04234: SUB|| R1 = R2 - R1 (s)
ffa04238: LOAD R5 = [FP + -0x58]
ffa0423a: NOP
ffa0423c: MOVE CC &= az
ffa0423e: MOVE CC |= an
ffa04240: LOAD R6 = [FP + -0x54]
ffa04242: LOAD R0 = [FP + -0x38]
ffa04244: LOAD R4 = [FP + -0x34]
ffa04246: IF !CC JUMP 0xffa04282
ffa04248: LOAD R0 = [FP + -0x5c]
ffa0424a: CC = R0 == 0x0
ffa0424c: IF !CC JUMP 0xffa04368
ffa0424e: LOAD R0 = [FP + -0x5c]
ffa04250: CC = R0 == 0x0
ffa04252: IF !CC JUMP 0xffa04358
ffa04254: LOAD P5 = [FP + -0x40]
ffa04256: LOAD R6 = 0x3
ffa04258: ADD R6 += -0x1
ffa0425a: LOAD R0 = [P4++]
ffa0425c: LSH|| R0 = R0 << 0x3
ffa04260: _LOAD R5 = [P4++]
ffa04262: _NOP
ffa04264: CALL 0xffa02894
ffa04268: LSH|| R0 = R5 << 0x3
ffa0426c: _STORE [P5++] = R0
ffa0426e: _NOP
ffa04270: CALL 0xffa02894
ffa04274: CC = R6 == 0x0
ffa04276: STORE [P5++] = R0
ffa04278: IF !CC JUMP 0xffa04258 (bp)
ffa0427a: LOAD R5 = [FP + -0x44]
ffa0427c: LOAD R0 = [FP + -0x3c]
ffa0427e: LOAD R6 = [FP + -0x6c]
ffa04280: LOAD R4 = [FP + 0x2c]
ffa04282: LOAD R2 = [FP + -0x44]
ffa04284: LOAD R3 = [FP + -0x68]
ffa04286: ADD|| R2 = R3 + R2 (ns)
ffa0428a: _LOAD R1 = [FP + -0x70]
ffa0428c: _NOP
ffa0428e: CC = R2 <= R1
ffa04290: LOAD R1 = [FP + 0x24]
ffa04292: SUB|| R1 = R1 - R3 (ns)
ffa04296: _STORE [FP + -0x58] = R5
ffa04298: _NOP
ffa0429a: STORE [FP + -0x54] = R6
ffa0429c: STORE [FP + -0x38] = R0
ffa0429e: STORE [FP + -0x34] = R4
ffa042a0: STORE [SP + 0x2c] = R7
ffa042a2: STORE [FP + -0x44] = R2
ffa042a4: STORE [FP + 0x24] = R1
ffa042a6: IF !CC JUMP 0xffa042aa
ffa042a8: JUMP.S 0xffa03dda
ffa042aa: LOAD R3 = [FP + -0x50]
ffa042ac: STORE [SP + 0x2c] = R3
ffa042ae: LOAD R1 = [FP + -0x4c]
ffa042b0: LOAD R2 = [FP + -0x6c]
ffa042b2: LOAD R3 = [SP + 0x44]
ffa042b6: ADD|| R2 = R3 + R2 (ns)
ffa042ba: _LOAD R3 = [SP + 0x2c]
ffa042bc: _NOP
ffa042be: STORE [FP + -0x50] = R3
ffa042c0: LOAD R3 = [SP + 0x48]
ffa042c4: STORE [FP + -0x6c] = R2
ffa042c6: CC = R2 < R3
ffa042c8: STORE [SP + 0x28] = R0
ffa042ca: STORE [FP + -0x34] = R4
ffa042cc: STORE [FP + -0x4c] = R1
ffa042ce: IF !CC JUMP 0xffa042d2
ffa042d0: JUMP.S 0xffa03d66
ffa042d2: ROT|| R7 = rot R0 by 0
ffa042d6: _LOAD R2 = [SP + 0x2c]
ffa042d8: _NOP
ffa042da: STORE [FP + -0x74] = R1
ffa042dc: STORE [FP + -0x6c] = R2
ffa042de: LOAD R2 = 0x1
ffa042e0: LOAD R1 = 0x0
ffa042e2: LOAD R0 = 0x1
ffa042e4: CALL 0xffa06008
ffa042e8: MOVE R0 = R6
ffa042ea: CALL 0xffa02894
ffa042ee: LOAD R1 = [SP + 0x38]
ffa042f0: CALL 0xffa018f0
ffa042f4: LOAD P1 = [SP + 0x34]
ffa042f6: ROT|| R0 = rot R5 by 0
ffa042fa: _STORE [P1 + 0x4] = R0
ffa042fc: _NOP
ffa042fe: CALL 0xffa02894
ffa04302: LOAD R1 = [SP + 0x38]
ffa04304: CALL 0xffa018f0
ffa04308: ROT|| R1 = rot R4 by 0
ffa0430c: _LOAD P0 = [SP + 0x34]
ffa0430e: _NOP
ffa04310: ROT|| R0 = rot R7 by 0
ffa04314: _STORE [P0 + 0x8] = R0
ffa04316: _NOP
ffa04318: CALL 0xffa015b4
ffa0431c: MOVE R7 = R0
ffa0431e: LOAD R1 = [FP + -0x74]
ffa04320: LOAD R0 = [FP + -0x6c]
ffa04322: CALL 0xffa015b4
ffa04326: LOAD R1 = 0x0
ffa04328: LOAD R1.H = 0x4580
ffa0432c: CALL 0xffa018f0
ffa04330: MOVE R6 = R0
ffa04332: LOAD R0 = [FP + -0x48]
ffa04334: CALL 0xffa01688
ffa04338: MOVE R1 = R0
ffa0433a: MOVE R0 = R6
ffa0433c: CALL 0xffa01814
ffa04340: MOVE R1 = R0
ffa04342: MOVE R0 = R7
ffa04344: CALL 0xffa01714
ffa04348: LOAD P1 = [SP + 0x30]
ffa0434a: STORE [P1] = R0
ffa0434c: ADD SP += 0xc
ffa0434e: POP (R7:4,P5:3) = [SP++]
ffa04350: UNLINK
ffa04354: LOAD R0 = 0x0
ffa04356: RTS
ffa04358: LOAD P1 = [SP + 0x3c]
ffa0435a: LOAD R0 = [FP + -0x3c]
ffa0435c: LOAD R4 = [FP + 0x2c]
ffa0435e: STORE [P1] = R7
ffa04360: LOAD R5 = [FP + -0x44]
