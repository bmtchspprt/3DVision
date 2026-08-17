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
