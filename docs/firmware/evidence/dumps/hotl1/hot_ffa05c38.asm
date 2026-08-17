ffa05c38: LINK 0x0
ffa05c3c: PUSH [--SP] = (R7:4,P5:3)
ffa05c3e: MOVE R7 = R2
ffa05c40: MOVE P1 = R7
ffa05c42: LOAD P0 = 0x548
ffa05c46: MOVE R6 = R0
ffa05c48: ADD SP += -0xc
ffa05c4a: LOAD P5.L = 0x5046
ffa05c4e: LOAD P5.H = 0x2021
ffa05c52: ADD P3 = P1 + P0
ffa05c54: LOAD P4.L = 0x2850
ffa05c58: LOAD P4.H = 0x202d
ffa05c5c: LOAD R4 = 0x0
ffa05c5e: ROT|| R5 = rot R4 by 0
ffa05c62: _LOAD R0 = W [P5++] (Z)
ffa05c64: _NOP
ffa05c66: MOVE P1 = R0
ffa05c68: LOAD R1 = 0xa028
ffa05c6c: ADD R4 += 0x1
ffa05c6e: ADD P1 = P4 + (P1 << 2)
ffa05c70: LOAD P1 = [P1]
ffa05c72: LOAD R0 = [P1 + 0x57c0]
ffa05c76: CALL 0xffa05ee4
ffa05c7a: ROT|| R1 = rot R7 by 0
ffa05c7e: _LOAD R2 = [P3++]
ffa05c80: _NOP
ffa05c82: ADD R0 = R0 + R2
ffa05c84: CALL 0xffa0586c
ffa05c88: CC = R0 < R6
ffa05c8a: IF !CC JUMP 0xffa05c94
ffa05c8c: MOVE R0 = R5.L (X)
ffa05c8e: LOAD R1 = 0xb
ffa05c90: CC = R1 <= R0
ffa05c92: IF !CC JUMP 0xffa05c5e (bp)
ffa05c94: ADD SP += 0xc
ffa05c96: MOVE R0 = R5.L (X)
ffa05c98: POP (R7:4,P5:3) = [SP++]
ffa05c9a: UNLINK
ffa05c9e: RTS
