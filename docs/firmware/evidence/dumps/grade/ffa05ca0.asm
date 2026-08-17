ffa05ca0: LINK 0x4
ffa05ca4: PUSH [--SP] = (R7:4,P5:3)
ffa05ca6: ADD SP += -0xc
ffa05ca8: LOAD P3 = [FP + 0x18]
ffa05caa: LOAD P1.L = 0x5044
ffa05cae: LOAD P1.H = 0x2021
ffa05cb2: LOAD P5.L = 0x2850
ffa05cb6: LOAD P5.H = 0x202d
ffa05cba: MOVE P4 = R0
ffa05cbc: ADD P1 = P1 + (P3 << 1)
ffa05cbe: LOAD R3 = W [P1] (Z)
ffa05cc0: MOVE P1 = R3
ffa05cc2: MOVE P0 = R1
ffa05cc4: LOAD P2 = [FP + 0x14]
ffa05cc6: CC = P3 < 0x0
ffa05cc8: LOAD R5 = 0x0
ffa05cca: ADD P1 = P5 + (P1 << 2)
ffa05ccc: LOAD P1 = [P1]
ffa05cce: MOVE P5 = R2
ffa05cd0: STORE [SP + 0x28] = P3
ffa05cd2: LOAD R3 = W [P1 + 0x5770] (Z)
ffa05cd6: LOAD R7 = W [P1 + 0x5776] (X)
ffa05cda: ASH|| R6 = R3 >>> 0x1
ffa05cde: _STORE [P2++] = R5
ffa05ce0: _NOP
ffa05ce2: SUB|| R0 = R7 -|- R6
ffa05ce6: _STORE [P2++] = R5
ffa05ce8: _NOP
ffa05cea: MOVE R1 = R0.L (X)
ffa05cec: MIN|| R1 = min(R3,R1)
ffa05cf0: _STORE [P2] = R5
ffa05cf2: _NOP
ffa05cf4: IF CC R0 = R1
ffa05cf6: MOVE R0 = R0.L (X)
ffa05cf8: MOVE R7 = R0
ffa05cfa: ADD R0 += 0x1
ffa05cfc: CALL 0xffa01688
ffa05d00: CC = R7 < 0x1
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
ffa05d84: LOAD R1 = 0x5cfc
ffa05d88: LOAD P0 = 0x578
ffa05d8c: ADD P1 = P4 + P1
ffa05d8e: LOAD R0 = W [P1] (X)
ffa05d90: MULT|| R0 = R0.L * R1.L (is)
ffa05d94: LOAD R2 = [SP + 0x28]
ffa05d96: NOP
ffa05d98: MOVE P1 = R0
ffa05d9a: ADD P0 = P4 + P0
ffa05d9c: ADD P1 = P0 + P1
ffa05d9e: LOAD R0 = B [P1 + 0x2] (Z)
ffa05da2: CC = R0 <= R2
ffa05da4: IF !CC JUMP 0xffa05dfe
ffa05da6: NOP
ffa05da8: LOAD P1 = [FP + 0x20]
ffa05daa: LOAD R5.H = 0x3f80
ffa05dae: LOAD R6 = W [P1 + 0x6] (Z)
ffa05db0: MOVE R0 = R6
ffa05db2: CALL 0xffa016d4
ffa05db6: LOAD R2 = 0x0
ffa05db8: CC = R6 == 0x0
ffa05dba: PACK|| R5 = pack(R5.H,R2.L)
ffa05dbe: _LOAD R1 = [P5]
ffa05dc0: _NOP
ffa05dc2: MOVE R7 = R0
ffa05dc4: ROT|| R6 = rot R5 by 0
ffa05dc8: _LOAD R0 = [P5 + 0x4]
ffa05dca: _NOP
ffa05dcc: IF CC R7 = R5
ffa05dce: CALL 0xffa01716
ffa05dd2: LOAD R1 = [P5 + 0x8]
ffa05dd4: CALL 0xffa01716
ffa05dd8: BITCLR (R0,0x1f)
ffa05dda: CC = R0 == 0x0
ffa05ddc: IF CC JUMP 0xffa05e42
ffa05dde: NOP
ffa05de0: LOAD P1 = [FP + 0x20]
ffa05de2: MOVE R6 = R7
ffa05de4: LOAD R0 = B [P1 + 0x5] (Z)
ffa05de8: ADD R0 += -0x1
ffa05dea: CC = R0 < 0x4 (IU)
ffa05dec: IF !CC JUMP 0xffa05e42
ffa05dee: MOVE P1 = R0
ffa05df0: LOAD P0.L = 0x2e50
ffa05df4: LOAD P0.H = 0xff80
ffa05df8: ADD P1 = P0 + (P1 << 2)
ffa05dfa: LOAD P1 = [P1]
ffa05dfc: JUMP (P1)
ffa05dfe: LOAD R1 = [FP + 0x1c]
ffa05e00: CC = R1 <= R0
ffa05e02: IF CC JUMP 0xffa05da6 (bp)
ffa05e04: ADD SP += 0xc
ffa05e06: POP (R7:4,P5:3) = [SP++]
ffa05e08: UNLINK
ffa05e0c: RTS
ffa05e0e: LOAD P3 = [FP + 0x14]
ffa05e10: LOAD P1 = 0x3
ffa05e12: LSETUP (0xffa05e16,0xffa05e30) LC1 = P1
ffa05e16: LOAD R0 = [P3]
ffa05e18: MOVE R1 = R6
ffa05e1a: CALL 0xffa01814
ffa05e1e: STORE [P3] = R0
ffa05e20: MOVE R7 = R0
ffa05e22: LOAD R0 = [P4++]
ffa05e24: MOVE R1 = R0
ffa05e26: CALL 0xffa018f0
ffa05e2a: MOVE R1 = R7
ffa05e2c: CALL 0xffa018f0
ffa05e30: STORE [P3++] = R0
ffa05e32: JUMP.S 0xffa05d7a
ffa05e34: MOVE R1 = R7
ffa05e36: LOAD R0 = 0x0
ffa05e38: LOAD R0.H = 0x41f0
ffa05e3c: CALL 0xffa018f0
ffa05e40: MOVE R6 = R0
ffa05e42: MOVE R1 = R5
ffa05e44: MOVE R0 = R6
ffa05e46: CALL 0xffa01714
ffa05e4a: LOAD P1 = 0x3
ffa05e4c: MOVE R7 = R0
ffa05e4e: LOAD P4 = [FP + 0x14]
ffa05e50: LSETUP (0xffa05e54,0xffa05e6e) LC1 = P1
ffa05e54: ROT|| R1 = rot R7 by 0
ffa05e58: _LOAD R0 = [P5]
ffa05e5a: _NOP
ffa05e5c: CALL 0xffa018f0
ffa05e60: STORE [P5] = R0
ffa05e62: LOAD R1 = [P4++]
ffa05e64: CALL 0xffa01716
ffa05e68: MOVE R1 = R6
ffa05e6a: CALL 0xffa01814
ffa05e6e: STORE [P5++] = R0
ffa05e70: JUMP.S 0xffa05e04
ffa05e72: MOVE R0 = R7
ffa05e74: LOAD R1 = 0x0
ffa05e76: LOAD R1.H = 0x42c8
ffa05e7a: CALL 0xffa018f0
ffa05e7e: MOVE R6 = R0
ffa05e80: JUMP.S 0xffa05e42
ffa05e82: MOVE R0 = R7
ffa05e84: LOAD R1 = 0x0
ffa05e86: LOAD R1.H = 0x4120
ffa05e8a: CALL 0xffa018f0
ffa05e8e: MOVE R6 = R0
ffa05e90: JUMP.S 0xffa05e42
ffa05eb0: LOAD R0 = 0x2
ffa05eb2: LOAD R0.H = 0xd
ffa05eb6: CALL 0xffa0872a
ffa05eba: LOAD R1 = 0x5
ffa05ebc: BITSET (R1,0x1e)
ffa05ebe: LOAD P1.L = 0x1918
ffa05ec2: LOAD P1.H = 0xff80
ffa05ec6: LOAD R0 = [P1]
ffa05ec8: LOAD R2 = 0x0
ffa05eca: CALL 0xffa10684
ffa05ece: LOAD R0 = 0x0
ffa05ed0: STORE [P5 + -0x4] = R0
ffa05ed4: LOAD P5 = [SP + 0xc]
ffa05ed6: UNLINK
ffa05eda: RTS
ffa05edc: LOAD R0 = 0x1
ffa05ede: STORE [P5 + 0x0] = R0
ffa05ee0: JUMP.S 0xffa05ed4
ffa05ee4: NEG R2 = -R0
ffa05ee6: NEG R3 = -R1
ffa05ee8: MAX R2 = max(R2,R0)
ffa05eec: MAX R3 = max(R3,R1)
ffa05ef0: CC = R3 <= R2
ffa05ef2: LINK 0x10
ffa05ef6: ASH R2 = R1 >>> 0x1f
ffa05efa: ASH|| R3 = R0 >>> 0x1f
ffa05efe: _STORE [SP + 0xc] = R2
ffa05f00: _NOP
ffa05f02: IF !CC JUMP 0xffa05f1a
ffa05f04: MOVE R2 = R1
ffa05f06: MOVE R1 = R3
ffa05f08: CALL 0xffa01c38
ffa05f0c: CC = R1 < 0x0
ffa05f0e: LOAD R1 = 0x0
ffa05f10: BITSET (R1,0x1f)
ffa05f12: LOAD R0 = -0x1
ffa05f14: LSHIFT R0 >>= 0x1
ffa05f16: IF CC R0 = R1
ffa05f18: JUMP.S 0xffa05f28
ffa05f1a: CC = BITTST (R3,0x0)
ffa05f1c: MOVE R2 = R1
ffa05f1e: ROT R1 = rot R0 by -0x1
ffa05f22: LSHIFT R0 <<= 0x1f
ffa05f24: CALL 0xffa01150
ffa05f28: UNLINK
ffa05f2c: RTS
