ffa014dc: LOAD R1.L = 0x1708
ffa014e0: LOAD R3 = 0x9e
ffa014e4: EXTRACT R2 = extract(R0,R1.L) (z)
ffa014e8: CC = R3 <= R2
ffa014ea: IF CC JUMP 0xffa01512
ffa014ec: CC = R2 == 0x0
ffa014ee: IF CC JUMP 0xffa0151a
ffa014f0: LOAD R1 = 0x96
ffa014f4: SUB R2 = R2 - R1
ffa014f6: LOAD R3.L = 0x17
ffa014fa: LOAD R1 = -0x18
ffa014fc: MAX R2 = max(R2,R1)
ffa01500: EXTRACT R3 = extract(R0,R3.L) (z)
ffa01504: BITSET (R3,0x17)
ffa01506: CC = R0 < 0x0
ffa01508: ASH R0 = ashift R3 by R2.L (s)
ffa0150c: NEG R1 = -R0
ffa0150e: IF CC R0 = R1
ffa01510: RTS
ffa01512: ASHIFT R0 >>>= 0x1f
ffa01514: BITTGL (R0,0x1f)
ffa01516: NOT R0 = ~R0
ffa01518: RTS
ffa0151a: LOAD R0 = 0x0
ffa0151c: RTS
