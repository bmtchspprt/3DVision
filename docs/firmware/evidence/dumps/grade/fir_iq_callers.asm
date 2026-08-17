######## FIR FFA00D00
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

######## IQ MAC FFA05B28
ffa05b00: CC = R1 == 0x0
ffa05b02: LOAD R0 = 0x0
ffa05b04: IF CC JUMP 0xffa05b16
ffa05b06: LOAD R0 = -0x1
ffa05b08: LSHIFT R0 >>= 0x1
ffa05b0a: CC = R1 == R0
ffa05b0c: LOAD R0 = 0x1
ffa05b0e: IF CC JUMP 0xffa05b16 (bp)
ffa05b10: ADD R1 += 0x1
ffa05b12: CALL 0xffa05ee4
ffa05b16: LOAD R1 = [FP + 0x18]
ffa05b18: CC = R1 == 0x0
ffa05b1a: IF CC JUMP 0xffa05b7a
ffa05b1c: CC = R7 <= 0x0
ffa05b1e: IF CC JUMP 0xffa05b5a
ffa05b20: MOVE P1 = R7
ffa05b22: LOAD P0 = [SP + 0x30]
ffa05b24: LOAD P2 = 0x2
ffa05b26: MOVE I0 = P0
ffa05b28: LSETUP (0xffa05b2c,0xffa05b58) LC0 = P1
ffa05b2c: MNOP||
ffa05b30: _LOAD R2 = W [P5] (X)
ffa05b32: _LOAD R3.L = W [I0]
ffa05b34: NEG|| R1 = -R2 (ns)
ffa05b38: _LOAD R7 = W [P4++] (X)
ffa05b3a: _NOP
ffa05b3c: MULT|| R6 = R2.L * R7.L (is)
ffa05b40: LOAD R2 = W [P4++] (X)
ffa05b42: NOP
ffa05b44: MULT R1 *= R2
ffa05b46: MULT R2 = R3.L * R2.L (is)
ffa05b4a: ADD R2 = R6 + R2
ffa05b4c: MULT R3 = R7.L * R3.L (is)
ffa05b50: ADD R1 = R1 + R3
ffa05b52: MULT R2 *= R0
ffa05b54: STORE W [P5 ++ P2] = R2.H
ffa05b56: MULT R1 *= R0
ffa05b58: STORE W [I0++] = R1.H
ffa05b5a: LOAD R1 = 0x1
ffa05b5c: MAX R0 = max(R0,R1)
ffa05b60: CALL 0xffa01688
ffa05b64: MOVE R1 = R0
ffa05b66: LOAD R0 = 0x0
ffa05b68: LOAD R0.H = 0x4f00
ffa05b6c: CALL 0xffa01814
ffa05b70: ADD SP += 0xc
ffa05b72: POP (R7:4,P5:3) = [SP++]
ffa05b74: UNLINK
ffa05b78: RTS
ffa05b7a: CC = R7 <= 0x0
ffa05b7c: IF CC JUMP 0xffa05b5a
ffa05b7e: MOVE P1 = R7
ffa05b80: LOAD P0 = [SP + 0x30]
ffa05b82: MOVE I0 = P5
ffa05b84: MOVE I1 = P0
ffa05b86: LSETUP (0xffa05b8a,0xffa05bb0) LC0 = P1
ffa05b8a: MNOP||
ffa05b8e: _LOAD R1 = W [P4++] (X)
ffa05b90: _LOAD R2.L = W [I0]
ffa05b92: MULT|| R6 = R2.L * R1.L (is)
ffa05b96: LOAD R7 = W [P4++] (X)
ffa05b98: LOAD R3.L = W [I1]
ffa05b9a: MULT R5 = R1.L * R3.L (is)
ffa05b9e: MULT R1 = R3.L * R7.L (is)
ffa05ba2: SUB R1 = R6 - R1
ffa05ba4: MULT R2 = R2.L * R7.L (is)
ffa05ba8: ADD R2 = R2 + R5
ffa05baa: MULT R1 *= R0
ffa05bac: STORE W [I0++] = R1.H
ffa05bae: MULT R2 *= R0
ffa05bb0: STORE W [I1++] = R2.H
ffa05bb2: JUMP.S 0xffa05b5a
ffa05bb4: CC = R7 <= 0x0
ffa05bb6: LOAD R1 = 0x0
ffa05bb8: IF CC JUMP 0xffa05b00
ffa05bba: LOAD P2 = [SP + 0x30]
ffa05bbc: MOVE P1 = R7
ffa05bbe: MOVE I0 = P4
ffa05bc0: MOVE P0 = P5
ffa05bc2: LOAD R3.L = W [I0++]
ffa05bc4: LOAD R6 = W [P2++] (X)
ffa05bc6: MULT|| R2 = R3.L * R6.L (is)
ffa05bca: LOAD R1 = W [P0++] (X)
ffa05bcc: LOAD R5.L = W [I0++]
ffa05bce: MULT R3 = R1.L * R3.L (is)
ffa05bd2: MULT R4 = R1.L * R5.L (is)
ffa05bd6: MULT R6 = R6.L * R5.L (is)
ffa05bda: ADD R2 = R4 + R2
ffa05bdc: SUB R3 = R3 - R6
ffa05bde: ADD P1 += -0x1
ffa05be0: NEG R4 = -R2
ffa05be2: NEG R6 = -R3
ffa05be4: CC = P1 == 0x0
ffa05be6: MAX R2 = max(R4,R2)
ffa05bea: MAX R1 = max(R6,R3)
ffa05bee: LOAD R0 = 0x0
ffa05bf0: IF CC JUMP 0xffa05c2e
ffa05bf2: LSETUP (0xffa05bf6,0xffa05c2a) LC0 = P1
ffa05bf6: MAX|| R0 = max(R0,R1)
ffa05bfa: _LOAD R1 = W [P2++] (X)
ffa05bfc: _NOP
ffa05bfe: MAX|| R0 = max(R0,R2)
ffa05c02: _LOAD R2.L = W [I0++]
ffa05c04: _NOP
ffa05c06: MULT|| R6 = R2.L * R1.L (is)
ffa05c0a: LOAD R3 = W [P0++] (X)
ffa05c0c: NOP
ffa05c0e: MULT|| R5 = R3.L * R2.L (is)
ffa05c12: LOAD R2.L = W [I0++]
ffa05c14: NOP
ffa05c16: MULT R3 = R3.L * R2.L (is)
ffa05c1a: MULT R1 = R1.L * R2.L (is)
ffa05c1e: ADD R2 = R3 + R6
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

######## 2022D2E0 I0 stores
2022d2a0: LOAD R6 = -0x1
2022d2a2: CC = R2 <= 0x0
2022d2a4: STORE [P4 + 0x20] = R0
2022d2a6: STORE [P4 + 0x10] = R5
2022d2a8: STORE [P4 + 0x14] = R5
2022d2aa: STORE [P4 + 0x4] = R6
2022d2ac: STORE W [P4 + 0x0] = R7
2022d2ae: MOVE P5 = P4
2022d2b0: STORE [FP + 0x10] = P3
2022d2b2: ADD P4 += 0x4
2022d2b4: IF CC JUMP 0x2022d408
2022d2b6: LOAD R0 = 0x14
2022d2b8: LOAD R1 = 0x5
2022d2ba: MOVE P1 = P5
2022d2bc: STORE W [SP + 0x28] = R0
2022d2c0: STORE W [SP + 0x2a] = R1
2022d2c4: ADD P1 += 0x2
2022d2c6: ADD P1 += 0x22
2022d2c8: LOAD P2 = 0x6040
2022d2cc: ADD P2 = P3 + P2
2022d2ce: MOVE I1 = P1
2022d2d0: LOAD P1 = 0x2300
2022d2d4: STORE [FP + 0xc] = P2
2022d2d6: ADD P1 = P3 + P1
2022d2d8: MOVE P0 = P5
2022d2da: MOVE R0 = P5
2022d2dc: LOAD P2 = 0x5280
2022d2e0: STORE [FP + -0x8] = P1
2022d2e2: ADD P2 = P3 + P2
2022d2e4: ADD P0 += 0x6
2022d2e6: ADD R0 += 0x24
2022d2e8: LOAD P1 = -0x1
2022d2ea: STORE [FP + 0x24] = P2
2022d2ec: STORE [SP + 0x38] = P0
2022d2ee: STORE [FP + -0xc] = R0
2022d2f0: LSETUP (0x2022d2f4,0x2022d404) LC0 = P1
2022d2f4: LOAD R2 = W [P5] (X)
2022d2f6: LOAD R3 = [SP + 0x28]
2022d2f8: MULT R2 = R2.L * R3.L (is)
2022d2fc: MOVE P0 = R2
2022d2fe: LOAD P1 = [FP + 0xc]
2022d300: MOVE I0 = I1
2022d302: LOAD R4 = 0x5
2022d304: STORE W [P5 + 0x2] = R4
2022d306: ADD P1 = P1 + P0
2022d308: LOAD R2 = [P1]
2022d30a: MNOP||
2022d30e: _LOAD R0 = [FP + -0xc]
2022d310: _STORE W [I0++] = R2.H
2022d312: LOAD R2 = [P1 + 0x4]
2022d314: MNOP||
2022d318: _LOAD R4 = [FP + 0x10]
2022d31a: _STORE W [I0++] = R2.H
2022d31c: LOAD R2 = [P1 + 0x8]
2022d31e: STORE W [I0++] = R2.H
2022d320: LOAD R2 = [P1 + 0xc]
2022d322: STORE W [I0++] = R2.H
2022d324: LOAD R2 = [P1 + 0x10]
2022d326: STORE W [I0] = R2.H
2022d328: LOAD R1 = 0x5
2022d32a: LOAD P1.L = 0x33f8
2022d32e: LOAD P1.H = 0xffa0
2022d332: CALL (P1)
2022d334: MOVE P1 = R0
2022d336: LOAD R3 = 0x6040
2022d33a: ADD|| R3 = R4 + R3 (ns)
2022d33e: _LOAD R2 = W [P5] (X)
2022d340: _NOP
2022d342: LOAD R1 = [SP + 0x28]
2022d344: MULT|| R0 = R2.L * R1.L (is)
2022d348: STORE [P5 + 0x30] = R0
2022d34a: NOP
2022d34c: ADD|| R0 = R3 + R0 (ns)
2022d350: _LOAD R4 = W [P1 + 0x4] (X)
2022d352: _NOP
2022d354: LSH|| R4 = R4 << 0x2
2022d358: _LOAD P2 = [FP + 0x24]
2022d35a: _NOP
2022d35c: MOVE P0 = R2
2022d35e: ADD|| R0 = R0 + R4 (ns)
2022d362: _LOAD R1 = [FP + 0x18]
2022d364: _NOP
2022d366: MOVE P1 = R0
2022d368: LOAD R0 = [FP + -0x4]
2022d36a: ADD P2 = P2 + (P0 << 1)
2022d36c: LOAD R3 = W [P2] (X)
2022d36e: LOAD R4 = [P1]
2022d370: CC = R1 == R3
2022d372: SUB|| R1 = R0 - R4 (ns)
2022d376: _STORE [SP + 0x2c] = R3
2022d378: _NOP
2022d37a: NEG|| R0 = -R1 (ns)
2022d37e: _STORE [P5 + 0x34] = R4
2022d380: _NOP
2022d382: MAX|| R3 = max(R0,R1)
2022d386: _STORE [FP + 0x8] = R0
2022d388: _NOP
2022d38a: STORE [P5 + 0xc] = R3
2022d38c: IF !CC JUMP 0x2022d3c8
2022d38e: NOP
2022d390: LOAD P1 = [FP + -0x8]
2022d392: ADD P1 = P1 + (P0 << 2)
2022d394: LOAD R0 = [P1]
2022d396: CC = R0 < 0x0
2022d398: STORE [FP + 0x8] = R0
2022d39a: IF CC JUMP 0x2022d3c8
2022d39c: NOP
2022d39e: NOP
2022d3a0: LOAD P1 = [FP + 0x1c]

##### call sites to FIR/IQ
##### MOVE I* = within 30 insn of 0x44 and CALL
--- MOVEI @20212e4e 44=false beam=true
20212e0e: LOAD P1.L = 0x18f0
20212e12: LOAD P1.H = 0xffa0
20212e16: CALL (P1)
20212e18: LOAD R1 = [FP + -0x18]
20212e1a: LOAD P1.L = 0x18f0
20212e1e: LOAD P1.H = 0xffa0
20212e22: CALL (P1)
20212e24: LOAD P1 = [FP + 0x10]
20212e26: STORE [P5++] = R0
20212e28: LOAD R1 = [FP + -0x28]
20212e2a: LOAD R0 = [P1 + 0xc]
20212e2c: ASHIFT R0 >>>= 0x12
20212e2e: ADD R0 += 0x1
20212e30: CC = R1 < R0
20212e32: IF !CC JUMP 0x20212e36
20212e34: JUMP.S 0x20212dda
20212e36: LOAD R0 = 0x578
20212e3a: LOAD R1 = [FP + -0x54]
20212e3c: ADD R0 = R1 + R0
20212e3e: LOAD P1 = [FP + -0x24]
20212e40: LOAD P2 = 0x8514
20212e44: STORE [FP + -0x18] = R0
20212e46: ADD P2 = P4 + P2
20212e48: STORE [FP + -0x34] = P2
20212e4a: LOAD P0 = 0x147
20212e4e: MOVE I0 = P1 <<<MOVEI
20212e50: LOAD R6 = 0x5798
20212e54: LOAD R7 = 0x0
20212e56: LOAD P5 = [FP + -0x34]
20212e58: LSETUP (0x20212e5c,0x20212e8e) LC0 = P0
20212e5c: MNOP||
20212e60: _LOAD R2 = [FP + -0x18]
20212e62: _LOAD R0.L = W [I0]
20212e64: LOAD R1 = 0x5cfc
20212e68: MULT R0 = R0.L * R1.L (is)
20212e6c: ADD R0 = R2 + R0
20212e6e: ADD R0 = R0 + R6
20212e70: ADD R0 = R0 + R7
20212e72: MOVE P1 = R0
20212e74: ADD R7 += 0x2
20212e76: LOAD R0 = W [P1] (X)
20212e78: LOAD P1.L = 0x1688
20212e7c: LOAD P1.H = 0xffa0
20212e80: CALL (P1)
20212e82: MOVE R1 = R5
20212e84: LOAD P1.L = 0x18f0
20212e88: LOAD P1.H = 0xffa0
20212e8c: CALL (P1)
20212e8e: STORE [P5++] = R0
20212e90: LOAD P2 = [FP + 0x14]
20212e92: LOAD P1 = -0x39f0
20212e96: LOAD P1.H = 0x2
20212e9a: LOAD P0 = 0x39f0
20212e9e: LOAD P0.H = 0xfffd
20212ea2: LOAD R0 = 0x147
20212ea6: ADD P1 = P2 + P1

--- MOVEI @2021327a 44=false beam=true
20213236: LOAD P1.H = 0xffa0
2021323a: CALL (P1)
2021323c: ROT|| R1 = rot R0 by 0
20213240: _LOAD R0 = [FP + -0x58]
20213242: _NOP
20213244: LOAD P1.L = 0x1c74
20213248: LOAD P1.H = 0xffa0
2021324c: CALL (P1)
2021324e: ROT|| R1 = rot R5 by 0
20213252: _LOAD P1 = [FP + -0x2c]
20213254: _NOP
20213256: LOAD R2 = 0x5cfc
2021325a: STORE [FP + -0x14] = R0
2021325c: LOAD R0 = [FP + -0x18]
2021325e: LOAD R6 = W [P1] (X)
20213260: MULT|| R2 = R6.L * R2.L (is)
20213264: LOAD R5 = W [P5 + 0xc] (X)
20213266: NOP
20213268: LOAD R3 = W [SP + 0x8e] (Z)
2021326c: ADD R2 = R0 + R2
2021326e: MULT R3 = R6.L * R3.L (is)
20213272: MOVE P1 = R2
20213274: ADD R3 = R4 + R3
20213276: LSHIFT R5 <<= 0x2
20213278: ADD R3 = R3 + R5
2021327a: MOVE I0 = R3 <<<MOVEI
2021327c: LOAD R0 = [P1 + 0x5ce4]
20213280: LOAD P1.L = 0x18f0
20213284: LOAD P1.H = 0xffa0
20213288: CALL (P1)
2021328a: ROT|| R5 = rot R0 by 0
2021328e: _LOAD R1 = [FP + -0x14]
20213290: _NOP
20213292: MOVE R4 = R5
20213294: LOAD R0 = [I0]
20213296: LOAD P1.L = 0x18f0
2021329a: LOAD P1.H = 0xffa0
2021329e: CALL (P1)
202132a0: BITCLR (R5,0x1f)
202132a2: ROT|| R1 = rot R0 by 0
202132a6: _LOAD P0 = [FP + -0x38]
202132a8: _NOP
202132aa: CC = R7 < R5
202132ac: BITCLR (R0,0x1f)
202132ae: OR R6 = R5 | R0
202132b0: MOVE R2 = CC
202132b2: CC = R7 < R0
202132b4: LOAD R5 = 0x1
202132b6: IF !CC R5 = R2
202132b8: CC = R1 <= R4
202132ba: AND R3 = R4 & R1
202132bc: LSHIFT R3 >>= 0x1f
202132be: MOVE R0 = CC
202132c0: CC = R4 == R1
202132c2: XOR R3 = R3 ^ R0
202132c4: IF !CC R0 = R3

--- MOVEI @20214348 44=false beam=true
2021430e: MOVE P1 = R0
20214310: STORE [FP + -0x8] = R2
20214312: LOAD R2 = 0x5cfc
20214316: LOAD R7 = [FP + -0xc]
20214318: ADD P1 = P2 + P1
2021431a: STORE [P1 + 0x5cd8] = R1
2021431e: LOAD R0 = W [P0] (X)
20214320: MULT|| R0 = R0.L * R2.L (is)
20214324: LOAD P0 = [FP + 0x10]
20214326: NOP
20214328: MOVE P1 = R0
2021432a: LOAD R5 = [FP + -0x8]
2021432c: BITCLR (R1,0x1f)
2021432e: CC = R1 == 0x0
20214330: ADD P1 = P2 + P1
20214332: STORE [P1 + 0x5cf0] = R5
20214336: LOAD R0 = [P0 + 0xc]
20214338: ASHIFT R0 >>>= 0x11
2021433a: ADD R0 += 0x1
2021433c: IF CC JUMP 0x20214464
2021433e: CC = R0 <= 0x0
20214340: IF CC JUMP 0x2021439e
20214342: LOAD R4 = 0x0
20214344: LOAD R6 = 0x0
20214346: LOAD P1 = [FP + -0x50]
20214348: MOVE I0 = P1 <<<MOVEI
2021434a: LOAD P1 = -0x1
2021434c: LSETUP (0x20214350,0x20214398) LC1 = P1
20214350: ROT|| R1 = rot R7 by 0
20214354: _LOAD P1 = [FP + -0x24]
20214356: _LOAD R0 = [I0++]
20214358: LOAD R3 = 0x5cfc
2021435c: ADD R4 += 0x1
2021435e: LOAD R2 = W [P1] (X)
20214360: MULT|| R2 = R2.L * R3.L (is)
20214364: LOAD R3 = [FP + -0x18]
20214366: NOP
20214368: ADD R2 = R3 + R2
2021436a: LOAD R3 = 0x2938
2021436e: ADD R2 = R2 + R3
20214370: ADD R2 = R2 + R6
20214372: MOVE P0 = R2
20214374: LOAD P1.L = 0x1814
20214378: LOAD P1.H = 0xffa0
2021437c: CALL (P1)
2021437e: LOAD P1.L = 0x290c
20214382: LOAD P1.H = 0xffa0
20214386: CALL (P1)
20214388: LOAD P1 = [FP + 0x10]
2021438a: MOVE R1 = R4.L (X)
2021438c: STORE W [P0] = R0.L
2021438e: ADD R6 += 0x2
20214390: LOAD R0 = [P1 + 0xc]
20214392: ASHIFT R0 >>>= 0x11
20214394: ADD R0 += 0x1
20214396: CC = R1 < R0

--- MOVEI @2022d188 44=false beam=true
2022d14e: LOAD P1 = [FP + 0x8]
2022d150: STORE [P3++] = R0
2022d152: MOVE R1 = R7.L (X)
2022d154: LOAD R0 = [P1 + 0xc]
2022d156: ASHIFT R0 >>>= 0xf
2022d158: ADD R0 += 0x1
2022d15a: CC = R1 < R0
2022d15c: IF !CC JUMP 0x2022d160
2022d15e: JUMP.S 0x2022d116
2022d160: LOAD P1 = [FP + 0x8]
2022d162: LOAD R0 = [P1 + 0xc]
2022d164: ASHIFT R0 >>>= 0x12
2022d166: ADD R0 += 0x1
2022d168: CC = R0 <= 0x0
2022d16a: IF CC JUMP 0x2022d22c
2022d16c: LOAD P0 = 0x6660
2022d170: LOAD P1 = 0x709c
2022d174: LOAD R0 = 0x578
2022d178: LOAD R1 = [SP + 0x28]
2022d17a: LOAD P2 = 0x7ad8
2022d17e: ADD P3 = P5 + P0
2022d180: ADD P1 = P5 + P1
2022d182: ADD R4 = R1 + R0
2022d184: ADD P5 = P5 + P2
2022d186: LOAD R7 = 0x0
2022d188: MOVE I1 = P1 <<<MOVEI
2022d18a: LOAD P1 = -0x1
2022d18c: LSETUP (0x2022d190,0x2022d224) LC0 = P1
2022d190: LOAD R0 = W [P4] (X)
2022d192: MULT R0 = R0.L * R5.H (is)
2022d196: ADD R0 = R4 + R0
2022d198: LOAD R2 = 0x3374
2022d19c: ADD R0 = R0 + R2
2022d19e: ADD R0 = R0 + R7
2022d1a0: MOVE P1 = R0
2022d1a2: ADD R6 += 0x1
2022d1a4: LOAD R0 = W [P1] (X)
2022d1a6: LOAD P1.L = 0x1688
2022d1aa: LOAD P1.H = 0xffa0
2022d1ae: CALL (P1)
2022d1b0: LOAD R1 = [SP + 0x34]
2022d1b2: LOAD P1.L = 0x18f0
2022d1b6: LOAD P1.H = 0xffa0
2022d1ba: CALL (P1)
2022d1bc: STORE [P3++] = R0
2022d1be: LOAD R0 = W [P4] (X)
2022d1c0: MULT R0 = R0.L * R5.H (is)
2022d1c4: ADD R0 = R4 + R0
2022d1c6: LOAD R2 = 0x3892
2022d1ca: ADD R0 = R0 + R2
2022d1cc: ADD R0 = R0 + R7
2022d1ce: MOVE P1 = R0
2022d1d0: LOAD R0 = W [P1] (X)
2022d1d2: LOAD P1.L = 0x1688
2022d1d6: LOAD P1.H = 0xffa0
2022d1da: CALL (P1)

--- MOVEI @2023015e 44=false beam=true
2023011a: LOAD R1 = W [P3 + -0xa6] (X)
2023011e: LOAD R5.H = 0x5cfc
20230122: MULT|| R1 = R1.L * R5.H (is)
20230126: LOAD P5 = [FP + -0x78]
20230128: NOP
2023012a: ADD|| R2 = R7 + R1 (ns)
2023012e: _STORE [FP + -0xc] = R1
20230130: _NOP
20230132: LOAD R3 = 0x3
20230134: LOAD P1 = 0x3
20230136: STORE [P3 + -0x6c] = R0
2023013a: STORE [FP + 0xc] = R2
2023013c: STORE [FP + -0x28] = R3
2023013e: MOVE I1 = R2
20230140: LOAD R6 = 0x0
20230142: LOAD M0 = 0x8
20230146: LSETUP (0x2023014a,0x2023028a) LC1 = P1
2023014a: LOAD R0 = 0x594
2023014e: LOAD R2 = [FP + -0x34]
20230150: ADD|| R0 = R2 + R0 (ns)
20230154: _LOAD R1 = [FP + -0xc]
20230156: _NOP
20230158: ADD R0 = R0 + R1
2023015a: LOAD P1 = 0x3
2023015c: MOVE P4 = I1
2023015e: MOVE I2 = R0 <<<MOVEI
20230160: LOAD R7 = 0x0
20230162: LSETUP (0x20230166,0x20230280) LC0 = P1
20230166: CC = R6 == R7
20230168: IF CC JUMP 0x2023027a
2023016a: CC = R6 <= 0x0
2023016c: IF CC JUMP 0x202301f4
2023016e: NOP
20230170: NOP
20230172: LOAD P1 = [FP + 0xc]
20230174: LOAD R2 = [P5]
20230176: STORE [FP + -0x4] = R2
20230178: LOAD R2 = [P5 + 0x4]
2023017a: MOVE I0 = P1
2023017c: MNOP||
20230180: _STORE [FP + 0x8] = R2
20230182: _LOAD R3 = [I0++]
20230184: MNOP||
20230188: _STORE [FP + -0x10] = R3
2023018a: _LOAD R5 = [I0]
2023018c: LOAD R1 = [FP + -0x4]
2023018e: BITTGL (R5,0x1f)
20230190: LOAD R0 = [FP + -0x10]
20230192: LOAD P1.L = 0x18f0
20230196: LOAD P1.H = 0xffa0
2023019a: CALL (P1)
2023019c: ROT|| R1 = rot R5 by 0
202301a0: _STORE [FP + 0x10] = R0
202301a2: _NOP
202301a4: LOAD R0 = [FP + 0x8]
202301a6: LOAD P1.L = 0x18f0

--- MOVEI @ffa04772 44=false beam=true
ffa0472e: CALL 0xffa01814
ffa04732: ROT|| R4 = rot R0 by 0
ffa04736: _STORE [FP + -0x8] = R0
ffa04738: _NOP
ffa0473a: LOAD R0 = [P2 + 0x5cf4]
ffa0473e: MOVE R1 = R7
ffa04740: CALL 0xffa01814
ffa04744: ROT|| R5 = rot R0 by 0
ffa04748: _STORE [FP + -0x4] = R0
ffa0474a: _NOP
ffa0474c: LOAD R1 = [FP + -0x40]
ffa0474e: LOAD R0 = [FP + -0x28]
ffa04750: STORE [FP + 0xc] = P0
ffa04752: LOAD P1.L = 0xd05e
ffa04756: LOAD P1.H = 0x2022
ffa0475a: CALL (P1)
ffa0475c: LOAD R2 = [FP + 0x28]
ffa0475e: LOAD R3 = 0x7
ffa04760: CC = R2 == R3
ffa04762: IF CC JUMP 0xffa04766 (bp)
ffa04764: JUMP.S 0xffa054c6
ffa04766: LOAD R0 = 0x578
ffa0476a: LOAD R1 = [FP + -0x40]
ffa0476c: LOAD P1 = 0x147
ffa04770: ADD R6 = R1 + R0
ffa04772: MOVE I0 = P4 <<<MOVEI
ffa04774: LOAD P3 = [FP + -0x48]
ffa04776: LOAD R7 = 0x0
ffa04778: LSETUP (0xffa0477c,0xffa047c4) LC0 = P1
ffa0477c: LOAD R0 = W [P5] (X)
ffa0477e: LOAD R1 = 0x5cfc
ffa04782: MULT R0 = R0.L * R1.L (is)
ffa04786: ADD R0 = R6 + R0
ffa04788: LOAD R2 = 0x5a26
ffa0478c: ADD R0 = R0 + R2
ffa0478e: ADD R0 = R0 + R7
ffa04790: MOVE P1 = R0
ffa04792: LOAD R0 = W [P1] (X)
ffa04794: CALL 0xffa01688
ffa04798: MOVE R1 = R4
ffa0479a: CALL 0xffa018f0
ffa0479e: STORE [I0++] = R0
ffa047a0: LOAD R0 = W [P5] (X)
ffa047a2: LOAD R1 = 0x5cfc
ffa047a6: MULT R0 = R0.L * R1.L (is)
ffa047aa: ADD R0 = R6 + R0
ffa047ac: LOAD R2 = 0x5798
ffa047b0: ADD R0 = R0 + R2
ffa047b2: ADD R0 = R0 + R7
ffa047b4: MOVE P1 = R0
ffa047b6: ADD R7 += 0x2
ffa047b8: LOAD R0 = W [P1] (X)
ffa047ba: CALL 0xffa01688
ffa047be: MOVE R1 = R5
ffa047c0: CALL 0xffa018f0
ffa047c4: STORE [P3++] = R0

--- MOVEI @ffa04b96 44=true beam=true
ffa04b58: LOAD M0.H = 0x3
ffa04b5c: ADD P1 = P3 + P1
ffa04b5e: STORE [P1 + 0x5ce4] = R3
ffa04b62: LOAD R0 = W [P5] (X)
ffa04b64: MOVE P1 = R0
ffa04b66: MULT R1 = R0.L * R1.L (is)
ffa04b6a: MOVE P2 = R1
ffa04b6c: ADD P1 = P0 + (P1 << 2)
ffa04b6e: LOAD R2 = [P1]
ffa04b70: ADD P2 = P3 + P2
ffa04b72: STORE [P2 + 0x5ce8] = R2
ffa04b76: IF CC JUMP 0xffa04be2
ffa04b78: NOP
ffa04b7a: LOAD P1 = [FP + 0x18]
ffa04b7c: LOAD P0 = [FP + -0x5c]
ffa04b7e: LOAD R0 = [P1 + 0xc]
ffa04b80: ASHIFT R0 >>>= 0xf
ffa04b82: ADD R0 += 0x1
ffa04b84: CC = R0 <= 0x0
ffa04b86: STORE W [P0 + -0x6] = R7
ffa04b8a: IF CC JUMP 0xffa04be2
ffa04b8c: LOAD P0 = 0x0
ffa04b8e: LOAD R6 = 0x0
ffa04b90: LOAD P2 = 0x44
ffa04b94: LOAD P1 = [FP + -0x44]
ffa04b96: MOVE I0 = P1 <<<MOVEI
ffa04b98: LOAD P1 = -0x1
ffa04b9a: LSETUP (0xffa04b9e,0xffa04bd6) LC1 = P1
ffa04b9e: MNOP||
ffa04ba2: _LOAD R1 = [FP + 0x8]
ffa04ba4: _LOAD R0 = [I0++]
ffa04ba6: CALL 0xffa01814
ffa04baa: CALL 0xffa0290c
ffa04bae: LOAD R4 = W [P5] (X)
ffa04bb0: LOAD R1 = 0x5cfc
ffa04bb4: MULT|| R1 = R4.L * R1.L (is)
ffa04bb8: LOAD P3 = [FP + 0xc]
ffa04bba: NOP
ffa04bbc: MOVE P1 = R1
ffa04bbe: ADD R6 += 0x1
ffa04bc0: MOVE R2 = R6.L (X)
ffa04bc2: ADD P1 = P3 + P1
ffa04bc4: LOAD P3 = [FP + 0x18]
ffa04bc6: ADD P1 = P1 + P2
ffa04bc8: ADD P1 = P1 + P0
ffa04bca: STORE W [P1] = R0.L
ffa04bcc: LOAD R0 = [P3 + 0xc]
ffa04bce: ASHIFT R0 >>>= 0xf
ffa04bd0: ADD R0 += 0x1
ffa04bd2: CC = R2 < R0
ffa04bd4: ADD P0 += 0x2
ffa04bd6: IF !CC JUMP 0xffa04bdc
ffa04bd8: MOVE P1 = I0
ffa04bda: JUMP.S 0xffa04b96
ffa04bdc: LOAD P1 = [FP + -0x5c]
ffa04bde: STORE W [P1 + -0x6] = R6

--- MOVEI @ffa04c7a 44=false beam=true
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
ffa04c7a: MOVE I0 = P1 <<<MOVEI
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

--- MOVEI @ffa04cee 44=false beam=true
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
ffa04cee: MOVE I0 = P1 <<<MOVEI
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

--- MOVEI @ffa04dd0 44=false beam=true
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
ffa04dd0: MOVE I0 = P0 <<<MOVEI
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

--- MOVEI @ffa04ea4 44=false beam=true
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
ffa04ea4: MOVE I0 = P1 <<<MOVEI
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

