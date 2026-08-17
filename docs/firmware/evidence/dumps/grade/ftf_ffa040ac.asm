ffa0407c: LOAD R2 = [FP + 0x2c]
ffa0407e: SUB|| R0 = R3 - R2 (s)
ffa04082: STORE [FP + -0x48] = R0
ffa04084: NOP
ffa04086: MOVE CC &= az
ffa04088: MOVE CC |= an
ffa0408a: STORE [FP + -0x4c] = R1
ffa0408c: LOAD R7 = [SP + 0x2c]
ffa0408e: IF !CC JUMP 0xffa0422a
ffa04090: LOAD R0 = [FP + -0x5c]
ffa04092: CC = R0 == 0x0
ffa04094: IF CC JUMP 0xffa0422a
ffa04096: LOAD R1 = [FP + 0xc]
ffa04098: LOAD R0 = 0x0
ffa0409a: LSH R4 = R1 << 0x3
ffa0409e: PACK|| R6 = pack(R6.H,R0.L)
ffa040a2: _LOAD R2 = [FP + 0x10]
ffa040a4: _NOP
ffa040a6: MOVE R0 = R4
ffa040a8: LSH R5 = R2 << 0x3
ffa040ac: CALL 0xffa02894
ffa040b0: MOVE R7 = R0
ffa040b2: MOVE R0 = R5
ffa040b4: CALL 0xffa02894
ffa040b8: LOAD P1 = [FP + -0x40]
ffa040ba: ROT|| R0 = rot R7 by 0
ffa040be: _STORE [FP + 0xc] = R0
ffa040c0: _NOP
ffa040c2: MOVE P5 = FP
ffa040c4: ADD P3 += 0x8
ffa040c6: LOAD R1 = [P1]
ffa040c8: CALL 0xffa018f0
ffa040cc: ROT|| R7 = rot R0 by 0
ffa040d0: _LOAD P0 = [FP + -0x40]
ffa040d2: _NOP
ffa040d4: LOAD R0 = [FP + 0xc]
ffa040d6: ADD P5 += -0x28
ffa040d8: LOAD R6.H = 0x3f80
ffa040dc: LOAD R1 = [P0 + 0x4]
ffa040de: CALL 0xffa018f0
ffa040e2: MOVE R1 = R7
ffa040e4: CALL 0xffa01716
ffa040e8: ROT|| R0 = rot R4 by 0
ffa040ec: _STORE [FP + -0x60] = R0
ffa040ee: _NOP
ffa040f0: CALL 0xffa02894
ffa040f4: MOVE R7 = R0
ffa040f6: MOVE R0 = R5
ffa040f8: CALL 0xffa02894
ffa040fc: ROT|| R5 = rot R0 by 0
