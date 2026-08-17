ffa009f8: MAC A1 += R1.H * R0.L (m)
ffa009fc: MAC A1 += R5.H * R5.H (fu)
ffa00a00: ASH A1 = A1 >>> 0xf
ffa00a04: MOVE R0 = (A0 += A1)
ffa00a08: ADD R2 = R0 + R2 (s)
ffa00a0c: ASH R0 = R3 >>> 0x1f
ffa00a10: LSHIFT R0 <<= 0x1e
ffa00a12: ASH R1 = R2 >>> 0x1f
ffa00a16: LSH|| R1 = R3 >> 0x2
ffa00a1a: _STORE [SP + 0xc] = R1
ffa00a1c: _NOP
ffa00a1e: OR R1 = R0 | R1
ffa00a20: LSH R0 = R3 << 0x1e
ffa00a24: CALL 0xffa01150
ffa00a28: CALL 0xffa02894
ffa00a2c: MOVE R1 = R7
ffa00a2e: CALL 0xffa018f0
ffa00a32: MOVE R1 = R7
ffa00a34: CALL 0xffa01716
ffa00a38: MOVE R7 = R0
ffa00a3a: CC = P5 <= 0x0
ffa00a3c: IF CC JUMP 0xffa00a60
ffa00a3e: CC = P5 <= 0x1
ffa00a40: ADD P5 += -0x1
ffa00a42: MOVE R0 = R7
ffa00a44: BITTGL (R0,0x1f)
ffa00a46: IF !CC R7 = R0
ffa00a48: LOAD P1.L = 0x346c
ffa00a4c: LOAD P1.H = 0xff80
ffa00a50: ADD P1 = P1 + (P5 << 2)
ffa00a52: ROT|| R0 = rot R7 by 0
ffa00a56: _LOAD R1 = [P1]
ffa00a58: _NOP
ffa00a5a: CALL 0xffa01716
ffa00a5e: MOVE R7 = R0
ffa00a60: ADD SP += 0x10
ffa00a62: ROT|| R0 = rot R7 by 0
ffa00a66: _LOAD P0 = [FP + 0x4]
ffa00a68: _NOP
ffa00a6a: CC = R6 < 0x0
ffa00a6c: BITTGL (R7,0x1f)
ffa00a6e: IF CC R0 = R7
ffa00a70: POP (R7:4,P5:5) = [SP++]
ffa00a72: UNLINK
ffa00a76: JUMP (P0)
ffa00a78: ABS R0 = abs R0 (v)
