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
ffa04100: _LOAD P0 = [FP + -0x40]
ffa04102: _NOP
ffa04104: BITTGL (R7,0x1f)
ffa04106: MOVE R1 = R7
ffa04108: LOAD R0 = [P0 + 0x4]
ffa0410a: CALL 0xffa018f0
ffa0410e: ROT|| R7 = rot R0 by 0
ffa04112: _LOAD P1 = [FP + -0x40]
ffa04114: _NOP
ffa04116: MOVE R1 = R5
ffa04118: LOAD R0 = [P1]
ffa0411a: CALL 0xffa018f0
ffa0411e: MOVE R1 = R7
ffa04120: CALL 0xffa01716
ffa04124: STORE [FP + -0x64] = R0
ffa04126: LOAD R1 = 0x2
ffa04128: ROT|| R5 = rot R6 by 0
ffa0412c: _LOAD R2 = [P5++]
ffa0412e: _NOP
ffa04130: LSH|| R4 = R2 << 0x3
ffa04134: _LOAD R3 = [P5++]
ffa04136: _NOP
ffa04138: LSHIFT R3 <<= 0x3
ffa0413a: LOAD R0 = 0xff
ffa0413e: LSH|| R0 = R0 << 0x17
