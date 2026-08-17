ffa054c0: MOVE R0 = A1.W
ffa054c2: SUB R0 = R1 - R0
ffa054c4: JUMP.S 0xffa04800
ffa054c6: LOAD R0 = 0x5
ffa054c8: CC = R2 == R0
ffa054ca: IF !CC JUMP 0xffa054ce
ffa054cc: JUMP.S 0xffa04766
ffa054ce: JUMP.S 0xffa047d0
ffa054d0: MOVE P1 = R2
ffa054d2: LSHIFT P0 = P1 << 2
ffa054d4: ADD P0 = P4 + P0
ffa054d6: LOAD R0 = [P0]
ffa054d8: MOVE R1 = R5
ffa054da: CALL 0xffa01814
ffa054de: STORE [P0] = R0
ffa054e0: JUMP.S 0xffa04930
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
ffa0551a: CALL 0xffa01688
ffa0551e: LOAD P1 = [FP + -0x38]
ffa05520: LOAD R1 = [P1 + 0xc]
ffa05522: CALL 0xffa018f0
ffa05526: STORE [FP + -0x38] = R0
ffa05528: SUB R0 = R4 - R6
ffa0552a: CALL 0xffa01688
ffa0552e: LOAD R1 = [FP + 0x20]
ffa05530: CALL 0xffa018f0
ffa05534: LOAD P1 = [FP + -0x5c]
ffa05536: LOAD R1 = [FP + -0x38]
ffa05538: LOAD P1 = [P1 + 0x4]
ffa0553a: STORE [FP + 0x20] = P1
ffa0553c: CALL 0xffa01716
ffa05540: LOAD P0 = [FP + 0x20]
ffa05542: MOVE R4 = R0
ffa05544: MOVE R0 = R6
ffa05546: CALL 0xffa01688
ffa0554a: MOVE R1 = R0
ffa0554c: MOVE R0 = R4
ffa0554e: CALL 0xffa01814
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
ffa055e6: STORE W [P2] = R3.L
ffa055e8: IF !CC R7 = R0
ffa055ea: STORE W [P5] = R7.L
ffa055ec: LOAD P0 = [FP + 0x4]
ffa055ee: POP (R7:6,P5:4) = [SP++]
ffa055f0: UNLINK
ffa055f4: JUMP (P0)
ffa055f6: STORE W [P2] = R3.L
ffa055f8: STORE W [P5] = R7.L
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
ffa05622: CALL 0xffa02894
ffa05626: STORE [P3 + 0xc] = R0
ffa05628: LOAD R0 = [P4]
ffa0562a: CALL 0xffa02894
ffa0562e: CC = R6 == 0x0
ffa05630: STORE [P3 + 0x10] = R0
ffa05632: STORE [SP + 0x2c] = R0
ffa05634: LOAD R7 = [P5 + 0x4]
ffa05636: MOVE R5 = R0
ffa05638: IF CC JUMP 0xffa05788
ffa0563a: MOVE R0 = R7
ffa0563c: CALL 0xffa00da4
ffa05640: MOVE R6 = R0
ffa05642: LOAD R5 = [P4 + 0x4]
ffa05644: MOVE R0 = R5
ffa05646: CALL 0xffa00da4
ffa0564a: MOVE R1 = R0
ffa0564c: MOVE R0 = R6
ffa0564e: CALL 0xffa01714
ffa05652: MOVE R1 = R0
ffa05654: CALL 0xffa018f0
ffa05658: STORE [SP + 0x2c] = R0
ffa0565a: MOVE R0 = R7
ffa0565c: CALL 0xffa020d4
ffa05660: LOAD R4 = [P5 + 0x8]
ffa05662: STORE [SP + 0x38] = R0
ffa05664: MOVE R0 = R4
ffa05666: CALL 0xffa00da4
ffa0566a: MOVE R7 = R0
ffa0566c: MOVE R0 = R5
ffa0566e: CALL 0xffa020d4
ffa05672: LOAD R6 = [P4 + 0x8]
ffa05674: MOVE R5 = R0
ffa05676: MOVE R0 = R6
ffa05678: CALL 0xffa00da4
ffa0567c: STORE [FP + 0x10] = R0
ffa0567e: MOVE R1 = R7
ffa05680: LOAD R0 = [SP + 0x38]
