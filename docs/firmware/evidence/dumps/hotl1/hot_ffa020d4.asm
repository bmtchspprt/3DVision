ffa020d4: LINK 0x8
ffa020d8: PUSH [--SP] = (R7:4,P5:5)
ffa020da: MOVE R7 = R0
ffa020dc: LOAD R2 = 0xe00
ffa020e0: BITCLR (R7,0x1f)
ffa020e2: MOVE R1 = R2
ffa020e4: LOAD R1.H = 0x47c9
ffa020e8: CC = R7 <= R1
ffa020ea: MOVE R4 = R0
ffa020ec: ADD SP += -0x10
ffa020ee: IF !CC JUMP 0xffa022de
ffa020f0: LOAD R2 = 0x4f3
ffa020f4: MOVE R1 = R2
ffa020f6: LOAD R1.H = 0x39b5
ffa020fa: CC = R1 < R7
ffa020fc: IF !CC JUMP 0xffa02244
ffa020fe: MOVE R1 = R7
ffa02100: LOAD R0 = -0x67d
ffa02104: LOAD R0.H = 0x3ea2
ffa02108: CALL 0xffa018f0
ffa0210c: LOAD R1 = 0x0
ffa0210e: LOAD R1.H = 0x3f00
ffa02112: CALL 0xffa01716
ffa02116: CALL 0xffa014dc
ffa0211a: LOAD R2 = 0xfdb
ffa0211e: MOVE R6 = R2
ffa02120: LOAD R6.H = 0x46c9
ffa02124: CC = R6 <= R7
ffa02126: MOVE R1 = CC
ffa02128: CC = R0 <= 0x0
ffa0212a: MOVE R5 = R0
ffa0212c: LSH R6 = R1 << 0x1
ffa02130: IF !CC JUMP 0xffa02250
ffa02132: MOVE R0 = R7
ffa02134: LOAD R1 = 0x1e
ffa02136: CALL 0xffa01564
ffa0213a: LOAD R2 = 0x504f
ffa0213e: ABS R3 = abs R0
ffa02142: MOVE R1 = R2
ffa02144: LOAD R1.H = 0xb
ffa02148: CC = R1 < R3
ffa0214a: IF !CC JUMP 0xffa02214
ffa0214c: MAC A1 = R0.L * R0.L (fu)
ffa02150: LOAD R1 = 0x80
ffa02154: MAC A1 += R1.L * R1.L 
ffa02158: LSH A1 = A1 >> 0x10
ffa0215c: MAC A1 += R0.H * R0.L (m),A0 = R0.H * R0.H 
ffa02160: MAC A1 += R0.H * R0.L (m)
ffa02164: MAC A1 += R1.L * R1.L (fu)
ffa02168: ASH A1 = A1 >>> 0xf
ffa0216c: LOAD P1.L = 0x3618
ffa02170: LOAD P1.H = 0xff80
ffa02174: MOVE|| R0 = (A0 += A1)
ffa02178: LOAD R2 = [P1++]
ffa0217a: NOP
ffa0217c: MAC|| A1 = R0.L * R2.L (fu)
ffa02180: LOAD R3 = [P1++]
ffa02182: NOP
ffa02184: MAC A1 += R1.L * R1.L 
ffa02188: LSH A1 = A1 >> 0x10
ffa0218c: MAC A1 += R0.H * R2.L (m),A0 = R0.H * R2.H 
ffa02190: MAC A1 += R2.H * R0.L (m)
ffa02194: MAC A1 += R1.L * R1.L (fu)
ffa02198: ASH A1 = A1 >>> 0xf
ffa0219c: MOVE R2 = (A0 += A1)
ffa021a0: ADD R2 = R2 + R3 (s)
ffa021a4: LOAD P0 = 0x3
ffa021a6: MAC A1 = R2.L * R0.L (fu)
ffa021aa: MAC A1 += R1.L * R1.L 
ffa021ae: LSH A1 = A1 >> 0x10
ffa021b2: MAC A1 += R2.H * R0.L (m),A0 = R2.H * R0.H 
ffa021b6: MAC A1 += R0.H * R2.L (m)
ffa021ba: MAC A1 += R1.L * R1.L (fu)
ffa021be: ASH A1 = A1 >>> 0xf
ffa021c2: LSETUP (0xffa021c6,0xffa021ea) LC0 = P0
ffa021c6: MOVE|| R2 = (A0 += A1)
ffa021ca: LOAD R3 = [P1++]
ffa021cc: NOP
ffa021ce: ADD R2 = R2 + R3 (s)
ffa021d2: MAC A1 = R2.L * R0.L (fu)
ffa021d6: MAC A1 += R1.L * R1.L 
ffa021da: LSH A1 = A1 >> 0x10
ffa021de: MAC A1 += R2.H * R0.L (m),A0 = R2.H * R0.H 
ffa021e2: MAC A1 += R0.H * R2.L (m)
ffa021e6: MAC A1 += R1.L * R1.L (fu)
ffa021ea: ASH A1 = A1 >>> 0xf
ffa021ee: MOVE R0 = (A0 += A1)
ffa021f2: ASH R1 = R0 >>> 0x1f
ffa021f6: CALL 0xffa015b4
ffa021fa: LOAD R6 = 0x0
ffa021fc: LOAD R6.H = 0xf080
ffa02200: CC = R0 == 0x0
ffa02202: ADD R1 = R0 + R6
ffa02204: IF !CC R0 = R1
ffa02206: MOVE R1 = R7
ffa02208: CALL 0xffa018f0
ffa0220c: MOVE R1 = R7
ffa0220e: CALL 0xffa01716
ffa02212: MOVE R7 = R0
ffa02214: LOAD R0 = -0x1
ffa02216: LSHIFT R0 <<= 0x17
ffa02218: CC = R4 <= R0
ffa0221a: LOAD R0 = 0x1
ffa0221c: AND R2 = R5 & R0
ffa0221e: MOVE R1 = R7
ffa02220: MOVE R0 = R7
ffa02222: LSH R3 = R4 >> 0x1f
ffa02226: LOAD R7 = 0x0
ffa02228: BITTGL (R4,0x1f)
ffa0222a: ADD SP += 0x10
ffa0222c: IF !CC R3 = R7
ffa0222e: CC = R4 == 0x0
ffa02230: LOAD P0 = [FP + 0x4]
ffa02232: IF CC R3 = R4
ffa02234: XOR R2 = R3 ^ R2
ffa02236: POP (R7:4,P5:5) = [SP++]
ffa02238: CC = R2 == 0x0
ffa0223a: BITTGL (R1,0x1f)
ffa0223c: UNLINK
ffa02240: IF !CC R0 = R1
ffa02242: JUMP (P0)
ffa02244: ADD SP += 0x10
ffa02246: LOAD P0 = [FP + 0x4]
ffa02248: POP (R7:4,P5:5) = [SP++]
ffa0224a: UNLINK
ffa0224e: JUMP (P0)
ffa02250: LOAD R3 = 0x30
ffa02252: SUB R3 = R3 - R6
ffa02254: ASH|| R0 = R6 >>> 0x1
ffa02258: _STORE [SP + 0x28] = R3
ffa0225a: _NOP
ffa0225c: LSHIFT R0 <<= 0x3
ffa0225e: LOAD R2.L = 0x3608
ffa02262: LOAD R2.H = 0xff80
ffa02266: ADD R0 = R2 + R0
ffa02268: MOVE P5 = R0
ffa0226a: ROT|| R0 = rot R7 by 0
ffa0226e: _LOAD R1 = [SP + 0x28]
ffa02270: _NOP
ffa02272: CALL 0xffa01564
ffa02276: ROT|| R7 = rot R0 by 0
ffa0227a: _LOAD R2 = [SP + 0x28]
ffa0227c: _NOP
ffa0227e: LSH|| R3 = R2 << 0x17
ffa02282: _STORE [SP + 0x3c] = R1
ffa02284: _NOP
ffa02286: ROT|| R0 = rot R5 by 0
ffa0228a: _LOAD R2 = [P5++]
ffa0228c: _NOP
ffa0228e: STORE [SP + 0x28] = R3
ffa02290: LOAD R3 = [P5]
ffa02292: STORE [SP + 0xc] = R3
ffa02294: LOAD R1 = 0x0
ffa02296: CALL 0xffa01c38
ffa0229a: CC = R7 < R0 (IU)
ffa0229c: SUB|| R2 = R7 - R0 (ns)
ffa022a0: _LOAD R7 = [SP + 0x3c]
ffa022a2: _NOP
ffa022a4: MOVE R3 = CC
ffa022a6: SUB|| R3 = R7 - R3 (ns)
ffa022aa: _STORE [SP + 0x24] = R2
ffa022ac: _NOP
ffa022ae: SUB R3 = R3 - R1
ffa022b0: STORE [SP + 0x3c] = R3
ffa022b2: LOAD R0 = [SP + 0x24]
ffa022b4: LOAD R1 = [SP + 0x3c]
ffa022b6: CALL 0xffa015b4
ffa022ba: ROT|| R7 = rot R0 by 0
ffa022be: _LOAD R3 = [SP + 0x28]
ffa022c0: _NOP
ffa022c2: LOAD R2 = 0x12
ffa022c4: CC = R0 == 0x0
ffa022c6: SUB|| R3 = R0 - R3 (ns)
ffa022ca: _LOAD R1 = [SP + 0x3c]
ffa022cc: _NOP
ffa022ce: SUB|| R2 = R6 - R2 (ns)
ffa022d2: _LOAD R0 = [SP + 0x24]
ffa022d4: _NOP
ffa022d6: IF !CC R7 = R3
ffa022d8: CALL 0xffa004c0
ffa022dc: JUMP.S 0xffa0213a
ffa022de: ADD SP += 0x10
ffa022e0: LOAD P0 = [FP + 0x4]
ffa022e2: POP (R7:4,P5:5) = [SP++]
ffa022e4: UNLINK
ffa022e8: LOAD R0 = 0x0
ffa022ea: JUMP (P0)
