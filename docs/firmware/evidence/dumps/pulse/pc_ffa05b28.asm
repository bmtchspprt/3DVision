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
