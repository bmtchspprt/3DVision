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
