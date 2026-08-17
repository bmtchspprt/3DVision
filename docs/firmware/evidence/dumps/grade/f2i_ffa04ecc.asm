ffa04eae: MNOP||
ffa04eb2: _LOAD R0 = [P0++]
ffa04eb4: _LOAD R1.L = W [I0]
ffa04eb6: LOAD R2 = 0x5cfc
ffa04eba: MULT R1 = R1.L * R2.L (is)
ffa04ebe: ADD R1 = R4 + R1
ffa04ec0: ADD R1 = R1 + R6
ffa04ec2: ADD R1 = R1 + R7
ffa04ec4: MOVE P2 = R1
ffa04ec6: MOVE R1 = R5
ffa04ec8: CALL 0xffa01814
ffa04ecc: CALL 0xffa0290c
ffa04ed0: ADD R7 += 0x2
ffa04ed2: STORE W [P2] = R0.L
ffa04ed4: ADD SP += 0x20
ffa04ed6: POP (R7:4,P5:3) = [SP++]
ffa04ed8: UNLINK
ffa04edc: LOAD R0 = 0x0
ffa04ede: RTS
ffa04ee0: LOAD P1 = [P2 + 0x4]
ffa04ee2: ADD P1 = P4 + (P1 << 2)
ffa04ee4: STORE [P1] = R6
ffa04ee6: JUMP.S 0xffa04930
ffa04ee8: LOAD P1 = [P2 + 0x4]
ffa04eea: LOAD R6 = [P2 + 0x18]
ffa04eec: MOVE R1 = R6
ffa04eee: ADD P0 = P4 + (P1 << 2)
ffa04ef0: LOAD R0 = [P0]
ffa04ef2: CALL 0xffa0165c
ffa04ef6: IF CC JUMP 0xffa04efa (bp)
ffa04ef8: JUMP.S 0xffa04930
ffa04efa: STORE [P0] = R6
ffa04efc: JUMP.S 0xffa04930
ffa04efe: LOAD R0 = [FP + 0x28]
ffa04f00: LOAD R1 = 0x7
ffa04f02: CC = R0 == R1
ffa04f04: IF CC JUMP 0xffa04f08 (bp)
ffa04f06: JUMP.S 0xffa04930
ffa04f08: LOAD P1 = [FP + -0x5c]
ffa04f0a: LOAD P3 = [FP + -0x5c]
ffa04f0c: LOAD R2 = 0xff
