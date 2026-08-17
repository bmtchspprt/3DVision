ffa03880: _NOP
ffa03882: LOAD R1 = [FP + 0x20]
ffa03884: CALL 0xffa018f0
ffa03888: ROT|| R7 = rot R0 by 0
ffa0388c: _LOAD R1 = [FP + 0xc]
ffa0388e: _NOP
ffa03890: LOAD R0 = [FP + -0x8]
ffa03892: CALL 0xffa01716
ffa03896: MOVE R1 = R7
ffa03898: CALL 0xffa01716
ffa0389c: ROT|| R7 = rot R0 by 0
ffa038a0: _LOAD R1 = [FP + 0x20]
ffa038a2: _NOP
ffa038a4: ROT|| R0 = rot R5 by 0
ffa038a8: _STORE [FP + 0xc] = R7
ffa038aa: _NOP
ffa038ac: CALL 0xffa018f0
ffa038b0: ROT|| R5 = rot R0 by 0
ffa038b4: _LOAD R1 = [FP + -0x4]
ffa038b6: _NOP
ffa038b8: MOVE R0 = R4
ffa038ba: CALL 0xffa018f0
ffa038be: ROT|| R4 = rot R0 by 0
ffa038c2: _LOAD R1 = [FP + 0x8]
ffa038c4: _NOP
ffa038c6: MOVE R0 = R5
ffa038c8: CALL 0xffa01716
ffa038cc: MOVE R1 = R4
ffa038ce: CALL 0xffa01714
ffa038d2: CC = R6 == 0x0
ffa038d4: ROT|| R5 = rot R0 by 0
ffa038d8: _STORE [FP + 0x8] = R0
ffa038da: _NOP
ffa038dc: IF !CC JUMP 0xffa0382a (bp)
ffa038de: MOVE R0 = R7
ffa038e0: JUMP.S 0xffa03728
ffa038e2: LINK 0x8
ffa038e6: PUSH [--SP] = (R7:4,P5:3)
ffa038e8: ADD SP += -0xc
ffa038ea: ASH|| R3 = R0 >>> 0xf
ffa038ee: _LOAD P3 = [FP + 0x20]
ffa038f0: _NOP
ffa038f2: LOAD P0 = 0x4c08
ffa038f6: LOAD P0.H = 0x3
ffa038fa: LOAD R5.H = 0x5cfc
ffa038fe: ASH|| R4 = R0 >>> 0x11
ffa03902: _STORE [FP + 0x24] = R1
ffa03904: _NOP
ffa03906: ADD P0 = P3 + P0
ffa03908: LOAD R7 = W [P0] (X)
ffa0390a: MULT|| R1 = R7.L * R5.H (is)
ffa0390e: STORE [SP + 0x28] = R2
ffa03910: NOP
ffa03912: MOVE P0 = R1
ffa03914: MOVE P1 = R3
ffa03916: LOAD P2 = 0x578
ffa0391a: ADD P2 = P3 + P2
ffa0391c: LOAD P3 = 0x44
ffa03920: ADD P2 = P2 + P0
ffa03922: LOAD P5.L = 0x5d04
ffa03926: LOAD P5.H = 0x2022
ffa0392a: ADD P0 = P2 + P3
ffa0392c: LOAD P4 = 0x2938
ffa03930: STORE [P5] = R3
ffa03932: ADD P1 = P0 + (P1 << 1)
ffa03934: ADD P4 = P2 + P4
ffa03936: LOAD R1 = [P2 + 0x5cd4]
ffa0393a: LOAD R3 = [P2 + 0x5cd8]
ffa0393e: STORE [P5 + 0x8] = P0
ffa03940: STORE [P5 + 0x14] = R3
ffa03942: STORE [P5 + 0xc] = P4
ffa03944: STORE [P5 + 0x4] = R4
ffa03946: STORE [P5 + 0x10] = R1
ffa03948: LOAD R0 = W [P1] (X)
ffa0394a: CALL 0xffa02948
ffa0394e: LOAD P4 = [P5 + 0x8]
ffa03950: LOAD P3 = [P5]
ffa03952: LOAD R1 = [P5 + 0x10]
ffa03954: CALL 0xffa018f0
ffa03958: LOAD R1 = 0x47ae
ffa0395c: LOAD R1.H = 0x3f81
ffa03960: CALL 0xffa018f0
ffa03964: ADD P1 = P4 + (P3 << 1)
ffa03966: STORE [SP + 0x38] = R0
ffa03968: LOAD R0 = W [P1] (X)
ffa0396a: CALL 0xffa02948
ffa0396e: LOAD P4 = [P5 + 0xc]
ffa03970: LOAD P3 = [P5 + 0x4]
ffa03972: LOAD R1 = [P5 + 0x10]
ffa03974: CALL 0xffa018f0
ffa03978: MOVE R7 = R0
ffa0397a: ADD P1 = P4 + (P3 << 1)
ffa0397c: LOAD R0 = W [P1] (X)
ffa0397e: CALL 0xffa02948
ffa03982: LOAD R1 = [P5 + 0x14]
ffa03984: CALL 0xffa018f0
ffa03988: MOVE R1 = R0
ffa0398a: MOVE R0 = R7
ffa0398c: LOAD R6 = -0x1
ffa0398e: CALL 0xffa01714
ffa03992: LSHIFT R6 <<= 0x17
ffa03994: CC = R0 <= R6
ffa03996: LSH R1 = R0 >> 0x1f
ffa0399a: LOAD R2 = 0x0
ffa0399c: IF !CC R1 = R2
ffa0399e: CC = R0 == 0x0
ffa039a0: LOAD R3 = 0x1
ffa039a2: IF CC R1 = R3
ffa039a4: CC = BITTST (R1,0x0)
ffa039a6: IF CC JUMP 0xffa03c6c
ffa039a8: LOAD R6 = [P5]
ffa039aa: MOVE R2 = R6.L (X)
ffa039ac: MOVE P1 = R2
ffa039ae: LOAD R0 = 0x0
ffa039b0: STORE [FP + 0x10] = R0
ffa039b2: ADD P4 = P1 + P1
ffa039b4: MOVE R0 = R6.L (X)
ffa039b6: ROT|| R3 = rot R2 by 0
ffa039ba: _STORE [SP + 0x2c] = R6
ffa039bc: _NOP
ffa039be: ADD R6 += -0x1
ffa039c0: ADD R2 += -0x1
ffa039c2: CC = R0 <= 0x0
ffa039c4: MOVE P1 = P4
ffa039c6: STORE [FP + 0x28] = R6
ffa039c8: ASH|| R2 = R3 >>> 0x2
ffa039cc: _STORE [SP + 0x3c] = R2
ffa039ce: _NOP
ffa039d0: ADD P4 += -0x2
ffa039d2: IF CC JUMP 0xffa03ade
ffa039d4: LOAD P0 = [P5 + 0x8]
ffa039d6: STORE [FP + 0x1c] = R2
ffa039d8: LOAD R6 = 0xff
ffa039dc: LSH R4 = R6 << 0x17
ffa039e0: ADD P1 = P0 + P1
ffa039e2: LOAD R0 = W [P1] (X)
ffa039e4: CALL 0xffa02948
ffa039e8: LOAD R1 = [P5 + 0x10]
ffa039ea: CALL 0xffa018f0
ffa039ee: ROT|| R7 = rot R0 by 0
ffa039f2: _LOAD P3 = [P5 + 0xc]
ffa039f4: _NOP
ffa039f6: ROT|| R5 = rot R0 by 0
ffa039fa: _LOAD P1 = [FP + 0x1c]
ffa039fc: _NOP
ffa039fe: ADD P1 = P3 + (P1 << 1)
ffa03a00: LOAD R0 = W [P1] (X)
ffa03a02: CALL 0xffa02948
ffa03a06: LOAD R1 = [P5 + 0x14]
ffa03a08: CALL 0xffa018f0
ffa03a0c: MOVE R6 = R0
ffa03a0e: MOVE R0 = R7
ffa03a10: MOVE R1 = R6
ffa03a12: CALL 0xffa01714
ffa03a16: ROT|| R7 = rot R0 by 0
ffa03a1a: _LOAD R1 = [FP + 0x14]
ffa03a1c: _NOP
ffa03a1e: LOAD R0 = [SP + 0x38]
ffa03a20: CALL 0xffa018f0
ffa03a24: MOVE R1 = R0
ffa03a26: AND R3 = R1 & R7
ffa03a28: LSHIFT R3 >>= 0x1f
ffa03a2a: BITCLR (R0,0x1f)
ffa03a2c: ROT|| R2 = rot R7 by 0
ffa03a30: _STORE [FP + 0x1c] = R3
ffa03a32: _NOP
ffa03a34: CC = R4 < R0
ffa03a36: BITCLR (R2,0x1f)
ffa03a38: MOVE R3 = CC
ffa03a3a: CC = R4 < R2
ffa03a3c: OR R0 = R0 | R2
ffa03a3e: LOAD R2 = 0x1
ffa03a40: IF !CC R2 = R3
ffa03a42: CC = R7 <= R1
ffa03a44: MOVE R3 = CC
ffa03a46: CC = R1 == R7
ffa03a48: LOAD R1 = [FP + 0x1c]
ffa03a4a: XOR R1 = R1 ^ R3
ffa03a4c: IF !CC R3 = R1
ffa03a4e: CC = R0 == 0x0
ffa03a50: LOAD R1 = 0x1
ffa03a52: IF CC R3 = R1
ffa03a54: CC = BITTST (R2,0x0)
ffa03a56: LOAD R0 = 0x0
ffa03a58: IF CC R3 = R0
ffa03a5a: CC = BITTST (R3,0x0)
ffa03a5c: IF CC JUMP 0xffa03ade
ffa03a5e: MOVE R0 = R6
ffa03a60: MOVE R1 = R5
ffa03a62: BITCLR (R0,0x1f)
ffa03a64: BITCLR (R1,0x1f)
ffa03a66: OR R3 = R0 | R1
ffa03a68: CC = R4 < R0
ffa03a6a: STORE [FP + 0x1c] = R3
ffa03a6c: MOVE R2 = CC
ffa03a6e: CC = R4 < R1
ffa03a70: LOAD R0 = 0x1
ffa03a72: IF !CC R0 = R2
ffa03a74: CC = R5 <= R6
ffa03a76: AND R3 = R6 & R5
ffa03a78: LSHIFT R3 >>= 0x1f
ffa03a7a: MOVE R2 = CC
ffa03a7c: CC = R6 == R5
ffa03a7e: XOR R3 = R3 ^ R2
ffa03a80: LOAD R6 = [FP + 0x1c]
