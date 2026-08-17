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
