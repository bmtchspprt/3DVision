ffa00926: ADD R3 = R0 + R3 (s)
ffa0092a: ASH R4 = R1 >>> 0x1
ffa0092e: MOVE R2 = R7
ffa00930: LOAD R2.H = 0x376c
ffa00934: ADD R2 = R4 + R2 (s)
ffa00938: ASH R1 = R3 >>> 0x1f
ffa0093c: CC = BITTST (R1,0x0)
ffa0093e: ASH R7 = R2 >>> 0x1f
ffa00942: LSH|| R0 = R3 << 0x1f
ffa00946: _STORE [SP + 0xc] = R7
ffa00948: _NOP
ffa0094a: ROT R1 = rot R3 by -0x1
ffa0094e: CALL 0xffa01150
ffa00952: MOVE R4 = R0
ffa00954: CALL 0xffa02894
ffa00958: ADD P5 += 0x1
ffa0095a: MOVE R7 = R0
ffa0095c: ABS R0 = abs R4
ffa00960: LOAD R1 = 0xb505
ffa00964: CC = R1 <= R0
ffa00966: IF !CC JUMP 0xffa00a3a
ffa00968: MAC A1 = R4.L * R4.L (fu)
ffa0096c: LOAD R5.H = 0x80
ffa00970: MAC A1 += R5.H * R5.H 
ffa00974: LSH A1 = A1 >> 0x10
ffa00978: MAC A1 += R4.H * R4.L (m),A0 = R4.H * R4.H 
ffa0097c: MAC A1 += R4.H * R4.L (m)
ffa00980: MAC A1 += R5.H * R5.H (fu)
ffa00984: ASH A1 = A1 >>> 0xf
ffa00988: LOAD P1.L = 0x3478
ffa0098c: LOAD P1.H = 0xff80
ffa00990: MOVE|| R1 = (A0 += A1)
ffa00994: LOAD R3 = [P1]
ffa00996: NOP
ffa00998: MAC|| A1 = R3.L * R1.L (fu)
ffa0099c: LOAD R4 = [P1 + 0x4]
ffa0099e: NOP
ffa009a0: MAC|| A1 += R5.H * R5.H 
ffa009a4: LOAD R0 = [P1 + 0x8]
