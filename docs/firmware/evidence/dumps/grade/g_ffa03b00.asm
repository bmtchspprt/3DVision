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
