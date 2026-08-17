ffa00820: LOAD R0 = [SP + 0x38]
ffa00822: NOP
ffa00824: MAC A1 += R2.L * R2.L (fu)
ffa00828: ASH A1 = A1 >>> 0xf
ffa0082c: MOVE R2 = (A0 += A1)
ffa00830: ADD R2 = R2 + R0 (s)
ffa00834: ASH R7 = R3 >>> 0x1f
ffa00838: ASH R0 = R2 >>> 0x1f
ffa0083c: LSH|| R1 = R3 >> 0x2
ffa00840: _STORE [SP + 0xc] = R0
ffa00842: _NOP
ffa00844: LSHIFT R7 <<= 0x1e
ffa00846: OR R1 = R7 | R1
ffa00848: LSH R0 = R3 << 0x1e
ffa0084c: CALL 0xffa01150
ffa00850: CALL 0xffa02894
ffa00854: MOVE R1 = R4
ffa00856: CALL 0xffa018f0
ffa0085a: MOVE R1 = R4
ffa0085c: CALL 0xffa01716
ffa00860: CC = P5 <= 0x0
ffa00862: IF CC JUMP 0xffa0087e
ffa00864: CC = P5 <= 0x1
ffa00866: MOVE R1 = R0
ffa00868: ADD P5 += -0x1
ffa0086a: LOAD P1.L = 0x3450
ffa0086e: LOAD P1.H = 0xff80
ffa00872: BITTGL (R1,0x1f)
ffa00874: ADD P1 = P1 + (P5 << 2)
ffa00876: IF !CC R0 = R1
ffa00878: LOAD R1 = [P1]
ffa0087a: CALL 0xffa01716
ffa0087e: LOAD R1 = [SP + 0x30]
ffa00880: CC = R1 < 0x0
ffa00882: IF !CC JUMP 0xffa00896
ffa00884: CC = R6 == 0x0
ffa00886: IF CC JUMP 0xffa00896
ffa00888: MOVE R1 = R0
ffa0088a: LOAD R0 = 0xfdb
ffa0088e: LOAD R0.H = 0x4049
ffa00892: CALL 0xffa01714
ffa00896: LOAD R1 = [SP + 0x34]
ffa00898: CC = R1 < 0x0
ffa0089a: IF !CC JUMP 0xffa008a4
ffa0089c: CC = R5 == 0x0
ffa0089e: MOVE R1 = R0
ffa008a0: BITTGL (R1,0x1f)
