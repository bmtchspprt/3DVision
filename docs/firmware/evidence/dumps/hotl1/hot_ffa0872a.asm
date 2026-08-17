ffa0872a: MOVE R1 = R0.B (Z)
ffa0872c: LOAD R2 = 0x3c
ffa0872e: LSH R0.L = R0.H << 0x0
ffa08732: MULT R2 = R1.L * R2.L (fu)
ffa08736: LOAD R1 = 0xf
ffa08738: AND R1 = R0 & R1
ffa0873a: LOAD R0.L = 0x3814
ffa0873e: LOAD R0.H = 0xff80
ffa08742: ADD R0 = R0 + R2
ffa08744: MOVE P1 = R0
ffa08746: LOAD R0 = 0x1
ffa08748: ASH R1.L = ashift R0.L by R1.L
ffa0874c: LOAD R0 = 0x0
ffa0874e: LOAD P1 = [P1 + 0x8]
ffa08750: STORE W [P1] = R1.L
ffa08752: RTS
