ffa01c38: LOAD R3 = [SP + 0xc]
ffa01c3a: MULT R1 *= R2
ffa01c3c: MULT R3 *= R0
ffa01c3e: ADD R1 = R1 + R3
ffa01c40: MAC R3 = (A1 = R0.L * R2.L) (fu)
ffa01c44: LSH A1 = A1 >> 0x10
ffa01c48: MAC|| A1 += R0.L * R2.H (fu)
ffa01c4c: STORE [SP] = R4
ffa01c4e: NOP
ffa01c50: MAC|| A1 += R0.H * R2.L (fu)
ffa01c54: STORE [SP + 0x4] = R5
ffa01c56: NOP
ffa01c58: MOVE R4 = A1.W
ffa01c5a: LSH A1 = A1 >> 0x10
ffa01c5e: MAC R5 = (A1 += R0.H * R2.H) (fu)
ffa01c62: PACK|| R0 = pack(R4.L,R3.L)
ffa01c66: _LOAD R4 = [SP]
ffa01c68: _NOP
ffa01c6a: ADD|| R1 = R1 + R5 (ns)
ffa01c6e: _LOAD R5 = [SP + 0x4]
ffa01c70: _NOP
ffa01c72: RTS
