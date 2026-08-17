ffa00306: LOAD R0.H = 0x39b5
ffa0030a: CC = R0 <= R5
ffa0030c: IF !CC JUMP 0xffa00498
ffa0030e: MOVE R0 = R5
ffa00310: CALL 0xffa028c8
ffa00314: LOAD R1 = 0x0
ffa00316: BITSET (R1,0x1e)
ffa00318: CC = R1 < R0
ffa0031a: IF !CC JUMP 0xffa00470
ffa0031c: SUB R0 = R1 - R0 (s)
ffa00320: ADD R0 = R0 + R1 (s)
ffa00324: ASH R7 = R0 >>> 0x1
ffa00328: MOVE R0 = R7
ffa0032a: CALL 0xffa0236c
ffa0032e: NEG R0 = -R0 (s)
ffa00332: ASH R0 = R0 << 0x1 (s)
ffa00336: CALL 0xffa02894
ffa0033a: MOVE R5 = R0
ffa0033c: LOAD P5 = 0x0
ffa0033e: LOAD P1.L = 0x3418
ffa00342: LOAD P1.H = 0xff80
ffa00346: LOAD R1 = [P1]
ffa00348: MAC|| A1 = R1.L * R7.L (fu)
ffa0034c: LOAD R3 = [P1 + 0x4]
ffa0034e: NOP
ffa00350: LOAD R2 = 0x80
ffa00354: MAC|| A1 += R2.L * R2.L 
ffa00358: LOAD R0 = [P1 + 0x8]
ffa0035a: NOP
ffa0035c: LSH|| A1 = A1 >> 0x10
ffa00360: LOAD R4 = [P1 + 0xc]
ffa00362: NOP
ffa00364: MAC|| A1 += R1.H * R7.L (m),A0 = R1.H * R7.H 
ffa00368: STORE [SP + 0x30] = R4
ffa0036a: NOP
ffa0036c: MAC|| A1 += R7.H * R1.L (m)
ffa00370: LOAD R4 = [P1 + 0x10]
ffa00372: NOP
ffa00374: MAC|| A1 += R2.L * R2.L (fu)
ffa00378: STORE [SP + 0x2c] = R4
ffa0037a: NOP
ffa0037c: ASH A1 = A1 >>> 0xf
ffa00380: MOVE R1 = (A0 += A1)
ffa00384: ADD R1 = R1 + R3 (s)
