ffa01688: LSH R1 = R0 << 0x1
ffa0168c: MOVE CC = az
ffa0168e: IF CC JUMP 0xffa016ca
ffa01690: ABS R2 = abs R0
ffa01694: MOVE P1 = R0
ffa01696: SIGN R1.L = signbits R2
ffa0169a: MOVE R1 = R1.L (Z)
ffa0169c: ASH R2 = ashift R2 by R1.L
ffa016a0: LOAD R0 = 0x9c
ffa016a4: SUB R1 = R0 - R1
ffa016a6: ADD R0 += -0x1d
ffa016a8: AND R3 = R0 & R2
ffa016aa: ADD R2 += 0x3f
ffa016ac: ADD R2 += 0x1
ffa016ae: LSHIFT R2 >>= 0x7
ffa016b0: BITTGL (R3,0x6)
ffa016b2: CC = R3 == 0x0
ffa016b4: MOVE R3 = CC
ffa016b6: NOT R3 = ~R3
ffa016b8: AND R2 = R2 & R3
ffa016ba: LSH R0 = R1 << 0x17
ffa016be: ADD R0 = R2 + R0
ffa016c0: CC = P1 < 0x0
ffa016c2: IF CC JUMP 0xffa016c6
ffa016c4: RTS
ffa016c6: BITSET (R0,0x1f)
ffa016c8: RTS
ffa016ca: CC = BITTST (R0,0x1f)
ffa016cc: LOAD R0.H = 0xcf00
ffa016d0: IF !CC R0 = R1
ffa016d2: RTS
