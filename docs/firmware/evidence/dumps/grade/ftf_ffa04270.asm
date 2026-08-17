ffa04240: LOAD R6 = [FP + -0x54]
ffa04242: LOAD R0 = [FP + -0x38]
ffa04244: LOAD R4 = [FP + -0x34]
ffa04246: IF !CC JUMP 0xffa04282
ffa04248: LOAD R0 = [FP + -0x5c]
ffa0424a: CC = R0 == 0x0
ffa0424c: IF !CC JUMP 0xffa04368
ffa0424e: LOAD R0 = [FP + -0x5c]
ffa04250: CC = R0 == 0x0
ffa04252: IF !CC JUMP 0xffa04358
ffa04254: LOAD P5 = [FP + -0x40]
ffa04256: LOAD R6 = 0x3
ffa04258: ADD R6 += -0x1
ffa0425a: LOAD R0 = [P4++]
ffa0425c: LSH|| R0 = R0 << 0x3
ffa04260: _LOAD R5 = [P4++]
ffa04262: _NOP
ffa04264: CALL 0xffa02894
ffa04268: LSH|| R0 = R5 << 0x3
ffa0426c: _STORE [P5++] = R0
ffa0426e: _NOP
ffa04270: CALL 0xffa02894
ffa04274: CC = R6 == 0x0
ffa04276: STORE [P5++] = R0
ffa04278: IF !CC JUMP 0xffa04258 (bp)
ffa0427a: LOAD R5 = [FP + -0x44]
ffa0427c: LOAD R0 = [FP + -0x3c]
ffa0427e: LOAD R6 = [FP + -0x6c]
ffa04280: LOAD R4 = [FP + 0x2c]
ffa04282: LOAD R2 = [FP + -0x44]
ffa04284: LOAD R3 = [FP + -0x68]
ffa04286: ADD|| R2 = R3 + R2 (ns)
ffa0428a: _LOAD R1 = [FP + -0x70]
ffa0428c: _NOP
ffa0428e: CC = R2 <= R1
ffa04290: LOAD R1 = [FP + 0x24]
ffa04292: SUB|| R1 = R1 - R3 (ns)
ffa04296: _STORE [FP + -0x58] = R5
ffa04298: _NOP
ffa0429a: STORE [FP + -0x54] = R6
ffa0429c: STORE [FP + -0x38] = R0
ffa0429e: STORE [FP + -0x34] = R4
ffa042a0: STORE [SP + 0x2c] = R7
ffa042a2: STORE [FP + -0x44] = R2
ffa042a4: STORE [FP + 0x24] = R1
ffa042a6: IF !CC JUMP 0xffa042aa
ffa042a8: JUMP.S 0xffa03dda
ffa042aa: LOAD R3 = [FP + -0x50]
ffa042ac: STORE [SP + 0x2c] = R3
ffa042ae: LOAD R1 = [FP + -0x4c]
ffa042b0: LOAD R2 = [FP + -0x6c]
ffa042b2: LOAD R3 = [SP + 0x44]
ffa042b6: ADD|| R2 = R3 + R2 (ns)
ffa042ba: _LOAD R3 = [SP + 0x2c]
ffa042bc: _NOP
ffa042be: STORE [FP + -0x50] = R3
ffa042c0: LOAD R3 = [SP + 0x48]
