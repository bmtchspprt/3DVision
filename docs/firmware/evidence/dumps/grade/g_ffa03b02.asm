ffa03b04: ADD R2 += 0x1
ffa03b06: ADD R0 += 0x1
ffa03b08: CC = R1 < R7
ffa03b0a: MOVE P1 = P4
ffa03b0c: ASH|| R2 = R3 >>> 0x2
ffa03b10: _STORE [FP + 0x28] = R2
ffa03b12: _NOP
ffa03b14: STORE [SP + 0x2c] = R0
ffa03b16: ADD P4 += 0x2
ffa03b18: IF !CC JUMP 0xffa03c2a
ffa03b1a: LOAD P0 = [P5 + 0x8]
ffa03b1c: STORE [SP + 0x3c] = R2
ffa03b1e: LOAD R6 = 0xff
ffa03b22: LSH R4 = R6 << 0x17
ffa03b26: ADD P1 = P0 + P1
ffa03b28: LOAD R0 = W [P1] (X)
ffa03b2a: CALL 0xffa02948
ffa03b2e: LOAD R1 = [P5 + 0x10]
ffa03b30: CALL 0xffa018f0
ffa03b34: ROT|| R7 = rot R0 by 0
ffa03b38: _LOAD P3 = [P5 + 0xc]
ffa03b3a: _NOP
ffa03b3c: ROT|| R5 = rot R0 by 0
ffa03b40: _LOAD P1 = [SP + 0x3c]
ffa03b42: _NOP
ffa03b44: ADD P1 = P3 + (P1 << 1)
ffa03b46: LOAD R0 = W [P1] (X)
ffa03b48: CALL 0xffa02948
ffa03b4c: LOAD R1 = [P5 + 0x14]
ffa03b4e: CALL 0xffa018f0
ffa03b52: MOVE R6 = R0
ffa03b54: MOVE R0 = R7
ffa03b56: MOVE R1 = R6
ffa03b58: CALL 0xffa01714
ffa03b5c: ROT|| R7 = rot R0 by 0
ffa03b60: _LOAD R1 = [FP + 0x14]
ffa03b62: _NOP
ffa03b64: LOAD R0 = [SP + 0x38]
ffa03b66: CALL 0xffa018f0
ffa03b6a: MOVE R1 = R0
ffa03b6c: AND R3 = R1 & R7
ffa03b6e: LSHIFT R3 >>= 0x1f
ffa03b70: BITCLR (R0,0x1f)
ffa03b72: ROT|| R2 = rot R7 by 0
ffa03b76: _STORE [SP + 0x3c] = R3
ffa03b78: _NOP
ffa03b7a: CC = R4 < R0
ffa03b7c: BITCLR (R2,0x1f)
ffa03b7e: MOVE R3 = CC
ffa03b80: CC = R4 < R2
ffa03b82: OR R0 = R0 | R2
ffa03b84: LOAD R2 = 0x1
ffa03b86: IF !CC R2 = R3
ffa03b88: CC = R7 <= R1
ffa03b8a: MOVE R3 = CC
ffa03b8c: CC = R1 == R7
ffa03b8e: LOAD R1 = [SP + 0x3c]
ffa03b90: XOR R1 = R1 ^ R3
ffa03b92: IF !CC R3 = R1
ffa03b94: CC = R0 == 0x0
ffa03b96: LOAD R1 = 0x1
ffa03b98: IF CC R3 = R1
ffa03b9a: CC = BITTST (R2,0x0)
ffa03b9c: LOAD R0 = 0x0
ffa03b9e: IF CC R3 = R0
ffa03ba0: CC = BITTST (R3,0x0)
ffa03ba2: IF CC JUMP 0xffa03c2a
ffa03ba4: MOVE R0 = R6
ffa03ba6: MOVE R1 = R5
ffa03ba8: BITCLR (R0,0x1f)
ffa03baa: BITCLR (R1,0x1f)
ffa03bac: OR R3 = R0 | R1
ffa03bae: CC = R4 < R0
ffa03bb0: STORE [SP + 0x3c] = R3
ffa03bb2: MOVE R2 = CC
ffa03bb4: CC = R4 < R1
ffa03bb6: LOAD R0 = 0x1
ffa03bb8: IF !CC R0 = R2
ffa03bba: CC = R5 <= R6
ffa03bbc: AND R3 = R6 & R5
ffa03bbe: LSHIFT R3 >>= 0x1f
ffa03bc0: MOVE R2 = CC
ffa03bc2: CC = R6 == R5
ffa03bc4: XOR R3 = R3 ^ R2
ffa03bc6: LOAD R6 = [SP + 0x3c]
ffa03bc8: IF !CC R2 = R3
ffa03bca: CC = R6 == 0x0
ffa03bcc: LOAD R3 = 0x1
ffa03bce: IF CC R2 = R3
ffa03bd0: CC = BITTST (R0,0x0)
ffa03bd2: LOAD R6 = 0x0
ffa03bd4: IF CC R2 = R6
ffa03bd6: CC = BITTST (R2,0x0)
ffa03bd8: IF CC JUMP 0xffa03c2a
ffa03bda: LOAD R0 = [SP + 0x38]
ffa03bdc: CC = R4 < R1
ffa03bde: BITCLR (R0,0x1f)
ffa03be0: OR R6 = R1 | R0
ffa03be2: MOVE R2 = CC
ffa03be4: CC = R4 < R0
ffa03be6: LOAD R1 = 0x1
ffa03be8: LOAD R4 = [SP + 0x38]
ffa03bea: LOAD R3 = [SP + 0x38]
ffa03bec: IF !CC R1 = R2
ffa03bee: CC = R4 < R5
ffa03bf0: AND R3 = R5 & R3
ffa03bf2: LSHIFT R3 >>= 0x1f
ffa03bf4: MOVE R0 = CC
ffa03bf6: CC = R5 == R4
ffa03bf8: XOR R3 = R3 ^ R0
ffa03bfa: IF !CC R0 = R3
ffa03bfc: CC = R6 == 0x0
ffa03bfe: IF CC R0 = R6
ffa03c00: CC = BITTST (R1,0x0)
ffa03c02: LOAD R2 = 0x0
ffa03c04: IF CC R0 = R2
ffa03c06: CC = BITTST (R0,0x0)
ffa03c08: IF CC JUMP 0xffa03c2a
ffa03c0a: ROT|| R0 = rot R7 by 0
ffa03c0e: _LOAD R6 = [SP + 0x2c]
ffa03c10: _NOP
ffa03c12: ROT|| R1 = rot R7 by 0
ffa03c16: _STORE [FP + 0x24] = R6
ffa03c18: _NOP
ffa03c1a: CALL 0xffa018f0
ffa03c1e: LOAD R1 = [FP + 0x10]
ffa03c20: CALL 0xffa01716
ffa03c24: STORE [FP + 0x10] = R0
ffa03c26: LOAD R2 = [FP + 0x28]
ffa03c28: JUMP.S 0xffa03af4
ffa03c2a: LOAD R0 = [SP + 0x28]
ffa03c2c: CC = R0 == 0x0
ffa03c2e: IF CC JUMP 0xffa03c36
ffa03c30: LOAD P1 = [SP + 0x28]
ffa03c32: LOAD R0 = [FP + 0x24]
ffa03c34: STORE W [P1] = R0.L
ffa03c36: LOAD P1 = [FP + 0x20]
ffa03c38: LOAD P2 = [FP + 0x18]
ffa03c3a: LOAD P0 = [FP + 0x20]
ffa03c3c: LOAD P1 = [P1 + 0x4d0]
ffa03c40: LOAD P0 = [P0 + 0x4cc]
ffa03c44: ADD P1 = P1 + (P2 << 1)
ffa03c46: LOAD R1 = W [P1] (Z)
ffa03c48: MOVE P1 = R1
ffa03c4a: ADD P1 = P0 + (P1 << 2)
ffa03c4c: LOAD P1 = [P1]
ffa03c4e: LOAD R0 = W [P1 + 0x5770] (Z)
ffa03c52: CALL 0xffa016d4
ffa03c56: MOVE R1 = R0
ffa03c58: LOAD R0 = [FP + 0x10]
ffa03c5a: CALL 0xffa01814
ffa03c5e: CALL 0xffa0248c
ffa03c62: ADD SP += 0xc
ffa03c64: POP (R7:4,P5:3) = [SP++]
ffa03c66: UNLINK
ffa03c6a: RTS
ffa03c6c: LOAD R0 = [FP + 0x24]
ffa03c6e: CC = R0 == 0x0
ffa03c70: IF CC JUMP 0xffa03c78
ffa03c72: LOAD P1 = [FP + 0x24]
ffa03c74: LOAD R0 = [P5 + 0x0]
ffa03c76: STORE W [P1] = R0.L
ffa03c78: LOAD R1 = [SP + 0x28]
ffa03c7a: CC = R1 == 0x0
ffa03c7c: LOAD R0 = 0x0
ffa03c7e: IF CC JUMP 0xffa03c62
ffa03c80: LOAD P1 = [SP + 0x28]
ffa03c82: LOAD R1 = [P5 + 0x0]
ffa03c84: STORE W [P1] = R1.L
ffa03c86: JUMP.S 0xffa03c62
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
