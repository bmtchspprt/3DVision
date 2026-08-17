ffa00fb4: NEG R2 = -R0
ffa00fb6: NEG R3 = -R1
ffa00fb8: MAX R2 = max(R0,R2)
ffa00fbc: MAX R3 = max(R1,R3)
ffa00fc0: CC = R2 < R3 (IU)
ffa00fc2: IF CC JUMP 0xffa01024
ffa00fc4: XOR R0 = R0 ^ R1
ffa00fc6: LSH R1 = R3 >> 0x1
ffa00fca: SIGN R0.L = signbits R2
ffa00fce: SIGN R1.L = signbits R1
ffa00fd2: LSH R2 = lshift R2 by R0.L
ffa00fd6: LSH R3 = lshift R3 by R1.L
ffa00fda: SUB R0.L = R1.L - R0.L (ns)
ffa00fde: MOVE R1 = R0.L (Z)
ffa00fe0: MOVE P1 = R1
ffa00fe2: LSH R1 = R3 << 0xf
ffa00fe6: MOVE CC = R1
ffa00fe8: IF CC JUMP 0xffa01004
ffa00fea: CC = R2 == R3
ffa00fec: IF CC JUMP 0xffa01028
ffa00fee: MOVE aq = CC
ffa00ff0: LSHIFT R3 >>= 0x11
ffa00ff2: LSETUP (0xffa00ff6,0xffa00ff6) LC0 = P1
ffa00ff6: DIVQ (R2,R3)
ffa00ff8: CC = BITTST (R0,0x1f)
ffa00ffa: EXTRACT R2 = extract(R2,R0.L) (z)
ffa00ffe: NEG R0 = -R2
ffa01000: IF !CC R0 = R2
ffa01002: RTS
ffa01004: ASHIFT R3 >>>= 0x1
ffa01006: LSETUP (0xffa0100a,0xffa01010) LC0 = P1
ffa0100a: ADDSUB R2 = R2 + R3,R1 = R2 - R3 (ns)
ffa0100e: IF CC R2 = R1
ffa01010: ROT R2 = rot R2 by 0x1
ffa01014: ROT R2 = rot R2 by 0x1
ffa01018: CC = BITTST (R0,0x1f)
ffa0101a: EXTRACT R2 = extract(R2,R0.L) (z)
ffa0101e: NEG R0 = -R2
ffa01020: IF !CC R0 = R2
ffa01022: RTS
ffa01024: LOAD R0 = 0x0
ffa01026: RTS
ffa01028: LOAD R2 = 0x1
ffa0102a: LSH R2 = lshift R2 by R0.L
ffa0102e: CC = BITTST (R0,0x1f)
ffa01030: NEG R0 = -R2
ffa01032: IF !CC R0 = R2
ffa01034: RTS
ffa01038: LSH R2 = R0 >> 0x1
ffa0103c: CC = R2 < R1 (IU)
ffa0103e: IF CC JUMP 0xffa0109a
ffa01040: LSH R3 = R1 >> 0x1
ffa01044: SIGN R2.L = signbits R2
ffa01048: SIGN R3.L = signbits R3
ffa0104c: LSH R0 = lshift R0 by R2.L
ffa01050: LSH R1 = lshift R1 by R3.L
ffa01054: SUB R2 = R3 - R2
ffa01056: MOVE R2 = R2.L (Z)
ffa01058: MOVE P1 = R2
ffa0105a: SUB R0 = R0 - R1
ffa0105c: LSH R3 = R1 << 0xf
ffa01060: MOVE CC = R3
ffa01062: IF CC JUMP 0xffa0107e
ffa01064: CC = BITTST (R0,0x1f)
ffa01066: MOVE aq = CC
ffa01068: LSHIFT R1 >>= 0x11
ffa0106a: LSETUP (0xffa0106e,0xffa0106e) LC0 = P1
ffa0106e: DIVQ (R0,R1)
ffa01070: NOT CC = !CC
ffa01072: MOVE R3 = CC
ffa01074: LSHIFT R3 <<= R2
ffa01076: EXTRACT R0 = extract(R0,R2.L) (z)
ffa0107a: OR R0 = R0 | R3
ffa0107c: RTS
ffa0107e: CC = !BITTST (R0,0x1f)
ffa01080: ASHIFT R1 >>>= 0x1
ffa01082: LSETUP (0xffa01086,0xffa0108c) LC0 = P1
ffa01086: ADDSUB R0 = R0 + R1,R3 = R0 - R1 (ns)
ffa0108a: IF CC R0 = R3
ffa0108c: ROT R0 = rot R0 by 0x1
ffa01090: EXTRACT R0 = extract(R0,R2.L) (z)
ffa01094: ROT R0 = rot R0 by 0x1
ffa01098: RTS
ffa0109a: CC = R1 <= R0 (IU)
ffa0109c: MOVE R0 = CC
ffa0109e: RTS
ffa010a0: NEG R2 = -R0
ffa010a2: NEG R3 = -R1
ffa010a4: MAX R2 = max(R0,R2)
ffa010a8: MAX R3 = max(R1,R3)
ffa010ac: CC = R2 < R3 (IU)
ffa010ae: IF CC JUMP 0xffa01138
ffa010b0: XOR R1 = R0 ^ R1
ffa010b2: CC = BITTST (R0,0x1f)
ffa010b4: LSH R0 = R3 >> 0x1
ffa010b8: ROT R1 = rot R1 by -0x1
ffa010bc: SIGN R1.L = signbits R0
ffa010c0: SIGN R0.L = signbits R2
ffa010c4: LSH R2 = lshift R2 by R0.L
ffa010c8: LSH R3 = lshift R3 by R1.L
ffa010cc: SUB R0 = R1 - R0
ffa010ce: MOVE R0 = R0.L (Z)
ffa010d0: MOVE P1 = R0
ffa010d2: LSH R0 = R3 << 0xf
ffa010d6: MOVE CC = R0
ffa010d8: IF CC JUMP 0xffa01106
ffa010da: CC = R2 == R3
ffa010dc: IF CC JUMP 0xffa0113e
ffa010de: MOVE aq = CC
ffa010e0: LSH R0 = R3 >> 0x11
ffa010e4: LSETUP (0xffa010e8,0xffa010e8) LC0 = P1
ffa010e8: DIVQ (R2,R0)
ffa010ea: ADD R3 = R2 + R3
ffa010ec: MOVE CC = aq
ffa010ee: IF !CC R3 = R2
ffa010f0: MOVE R0 = R1.L (Z)
ffa010f2: LSHIFT R3 >>= R0
ffa010f4: EXTRACT R2 = extract(R2,R1.L) (z)
ffa010f8: CC = BITTST (R1,0x1e)
ffa010fa: NEG R0 = -R2
ffa010fc: IF !CC R0 = R2
ffa010fe: CC = BITTST (R1,0x1f)
ffa01100: NEG R1 = -R3
ffa01102: IF !CC R1 = R3
ffa01104: RTS
ffa01106: ASHIFT R3 >>>= 0x1
ffa01108: LSETUP (0xffa0110c,0xffa01112) LC0 = P1
ffa0110c: ADDSUB R2 = R2 + R3,R0 = R2 - R3 (ns)
ffa01110: IF CC R2 = R0
ffa01112: ROT R2 = rot R2 by 0x1
ffa01116: LSHIFT R3 <<= 0x1
ffa01118: ADD R3 = R2 + R3
ffa0111a: IF CC R3 = R2
ffa0111c: MOVE R0 = R1.L (Z)
ffa0111e: LSHIFT R3 >>= R0
ffa01120: ROT R2 = rot R2 by 0x1
ffa01124: MOVE R0 = P1
ffa01126: CC = BITTST (R1,0x1e)
ffa01128: EXTRACT R2 = extract(R2,R0.L) (z)
ffa0112c: NEG R0 = -R2
ffa0112e: IF !CC R0 = R2
ffa01130: CC = BITTST (R1,0x1f)
ffa01132: NEG R1 = -R3
ffa01134: IF !CC R1 = R3
ffa01136: RTS
ffa01138: MOVE R1 = R0
ffa0113a: LOAD R0 = 0x0
ffa0113c: RTS
ffa0113e: LOAD R2 = 0x1
ffa01140: LSH R2 = lshift R2 by R1.L
ffa01144: CC = BITTST (R1,0x1e)
ffa01146: NEG R0 = -R2
ffa01148: IF !CC R0 = R2
ffa0114a: LOAD R1 = 0x0
ffa0114c: RTS
ffa01150: LOAD R3 = [SP + 0xc]
