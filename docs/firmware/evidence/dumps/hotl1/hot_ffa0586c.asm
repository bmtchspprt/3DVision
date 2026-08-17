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
