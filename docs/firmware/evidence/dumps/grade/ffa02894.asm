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
ffa028c8: LOAD R1.L = 0x1708
ffa028cc: LOAD R3 = 0x7f
ffa028d0: EXTRACT R2 = extract(R0,R1.L) (z)
ffa028d4: CC = R3 <= R2
ffa028d6: IF CC JUMP 0xffa028fe
ffa028d8: CC = R2 == 0x0
ffa028da: IF CC JUMP 0xffa02906
ffa028dc: LOAD R1 = 0x77
ffa028e0: SUB R2 = R2 - R1
ffa028e2: LOAD R3.L = 0x17
ffa028e6: LOAD R1 = -0x20
ffa028e8: MAX R2 = max(R2,R1)
ffa028ec: EXTRACT R3 = extract(R0,R3.L) (z)
ffa028f0: BITSET (R3,0x17)
ffa028f2: CC = R0 < 0x0
ffa028f4: ASH R0 = ashift R3 by R2.L (s)
ffa028f8: NEG R1 = -R0
ffa028fa: IF CC R0 = R1
ffa028fc: RTS
ffa028fe: ASHIFT R0 >>>= 0x1f
ffa02900: BITTGL (R0,0x1f)
ffa02902: NOT R0 = ~R0
ffa02904: RTS
ffa02906: LOAD R0 = 0x0
ffa02908: RTS
ffa0290c: LOAD R1.L = 0x1708
ffa02910: LOAD R2 = 0x7f
ffa02914: EXTRACT R1 = extract(R0,R1.L) (z)
ffa02918: CC = R2 <= R1
ffa0291a: IF CC JUMP 0xffa02938
ffa0291c: ADD R2 += -0xf
ffa0291e: CC = R1 < R2
ffa02920: IF CC JUMP 0xffa02942
ffa02922: CC = R0 < 0x0
ffa02924: BITSET (R0,0x17)
ffa02926: LSHIFT R0 <<= 0x8
ffa02928: LOAD R2 = 0x8f
ffa0292c: SUB R1 = R1 - R2
ffa0292e: LSH R0 = lshift R0 by R1.L
ffa02932: NEG R1 = -R0
ffa02934: IF CC R0 = R1
ffa02936: RTS
ffa02938: ASHIFT R0 >>>= 0x1f
ffa0293a: BITTGL (R0,0x1f)
ffa0293c: NOT R0 = ~R0
ffa0293e: ASHIFT R0 >>>= 0x10
ffa02940: RTS
ffa02942: LOAD R0 = 0x0
ffa02944: RTS
ffa02948: CC = R0 == 0x0
ffa0294a: IF CC JUMP 0xffa0296c
ffa0294c: ABS R1 = abs R0
ffa02950: CC = BITTST (R0,0x1f)
