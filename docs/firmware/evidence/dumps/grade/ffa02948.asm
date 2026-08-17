ffa02940: RTS
ffa02942: LOAD R0 = 0x0
ffa02944: RTS
ffa02948: CC = R0 == 0x0
ffa0294a: IF CC JUMP 0xffa0296c
ffa0294c: ABS R1 = abs R0
ffa02950: CC = BITTST (R0,0x1f)
ffa02952: SIGN R2.L = signbits R1
ffa02956: MOVE R2 = R2.L (Z)
ffa02958: ADD R2 += -0x6
ffa0295a: LSH R1 = lshift R1 by R2.L
ffa0295e: LOAD R0 = 0x87
ffa02962: SUB R0 = R0 - R2
ffa02964: LSHIFT R0 <<= 0x18
ffa02966: ADD R0 = R0 + R1
ffa02968: ROT R0 = rot R0 by -0x1
ffa0296c: RTS
ffa02970: LINK 0x0
ffa02974: UNLINK
ffa02978: RTS
ffa0297a: LINK 0x0
ffa0297e: PUSH [--SP] = P5
ffa02980: STORE W [FP + 0x10] = R2
ffa02982: STORE [FP + 0xc] = R1
ffa02984: STORE W [FP + 0x8] = R0
ffa02986: LOAD P5.L = 0x3e2c
ffa0298a: LOAD P5.H = 0xff80
ffa0298e: LOAD R3 = 0x0
ffa02990: STORE [P5] = R3
ffa02992: LOAD P2.L = 0x3e30
ffa02996: LOAD P2.H = 0xff80
ffa0299a: STORE [P2] = R3
ffa0299c: LOAD P0 = 0x500
ffa029a0: LOAD P0.H = 0xffc0
ffa029a4: LOAD R0 = W [P0] (Z)
ffa029a6: BITSET (R0,0xe)
ffa029a8: STORE W [P0] = R0.L
ffa029aa: LOAD R0 = W [FP + 0x8] (X)
ffa029ac: LOAD P1 = 0x50c
ffa029b0: LOAD P1.H = 0xffc0
ffa029b4: STORE W [P1] = R0.L
ffa029b6: LOAD P1 = 0x508
ffa029ba: LOAD P1.H = 0xffc0
ffa029be: LOAD R0 = W [P1] (Z)
ffa029c0: CC = BITTST (R0,0x5)
ffa029c2: IF CC JUMP 0xffa029e6
ffa029c4: LOAD R0 = [P2]
ffa029c6: CC = R0 == 0x0
ffa029c8: IF !CC JUMP 0xffa029e6
ffa029ca: LOAD R0 = [P5]
ffa029cc: ADD R0 += 0x1
ffa029ce: STORE [P5] = R0
ffa029d0: MOVE P1 = FP
ffa029d2: ADD P1 += 0x10
ffa029d4: LOAD R1 = W [P1] (Z)
ffa029d6: CC = R0 <= R1 (IU)
ffa029d8: IF CC JUMP 0xffa029e4
ffa029da: LOAD R0 = 0x2
ffa029dc: LOAD R0.H = 0xf000
ffa029e0: STORE [P2] = R0
ffa029e2: JUMP.S 0xffa029e4
ffa029e4: JUMP.S 0xffa029b6
ffa029e6: LOAD R0 = [P2]
ffa029e8: CC = R0 == 0x0
ffa029ea: IF !CC JUMP 0xffa029fa
ffa029ec: LOAD R0 = [P5]
ffa029ee: CC = R0 == 0x0
ffa029f0: IF CC JUMP 0xffa029f8
ffa029f2: ADD R0 += -0x1
ffa029f4: STORE [P5] = R0
ffa029f6: JUMP.S 0xffa029ec
ffa029f8: JUMP.S 0xffa029fa
ffa029fa: LOAD R0 = W [P0] (Z)
ffa029fc: LOAD R1 = 0xbfff
