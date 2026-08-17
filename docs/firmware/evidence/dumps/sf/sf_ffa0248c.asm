ffa0248c: ASH R2 = R0 >>> 0x17
ffa02490: CC = R2 <= 0x0
ffa02492: IF CC JUMP 0xffa02534
ffa02494: LOAD R3 = 0xff
ffa02498: CC = R2 == R3
ffa0249a: IF CC JUMP 0xffa02534
ffa0249c: PUSH [--SP] = (R7:6)
ffa0249e: LOAD R3.L = 0x7f
ffa024a2: ADDSUB R1 = R2 +|+ R3,R2 = R2 -|- R3 (asr)
ffa024a6: ADD R3.L = R2.L + R3.L (ns)
ffa024aa: CC = BITTST (R0,0x17)
ffa024ac: MOVE R1 = CC
ffa024ae: ADD R1 += -0x1
ffa024b0: LSHIFT R0 <<= 0x9
ffa024b2: LSHIFT R0 >>= 0x2
ffa024b4: BITSET (R0,0x1e)
ffa024b6: LSH R7 = lshift R0 by R1.L
ffa024ba: LSH R0 = R7 >> 0x18
ffa024be: MOVE P0 = R0
ffa024c0: LOAD P2.L = 0x349c
ffa024c4: LOAD P2.H = 0xff80
ffa024c8: LOAD R6.H = 0x3000
ffa024cc: LOAD R6.L = 0x0
ffa024d0: LOAD P1 = 0x3
ffa024d2: ADD P2 = P2 + P0
ffa024d4: LOAD R2 = B [P2] (Z)
ffa024d6: LSHIFT R2 <<= 0x18
ffa024d8: LSETUP (0xffa024dc,0xffa0250c) LC0 = P1
ffa024dc: MAC A0 = R2.H * R2.L (fu)
ffa024e0: LSH A0 = A0 >> 0xf
ffa024e4: MAC R0 = (A0 += R2.H * R2.H) (iu)
ffa024e8: MAC A0 = R0.H * R7.L (fu)
ffa024ec: MAC A0 += R0.L * R7.H (fu)
ffa024f0: LSH A0 = A0 >> 0x10
ffa024f4: MAC R0 = (A0 += R0.H * R7.H) (iu)
ffa024f8: SUB R0 = R6 - R0 (ns)
ffa024fc: MAC A0 = R0.H * R2.L (fu)
ffa02500: MAC A0 += R0.L * R2.H (fu)
ffa02504: LSH A0 = A0 >> 0x10
ffa02508: MAC R2 = (A0 += R0.H * R2.H) (iu)
ffa0250c: LSHIFT R2 <<= 0x3
ffa0250e: MAC A0 = R2.H * R7.L (fu)
ffa02512: MAC A0 += R2.L * R7.H (fu)
ffa02516: LSH A0 = A0 >> 0x10
ffa0251a: MAC R0 = (A0 += R2.H * R7.H) (iu)
ffa0251e: LOAD R2.L = 0xfffa
ffa02522: SUB R2.L = R2.L - R1.L (ns)
ffa02526: LSH R0 = lshift R0 by R2.L
ffa0252a: BITCLR (R0,0x17)
ffa0252c: LSHIFT R3 <<= 0x17
ffa0252e: OR R0 = R0 | R3
ffa02530: POP (R7:6) = [SP++]
ffa02532: RTS
ffa02534: LOAD R0 = 0x0
ffa02536: RTS
