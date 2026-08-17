ffa04b70: ADD P2 = P3 + P2
ffa04b72: STORE [P2 + 0x5ce8] = R2
ffa04b76: IF CC JUMP 0xffa04be2
ffa04b78: NOP
ffa04b7a: LOAD P1 = [FP + 0x18]
ffa04b7c: LOAD P0 = [FP + -0x5c]
ffa04b7e: LOAD R0 = [P1 + 0xc]
ffa04b80: ASHIFT R0 >>>= 0xf
ffa04b82: ADD R0 += 0x1
ffa04b84: CC = R0 <= 0x0
ffa04b86: STORE W [P0 + -0x6] = R7
ffa04b8a: IF CC JUMP 0xffa04be2
ffa04b8c: LOAD P0 = 0x0
ffa04b8e: LOAD R6 = 0x0
ffa04b90: LOAD P2 = 0x44
ffa04b94: LOAD P1 = [FP + -0x44]
ffa04b96: MOVE I0 = P1
ffa04b98: LOAD P1 = -0x1
ffa04b9a: LSETUP (0xffa04b9e,0xffa04bd6) LC1 = P1
ffa04b9e: MNOP||
ffa04ba2: _LOAD R1 = [FP + 0x8]
ffa04ba4: _LOAD R0 = [I0++]
ffa04ba6: CALL 0xffa01814
ffa04baa: CALL 0xffa0290c
ffa04bae: LOAD R4 = W [P5] (X)
ffa04bb0: LOAD R1 = 0x5cfc
ffa04bb4: MULT|| R1 = R4.L * R1.L (is)
ffa04bb8: LOAD P3 = [FP + 0xc]
ffa04bba: NOP
ffa04bbc: MOVE P1 = R1
ffa04bbe: ADD R6 += 0x1
ffa04bc0: MOVE R2 = R6.L (X)
ffa04bc2: ADD P1 = P3 + P1
ffa04bc4: LOAD P3 = [FP + 0x18]
ffa04bc6: ADD P1 = P1 + P2
ffa04bc8: ADD P1 = P1 + P0
ffa04bca: STORE W [P1] = R0.L
ffa04bcc: LOAD R0 = [P3 + 0xc]
ffa04bce: ASHIFT R0 >>>= 0xf
ffa04bd0: ADD R0 += 0x1
ffa04bd2: CC = R2 < R0
ffa04bd4: ADD P0 += 0x2
ffa04bd6: IF !CC JUMP 0xffa04bdc
ffa04bd8: MOVE P1 = I0
ffa04bda: JUMP.S 0xffa04b96
ffa04bdc: LOAD P1 = [FP + -0x5c]
ffa04bde: STORE W [P1 + -0x6] = R6
ffa04be2: MOVE R6 = R5
ffa04be4: BITCLR (R5,0x1f)
ffa04be6: CC = R5 == 0x0
ffa04be8: IF CC JUMP 0xffa04c54
ffa04bea: NOP
ffa04bec: LOAD P1 = [FP + 0x18]
ffa04bee: LOAD P0 = [FP + -0x5c]
ffa04bf0: LOAD R0 = [P1 + 0xc]
ffa04bf2: ASHIFT R0 >>>= 0x12
ffa04bf4: ADD R0 += 0x1
ffa04bf6: CC = R0 <= 0x0
ffa04bf8: STORE W [P0 + -0x6] = R7
ffa04bfc: IF CC JUMP 0xffa04c54
ffa04bfe: LOAD P0 = 0x0
ffa04c00: LOAD R5 = 0x0
ffa04c02: LOAD P2 = [FP + -0x4c]
ffa04c04: LOAD P1 = -0x1
ffa04c06: LOAD R1 = W [P5] (X)
ffa04c08: LSETUP (0xffa04c0c,0xffa04c4a) LC1 = P1
ffa04c0c: LOAD R1.H = 0x5cfc
ffa04c10: MULT|| R1 = R1.L * R1.H (is)
ffa04c14: LOAD R0 = [P2++]
ffa04c16: NOP
ffa04c18: ROT|| R1 = rot R6 by 0
ffa04c1c: _STORE [FP + -0x58] = R1
ffa04c1e: _NOP
ffa04c20: CALL 0xffa01814
ffa04c24: CALL 0xffa0290c
ffa04c28: LOAD P3 = [FP + -0x58]
ffa04c2a: LOAD P1 = [FP + 0xc]
ffa04c2c: ADD R5 += 0x1
ffa04c2e: MOVE R1 = R5.L (X)
ffa04c30: ADD P1 = P1 + P3
ffa04c32: LOAD P3 = 0x3374
ffa04c36: ADD P1 = P1 + P3
ffa04c38: LOAD P3 = [FP + 0x18]
ffa04c3a: ADD P1 = P1 + P0
ffa04c3c: STORE W [P1] = R0.L
ffa04c3e: ADD P0 += 0x2
ffa04c40: LOAD R0 = [P3 + 0xc]
ffa04c42: ASHIFT R0 >>>= 0x12
ffa04c44: ADD R0 += 0x1
ffa04c46: CC = R1 < R0
ffa04c48: IF !CC JUMP 0xffa04c4e
ffa04c4a: LOAD R1 = W [P5] (X)
ffa04c4c: JUMP.S 0xffa04c04
ffa04c4e: LOAD P1 = [FP + -0x5c]
ffa04c50: STORE W [P1 + -0x6] = R5
ffa04c54: LOAD R0 = [FP + 0x10]
ffa04c56: BITCLR (R0,0x1f)
ffa04c58: CC = R0 == 0x0
ffa04c5a: IF CC JUMP 0xffa04cc6
ffa04c5c: NOP
ffa04c5e: LOAD P1 = [FP + 0x18]
ffa04c60: LOAD P0 = [FP + -0x5c]
ffa04c62: LOAD R0 = [P1 + 0xc]
ffa04c64: ASHIFT R0 >>>= 0x12
ffa04c66: ADD R0 += 0x1
ffa04c68: CC = R0 <= 0x0
ffa04c6a: STORE W [P0 + -0x6] = R7
ffa04c6e: IF CC JUMP 0xffa04cc6
ffa04c70: LOAD P0 = 0x0
ffa04c72: LOAD R6 = 0x0
ffa04c74: LOAD P2 = 0x3892
ffa04c78: LOAD P1 = [FP + -0x54]
ffa04c7a: MOVE I0 = P1
ffa04c7c: LOAD P1 = -0x1
ffa04c7e: LSETUP (0xffa04c82,0xffa04cba) LC1 = P1
