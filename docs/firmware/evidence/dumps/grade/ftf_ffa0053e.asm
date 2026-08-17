ffa0050e: LOAD R1.H = 0x39b5
ffa00512: CC = R1 <= R6
ffa00514: IF !CC JUMP 0xffa00658
ffa00516: MOVE R0 = R6
ffa00518: CALL 0xffa028c8
ffa0051c: LOAD R2 = 0x0
ffa0051e: BITSET (R2,0x1e)
ffa00520: CC = R2 < R0
ffa00522: IF !CC JUMP 0xffa00664
ffa00524: SUB R0 = R2 - R0 (s)
ffa00528: ADD R0 = R0 + R2 (s)
ffa0052c: ASH R4 = R0 >>> 0x1
ffa00530: MOVE R0 = R4
ffa00532: CALL 0xffa0236c
ffa00536: NEG R0 = -R0 (s)
ffa0053a: ASH R0 = R0 << 0x1 (s)
ffa0053e: CALL 0xffa02894
ffa00542: LOAD R1 = 0xfdb
ffa00546: MOVE R6 = R0
ffa00548: MOVE R7 = R1
ffa0054a: LOAD R7.H = 0x3fc9
ffa0054e: LOAD P1.L = 0x343c
ffa00552: LOAD P1.H = 0xff80
ffa00556: LOAD R1 = [P1]
ffa00558: MAC|| A1 = R1.L * R4.L (fu)
ffa0055c: LOAD R3 = [P1 + 0x4]
ffa0055e: NOP
ffa00560: LOAD R2 = 0x80
ffa00564: MAC|| A1 += R2.L * R2.L 
ffa00568: STORE [SP + 0x30] = R3
ffa0056a: NOP
ffa0056c: LSH|| A1 = A1 >> 0x10
ffa00570: LOAD R3 = [P1 + 0xc]
ffa00572: NOP
ffa00574: MAC|| A1 += R1.H * R4.L (m),A0 = R1.H * R4.H 
ffa00578: STORE [SP + 0x2c] = R3
ffa0057a: NOP
ffa0057c: MAC|| A1 += R4.H * R1.L (m)
ffa00580: LOAD R3 = [P1 + 0x10]
ffa00582: NOP
ffa00584: MAC|| A1 += R2.L * R2.L (fu)
ffa00588: STORE [SP + 0x28] = R3
ffa0058a: NOP
ffa0058c: ASH|| A1 = A1 >>> 0xf
