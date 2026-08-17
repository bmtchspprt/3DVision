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
