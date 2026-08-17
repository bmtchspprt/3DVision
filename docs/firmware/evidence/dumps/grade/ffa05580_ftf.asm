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
ffa05682: CALL 0xffa018f0
ffa05686: MOVE R7 = R0
ffa05688: MOVE R1 = R5
ffa0568a: LOAD R0 = [FP + 0x10]
ffa0568c: CALL 0xffa018f0
ffa05690: MOVE R1 = R0
ffa05692: MOVE R0 = R7
ffa05694: CALL 0xffa01714
ffa05698: MOVE R1 = R0
ffa0569a: CALL 0xffa018f0
ffa0569e: LOAD R1 = [SP + 0x2c]
ffa056a0: CALL 0xffa01716
ffa056a4: MOVE R7 = R0
ffa056a6: MOVE R0 = R4
ffa056a8: CALL 0xffa020d4
ffa056ac: MOVE R4 = R0
ffa056ae: MOVE R0 = R6
ffa056b0: CALL 0xffa020d4
ffa056b4: MOVE R6 = R0
ffa056b6: MOVE R0 = R4
ffa056b8: LOAD R1 = [SP + 0x38]
ffa056ba: CALL 0xffa018f0
ffa056be: MOVE R4 = R0
ffa056c0: MOVE R0 = R6
ffa056c2: MOVE R1 = R5
ffa056c4: CALL 0xffa018f0
ffa056c8: MOVE R1 = R0
ffa056ca: MOVE R0 = R4
ffa056cc: CALL 0xffa01714
ffa056d0: MOVE R1 = R0
ffa056d2: STORE [P3 + 0x4] = R0
ffa056d4: CALL 0xffa018f0
ffa056d8: MOVE R1 = R7
ffa056da: CALL 0xffa01716
ffa056de: STORE [P3] = R0
ffa056e0: CALL 0xffa0248c
ffa056e4: LOAD P1 = [FP + 0x18]
ffa056e6: STORE [P3] = R0
ffa056e8: LOAD R2 = [P1 + 0x5c]
ffa056ec: LSH R0 = R2 << 0x1
ffa056f0: CALL 0xffa02894
ffa056f4: LOAD R1 = 0xfdb
ffa056f8: LOAD R1.H = 0x40c9
ffa056fc: CALL 0xffa018f0
ffa05700: CALL 0xffa020d4
ffa05704: LOAD R1 = 0x0
ffa05706: BITSET (R1,0x1e)
ffa05708: MOVE R6 = R0
ffa0570a: CALL 0xffa018f0
ffa0570e: LOAD R7 = [P3]
ffa05710: MOVE R1 = R0
ffa05712: MOVE R0 = R7
ffa05714: CALL 0xffa0165c
ffa05718: STORE [P3 + 0x8] = R6
ffa0571a: IF !CC JUMP 0xffa0573e
ffa0571c: MOVE R1 = R6
ffa0571e: MOVE R0 = R7
ffa05720: CALL 0xffa01814
ffa05724: MOVE R1 = R0
ffa05726: CALL 0xffa018f0
ffa0572a: STORE [P3 + 0x4] = R0
ffa0572c: LOAD R1 = 0x0
ffa0572e: LOAD R1.H = 0x4100
ffa05732: CALL 0xffa01814
ffa05736: MOVE R1 = R7
ffa05738: CALL 0xffa018f0
ffa0573c: JUMP.S 0xffa05746
ffa0573e: MOVE R1 = R6
ffa05740: MOVE R0 = R7
ffa05742: CALL 0xffa01714
ffa05746: STORE [P3] = R0
ffa05748: LOAD R0 = [P5]
ffa0574a: LOAD R1 = [P4]
ffa0574c: MAX R0 = max(R0,R1)
ffa05750: CALL 0xffa02894
ffa05754: LOAD R1 = [P3]
ffa05756: CALL 0xffa018f0
ffa0575a: MOVE R1 = R0
ffa0575c: CALL 0xffa018f0
ffa05760: MOVE R7 = R0
ffa05762: LOAD R1 = [P3 + 0x10]
ffa05764: LOAD R0 = [P3 + 0xc]
ffa05766: CALL 0xffa01714
ffa0576a: MOVE R1 = R0
ffa0576c: CALL 0xffa018f0
ffa05770: MOVE R1 = R7
ffa05772: CALL 0xffa01716
ffa05776: STORE [P3] = R0
ffa05778: CALL 0xffa0248c
ffa0577c: STORE [P3] = R0
ffa0577e: ADD SP += 0xc
ffa05780: POP (R7:4,P5:3) = [SP++]
ffa05782: UNLINK
ffa05786: RTS
ffa05788: LOAD R0 = [P5 + 0x8]
ffa0578a: STORE [FP + 0x10] = R0
ffa0578c: MOVE R0 = R7
ffa0578e: CALL 0xffa00da4
ffa05792: LOAD R6 = [P4 + 0x4]
ffa05794: LOAD R2 = [P4 + 0x8]
ffa05796: MOVE R4 = R0
ffa05798: MOVE R0 = R6
ffa0579a: STORE [SP + 0x38] = R2
ffa0579c: CALL 0xffa00da4
ffa057a0: LOAD R3 = [P3 + 0xc]
ffa057a2: MOVE R1 = R4
ffa057a4: STORE [SP + 0x3c] = R3
ffa057a6: STORE [SP + 0x28] = R0
ffa057a8: LOAD R0 = [SP + 0x3c]
ffa057aa: CALL 0xffa018f0
ffa057ae: MOVE R4 = R0
ffa057b0: LOAD R0 = [SP + 0x28]
ffa057b2: MOVE R1 = R5
ffa057b4: CALL 0xffa018f0
ffa057b8: MOVE R1 = R0
ffa057ba: MOVE R0 = R4
ffa057bc: CALL 0xffa01714
ffa057c0: MOVE R1 = R0
ffa057c2: CALL 0xffa018f0
ffa057c6: STORE [SP + 0x28] = R0
ffa057c8: MOVE R0 = R7
ffa057ca: CALL 0xffa020d4
ffa057ce: MOVE R7 = R0
ffa057d0: LOAD R0 = [FP + 0x10]
ffa057d2: CALL 0xffa00da4
ffa057d6: MOVE R5 = R0
ffa057d8: MOVE R0 = R6
ffa057da: CALL 0xffa020d4
ffa057de: MOVE R6 = R0
ffa057e0: LOAD R0 = [SP + 0x38]
ffa057e2: CALL 0xffa00da4
ffa057e6: MOVE R4 = R0
ffa057e8: LOAD R0 = [SP + 0x3c]
ffa057ea: MOVE R1 = R7
ffa057ec: CALL 0xffa018f0
ffa057f0: MOVE R1 = R5
ffa057f2: STORE [SP + 0x3c] = R0
ffa057f4: CALL 0xffa018f0
ffa057f8: MOVE R7 = R0
ffa057fa: MOVE R1 = R6
ffa057fc: LOAD R0 = [SP + 0x2c]
ffa057fe: CALL 0xffa018f0
ffa05802: MOVE R1 = R4
ffa05804: MOVE R6 = R0
ffa05806: CALL 0xffa018f0
ffa0580a: MOVE R1 = R0
ffa0580c: MOVE R0 = R7
ffa0580e: CALL 0xffa01714
ffa05812: MOVE R1 = R0
ffa05814: CALL 0xffa018f0
ffa05818: LOAD R1 = [SP + 0x28]
ffa0581a: CALL 0xffa01716
ffa0581e: MOVE R4 = R0
ffa05820: LOAD R0 = [FP + 0x10]
ffa05822: CALL 0xffa020d4
ffa05826: MOVE R7 = R0
ffa05828: LOAD R0 = [SP + 0x38]
ffa0582a: CALL 0xffa020d4
ffa0582e: MOVE R5 = R0
ffa05830: MOVE R0 = R7
ffa05832: LOAD R1 = [SP + 0x3c]
ffa05834: CALL 0xffa018f0
ffa05838: MOVE R7 = R0
ffa0583a: MOVE R1 = R6
ffa0583c: MOVE R0 = R5
ffa0583e: CALL 0xffa018f0
ffa05842: MOVE R1 = R0
ffa05844: MOVE R0 = R7
ffa05846: CALL 0xffa01714
ffa0584a: MOVE R1 = R0
ffa0584c: STORE [P3 + 0x4] = R0
ffa0584e: CALL 0xffa018f0
ffa05852: MOVE R1 = R4
ffa05854: CALL 0xffa01716
ffa05858: STORE [P3] = R0
ffa0585a: CALL 0xffa0248c
ffa0585e: JUMP.S 0xffa0577c
ffa05860: LOAD R1 = [P4]
ffa05862: SUB R0 = R0 - R1
ffa05864: CALL 0xffa02894
ffa05868: BITCLR (R0,0x1f)
ffa0586a: JUMP.S 0xffa0577c
ffa0586c: MOVE P1 = R1
ffa0586e: LINK 0x0
ffa05872: LOAD R1 = [P1 + 0x4ec]
ffa05876: MAC A1 = R1.L * R0.L (fu)
ffa0587a: LSH A1 = A1 >> 0x10
ffa0587e: UNLINK
ffa05882: MAC A1 += R1.H * R0.L (m),A0 = R1.H * R0.H 
ffa05886: MAC A1 += R0.H * R1.L (m)
ffa0588a: ASH A1 = A1 >>> 0xf
ffa0588e: MOVE R0 = (A0 += A1)
ffa05892: ASHIFT R0 >>>= 0x1
ffa05894: RTS
ffa05896: MOVE P1 = R1
ffa05898: LINK 0xc
ffa0589c: LOAD R1 = [P1 + 0x4ec]
ffa058a0: CALL 0xffa05ee4
ffa058a4: UNLINK
ffa058a8: LSHIFT R0 <<= 0x1
ffa058aa: RTS
ffa058ac: LINK 0x0
ffa058b0: PUSH [--SP] = (R7:6,P5:4)
ffa058b2: ADD SP += -0xc
ffa058b4: ROT|| R7 = rot R2 by 0
ffa058b8: _LOAD P5 = [SP + 0x34]
ffa058ba: _NOP
ffa058bc: MOVE P2 = R7
ffa058be: LSH|| R0 = R0 << 0x1
ffa058c2: _LOAD P1 = [SP + 0x30]
ffa058c4: _NOP
ffa058c6: ADD R0 = R1 + R0
ffa058c8: CC = P5 <= 0x0
ffa058ca: MOVE P0 = R0
ffa058cc: MOVE R6 = P5
ffa058ce: LOAD R0 = 0x0
ffa058d0: IF CC JUMP 0xffa058ea
ffa058d2: ADD P4 = P1 + P1
ffa058d4: MOVE P1 = P2
ffa058d6: LSETUP (0xffa058da,0xffa058e2) LC0 = P5
ffa058da: LOAD R1.L = W [P0 ++ P4]
ffa058dc: LSHIFT R1 <<= 0x4
ffa058de: NEG R2 = -R1
ffa058e0: MOVE R1 = R1.L (X)
ffa058e2: SUB|| R0 = R0 - R1 (ns)
ffa058e6: _STORE W [P1++] = R2
ffa058e8: _NOP
ffa058ea: MOVE R1 = R6
ffa058ec: CALL 0xffa00fb4
ffa058f0: CC = P5 <= 0x0
ffa058f2: IF CC JUMP 0xffa05932
ffa058f4: LSHIFT R7 <<= 0x1e
ffa058f6: MOVE CC = az
ffa058f8: IF !CC JUMP 0xffa0593c
ffa058fa: CC = P5 == 0x1
ffa058fc: IF CC JUMP 0xffa0592a
ffa058fe: ASH R1 = R6 >>> 0x1
