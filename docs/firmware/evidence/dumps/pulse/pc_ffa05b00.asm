ffa05b00: CC = R1 == 0x0
ffa05b02: LOAD R0 = 0x0
ffa05b04: IF CC JUMP 0xffa05b16
ffa05b06: LOAD R0 = -0x1
ffa05b08: LSHIFT R0 >>= 0x1
ffa05b0a: CC = R1 == R0
ffa05b0c: LOAD R0 = 0x1
ffa05b0e: IF CC JUMP 0xffa05b16 (bp)
ffa05b10: ADD R1 += 0x1
ffa05b12: CALL 0xffa05ee4
ffa05b16: LOAD R1 = [FP + 0x18]
ffa05b18: CC = R1 == 0x0
ffa05b1a: IF CC JUMP 0xffa05b7a
ffa05b1c: CC = R7 <= 0x0
ffa05b1e: IF CC JUMP 0xffa05b5a
ffa05b20: MOVE P1 = R7
ffa05b22: LOAD P0 = [SP + 0x30]
ffa05b24: LOAD P2 = 0x2
ffa05b26: MOVE I0 = P0
ffa05b28: LSETUP (0xffa05b2c,0xffa05b58) LC0 = P1
ffa05b2c: MNOP||
ffa05b30: _LOAD R2 = W [P5] (X)
ffa05b32: _LOAD R3.L = W [I0]
ffa05b34: NEG|| R1 = -R2 (ns)
ffa05b38: _LOAD R7 = W [P4++] (X)
ffa05b3a: _NOP
ffa05b3c: MULT|| R6 = R2.L * R7.L (is)
ffa05b40: LOAD R2 = W [P4++] (X)
ffa05b42: NOP
ffa05b44: MULT R1 *= R2
ffa05b46: MULT R2 = R3.L * R2.L (is)
ffa05b4a: ADD R2 = R6 + R2
ffa05b4c: MULT R3 = R7.L * R3.L (is)
ffa05b50: ADD R1 = R1 + R3
ffa05b52: MULT R2 *= R0
ffa05b54: STORE W [P5 ++ P2] = R2.H
ffa05b56: MULT R1 *= R0
ffa05b58: STORE W [I0++] = R1.H
ffa05b5a: LOAD R1 = 0x1
ffa05b5c: MAX R0 = max(R0,R1)
ffa05b60: CALL 0xffa01688
ffa05b64: MOVE R1 = R0
ffa05b66: LOAD R0 = 0x0
ffa05b68: LOAD R0.H = 0x4f00
ffa05b6c: CALL 0xffa01814
ffa05b70: ADD SP += 0xc
ffa05b72: POP (R7:4,P5:3) = [SP++]
ffa05b74: UNLINK
ffa05b78: RTS
ffa05b7a: CC = R7 <= 0x0
ffa05b7c: IF CC JUMP 0xffa05b5a
ffa05b7e: MOVE P1 = R7
ffa05b80: LOAD P0 = [SP + 0x30]
ffa05b82: MOVE I0 = P5
ffa05b84: MOVE I1 = P0
ffa05b86: LSETUP (0xffa05b8a,0xffa05bb0) LC0 = P1
ffa05b8a: MNOP||
ffa05b8e: _LOAD R1 = W [P4++] (X)
ffa05b90: _LOAD R2.L = W [I0]
ffa05b92: MULT|| R6 = R2.L * R1.L (is)
ffa05b96: LOAD R7 = W [P4++] (X)
ffa05b98: LOAD R3.L = W [I1]
ffa05b9a: MULT R5 = R1.L * R3.L (is)
ffa05b9e: MULT R1 = R3.L * R7.L (is)
ffa05ba2: SUB R1 = R6 - R1
ffa05ba4: MULT R2 = R2.L * R7.L (is)
ffa05ba8: ADD R2 = R2 + R5
ffa05baa: MULT R1 *= R0
ffa05bac: STORE W [I0++] = R1.H
ffa05bae: MULT R2 *= R0
ffa05bb0: STORE W [I1++] = R2.H
ffa05bb2: JUMP.S 0xffa05b5a
