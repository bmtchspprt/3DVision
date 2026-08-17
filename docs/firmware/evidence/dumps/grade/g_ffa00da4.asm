ffa00da4: LINK 0x8
ffa00da8: PUSH [--SP] = (R7:4,P5:5)
ffa00daa: MOVE R7 = R0
ffa00dac: LOAD R1 = 0xe00
ffa00db0: BITCLR (R7,0x1f)
ffa00db2: MOVE R0 = R1
ffa00db4: LOAD R0.H = 0x47c9
ffa00db8: CC = R7 <= R0
ffa00dba: ADD SP += -0x10
ffa00dbc: IF !CC JUMP 0xffa00f84
ffa00dbe: MOVE R1 = R7
ffa00dc0: LOAD R0 = -0x67d
ffa00dc4: LOAD R0.H = 0x3ea2
ffa00dc8: CALL 0xffa018f0
ffa00dcc: LOAD R1 = 0x0
ffa00dce: LOAD R1.H = 0x3f80
ffa00dd2: CALL 0xffa01716
ffa00dd6: CALL 0xffa014dc
ffa00dda: LOAD R2 = 0xfdb
ffa00dde: PACK|| R6 = pack(R6.H,R2.L)
ffa00de2: _STORE [SP + 0x28] = R0
ffa00de4: _NOP
ffa00de6: LOAD R6.H = 0x46c9
ffa00dea: CC = R6 <= R7
ffa00dec: MOVE R1 = CC
ffa00dee: LSHIFT R1 <<= 0x1
ffa00df0: ROT|| R6 = rot R0 by 0
ffa00df4: _STORE [SP + 0x3c] = R1
ffa00df6: _NOP
ffa00df8: ROT|| R0 = rot R7 by 0
ffa00dfc: _LOAD P1 = [SP + 0x3c]
ffa00dfe: _NOP
ffa00e00: LOAD R2 = 0x30
ffa00e02: SUB R4 = R2 - R1
ffa00e04: LOAD P0.L = 0x3488
ffa00e08: LOAD P0.H = 0xff80
ffa00e0c: ADD P1 = (P1 + P1) << 2
ffa00e0e: MOVE R1 = R4
ffa00e10: ADD P5 = P0 + P1
ffa00e12: CALL 0xffa01564
ffa00e16: ROT|| R7 = rot R0 by 0
ffa00e1a: _LOAD R2 = [SP + 0x28]
ffa00e1c: _NOP
ffa00e1e: ROT|| R0 = rot R6 by 0
ffa00e22: _LOAD R3 = [P5 + 0x4]
ffa00e24: _NOP
ffa00e26: ROT|| R6 = rot R1 by 0
ffa00e2a: _STORE [SP + 0xc] = R3
ffa00e2c: _NOP
ffa00e2e: ASH|| R1 = R2 >>> 0x1f
ffa00e32: _LOAD R2 = [P5]
ffa00e34: _NOP
ffa00e36: CALL 0xffa01c38
ffa00e3a: CC = R7 < R0 (IU)
ffa00e3c: MOVE R2 = CC
ffa00e3e: SUB|| R2 = R6 - R2 (ns)
ffa00e42: _LOAD R3 = [P5 + 0x8]
ffa00e44: _NOP
ffa00e46: SUB R1 = R2 - R1
ffa00e48: SUB|| R7 = R7 - R0 (ns)
ffa00e4c: _LOAD R0 = [P5 + 0xc]
ffa00e4e: _NOP
ffa00e50: ADD R6 = R7 + R3
ffa00e52: MOVE CC = ac0
ffa00e54: LSH R3 = R4 << 0x17
ffa00e58: MOVE R7 = CC
ffa00e5a: ADD|| R1 = R1 + R7 (ns)
ffa00e5e: _STORE [SP + 0x24] = R3
ffa00e60: _NOP
ffa00e62: ADD R4 = R1 + R0
ffa00e64: MOVE R0 = R6
ffa00e66: MOVE R1 = R4
ffa00e68: CALL 0xffa015b4
ffa00e6c: LOAD R2 = 0x12
ffa00e6e: ROT|| R7 = rot R0 by 0
ffa00e72: _LOAD R1 = [SP + 0x3c]
ffa00e74: _NOP
ffa00e76: SUB|| R2 = R1 - R2 (ns)
ffa00e7a: _LOAD R3 = [SP + 0x24]
ffa00e7c: _NOP
ffa00e7e: CC = R0 == 0x0
ffa00e80: SUB R3 = R0 - R3
ffa00e82: MOVE R1 = R4
ffa00e84: MOVE R0 = R6
ffa00e86: IF !CC R7 = R3
ffa00e88: CALL 0xffa004c0
ffa00e8c: LOAD R5 = 0x504f
ffa00e90: ABS R2 = abs R0
ffa00e94: LOAD R5.H = 0xb
ffa00e98: MOVE R1 = R0
ffa00e9a: CC = R5 < R2
ffa00e9c: MOVE R0 = R7
ffa00e9e: IF !CC JUMP 0xffa00f66
ffa00ea0: MAC A1 = R1.L * R1.L (fu)
ffa00ea4: LOAD R2 = 0x80
ffa00ea8: MAC A1 += R2.L * R2.L 
ffa00eac: LSH A1 = A1 >> 0x10
ffa00eb0: MAC A1 += R1.H * R1.L (m),A0 = R1.H * R1.H 
ffa00eb4: MAC A1 += R1.H * R1.L (m)
ffa00eb8: MAC A1 += R2.L * R2.L (fu)
ffa00ebc: ASH A1 = A1 >>> 0xf
ffa00ec0: LOAD P1.L = 0x34a8
ffa00ec4: LOAD P1.H = 0xff80
ffa00ec8: MOVE|| R0 = (A0 += A1)
ffa00ecc: LOAD R1 = [P1++]
ffa00ece: NOP
ffa00ed0: MAC|| A1 = R0.L * R1.L (fu)
ffa00ed4: LOAD R3 = [P1++]
ffa00ed6: NOP
ffa00ed8: MAC A1 += R2.L * R2.L 
ffa00edc: LSH A1 = A1 >> 0x10
ffa00ee0: MAC A1 += R0.H * R1.L (m),A0 = R0.H * R1.H 
ffa00ee4: MAC A1 += R1.H * R0.L (m)
ffa00ee8: MAC A1 += R2.L * R2.L (fu)
ffa00eec: ASH A1 = A1 >>> 0xf
ffa00ef0: MOVE R1 = (A0 += A1)
ffa00ef4: ADD R1 = R1 + R3 (s)
ffa00ef8: LOAD P0 = 0x3
ffa00efa: MAC A1 = R1.L * R0.L (fu)
ffa00efe: MAC A1 += R2.L * R2.L 
ffa00f02: LSH A1 = A1 >> 0x10
ffa00f06: MAC A1 += R1.H * R0.L (m),A0 = R1.H * R0.H 
ffa00f0a: MAC A1 += R0.H * R1.L (m)
ffa00f0e: MAC A1 += R2.L * R2.L (fu)
ffa00f12: ASH A1 = A1 >>> 0xf
ffa00f16: LSETUP (0xffa00f1a,0xffa00f3e) LC0 = P0
ffa00f1a: MOVE|| R1 = (A0 += A1)
ffa00f1e: LOAD R3 = [P1++]
ffa00f20: NOP
ffa00f22: ADD R1 = R1 + R3 (s)
ffa00f26: MAC A1 = R1.L * R0.L (fu)
ffa00f2a: MAC A1 += R2.L * R2.L 
ffa00f2e: LSH A1 = A1 >> 0x10
ffa00f32: MAC A1 += R1.H * R0.L (m),A0 = R1.H * R0.H 
ffa00f36: MAC A1 += R0.H * R1.L (m)
ffa00f3a: MAC A1 += R2.L * R2.L (fu)
ffa00f3e: ASH A1 = A1 >>> 0xf
ffa00f42: MOVE R0 = (A0 += A1)
ffa00f46: ASH R1 = R0 >>> 0x1f
ffa00f4a: CALL 0xffa015b4
ffa00f4e: LOAD R6 = 0x0
ffa00f50: LOAD R6.H = 0xf080
ffa00f54: CC = R0 == 0x0
ffa00f56: ADD R1 = R0 + R6
ffa00f58: IF !CC R0 = R1
ffa00f5a: MOVE R1 = R7
ffa00f5c: CALL 0xffa018f0
ffa00f60: MOVE R1 = R7
ffa00f62: CALL 0xffa01716
ffa00f66: ROT|| R1 = rot R0 by 0
ffa00f6a: _LOAD R3 = [SP + 0x28]
ffa00f6c: _NOP
ffa00f6e: ADD SP += 0x10
ffa00f70: LOAD P0 = [FP + 0x4]
ffa00f72: LOAD R2 = 0x1
ffa00f74: AND R2 = R3 & R2
ffa00f76: POP (R7:4,P5:5) = [SP++]
ffa00f78: CC = R2 == 0x1
ffa00f7a: BITTGL (R1,0x1f)
ffa00f7c: UNLINK
ffa00f80: IF CC R0 = R1
ffa00f82: JUMP (P0)
ffa00f84: ADD SP += 0x10
ffa00f86: LOAD P0 = [FP + 0x4]
ffa00f88: POP (R7:4,P5:5) = [SP++]
ffa00f8a: UNLINK
ffa00f8e: LOAD R0 = 0x0
ffa00f90: JUMP (P0)
