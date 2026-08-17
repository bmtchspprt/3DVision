ffa085c0: LOAD R2 = 0x3e8
ffa085c4: LOAD R3 = [SP + 0x2c]
ffa085c6: MULT R3 = R3.H * R2.L ,R2 = R3.L * R2.L (fu)
ffa085ca: LSH R5 = R3 << 0x10
ffa085ce: ADD R2 = R5 + R2
ffa085d0: MULT R0 *= R2
ffa085d2: CALL 0xffa01038
ffa085d6: JUMP.S 0xffa085e0
ffa085d8: MULT R1 *= R2
ffa085da: MULT R0 *= R3
ffa085dc: CALL 0xffa01038
ffa085e0: ADD R0.H = R7.H + R6.H (ns)
ffa085e4: SUB R0.L = R0.L - R0.H (ns)
ffa085e8: MOVE R0 = R0.L (Z)
ffa085ea: LOAD R1 = 0xfff
ffa085ee: CC = R1 < R0
ffa085f0: IF CC R0 = R1
ffa085f2: STORE W [P5 + 0xa] = R0
ffa085f4: LOAD P1 = 0xa1c
ffa085f8: LOAD P1.H = 0xffc0
ffa085fc: LOAD R0 = W [P1] (X)
ffa085fe: LOAD R1 = 0x8
ffa08600: AND R0 = R0 & R1
ffa08602: MOVE R0 = R0.L (Z)
ffa08604: CC = R0 == 0x0
ffa08606: IF !CC JUMP 0xffa0860e
ffa08608: LOAD R0 = [P5 + 0x4]
ffa0860a: BITCLR (R0,0x17)
ffa0860c: STORE [P5 + 0x4] = R0
ffa0860e: MOVE R1 = P5
ffa08610: LOAD P1 = 0x0
ffa08612: STORE [SP + 0xc] = P1
ffa08614: LOAD R0 = [P5 + 0x4]
ffa08616: LOAD R2 = W [P5 + 0xa] (Z)
ffa08618: ADD R1 += 0x8
ffa0861a: CALL 0xffa00098
ffa0861e: ADD SP += 0x10
ffa08620: SUB|| R0 = R0 - R0 (ns)
ffa08624: _LOAD P0 = [FP + 0x4]
ffa08626: _NOP
ffa08628: POP (R7:4,P5:5) = [SP++]
ffa0862a: UNLINK
ffa0862e: JUMP (P0)
ffa08630: LOAD P1.H = 0xffc0
ffa08634: LOAD P1.L = 0xa14
ffa08638: LOAD R1 = [P1]
ffa0863a: CC = BITTST (R1,0x0)
ffa0863c: IF !CC JUMP 0xffa0866c
ffa0863e: CLI R0
ffa08640: LOAD P1.H = 0x0
ffa08644: LOAD P1.L = 0x0
ffa08648: LOAD R1 = [P1]
ffa0864a: STORE [P1] = R1
ffa0864c: FLUSH [P1]
ffa0864e: LOAD P2.H = 0xffc0
ffa08652: LOAD P2.L = 0xa10
ffa08656: LOAD R3 = [P2]
ffa08658: BITSET (R3,0x18)
ffa0865a: STORE [P2] = R3
ffa0865c: LOAD P2.H = 0xffc0
ffa08660: LOAD P2.L = 0xa1c
ffa08664: LOAD R2 = W [P2] (Z)
ffa08666: CC = BITTST (R2,0x1)
ffa08668: IF !CC JUMP 0xffa08664
ffa0866a: STI R0
ffa0866c: RTS
ffa08670: PUSH [--SP] = (R7:5)
ffa08672: LOAD R3 = 0x1b
ffa08674: MOVE R6 = R0.B (Z)
ffa08676: LOAD R7 = 0x3c
ffa08678: LOAD R3.H = 0x630
ffa0867c: CC = R1 == R3
ffa0867e: MULT R3 = R6.L * R7.L (fu)
ffa08682: LOAD R5.L = 0x3814
ffa08686: LOAD R5.H = 0xff80
ffa0868a: ADD R3 = R5 + R3
ffa0868c: IF CC JUMP 0xffa08698
ffa0868e: LOAD R7 = 0x11
ffa08690: LOAD R7.H = 0x220
ffa08694: CC = R1 == R7
ffa08696: IF !CC JUMP 0xffa086a4
ffa08698: CC = R2 == 0x0
ffa0869a: MOVE R1 = R3
ffa0869c: ADD R3 += 0x18
ffa0869e: ADD R1 += 0x14
ffa086a0: IF CC R3 = R1
ffa086a2: JUMP.S 0xffa086ae
ffa086a4: MOVE R1 = R3
ffa086a6: CC = R2 == 0x0
ffa086a8: ADD R3 += 0x24
ffa086aa: ADD R1 += 0x20
ffa086ac: IF CC R3 = R1
ffa086ae: MOVE P1 = R3
ffa086b0: LSH R0.L = R0.H << 0x0
ffa086b4: LOAD R1 = 0xf
ffa086b6: AND R1 = R0 & R1
ffa086b8: LOAD R0 = 0x1
ffa086ba: ASH|| R1.L = ashift R0.L by R1.L
ffa086be: LOAD P1 = [P1]
ffa086c0: NOP
ffa086c2: LOAD R0 = 0x0
ffa086c4: STORE W [P1] = R1.L
ffa086c6: POP (R7:5) = [SP++]
ffa086c8: RTS
ffa086ca: MOVE R2 = R0.B (Z)
ffa086cc: LOAD R3 = 0x3c
ffa086ce: PUSH [--SP] = R7
ffa086d0: MULT R2 = R2.L * R3.L (fu)
ffa086d4: LOAD R7.L = 0x3814
ffa086d8: LOAD R7.H = 0xff80
ffa086dc: ADD R2 = R7 + R2
ffa086de: MOVE P1 = R2
ffa086e0: MOVE P0 = R1
ffa086e2: LOAD R1 = 0x1004
ffa086e6: EXTRACT R2 = extract(R0,R1.L) (z)
ffa086ea: LOAD R3 = 0x1
ffa086ec: SUB|| R0 = R0 - R0 (ns)
ffa086f0: _LOAD P1 = [P1]
ffa086f2: _NOP
ffa086f4: LOAD R1 = W [P1] (Z)
ffa086f6: ASHIFT R1 >>>= R2
ffa086f8: AND R1 = R1 & R3
ffa086fa: STORE [P0] = R1
ffa086fc: LOAD R7 = [SP++]
ffa086fe: RTS
ffa08700: MOVE R1 = R0.B (Z)
