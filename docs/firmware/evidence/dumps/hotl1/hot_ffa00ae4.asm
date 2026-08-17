ffa00ae4: LINK 0x0
ffa00ae8: MOVE R2 = R0
ffa00aea: MOVE R3 = R1
ffa00aec: PUSH [--SP] = (R7:4)
ffa00aee: MOVE R7 = R2
ffa00af0: BITCLR (R3,0x1f)
ffa00af2: BITCLR (R7,0x1f)
ffa00af4: CC = R3 == 0x0
ffa00af6: ADD SP += -0xc
ffa00af8: MOVE R0 = R7
ffa00afa: IF CC JUMP 0xffa00b7a
ffa00afc: CC = R7 == 0x0
ffa00afe: MOVE R0 = R3
ffa00b00: IF CC JUMP 0xffa00b7a
ffa00b02: LOAD R5 = 0x0
ffa00b04: LOAD R5.H = 0x7f80
ffa00b08: MOVE R0 = R7
ffa00b0a: AND R6 = R2 & R5
ffa00b0c: AND R7 = R1 & R5
ffa00b0e: LOAD R4 = 0x0
ffa00b10: ADDSUB R7 = R6 + R7,R6 = R6 - R7 (ns)
ffa00b14: LOAD R4.H = 0x680
ffa00b18: CC = R4 < R6
ffa00b1a: IF CC JUMP 0xffa00b7a
ffa00b1c: MOVE R0 = R3
ffa00b1e: LOAD R4 = 0x0
ffa00b20: LOAD R4.H = 0xf980
ffa00b24: CC = R6 < R4
ffa00b26: IF CC JUMP 0xffa00b7a (bp)
ffa00b28: LSHIFT R7 >>= 0x1
ffa00b2a: AND R4 = R7 & R5
ffa00b2c: AND R3 = R2 & R5
ffa00b2e: SUB R3 = R3 - R4
ffa00b30: STORE [SP + 0x2c] = R3
ffa00b32: LOAD R6 = -0x1
ffa00b34: AND R0 = R1 & R5
ffa00b36: LOAD R6.H = 0x807f
ffa00b3a: SUB R7 = R0 - R4
ffa00b3c: AND R0 = R1 & R6
ffa00b3e: LOAD R3 = 0x0
ffa00b40: LOAD R1 = [SP + 0x2c]
ffa00b42: LOAD R3.H = 0x3f80
ffa00b46: ADD R1 = R1 + R3
ffa00b48: AND R2 = R2 & R6
ffa00b4a: ADD R7 = R7 + R3
ffa00b4c: OR R1 = R1 | R2
ffa00b4e: OR R7 = R7 | R0
ffa00b50: MOVE R0 = R1
ffa00b52: CALL 0xffa018f0
ffa00b56: STORE [SP + 0x2c] = R0
ffa00b58: MOVE R1 = R7
ffa00b5a: MOVE R0 = R7
ffa00b5c: CALL 0xffa018f0
ffa00b60: LOAD R1 = [SP + 0x2c]
ffa00b62: CALL 0xffa01716
ffa00b66: CALL 0xffa0248c
ffa00b6a: LOAD R2 = 0x0
ffa00b6c: LOAD R2.H = 0xc080
ffa00b70: AND R1 = R0 & R5
ffa00b72: ADD R2 = R4 + R2
ffa00b74: AND R3 = R0 & R6
ffa00b76: ADD R1 = R1 + R2
ffa00b78: OR R0 = R1 | R3
ffa00b7a: ADD SP += 0xc
ffa00b7c: POP (R7:4) = [SP++]
ffa00b7e: UNLINK
ffa00b82: RTS
