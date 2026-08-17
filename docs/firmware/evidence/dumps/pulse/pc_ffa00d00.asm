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
