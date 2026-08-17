ffa042ce: IF !CC JUMP 0xffa042d2
ffa042d0: JUMP.S 0xffa03d66
ffa042d2: ROT|| R7 = rot R0 by 0
ffa042d6: _LOAD R2 = [SP + 0x2c]
ffa042d8: _NOP
ffa042da: STORE [FP + -0x74] = R1
ffa042dc: STORE [FP + -0x6c] = R2
ffa042de: LOAD R2 = 0x1
ffa042e0: LOAD R1 = 0x0
ffa042e2: LOAD R0 = 0x1
ffa042e4: CALL 0xffa06008
ffa042e8: MOVE R0 = R6
ffa042ea: CALL 0xffa02894
ffa042ee: LOAD R1 = [SP + 0x38]
ffa042f0: CALL 0xffa018f0
ffa042f4: LOAD P1 = [SP + 0x34]
ffa042f6: ROT|| R0 = rot R5 by 0
ffa042fa: _STORE [P1 + 0x4] = R0
ffa042fc: _NOP
ffa042fe: CALL 0xffa02894
ffa04302: LOAD R1 = [SP + 0x38]
ffa04304: CALL 0xffa018f0
ffa04308: ROT|| R1 = rot R4 by 0
ffa0430c: _LOAD P0 = [SP + 0x34]
ffa0430e: _NOP
ffa04310: ROT|| R0 = rot R7 by 0
ffa04314: _STORE [P0 + 0x8] = R0
ffa04316: _NOP
ffa04318: CALL 0xffa015b4
ffa0431c: MOVE R7 = R0
ffa0431e: LOAD R1 = [FP + -0x74]
ffa04320: LOAD R0 = [FP + -0x6c]
ffa04322: CALL 0xffa015b4
ffa04326: LOAD R1 = 0x0
ffa04328: LOAD R1.H = 0x4580
ffa0432c: CALL 0xffa018f0
ffa04330: MOVE R6 = R0
ffa04332: LOAD R0 = [FP + -0x48]
ffa04334: CALL 0xffa01688
ffa04338: MOVE R1 = R0
ffa0433a: MOVE R0 = R6
ffa0433c: CALL 0xffa01814
ffa04340: MOVE R1 = R0
ffa04342: MOVE R0 = R7
ffa04344: CALL 0xffa01714
ffa04348: LOAD P1 = [SP + 0x30]
ffa0434a: STORE [P1] = R0
ffa0434c: ADD SP += 0xc
ffa0434e: POP (R7:4,P5:3) = [SP++]
