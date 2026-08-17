ffa05c20: SUB R1 = R5 - R1
ffa05c22: NEG R3 = -R2
ffa05c24: NEG R6 = -R1
ffa05c26: MAX R2 = max(R3,R2)
ffa05c2a: MAX R1 = max(R6,R1)
ffa05c2e: MAX R0 = max(R0,R1)
ffa05c32: MAX R1 = max(R0,R2)
ffa05c36: JUMP.S 0xffa05b00
ffa05c38: LINK 0x0
ffa05c3c: PUSH [--SP] = (R7:4,P5:3)
ffa05c3e: MOVE R7 = R2
ffa05c40: MOVE P1 = R7
ffa05c42: LOAD P0 = 0x548
ffa05c46: MOVE R6 = R0
ffa05c48: ADD SP += -0xc
ffa05c4a: LOAD P5.L = 0x5046
ffa05c4e: LOAD P5.H = 0x2021
ffa05c52: ADD P3 = P1 + P0
ffa05c54: LOAD P4.L = 0x2850
ffa05c58: LOAD P4.H = 0x202d
ffa05c5c: LOAD R4 = 0x0
ffa05c5e: ROT|| R5 = rot R4 by 0
ffa05c62: _LOAD R0 = W [P5++] (Z)
ffa05c64: _NOP
ffa05c66: MOVE P1 = R0
ffa05c68: LOAD R1 = 0xa028
ffa05c6c: ADD R4 += 0x1
ffa05c6e: ADD P1 = P4 + (P1 << 2)
ffa05c70: LOAD P1 = [P1]
ffa05c72: LOAD R0 = [P1 + 0x57c0]
ffa05c76: CALL 0xffa05ee4
ffa05c7a: ROT|| R1 = rot R7 by 0
ffa05c7e: _LOAD R2 = [P3++]
ffa05c80: _NOP
ffa05c82: ADD R0 = R0 + R2
ffa05c84: CALL 0xffa0586c
ffa05c88: CC = R0 < R6
ffa05c8a: IF !CC JUMP 0xffa05c94
ffa05c8c: MOVE R0 = R5.L (X)
ffa05c8e: LOAD R1 = 0xb
ffa05c90: CC = R1 <= R0
ffa05c92: IF !CC JUMP 0xffa05c5e (bp)
ffa05c94: ADD SP += 0xc
ffa05c96: MOVE R0 = R5.L (X)
ffa05c98: POP (R7:4,P5:3) = [SP++]
ffa05c9a: UNLINK
ffa05c9e: RTS
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
