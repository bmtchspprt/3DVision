ffa003e4: MAC A1 += R7.H * R0.L (m)
ffa003e8: MAC A1 += R2.L * R2.L (fu)
ffa003ec: ASH A1 = A1 >>> 0xf
ffa003f0: CC = BITTST (R4,0x0)
ffa003f2: MOVE|| R2 = (A0 += A1)
ffa003f6: LOAD R4 = [SP + 0x2c]
ffa003f8: NOP
ffa003fa: ADD R2 = R2 + R4 (s)
ffa003fe: ASH R7 = R2 >>> 0x1f
ffa00402: LSH|| R0 = R3 << 0x1f
ffa00406: _STORE [SP + 0xc] = R7
ffa00408: _NOP
ffa0040a: ROT R1 = rot R3 by -0x1
ffa0040e: CALL 0xffa01258
ffa00412: CALL 0xffa02894
ffa00416: MOVE R1 = R5
ffa00418: CALL 0xffa018f0
ffa0041c: MOVE R1 = R5
ffa0041e: CALL 0xffa01716
ffa00422: CC = R6 < 0x0
ffa00424: LOAD P1.L = 0x342c
ffa00428: LOAD P1.H = 0xff80
ffa0042c: IF !CC JUMP 0xffa0044e
ffa0042e: NOP
ffa00430: ADD P5 += 0x2
ffa00432: ADD P1 = P1 + (P5 << 2)
ffa00434: LOAD R7 = [P1]
ffa00436: MOVE R1 = R7
ffa00438: CALL 0xffa01716
ffa0043c: MOVE R1 = R7
ffa0043e: CALL 0xffa01716
ffa00442: ADD SP += 0x10
ffa00444: LOAD P0 = [FP + 0x4]
ffa00446: POP (R7:4,P5:5) = [SP++]
ffa00448: UNLINK
ffa0044c: JUMP (P0)
ffa0044e: ADD P1 = P1 + (P5 << 2)
ffa00450: ROT|| R1 = rot R0 by 0
ffa00454: _LOAD R7 = [P1]
ffa00456: _NOP
ffa00458: MOVE R0 = R7
ffa0045a: CALL 0xffa01714
ffa0045e: MOVE R1 = R7
ffa00460: CALL 0xffa01716
