ffa018f0: PUSH [--SP] = R7
ffa018f2: LOAD R3.L = 0x1708
ffa018f6: EXTRACT R2 = extract(R0,R3.L) (z)
ffa018fa: EXTRACT R3 = extract(R1,R3.L) (z)
ffa018fe: LOAD R7 = 0xff
ffa01902: CC = R2 == R7
ffa01904: IF CC JUMP 0xffa01990
ffa01906: CC = R3 == R7
ffa01908: IF CC JUMP 0xffa0198a
ffa0190a: XOR R7 = R0 ^ R1
ffa0190c: MOVE CC = R2
ffa0190e: IF !CC JUMP 0xffa019b0
ffa01910: LSH R0 = R0 << 0x8
ffa01914: BITSET (R0,0x1f)
ffa01916: MOVE CC = R3
ffa01918: IF !CC JUMP 0xffa019d8
ffa0191a: LSH R1 = R1 << 0x8
ffa0191e: BITSET (R1,0x1f)
ffa01920: ADD R2 = R2 + R3
ffa01922: ADD R2 += -0x40
ffa01924: ADD R2 += -0x3f
ffa01926: MAC A1 = R0.H * R1.L ,A0 = R0.L * R1.L (fu)
ffa0192a: LSH A0 = A0 >> 0x10
ffa0192e: ADD A0 += A1
ffa01932: MAC A1 = R0.H * R1.H ,A0 += R0.L * R1.H (fu)
ffa01936: MOVE R0 = A0.W
ffa01938: MOVE R0 = R0.L (Z)
ffa0193a: LSH A0 = A0 >> 0x10
ffa0193e: ADD A0 += A1
ffa01942: MOVE R1 = A0.W
ffa01944: MOVE CC = R0
ffa01946: MOVE R0 = CC
ffa01948: OR R1 = R1 | R0
ffa0194a: SIGN R0.L = signbits A0
ffa0194e: MOVE R0 = R0.L (X)
ffa01950: SUB R2 = R2 - R0
ffa01952: ADD R0 += 0x1
ffa01954: LSH R1 = lshift R1 by R0.L
ffa01958: CC = R2 <= 0x0
ffa0195a: IF CC JUMP 0xffa01a00
ffa0195c: LOAD R0 = 0xfe
ffa01960: CC = R0 < R2
ffa01962: IF CC JUMP 0xffa01a16
ffa01964: BITCLR (R1,0x1f)
ffa01966: CC = R7 < 0x0
ffa01968: LSHIFT R2 <<= 0x18
ffa0196a: ROT R2 = rot R2 by -0x1
ffa0196e: LOAD R3 = 0x80
ffa01972: ADD R0 = R1 + R3
ffa01974: LSH R7 = R1 << 0x17
ffa01978: LSHIFT R7 >>= 0x17
ffa0197a: CC = R7 == R3
ffa0197c: IF !CC R1 = R0
ffa0197e: LSHIFT R1 >>= 0x8
ffa01980: ADD|| R0 = R1 + R2 (ns)
ffa01984: _LOAD R7 = [SP++]
ffa01986: _NOP
ffa01988: RTS
ffa0198a: MOVE R2 = R1
ffa0198c: MOVE R1 = R0
ffa0198e: MOVE R0 = R2
ffa01990: MOVE R2 = R0
ffa01992: BITTGL (R2,0x1f)
ffa01994: ROT R1 = rot R1 by 0x1
ffa01998: IF CC R0 = R2
ffa0199a: LOAD R2 = -0x1
ffa0199c: CC = R1 == 0x1
ffa0199e: IF CC R0 = R2
ffa019a0: LOAD R3.L = 0x1
ffa019a4: LOAD R3.H = 0xff00
ffa019a8: CC = R3 < R1 (IU)
ffa019aa: IF CC R0 = R2
ffa019ac: LOAD R7 = [SP++]
ffa019ae: RTS
ffa019b0: LSH R0 = R0 << 0x9
ffa019b4: MOVE CC = R0
ffa019b6: IF CC JUMP 0xffa019c4
ffa019b8: LSH R0 = R7 >> 0x1f
ffa019bc: LSHIFT R0 <<= 0x1f
ffa019be: NOP
ffa019c0: LOAD R7 = [SP++]
ffa019c2: RTS
ffa019c4: LSHIFT R0 >>= 0x1
ffa019c6: LOAD R2.H = 0x0
ffa019ca: SIGN R2.L = signbits R0
ffa019ce: LSH R0 = lshift R0 by R2.L
ffa019d2: LSHIFT R0 <<= 0x1
ffa019d4: NEG R2 = -R2
ffa019d6: JUMP.S 0xffa01916
ffa019d8: LSH R1 = R1 << 0x9
ffa019dc: MOVE CC = R1
ffa019de: IF CC JUMP 0xffa019ec
ffa019e0: LSH R0 = R7 >> 0x1f
ffa019e4: LSHIFT R0 <<= 0x1f
ffa019e6: NOP
ffa019e8: LOAD R7 = [SP++]
ffa019ea: RTS
ffa019ec: LSHIFT R1 >>= 0x1
ffa019ee: LOAD R3.H = 0x0
ffa019f2: SIGN R3.L = signbits R1
ffa019f6: LSH R1 = lshift R1 by R3.L
ffa019fa: LSHIFT R1 <<= 0x1
ffa019fc: NEG R3 = -R3
ffa019fe: JUMP.S 0xffa01920
ffa01a00: LOAD R0 = 0x2
ffa01a02: SUB R0 = R0 - R2
ffa01a04: MOVE R2 = R1
ffa01a06: LSHIFT R2 >>= R0
ffa01a08: MOVE R3 = R2
ffa01a0a: LSHIFT R3 <<= R0
ffa01a0c: CC = R3 < R1 (IU)
ffa01a0e: ROT R1 = rot R2 by 0x1
ffa01a12: LOAD R2 = 0x0
ffa01a14: JUMP.S 0xffa01966
ffa01a16: CC = R7 < 0x0
ffa01a18: LOAD R0 = 0x0
ffa01a1a: LOAD R0.H = 0xff00
ffa01a1e: ROT|| R0 = rot R0 by -0x1
ffa01a22: LOAD R7 = [SP++]
ffa01a24: NOP
ffa01a26: RTS
