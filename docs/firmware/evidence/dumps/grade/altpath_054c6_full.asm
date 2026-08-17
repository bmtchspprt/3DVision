ffa054c6: LOAD R0 = 0x5
ffa054c8: CC = R2 == R0
ffa054ca: IF !CC JUMP 0xffa054ce
ffa054cc: JUMP.S 0xffa04766 **JOIN**
ffa054ce: JUMP.S 0xffa047d0 **JOIN**
ffa054d0: MOVE P1 = R2
ffa054d2: LSHIFT P0 = P1 << 2
ffa054d4: ADD P0 = P4 + P0
ffa054d6: LOAD R0 = [P0]
ffa054d8: MOVE R1 = R5
ffa054da: CALL 0xffa01814 **CALL**
ffa054de: STORE [P0] = R0
ffa054e0: JUMP.S 0xffa04930 **JOIN**
ffa054e2: LOAD P1 = [FP + -0x38]
ffa054e4: LOAD R6 = [P1 + 0x10]
ffa054e6: CC = R4 < R6
ffa054e8: IF !CC JUMP 0xffa054fc
ffa054ea: NOP
ffa054ec: LOAD P1 = [FP + -0x5c]
ffa054ee: LOAD P2 = [FP + -0x38]
ffa054f0: LOAD P1 = [P1 + 0x4]
ffa054f2: LOAD R0 = [P2 + 0xc]
ffa054f4: LSHIFT P0 = P1 << 2
ffa054f6: ADD P1 = P4 + P0
ffa054f8: STORE [P1] = R0
ffa054fa: JUMP.S 0xffa054d4
ffa054fc: LSH R2 = R6 << 0x1
ffa05500: LOAD R0 = [P1 + 0x8]
ffa05502: CC = R4 < R2
ffa05504: STORE [FP + 0x20] = R0
ffa05506: IF CC JUMP 0xffa05518
ffa05508: NOP
ffa0550a: NOP
ffa0550c: LOAD P1 = [FP + -0x5c]
ffa0550e: LOAD P1 = [P1 + 0x4]
ffa05510: LSHIFT P0 = P1 << 2
ffa05512: ADD P1 = P4 + P0
ffa05514: STORE [P1] = R0
ffa05516: JUMP.S 0xffa054d4
ffa05518: SUB R0 = R2 - R4
ffa0551a: CALL 0xffa01688 **CALL**
ffa0551e: LOAD P1 = [FP + -0x38]
ffa05520: LOAD R1 = [P1 + 0xc]
ffa05522: CALL 0xffa018f0 **CALL**
ffa05526: STORE [FP + -0x38] = R0
ffa05528: SUB R0 = R4 - R6
ffa0552a: CALL 0xffa01688 **CALL**
ffa0552e: LOAD R1 = [FP + 0x20]
ffa05530: CALL 0xffa018f0 **CALL**
ffa05534: LOAD P1 = [FP + -0x5c]
ffa05536: LOAD R1 = [FP + -0x38]
ffa05538: LOAD P1 = [P1 + 0x4]
ffa0553a: STORE [FP + 0x20] = P1
ffa0553c: CALL 0xffa01716 **CALL**
ffa05540: LOAD P0 = [FP + 0x20]
ffa05542: MOVE R4 = R0
ffa05544: MOVE R0 = R6
ffa05546: CALL 0xffa01688 **CALL**
ffa0554a: MOVE R1 = R0
ffa0554c: MOVE R0 = R4
ffa0554e: CALL 0xffa01814 **CALL**
ffa05552: LSHIFT P0 = P0 << 2
ffa05554: ADD P1 = P4 + P0
ffa05556: STORE [P1] = R0
ffa05558: JUMP.S 0xffa054d4
ffa0555a: LOAD P1 = [FP + -0x5c]
ffa0555c: LOAD P2 = [FP + -0x38]
ffa0555e: LOAD P1 = [P1 + 0x4]
ffa05560: LOAD R0 = [P2 + 0x4]
ffa05562: LSHIFT P0 = P1 << 2
ffa05564: ADD P1 = P4 + P0
ffa05566: STORE [P1] = R0
ffa05568: JUMP.S 0xffa054d4
ffa0556a: LOAD P1 = [FP + -0x5c]
ffa0556c: LOAD P2 = [FP + -0x38]
ffa0556e: LOAD P1 = [P1 + 0x4]
ffa05570: LOAD R0 = [P2 + 0x0]
ffa05572: LSHIFT P0 = P1 << 2
ffa05574: ADD P1 = P4 + P0
ffa05576: STORE [P1] = R0
ffa05578: JUMP.S 0xffa054d4
ffa0557a: ???
ffa0557c: LINK 0x0
ffa05580: PUSH [--SP] = (R7:6,P5:4)
ffa05582: MOVE P4 = R0
ffa05584: MOVE P1 = R1
ffa05586: ROT|| R0 = rot R1 by 0
ffa0558a: _LOAD P5 = [SP + 0x24]
ffa0558c: _NOP
ffa0558e: ADD R0 += -0x1
ffa05590: MOVE P2 = R2
ffa05592: MOVE R2 = R0.L (X)
ffa05594: ADD P1 = P4 + (P1 << 1)
ffa05596: LOAD R6 = W [P1] (X)
ffa05598: LOAD R0 = 0x1479
ffa0559c: CC = R2 < 0x0
ffa0559e: SUB R7 = R0 -|- R6
ffa055a2: NEG R3 = -R6
ffa055a4: IF CC JUMP 0xffa055f6
ffa055a6: ADD R1 += -0x2
ffa055a8: MOVE R0 = R1.L (X)
ffa055aa: CC = R0 < 0x0
ffa055ac: ADD R0 += 0x2
ffa055ae: LOAD R1 = 0x1
ffa055b0: IF CC R0 = R1
ffa055b2: MOVE P0 = R0
ffa055b4: MOVE P1 = R2
ffa055b6: ADD P0 += -0x1
ffa055b8: ADD P1 = P4 + (P1 << 1)
ffa055ba: CC = P0 == 0x0
ffa055bc: LOAD R0 = W [P1--] (X)
ffa055be: IF CC JUMP 0xffa055d8
ffa055c0: LSETUP (0xffa055c4,0xffa055d6) LC0 = P0
ffa055c4: SUB R0 = R0 - R6
ffa055c6: MAX R1 = max(R3,R0) (v)
ffa055ca: CC = BITTST (R0,0xf)
ffa055cc: MIN|| R2 = min(R7,R0) (v)
ffa055d0: LOAD R0 = W [P1--] (X)
ffa055d2: NOP
ffa055d4: IF !CC R7 = R2
ffa055d6: IF CC R3 = R1
ffa055d8: SUB R0 = R0 - R6
ffa055da: CC = BITTST (R0,0xf)
ffa055dc: MAX R1 = max(R3,R0) (v)
ffa055e0: MIN R0 = min(R7,R0) (v)
ffa055e4: IF CC R3 = R1
ffa055e6: STORE W [P2] = R3.L **STW**
ffa055e8: IF !CC R7 = R0
ffa055ea: STORE W [P5] = R7.L **STW**
ffa055ec: LOAD P0 = [FP + 0x4]
ffa055ee: POP (R7:6,P5:4) = [SP++]
ffa055f0: UNLINK
ffa055f4: JUMP (P0)
ffa055f6: STORE W [P2] = R3.L **STW**
ffa055f8: STORE W [P5] = R7.L **STW**
ffa055fa: LOAD P0 = [FP + 0x4]
ffa055fc: POP (R7:6,P5:4) = [SP++]
ffa055fe: UNLINK
ffa05602: JUMP (P0)
ffa05604: LINK 0x8
ffa05608: PUSH [--SP] = (R7:4,P5:3)
ffa0560a: MOVE P5 = R0
ffa0560c: ADD SP += -0xc
ffa0560e: MOVE P4 = R1
ffa05610: CC = R2 == 0x0
ffa05612: LOAD P3.L = 0x5db0
ffa05616: LOAD P3.H = 0x2022
ffa0561a: LOAD R0 = [P5]
ffa0561c: LOAD R6 = [FP + 0x14]
ffa0561e: IF !CC JUMP 0xffa05622 (bp)
ffa05620: JUMP.S 0xffa05860
ffa05622: CALL 0xffa02894 **CALL**
ffa05626: STORE [P3 + 0xc] = R0
ffa05628: LOAD R0 = [P4]
ffa0562a: CALL 0xffa02894 **CALL**
ffa0562e: CC = R6 == 0x0
ffa05630: STORE [P3 + 0x10] = R0
ffa05632: STORE [SP + 0x2c] = R0
ffa05634: LOAD R7 = [P5 + 0x4]
ffa05636: MOVE R5 = R0
ffa05638: IF CC JUMP 0xffa05788
ffa0563a: MOVE R0 = R7
ffa0563c: CALL 0xffa00da4 **CALL**
ffa05640: MOVE R6 = R0
ffa05642: LOAD R5 = [P4 + 0x4]
ffa05644: MOVE R0 = R5
ffa05646: CALL 0xffa00da4 **CALL**
ffa0564a: MOVE R1 = R0
ffa0564c: MOVE R0 = R6
ffa0564e: CALL 0xffa01714 **CALL**
ffa05652: MOVE R1 = R0
ffa05654: CALL 0xffa018f0 **CALL**
ffa05658: STORE [SP + 0x2c] = R0
ffa0565a: MOVE R0 = R7
ffa0565c: CALL 0xffa020d4 **CALL**
ffa05660: LOAD R4 = [P5 + 0x8]
ffa05662: STORE [SP + 0x38] = R0
ffa05664: MOVE R0 = R4
ffa05666: CALL 0xffa00da4 **CALL**
ffa0566a: MOVE R7 = R0
ffa0566c: MOVE R0 = R5
ffa0566e: CALL 0xffa020d4 **CALL**
ffa05672: LOAD R6 = [P4 + 0x8]
ffa05674: MOVE R5 = R0
ffa05676: MOVE R0 = R6
ffa05678: CALL 0xffa00da4 **CALL**
ffa0567c: STORE [FP + 0x10] = R0
ffa0567e: MOVE R1 = R7
ffa05680: LOAD R0 = [SP + 0x38]
ffa05682: CALL 0xffa018f0 **CALL**
ffa05686: MOVE R7 = R0
ffa05688: MOVE R1 = R5
ffa0568a: LOAD R0 = [FP + 0x10]
ffa0568c: CALL 0xffa018f0 **CALL**
ffa05690: MOVE R1 = R0
ffa05692: MOVE R0 = R7
ffa05694: CALL 0xffa01714 **CALL**
ffa05698: MOVE R1 = R0
ffa0569a: CALL 0xffa018f0 **CALL**
ffa0569e: LOAD R1 = [SP + 0x2c]
ffa056a0: CALL 0xffa01716 **CALL**
ffa056a4: MOVE R7 = R0
ffa056a6: MOVE R0 = R4
ffa056a8: CALL 0xffa020d4 **CALL**
ffa056ac: MOVE R4 = R0
ffa056ae: MOVE R0 = R6
ffa056b0: CALL 0xffa020d4 **CALL**
ffa056b4: MOVE R6 = R0
ffa056b6: MOVE R0 = R4
ffa056b8: LOAD R1 = [SP + 0x38]
ffa056ba: CALL 0xffa018f0 **CALL**
ffa056be: MOVE R4 = R0
ffa056c0: MOVE R0 = R6
ffa056c2: MOVE R1 = R5
ffa056c4: CALL 0xffa018f0 **CALL**
ffa056c8: MOVE R1 = R0
ffa056ca: MOVE R0 = R4
ffa056cc: CALL 0xffa01714 **CALL**
ffa056d0: MOVE R1 = R0
ffa056d2: STORE [P3 + 0x4] = R0
ffa056d4: CALL 0xffa018f0 **CALL**
ffa056d8: MOVE R1 = R7
ffa056da: CALL 0xffa01716 **CALL**
ffa056de: STORE [P3] = R0
ffa056e0: CALL 0xffa0248c **CALL**
ffa056e4: LOAD P1 = [FP + 0x18]
ffa056e6: STORE [P3] = R0
ffa056e8: LOAD R2 = [P1 + 0x5c]
ffa056ec: LSH R0 = R2 << 0x1
ffa056f0: CALL 0xffa02894 **CALL**
ffa056f4: LOAD R1 = 0xfdb
ffa056f8: LOAD R1.H = 0x40c9
ffa056fc: CALL 0xffa018f0 **CALL**
ffa05700: CALL 0xffa020d4 **CALL**
ffa05704: LOAD R1 = 0x0
ffa05706: BITSET (R1,0x1e)
ffa05708: MOVE R6 = R0
ffa0570a: CALL 0xffa018f0 **CALL**
ffa0570e: LOAD R7 = [P3]
ffa05710: MOVE R1 = R0
ffa05712: MOVE R0 = R7
ffa05714: CALL 0xffa0165c **CALL**
ffa05718: STORE [P3 + 0x8] = R6
ffa0571a: IF !CC JUMP 0xffa0573e
ffa0571c: MOVE R1 = R6
ffa0571e: MOVE R0 = R7
ffa05720: CALL 0xffa01814 **CALL**
ffa05724: MOVE R1 = R0
ffa05726: CALL 0xffa018f0 **CALL**
ffa0572a: STORE [P3 + 0x4] = R0
ffa0572c: LOAD R1 = 0x0
ffa0572e: LOAD R1.H = 0x4100
ffa05732: CALL 0xffa01814 **CALL**
ffa05736: MOVE R1 = R7
ffa05738: CALL 0xffa018f0 **CALL**
ffa0573c: JUMP.S 0xffa05746
ffa0573e: MOVE R1 = R6
ffa05740: MOVE R0 = R7
ffa05742: CALL 0xffa01714 **CALL**
ffa05746: STORE [P3] = R0
ffa05748: LOAD R0 = [P5]
ffa0574a: LOAD R1 = [P4]
ffa0574c: MAX R0 = max(R0,R1)
ffa05750: CALL 0xffa02894 **CALL**
ffa05754: LOAD R1 = [P3]
ffa05756: CALL 0xffa018f0 **CALL**
ffa0575a: MOVE R1 = R0
ffa0575c: CALL 0xffa018f0 **CALL**
ffa05760: MOVE R7 = R0
ffa05762: LOAD R1 = [P3 + 0x10]
ffa05764: LOAD R0 = [P3 + 0xc]
ffa05766: CALL 0xffa01714 **CALL**
ffa0576a: MOVE R1 = R0
ffa0576c: CALL 0xffa018f0 **CALL**
ffa05770: MOVE R1 = R7
ffa05772: CALL 0xffa01716 **CALL**
ffa05776: STORE [P3] = R0
ffa05778: CALL 0xffa0248c **CALL**
ffa0577c: STORE [P3] = R0
ffa0577e: ADD SP += 0xc
ffa05780: POP (R7:4,P5:3) = [SP++]
ffa05782: UNLINK
ffa05786: RTS

######## from FFA047D0 (054CE target)
ffa047d0: LOAD P0 = [FP + 0x18]
ffa047d2: LOAD P2 = [FP + -0x5c]
ffa047d4: LOAD R0 = W [P0 + 0x46] (Z)
ffa047d8: CALL 0xffa016d4
ffa047dc: LOAD P1 = [FP + 0x1c]
ffa047de: STORE [P2 + 0x1c] = R0
ffa047e0: LOAD R1 = B [P1 + 0x521] (Z)
ffa047e4: CC = R1 == 0x0
ffa047e6: IF !CC JUMP 0xffa047f4
ffa047e8: LOAD R1 = 0x0
ffa047ea: LOAD R1.H = 0x4040
ffa047ee: CALL 0xffa01814
ffa047f2: STORE [P2 + 0x1c] = R0
ffa047f4: LOAD R0 = [FP + 0x14]
ffa047f6: CC = R0 == 0x0
ffa047f8: IF !CC JUMP 0xffa047fc (bp)
ffa047fa: JUMP.S 0xffa0549e
ffa047fc: LOAD R0 = [FP + 0x8]
ffa047fe: ADD R0 += 0x1
ffa04800: LOAD P3 = [FP + -0x44]
ffa04802: LOAD P1 = 0x7ad8
ffa04806: LOAD P0 = [FP + -0x5c]
ffa04808: LOAD R1 = [FP + -0x24]
ffa0480a: ADD P1 = P3 + P1
ffa0480c: STORE [FP + -0x50] = P1
ffa0480e: LOAD P1 = [FP + -0x44]
ffa04810: STORE W [P0 + 0x8] = R0
ffa04812: STORE W [P0 + -0x6] = R1
ffa04816: LOAD P2 = 0x6660
ffa0481a: LOAD P0 = 0x709c
ffa0481e: LOAD R2 = [FP + 0x8]
ffa04820: ADD P2 = P1 + P2
ffa04822: ADD P0 = P3 + P0
ffa04824: CC = R1 <= R2
ffa04826: STORE [FP + -0x4c] = P2
ffa04828: STORE [FP + -0x54] = P0
ffa0482a: IF !CC JUMP 0xffa04940
ffa0482c: LOAD P1 = [FP + -0x5c]
ffa0482e: LOAD R1 = 0xa028
ffa04832: LOAD R7 = [FP + 0x10]
ffa04834: LOAD R0 = W [P1 + -0x6] (X)
ffa04838: CALL 0xffa05ee4
ffa0483c: ADD|| R0 = R7 + R0 (ns)
ffa04840: _LOAD R1 = [FP + -0x40]
ffa04842: _NOP
ffa04844: CALL 0xffa0586c
ffa04848: LOAD P1 = [FP + -0x5c]
ffa0484a: LOAD R2 = [FP + 0x28]
ffa0484c: LOAD R3 = 0x7
ffa0484e: CC = R2 == R3
ffa04850: STORE [P1] = R0
ffa04852: IF CC JUMP 0xffa04858 (bp)
ffa04854: JUMP.S 0xffa053b0
ffa04858: ASH|| R0 = R0 >>> 0x13
ffa0485c: _LOAD P0 = [FP + -0x5c]
ffa0485e: _NOP
ffa04860: MOVE P1 = R0
ffa04862: STORE [P0 + 0x4] = R0
ffa04864: ADD P1 = P4 + (P1 << 2)
ffa04866: LOAD R1 = [P1]
ffa04868: STORE [P0 + 0xc] = R1
ffa0486a: LOAD P1 = [FP + -0x5c]
ffa0486c: LOAD R1 = [FP + -0x28]
ffa0486e: LOAD R2 = [FP + -0x40]
ffa04870: LOAD R0 = [P1]
ffa04872: LOAD P1.L = 0x2a64
ffa04876: LOAD P1.H = 0x2021
ffa0487a: CALL (P1)
ffa0487c: LOAD P0 = [FP + -0x5c]
ffa0487e: LOAD R3 = [FP + 0x28]
ffa04880: CC = R3 == 0x3
ffa04882: STORE [P0 + 0x14] = R0
ffa04884: IF !CC JUMP 0xffa04888 (bp)
ffa04886: JUMP.S 0xffa04f6e
ffa04888: LOAD R1 = 0x5
ffa0488a: CC = R3 == R1
ffa0488c: IF !CC JUMP 0xffa04890 (bp)
ffa0488e: JUMP.S 0xffa04f6e
ffa04890: LOAD R1 = 0x4
