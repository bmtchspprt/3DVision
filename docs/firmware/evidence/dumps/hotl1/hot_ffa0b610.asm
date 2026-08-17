ffa0b610: LINK 0x0
ffa0b614: PUSH [--SP] = (R7:6,P5:3)
ffa0b616: LSH R3 = R0 >> 0x1b
ffa0b61a: LOAD R6 = 0x24
ffa0b61c: LOAD P4.L = 0x1e50
ffa0b620: LOAD P4.H = 0xff80
ffa0b624: MULT R3 = R3.L * R6.L (is)
ffa0b628: MOVE P1 = R3
ffa0b62a: ADD SP += -0xc
ffa0b62c: MOVE P5 = R1
ffa0b62e: MOVE R7 = R2
ffa0b630: MOVE R6 = R0
ffa0b632: ADD P1 = P4 + P1
ffa0b634: LOAD P4 = [P1]
ffa0b636: STORE [SP + 0x28] = P4
ffa0b638: LOAD P2 = -0x1
ffa0b63a: LOAD P2.H = 0xfff8
ffa0b63e: LOAD P0.L = 0x3ae0
ffa0b642: LOAD P0.H = 0xff80
ffa0b646: LOAD P4 = -0x1
ffa0b648: LSETUP (0xffa0b64c,0xffa0b688) LC0 = P4
ffa0b64c: ADD P3 = P5 + P2
ffa0b64e: LOAD P4 = 0x1a
ffa0b650: CC = P3 < P4 (IU)
ffa0b652: MOVE P4 = R7
ffa0b654: IF !CC JUMP 0xffa0b662
ffa0b656: NOP
ffa0b658: NOP
ffa0b65a: ADD P3 = P0 + (P3 << 2)
ffa0b65c: LOAD P3 = [P3]
ffa0b65e: LOAD R2 = 0x1
ffa0b660: JUMP (P3)
ffa0b662: ADD SP += 0xc
ffa0b664: LOAD P0 = [FP + 0x4]
ffa0b666: POP (R7:6,P5:3) = [SP++]
ffa0b668: UNLINK
ffa0b66c: LOAD R0 = 0x5
ffa0b66e: LOAD R0.H = 0x7
ffa0b672: JUMP (P0)
