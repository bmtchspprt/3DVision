ffa05834: CALL 0xffa018f0
ffa05838: MOVE R7 = R0
ffa0583a: MOVE R1 = R6
ffa0583c: MOVE R0 = R5
ffa0583e: CALL 0xffa018f0
ffa05842: MOVE R1 = R0
ffa05844: MOVE R0 = R7
ffa05846: CALL 0xffa01714
ffa0584a: MOVE R1 = R0
ffa0584c: STORE [P3 + 0x4] = R0
ffa0584e: CALL 0xffa018f0
ffa05852: MOVE R1 = R4
ffa05854: CALL 0xffa01716
ffa05858: STORE [P3] = R0
ffa0585a: CALL 0xffa0248c
ffa0585e: JUMP.S 0xffa0577c
ffa05860: LOAD R1 = [P4]
ffa05862: SUB R0 = R0 - R1
ffa05864: CALL 0xffa02894
ffa05868: BITCLR (R0,0x1f)
ffa0586a: JUMP.S 0xffa0577c
ffa0586c: MOVE P1 = R1
ffa0586e: LINK 0x0
ffa05872: LOAD R1 = [P1 + 0x4ec]
ffa05876: MAC A1 = R1.L * R0.L (fu)
ffa0587a: LSH A1 = A1 >> 0x10
ffa0587e: UNLINK
ffa05882: MAC A1 += R1.H * R0.L (m),A0 = R1.H * R0.H 
ffa05886: MAC A1 += R0.H * R1.L (m)
ffa0588a: ASH A1 = A1 >>> 0xf
ffa0588e: MOVE R0 = (A0 += A1)
ffa05892: ASHIFT R0 >>>= 0x1
ffa05894: RTS
ffa05896: MOVE P1 = R1
ffa05898: LINK 0xc
ffa0589c: LOAD R1 = [P1 + 0x4ec]
ffa058a0: CALL 0xffa05ee4
ffa058a4: UNLINK
ffa058a8: LSHIFT R0 <<= 0x1
ffa058aa: RTS
ffa058ac: LINK 0x0
ffa058b0: PUSH [--SP] = (R7:6,P5:4)
ffa058b2: ADD SP += -0xc
ffa058b4: ROT|| R7 = rot R2 by 0
