ffa02894: LSH R1 = R0 << 0x1
ffa02898: MOVE CC = az
ffa0289a: IF CC JUMP 0xffa028be
ffa0289c: ABS R1 = abs R0
ffa028a0: CC = BITTST (R0,0x1f)
ffa028a2: SIGN R2.L = signbits R1
ffa028a6: MOVE R2 = R2.L (Z)
ffa028a8: ADD R2 += -0x6
ffa028aa: LSH R1 = lshift R1 by R2.L
ffa028ae: LOAD R0 = 0x77
ffa028b2: SUB R0 = R0 - R2
ffa028b4: LSHIFT R0 <<= 0x18
ffa028b6: ADD R0 = R0 + R1
ffa028b8: ROT R0 = rot R0 by -0x1
ffa028bc: RTS
ffa028be: CC = BITTST (R0,0x1f)
ffa028c0: LOAD R1.H = 0xbf80
ffa028c4: IF CC R0 = R1
ffa028c6: RTS
