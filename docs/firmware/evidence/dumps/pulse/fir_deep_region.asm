ffa00b80: <no>
ffa00b82: RTS
ffa00b84: LINK 0xc
ffa00b88: PUSH [--SP] = (R7:4)
ffa00b8a: MOVE R5 = R2
ffa00b8c: BITCLR (R2,0x1f)
ffa00b8e: CC = R2 == 0x0
ffa00b90: MOVE R6 = R1
ffa00b92: MOVE R4 = R0
ffa00b94: ADD SP += -0xc
ffa00b96: IF !CC JUMP 0xffa00bb4
ffa00b98: LOAD R1 = [SP + 0x3c]
ffa00b9a: BITCLR (R1,0x1f)
ffa00b9c: CC = R1 == 0x0
ffa00b9e: IF !CC JUMP 0xffa00bb4
ffa00ba0: LOAD R0 = 0x0
ffa00ba2: STORE [SP + 0x20] = R0
ffa00ba4: STORE [SP + 0x24] = R0
ffa00ba6: LOAD R0 = [SP + 0x20]
ffa00ba8: LOAD R1 = [SP + 0x24]
ffa00baa: ADD SP += 0xc
ffa00bac: POP (R7:4) = [SP++]
ffa00bae: UNLINK
ffa00bb2: RTS
ffa00bb4: CC = R2 == 0x0
ffa00bb6: LOAD R7 = [SP + 0x3c]
ffa00bb8: IF !CC JUMP 0xffa00bd2
ffa00bba: MOVE R0 = R6
ffa00bbc: MOVE R1 = R7
ffa00bbe: CALL 0xffa01814
ffa00bc2: STORE [SP + 0x20] = R0
ffa00bc4: MOVE R1 = R7
ffa00bc6: MOVE R0 = R4
ffa00bc8: CALL 0xffa01814
ffa00bcc: BITTGL (R0,0x1f)
ffa00bce: STORE [SP + 0x24] = R0
ffa00bd0: JUMP.S 0xffa00ba6
ffa00bd2: MOVE R1 = R7
ffa00bd4: BITCLR (R1,0x1f)
ffa00bd6: CC = R1 == 0x0
ffa00bd8: IF !CC JUMP 0xffa00bee
ffa00bda: MOVE R1 = R5
ffa00bdc: CALL 0xffa01814
ffa00be0: STORE [SP + 0x20] = R0
ffa00be2: MOVE R1 = R5
ffa00be4: MOVE R0 = R6
ffa00be6: CALL 0xffa01814
ffa00bea: STORE [SP + 0x24] = R0
ffa00bec: JUMP.S 0xffa00ba6
ffa00bee: MOVE R0 = R2
ffa00bf0: CALL 0xffa01630
ffa00bf4: IF !CC JUMP 0xffa00c4e
ffa00bf6: MOVE R1 = R5
ffa00bf8: MOVE R0 = R7
ffa00bfa: CALL 0xffa01814
ffa00bfe: STORE [SP + 0x1c] = R0
ffa00c00: MOVE R0 = R7
ffa00c02: LOAD R1 = [SP + 0x1c]
ffa00c04: CALL 0xffa018f0
ffa00c08: MOVE R1 = R5
ffa00c0a: CALL 0xffa01716
ffa00c0e: MOVE R1 = R0
ffa00c10: LOAD R0 = 0x0
ffa00c12: LOAD R0.H = 0x3f80
ffa00c16: CALL 0xffa01814
ffa00c1a: MOVE R7 = R0
ffa00c1c: MOVE R5 = R0
ffa00c1e: MOVE R0 = R6
ffa00c20: LOAD R1 = [SP + 0x1c]
ffa00c22: CALL 0xffa018f0
ffa00c26: MOVE R1 = R4
ffa00c28: CALL 0xffa01716
ffa00c2c: MOVE R1 = R7
ffa00c2e: CALL 0xffa018f0
ffa00c32: STORE [SP + 0x20] = R0
ffa00c34: MOVE R0 = R4
ffa00c36: LOAD R1 = [SP + 0x1c]
ffa00c38: CALL 0xffa018f0
ffa00c3c: MOVE R1 = R0
ffa00c3e: MOVE R0 = R6
ffa00c40: CALL 0xffa01714
ffa00c44: MOVE R1 = R5
ffa00c46: CALL 0xffa018f0
ffa00c4a: STORE [SP + 0x24] = R0
ffa00c4c: JUMP.S 0xffa00ba6
ffa00c4e: MOVE R1 = R7
ffa00c50: MOVE R0 = R5
ffa00c52: CALL 0xffa01814
ffa00c56: STORE [SP + 0x1c] = R0
ffa00c58: MOVE R0 = R5
ffa00c5a: LOAD R1 = [SP + 0x1c]
ffa00c5c: CALL 0xffa018f0
ffa00c60: MOVE R1 = R7
ffa00c62: CALL 0xffa01716
ffa00c66: MOVE R1 = R0
ffa00c68: LOAD R0 = 0x0
ffa00c6a: LOAD R0.H = 0x3f80
ffa00c6e: CALL 0xffa01814
ffa00c72: MOVE R7 = R0
ffa00c74: MOVE R5 = R0
ffa00c76: MOVE R1 = R4
ffa00c78: LOAD R0 = [SP + 0x1c]
ffa00c7a: CALL 0xffa018f0
ffa00c7e: MOVE R1 = R6
ffa00c80: CALL 0xffa01716
ffa00c84: MOVE R1 = R7
ffa00c86: CALL 0xffa018f0
ffa00c8a: STORE [SP + 0x20] = R0
ffa00c8c: MOVE R0 = R6
ffa00c8e: LOAD R1 = [SP + 0x1c]
ffa00c90: CALL 0xffa018f0
ffa00c94: MOVE R1 = R4
ffa00c96: CALL 0xffa01714
ffa00c9a: MOVE R1 = R5
ffa00c9c: CALL 0xffa018f0
ffa00ca0: STORE [SP + 0x24] = R0
ffa00ca2: JUMP.S 0xffa00ba6
ffa00ca4: LINK 0x0
ffa00ca8: PUSH [--SP] = (R7:6)
ffa00caa: ADD SP += -0xc
ffa00cac: MOVE R7 = R0
ffa00cae: CALL 0xffa00da4
ffa00cb2: MOVE R6 = R0
ffa00cb4: MOVE R0 = R7
ffa00cb6: CALL 0xffa020d4
ffa00cba: ADD SP += 0xc
ffa00cbc: MOVE R1 = R0
ffa00cbe: MOVE R0 = R6
ffa00cc0: POP (R7:6) = [SP++]
ffa00cc2: UNLINK
ffa00cc6: RTS
ffa00cc8: PUSH [--SP] = (R7:6)
ffa00cca: LOAD R3 = [SP + 0x14]
ffa00ccc: CC = R3 <= 0x0
ffa00cce: IF CC JUMP 0xffa00d7a
ffa00cd0: CC = R1 <= 0x0
ffa00cd2: IF CC JUMP 0xffa00d7a
ffa00cd4: MOVE R6 = R0
ffa00cd6: MOVE R7 = R1
ffa00cd8: CC = R1 < R3
ffa00cda: IF CC R0 = R2
ffa00cdc: IF CC R1 = R3
ffa00cde: IF CC R2 = R6
ffa00ce0: IF CC R3 = R7
ffa00ce2: LSH R7 = R1 << 0x1
ffa00ce6: MOVE B0 = R0
ffa00ce8: MOVE I0 = R0
ffa00cea: MOVE L0 = R7
ffa00cec: LSH R6 = R3 << 0x1
ffa00cf0: MOVE B1 = R2
ffa00cf2: MOVE I1 = R2
ffa00cf4: MOVE L1 = R6
ffa00cf6: ADD R3 += -0x1
ffa00cf8: SUB R6 = R1 - R3
ffa00cfa: LOAD R2 = -0x3
ffa00cfc: ADD R2 = (R2 + R6) << 1
ffa00cfe: MOVE M1 = R2
ffa00d00: LOAD R0 = [SP + 0x18]
ffa00d02: ADD R7 = R0 + R7
ffa00d04: MOVE I3 = R7
ffa00d06: MOVE I2 = R0
ffa00d08: MOVE P0 = R3
ffa00d0a: LOAD P1 = 0x1
ffa00d0c: MOVE P2 = R6
ffa00d0e: CC = R3 == 0x0
ffa00d10: IF CC JUMP 0xffa00d86
ffa00d12: LSH R6 = R6 << 0x1
ffa00d16: MOVE M0 = R6
ffa00d18: LSETUP (0xffa00d1c,0xffa00d48) LC0 = P0
ffa00d1c: CLR|| A1 = A0 = 0
ffa00d20: _LOAD R0.L = W [I0--]
ffa00d22: _LOAD R1.L = W [I1++]
ffa00d24: LSETUP (0xffa00d28,0xffa00d28) LC1 = P1
ffa00d28: MAC|| R2.L = (A0 += R0.L * R1.L) 
ffa00d2c: LOAD R0.L = W [I0--]
ffa00d2e: LOAD R1.L = W [I1++]
ffa00d30: ADD P1 += 0x1
ffa00d32: LSETUP (0xffa00d36,0xffa00d36) LC1 = P0
ffa00d36: MAC|| R3.H = (A1 += R0.L * R1.L) 
ffa00d3a: LOAD R0.L = W [I0--]
ffa00d3c: LOAD R1.L = W [I1++]
ffa00d3e: ADD P0 += -0x1
ffa00d40: MNOP||
ffa00d44: _SUB I1 -= 2
ffa00d46: _STORE W [I2++] = R2.L
ffa00d48: MNOP||
ffa00d4c: _SUB I0 -= M1
ffa00d4e: _STORE W [I3++] = R3.H
ffa00d50: ADD P1 += -0x1
ffa00d52: MOVE I0 = B0
ffa00d54: SUB I1 -= 2
ffa00d56: LSETUP (0xffa00d5a,0xffa00d72) LC0 = P2
ffa00d5a: CLR|| A0 = 0
ffa00d5e: _LOAD R0.L = W [I0++]
ffa00d60: _LOAD R1.L = W [I1--]
ffa00d62: LSETUP (0xffa00d66,0xffa00d66) LC1 = P1
ffa00d66: MAC|| A0 += R0.L * R1.L 
ffa00d6a: LOAD R0.L = W [I0++]
ffa00d6c: LOAD R1.L = W [I1--]
ffa00d6e: MAC R2.L = (A0 += R0.L * R1.L) 
ffa00d72: MNOP||
ffa00d76: _ADD I0 += M0
ffa00d78: _STORE W [I2++] = R2.L
ffa00d7a: POP (R7:6) = [SP++]
ffa00d7c: LOAD L0 = 0x0
ffa00d80: LOAD L1 = 0x0
ffa00d84: RTS
ffa00d86: MNOP||
ffa00d8a: _LOAD R0.L = W [I0++]
ffa00d8c: _LOAD R1.L = W [I1]
ffa00d8e: MAC|| R2.L = (A0 = R0.L * R1.L) 
ffa00d92: LOAD R0.L = W [I0++]
ffa00d94: NOP
ffa00d96: LSETUP (0xffa00d9a,0xffa00d9a) LC0 = P2
ffa00d9a: MAC|| R2.L = (A0 = R0.L * R1.L) 
ffa00d9e: LOAD R0.L = W [I0++]
ffa00da0: STORE W [I2++] = R2.L
ffa00da2: JUMP.S 0xffa00d7a
ffa00da4: LINK 0x8
