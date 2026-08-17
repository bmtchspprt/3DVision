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
ffa03a82: IF !CC R2 = R3
ffa03a84: CC = R6 == 0x0
ffa03a86: LOAD R3 = 0x1
ffa03a88: IF CC R2 = R3
ffa03a8a: CC = BITTST (R0,0x0)
ffa03a8c: LOAD R6 = 0x0
ffa03a8e: IF CC R2 = R6
ffa03a90: CC = BITTST (R2,0x0)
ffa03a92: IF CC JUMP 0xffa03ade
ffa03a94: LOAD R0 = [SP + 0x38]
ffa03a96: CC = R4 < R1
ffa03a98: BITCLR (R0,0x1f)
ffa03a9a: OR R6 = R1 | R0
ffa03a9c: MOVE R2 = CC
ffa03a9e: CC = R4 < R0
ffa03aa0: LOAD R1 = 0x1
ffa03aa2: LOAD R4 = [SP + 0x38]
ffa03aa4: LOAD R3 = [SP + 0x38]
ffa03aa6: IF !CC R1 = R2
ffa03aa8: CC = R4 < R5
ffa03aaa: AND R3 = R5 & R3
ffa03aac: LSHIFT R3 >>= 0x1f
ffa03aae: MOVE R0 = CC
ffa03ab0: CC = R5 == R4
ffa03ab2: XOR R3 = R3 ^ R0
ffa03ab4: IF !CC R0 = R3
ffa03ab6: CC = R6 == 0x0
ffa03ab8: IF CC R0 = R6
ffa03aba: CC = BITTST (R1,0x0)
ffa03abc: LOAD R2 = 0x0
ffa03abe: IF CC R0 = R2
ffa03ac0: CC = BITTST (R0,0x0)
ffa03ac2: IF CC JUMP 0xffa03ade
ffa03ac4: ROT|| R0 = rot R7 by 0
ffa03ac8: _LOAD R6 = [FP + 0x28]
ffa03aca: _NOP
ffa03acc: MOVE R1 = R7
ffa03ace: CALL 0xffa018f0
ffa03ad2: LOAD R1 = [FP + 0x10]
ffa03ad4: CALL 0xffa01716
ffa03ad8: STORE [FP + 0x10] = R0
ffa03ada: LOAD R2 = [SP + 0x3c]
ffa03adc: JUMP.S 0xffa039b4
ffa03ade: LOAD R0 = [FP + 0x24]
ffa03ae0: CC = R0 == 0x0
ffa03ae2: IF CC JUMP 0xffa03aea
ffa03ae4: LOAD P1 = [FP + 0x24]
ffa03ae6: LOAD R0 = [SP + 0x2c]
ffa03ae8: STORE W [P1] = R0.L
ffa03aea: LOAD R0 = [P5]
ffa03aec: MOVE R2 = R0.L (X)
ffa03aee: MOVE P1 = R2
ffa03af0: STORE [FP + 0x24] = R0
ffa03af2: ADD P4 = P1 + P1
ffa03af4: ROT|| R3 = rot R2 by 0
ffa03af8: _LOAD R1 = [FP + 0x24]
ffa03afa: _NOP
ffa03afc: LOAD R0 = [FP + 0x24]
ffa03afe: MOVE R1 = R1.L (X)
ffa03b00: LOAD R7 = 0x147a
ffa03b04: ADD R2 += 0x1
ffa03b06: ADD R0 += 0x1
ffa03b08: CC = R1 < R7
ffa03b0a: MOVE P1 = P4
ffa03b0c: ASH|| R2 = R3 >>> 0x2
ffa03b10: _STORE [FP + 0x28] = R2
ffa03b12: _NOP
ffa03b14: STORE [SP + 0x2c] = R0
ffa03b16: ADD P4 += 0x2
ffa03b18: IF !CC JUMP 0xffa03c2a
ffa03b1a: LOAD P0 = [P5 + 0x8]
ffa03b1c: STORE [SP + 0x3c] = R2
ffa03b1e: LOAD R6 = 0xff
ffa03b22: LSH R4 = R6 << 0x17
ffa03b26: ADD P1 = P0 + P1
ffa03b28: LOAD R0 = W [P1] (X)
ffa03b2a: CALL 0xffa02948
ffa03b2e: LOAD R1 = [P5 + 0x10]
ffa03b30: CALL 0xffa018f0
ffa03b34: ROT|| R7 = rot R0 by 0
ffa03b38: _LOAD P3 = [P5 + 0xc]
ffa03b3a: _NOP
ffa03b3c: ROT|| R5 = rot R0 by 0
ffa03b40: _LOAD P1 = [SP + 0x3c]
ffa03b42: _NOP
ffa03b44: ADD P1 = P3 + (P1 << 1)
ffa03b46: LOAD R0 = W [P1] (X)
ffa03b48: CALL 0xffa02948
ffa03b4c: LOAD R1 = [P5 + 0x14]
ffa03b4e: CALL 0xffa018f0
ffa03b52: MOVE R6 = R0
ffa03b54: MOVE R0 = R7
ffa03b56: MOVE R1 = R6
ffa03b58: CALL 0xffa01714
ffa03b5c: ROT|| R7 = rot R0 by 0
ffa03b60: _LOAD R1 = [FP + 0x14]
ffa03b62: _NOP
ffa03b64: LOAD R0 = [SP + 0x38]
ffa03b66: CALL 0xffa018f0
ffa03b6a: MOVE R1 = R0
ffa03b6c: AND R3 = R1 & R7
ffa03b6e: LSHIFT R3 >>= 0x1f
ffa03b70: BITCLR (R0,0x1f)
ffa03b72: ROT|| R2 = rot R7 by 0
ffa03b76: _STORE [SP + 0x3c] = R3
ffa03b78: _NOP
ffa03b7a: CC = R4 < R0
ffa03b7c: BITCLR (R2,0x1f)
ffa03b7e: MOVE R3 = CC
ffa03b80: CC = R4 < R2
ffa03b82: OR R0 = R0 | R2
ffa03b84: LOAD R2 = 0x1
ffa03b86: IF !CC R2 = R3
ffa03b88: CC = R7 <= R1
ffa03b8a: MOVE R3 = CC
ffa03b8c: CC = R1 == R7
ffa03b8e: LOAD R1 = [SP + 0x3c]
ffa03b90: XOR R1 = R1 ^ R3
ffa03b92: IF !CC R3 = R1
ffa03b94: CC = R0 == 0x0
ffa03b96: LOAD R1 = 0x1
ffa03b98: IF CC R3 = R1
ffa03b9a: CC = BITTST (R2,0x0)
ffa03b9c: LOAD R0 = 0x0
ffa03b9e: IF CC R3 = R0
ffa03ba0: CC = BITTST (R3,0x0)
ffa03ba2: IF CC JUMP 0xffa03c2a
ffa03ba4: MOVE R0 = R6
ffa03ba6: MOVE R1 = R5
ffa03ba8: BITCLR (R0,0x1f)
ffa03baa: BITCLR (R1,0x1f)
ffa03bac: OR R3 = R0 | R1
ffa03bae: CC = R4 < R0
ffa03bb0: STORE [SP + 0x3c] = R3
ffa03bb2: MOVE R2 = CC
ffa03bb4: CC = R4 < R1
ffa03bb6: LOAD R0 = 0x1
ffa03bb8: IF !CC R0 = R2
ffa03bba: CC = R5 <= R6
ffa03bbc: AND R3 = R6 & R5
ffa03bbe: LSHIFT R3 >>= 0x1f
ffa03bc0: MOVE R2 = CC
ffa03bc2: CC = R6 == R5
ffa03bc4: XOR R3 = R3 ^ R2
ffa03bc6: LOAD R6 = [SP + 0x3c]
ffa03bc8: IF !CC R2 = R3
ffa03bca: CC = R6 == 0x0
ffa03bcc: LOAD R3 = 0x1
ffa03bce: IF CC R2 = R3
ffa03bd0: CC = BITTST (R0,0x0)
ffa03bd2: LOAD R6 = 0x0
ffa03bd4: IF CC R2 = R6
ffa03bd6: CC = BITTST (R2,0x0)
ffa03bd8: IF CC JUMP 0xffa03c2a
ffa03bda: LOAD R0 = [SP + 0x38]
ffa03bdc: CC = R4 < R1
ffa03bde: BITCLR (R0,0x1f)
ffa03be0: OR R6 = R1 | R0
ffa03be2: MOVE R2 = CC
ffa03be4: CC = R4 < R0
ffa03be6: LOAD R1 = 0x1
ffa03be8: LOAD R4 = [SP + 0x38]
ffa03bea: LOAD R3 = [SP + 0x38]
ffa03bec: IF !CC R1 = R2
ffa03bee: CC = R4 < R5
ffa03bf0: AND R3 = R5 & R3
ffa03bf2: LSHIFT R3 >>= 0x1f
ffa03bf4: MOVE R0 = CC
ffa03bf6: CC = R5 == R4
ffa03bf8: XOR R3 = R3 ^ R0
ffa03bfa: IF !CC R0 = R3
ffa03bfc: CC = R6 == 0x0
ffa03bfe: IF CC R0 = R6
ffa03c00: CC = BITTST (R1,0x0)
ffa03c02: LOAD R2 = 0x0
ffa03c04: IF CC R0 = R2
ffa03c06: CC = BITTST (R0,0x0)
ffa03c08: IF CC JUMP 0xffa03c2a
ffa03c0a: ROT|| R0 = rot R7 by 0
ffa03c0e: _LOAD R6 = [SP + 0x2c]
ffa03c10: _NOP
ffa03c12: ROT|| R1 = rot R7 by 0
ffa03c16: _STORE [FP + 0x24] = R6
ffa03c18: _NOP
ffa03c1a: CALL 0xffa018f0
ffa03c1e: LOAD R1 = [FP + 0x10]
ffa03c20: CALL 0xffa01716
ffa03c24: STORE [FP + 0x10] = R0
ffa03c26: LOAD R2 = [FP + 0x28]
ffa03c28: JUMP.S 0xffa03af4
ffa03c2a: LOAD R0 = [SP + 0x28]
ffa03c2c: CC = R0 == 0x0
ffa03c2e: IF CC JUMP 0xffa03c36
ffa03c30: LOAD P1 = [SP + 0x28]
ffa03c32: LOAD R0 = [FP + 0x24]
ffa03c34: STORE W [P1] = R0.L
ffa03c36: LOAD P1 = [FP + 0x20]
ffa03c38: LOAD P2 = [FP + 0x18]
ffa03c3a: LOAD P0 = [FP + 0x20]
ffa03c3c: LOAD P1 = [P1 + 0x4d0]
ffa03c40: LOAD P0 = [P0 + 0x4cc]
ffa03c44: ADD P1 = P1 + (P2 << 1)
ffa03c46: LOAD R1 = W [P1] (Z)
ffa03c48: MOVE P1 = R1
ffa03c4a: ADD P1 = P0 + (P1 << 2)
ffa03c4c: LOAD P1 = [P1]
ffa03c4e: LOAD R0 = W [P1 + 0x5770] (Z)
ffa03c52: CALL 0xffa016d4
ffa03c56: MOVE R1 = R0
ffa03c58: LOAD R0 = [FP + 0x10]
ffa03c5a: CALL 0xffa01814
ffa03c5e: CALL 0xffa0248c
ffa03c62: ADD SP += 0xc
ffa03c64: POP (R7:4,P5:3) = [SP++]
ffa03c66: UNLINK
ffa03c6a: RTS
ffa03c6c: LOAD R0 = [FP + 0x24]
ffa03c6e: CC = R0 == 0x0
ffa03c70: IF CC JUMP 0xffa03c78
ffa03c72: LOAD P1 = [FP + 0x24]
ffa03c74: LOAD R0 = [P5 + 0x0]
ffa03c76: STORE W [P1] = R0.L
ffa03c78: LOAD R1 = [SP + 0x28]
ffa03c7a: CC = R1 == 0x0
ffa03c7c: LOAD R0 = 0x0
ffa03c7e: IF CC JUMP 0xffa03c62
ffa03c80: LOAD P1 = [SP + 0x28]
ffa03c82: LOAD R1 = [P5 + 0x0]
ffa03c84: STORE W [P1] = R1.L
ffa03c86: JUMP.S 0xffa03c62
ffa03c8a: LINK 0xa0
ffa03c8e: PUSH [--SP] = (R7:4,P5:3)
ffa03c90: ADD SP += -0xc
ffa03c92: STORE [SP + 0x30] = R2
ffa03c94: LOAD R3 = 0x5cfc
ffa03c98: LOAD R2 = [FP + 0x28]
ffa03c9a: MULT|| R2 = R2.L * R3.L (is)
ffa03c9e: LOAD P2 = [FP + 0x18]
ffa03ca0: NOP
ffa03ca2: STORE [SP + 0x3c] = P2
ffa03ca4: MOVE P1 = R2
ffa03ca6: LOAD P2 = [FP + 0x30]
ffa03ca8: LOAD P0 = [FP + 0x14]
ffa03caa: STORE [FP + -0x40] = P0
ffa03cac: LOAD P0 = 0x578
ffa03cb0: ADD P0 = P2 + P0
ffa03cb2: ADD P0 = P0 + P1
ffa03cb4: STORE [FP + -0x5c] = R1
ffa03cb6: STORE [SP + 0x34] = R0
ffa03cb8: LOAD R0 = [P0 + 0x5cc4]
ffa03cbc: LOAD R1 = 0xfdb
ffa03cc0: LOAD R1.H = 0x4249
ffa03cc4: CALL 0xffa01814
ffa03cc8: CALL 0xffa028c8
ffa03ccc: LOAD R3 = 0x40c9
ffa03cd0: LOAD R2 = 0xfdb
ffa03cd4: STORE W [SP + 0x3a] = R3
ffa03cd8: STORE W [SP + 0x38] = R2
ffa03cdc: LOAD P3 = -0x143c
ffa03ce0: LOAD P3.H = 0x4
ffa03ce4: ADD P2 = P2 + P3
ffa03ce6: LOAD P3 = [FP + 0x34]
ffa03ce8: STORE [SP + 0x40] = R0
ffa03cec: LOAD R0 = [P0 + 0x38]
ffa03cee: MOVE P5 = FP
ffa03cf0: ADD P5 += -0x18
ffa03cf2: LOAD R1 = [SP + 0x38]
ffa03cf4: CALL 0xffa01814
ffa03cf8: CALL 0xffa028c8
ffa03cfc: LOAD R1 = W [P3 + 0x2] (Z)
ffa03cfe: STORE [SP + 0x48] = R0
