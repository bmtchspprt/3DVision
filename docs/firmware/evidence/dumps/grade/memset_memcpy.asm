ffa05f2e: LINK 0x0
ffa05f32: CC = R2 <= 0x0
ffa05f34: PUSH [--SP] = R7
ffa05f36: MOVE P0 = R0
ffa05f38: IF CC JUMP 0xffa05f7a
ffa05f3a: LSH R3 = R0 << 0x1f
ffa05f3e: MOVE CC = az
ffa05f40: MOVE P1 = R2
ffa05f42: IF !CC JUMP 0xffa05f8a
ffa05f44: CC = R2 == 0x1
ffa05f46: IF CC JUMP 0xffa05f78
ffa05f48: LSH R3 = R1 << 0x8
ffa05f4c: OR R7 = R1 | R3
ffa05f4e: ASH R3 = R2 >>> 0x1
ffa05f52: LSHIFT R0 <<= 0x1e
ffa05f54: MOVE CC = az
ffa05f56: MOVE P1 = R3
ffa05f58: IF !CC JUMP 0xffa05f82
ffa05f5a: CC = R3 == 0x1
ffa05f5c: IF CC JUMP 0xffa05f72
ffa05f5e: ASH R0 = R3 >>> 0x1
ffa05f62: MOVE P1 = R0
ffa05f64: PACK R7 = pack(R7.L,R7.L)
ffa05f68: LSETUP (0xffa05f6c,0xffa05f6c) LC0 = P1
ffa05f6c: STORE [P0++] = R7
ffa05f6e: CC = BITTST (R3,0x0)
ffa05f70: IF !CC JUMP 0xffa05f74
ffa05f72: STORE W [P0++] = R7
ffa05f74: CC = BITTST (R2,0x0)
ffa05f76: IF !CC JUMP 0xffa05f7a
ffa05f78: STORE B [P0] = R1
ffa05f7a: LOAD R7 = [SP++]
ffa05f7c: UNLINK
ffa05f80: RTS
ffa05f82: LSETUP (0xffa05f86,0xffa05f86) LC0 = P1
ffa05f86: STORE W [P0++] = R7
ffa05f88: JUMP.S 0xffa05f74
ffa05f8a: LSETUP (0xffa05f8e,0xffa05f8e) LC0 = P1
ffa05f8e: STORE B [P0++] = R1
ffa05f90: JUMP.S 0xffa05f7a
ffa05f92: CC = R2 <= 0x0
ffa05f94: LINK 0x0
ffa05f98: MOVE P0 = R1
ffa05f9a: MOVE P2 = R0
ffa05f9c: IF CC JUMP 0xffa05faa
ffa05f9e: NOP
ffa05fa0: MOVE P1 = R2
ffa05fa2: LSETUP (0xffa05fa6,0xffa05fa8) LC0 = P1
ffa05fa6: LOAD R0 = B [P0++] (Z)
ffa05fa8: STORE B [P2++] = R0
ffa05faa: UNLINK
ffa05fae: RTS
ffa05fb0: LOAD R1 = 0xa028
ffa05fb4: MULT R1 *= R0
ffa05fb6: LOAD R0 = 0x6999
ffa05fba: MAC R3 = (A1 = R1.L * R0.L) (fu)
ffa05fbe: LSH A1 = A1 >> 0x10
ffa05fc2: LOAD R2 = 0x3326
ffa05fc6: MAC A1 += R2.L * R1.L (m,is)
ffa05fca: LINK 0x0
ffa05fce: MAC A1 += R1.H * R0.L (m,is)
ffa05fd2: UNLINK
ffa05fd6: ASH A1 = A1 >>> 0x10
ffa05fda: MAC R3 = (A1 += R1.H * R2.L) (is)
ffa05fde: ASHIFT R1 >>>= 0x1f
ffa05fe0: ASHIFT R3 >>>= 0xe
ffa05fe2: SUB R0 = R3 - R1
ffa05fe4: RTS
ffa05fe6: LINK 0x10
ffa05fea: STORE [SP + 0xc] = R7
ffa05fec: STORE [SP + 0x18] = R0
ffa05fee: MOVE R0 = R0.L (X)
ffa05ff0: CALL 0xffa02948
ffa05ff4: MOVE R7 = R0
ffa05ff6: LOAD R0 = W [SP + 0x1a] (X)
ffa05ff8: CALL 0xffa02948
ffa05ffc: MOVE R1 = R0
ffa05ffe: MOVE R0 = R7
ffa06000: LOAD R7 = [SP + 0xc]
ffa06002: UNLINK
ffa06006: RTS
ffa06008: LINK 0x5c
ffa0600c: PUSH [--SP] = (R7:4,P5:3)
ffa0600e: ADD SP += -0x10
ffa06010: STORE B [FP + 0x10] = R2
ffa06014: STORE [FP + 0xc] = R1
ffa06016: STORE [FP + 0x8] = R0
ffa06018: MOVE P1 = FP
ffa0601a: ADD P1 += -0x3c
ffa0601c: MOVE R2 = CYCLES
ffa0601e: MOVE R1 = CYCLES2
ffa06020: STORE [P1] = R2
ffa06022: STORE [P1 + 0x4] = R1
ffa06024: LOAD R0 = [FP + -0x3c]
ffa06026: LOAD R1 = [FP + -0x38]
ffa06028: STORE [FP + -0x44] = R0
ffa0602a: STORE [FP + -0x40] = R1
ffa0602c: STORE [FP + -0xc] = R0
ffa0602e: STORE [FP + -0x8] = R0
ffa06030: LOAD P1 = 0x208
ffa06034: LOAD P1.H = 0xffc0
ffa06038: LOAD R6 = 0x0
ffa0603a: STORE [P1] = R6
ffa0603c: LOAD R0 = [FP + 0xc]
ffa0603e: CC = R0 == 0x0
ffa06040: IF CC JUMP 0xffa0604e
