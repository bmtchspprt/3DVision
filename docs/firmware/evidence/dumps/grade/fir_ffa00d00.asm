ffa00d00: LOAD R0 = [SP + 0x18]
ffa00d02: ADD R7 = R0 + R7
ffa00d04: MOVE I3 = R7
ffa00d06: MOVE I2 = R0
ffa00d08: MOVE P0 = R3
ffa00d0a: LOAD P1 = 0x1
ffa00d0c: MOVE P2 = R6
ffa00d0e: CC = R3 == 0x0
ffa00d10: IF CC JUMP 0xffa00d86
ffa00d12: LSH R6 = R6 << 0x1
ffa00d16: MOVE M0 = R6
ffa00d18: LSETUP (0xffa00d1c,0xffa00d48) LC0 = P0
ffa00d1c: CLR|| A1 = A0 = 0
ffa00d20: _LOAD R0.L = W [I0--]
ffa00d22: _LOAD R1.L = W [I1++]
ffa00d24: LSETUP (0xffa00d28,0xffa00d28) LC1 = P1
ffa00d28: MAC|| R2.L = (A0 += R0.L * R1.L) 
ffa00d2c: LOAD R0.L = W [I0--]
ffa00d2e: LOAD R1.L = W [I1++]
ffa00d30: ADD P1 += 0x1
ffa00d32: LSETUP (0xffa00d36,0xffa00d36) LC1 = P0
ffa00d36: MAC|| R3.H = (A1 += R0.L * R1.L) 
ffa00d3a: LOAD R0.L = W [I0--]
ffa00d3c: LOAD R1.L = W [I1++]
ffa00d3e: ADD P0 += -0x1
ffa00d40: MNOP||
ffa00d44: _SUB I1 -= 2
ffa00d46: _STORE W [I2++] = R2.L
ffa00d48: MNOP||
ffa00d4c: _SUB I0 -= M1
ffa00d4e: _STORE W [I3++] = R3.H
ffa00d50: ADD P1 += -0x1
ffa00d52: MOVE I0 = B0
ffa00d54: SUB I1 -= 2
ffa00d56: LSETUP (0xffa00d5a,0xffa00d72) LC0 = P2
ffa00d5a: CLR|| A0 = 0
ffa00d5e: _LOAD R0.L = W [I0++]
ffa00d60: _LOAD R1.L = W [I1--]
ffa00d62: LSETUP (0xffa00d66,0xffa00d66) LC1 = P1
ffa00d66: MAC|| A0 += R0.L * R1.L 
ffa00d6a: LOAD R0.L = W [I0++]
ffa00d6c: LOAD R1.L = W [I1--]
ffa00d6e: MAC R2.L = (A0 += R0.L * R1.L) 
ffa00d72: MNOP||
ffa00d76: _ADD I0 += M0
ffa00d78: _STORE W [I2++] = R2.L
ffa00d7a: POP (R7:6) = [SP++]
ffa00d7c: LOAD L0 = 0x0
ffa00d80: LOAD L1 = 0x0
ffa00d84: RTS
ffa00d86: MNOP||
ffa00d8a: _LOAD R0.L = W [I0++]
ffa00d8c: _LOAD R1.L = W [I1]
ffa00d8e: MAC|| R2.L = (A0 = R0.L * R1.L) 
ffa00d92: LOAD R0.L = W [I0++]
ffa00d94: NOP
ffa00d96: LSETUP (0xffa00d9a,0xffa00d9a) LC0 = P2
ffa00d9a: MAC|| R2.L = (A0 = R0.L * R1.L) 
ffa00d9e: LOAD R0.L = W [I0++]
ffa00da0: STORE W [I2++] = R2.L
ffa00da2: JUMP.S 0xffa00d7a
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
