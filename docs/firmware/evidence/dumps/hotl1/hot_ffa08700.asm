ffa08700: MOVE R1 = R0.B (Z)
ffa08702: LOAD R2 = 0x3c
ffa08704: LSH R0.L = R0.H << 0x0
ffa08708: MULT R2 = R1.L * R2.L (fu)
ffa0870c: LOAD R1 = 0xf
ffa0870e: AND R1 = R0 & R1
ffa08710: LOAD R0.L = 0x3814
ffa08714: LOAD R0.H = 0xff80
ffa08718: ADD R0 = R0 + R2
ffa0871a: MOVE P1 = R0
ffa0871c: LOAD R0 = 0x1
ffa0871e: ASH R1.L = ashift R0.L by R1.L
ffa08722: LOAD R0 = 0x0
ffa08724: LOAD P1 = [P1 + 0x4]
ffa08726: STORE W [P1] = R1.L
ffa08728: RTS
