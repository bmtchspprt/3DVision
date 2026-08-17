ffa043c4: LINK 0x40
ffa043c8: PUSH [--SP] = (R7:4,P5:3)
ffa043ca: ADD SP += -0xc
ffa043cc: LOAD P3 = [FP + 0x20]
ffa043ce: MOVE P0 = R2
ffa043d0: MOVE P5 = R1
ffa043d2: MOVE P4 = R0
ffa043d4: LOAD R3 = 0x5cfc
ffa043d8: LOAD P2 = 0x578
ffa043dc: LOAD R0 = [FP + 0x18]
ffa043de: MULT R0 = R0.L * R3.L (is)
ffa043e2: ADD P2 = P3 + P2
ffa043e4: MOVE P1 = R0
ffa043e6: STORE [SP + 0x34] = P2
ffa043e8: ADD P5 = P5 + (P0 << 2)
ffa043ea: LOAD P0 = [SP + 0x34]
ffa043ec: LOAD P2 = 0x580
ffa043f0: ADD P2 = P3 + P2
ffa043f2: ADD P0 = P0 + P1
ffa043f4: LOAD R0 = B [P0 + 0x1] (Z)
ffa043f8: ADD P1 = P2 + P1
ffa043fa: CC = R0 == 0x0
ffa043fc: STORE [SP + 0x34] = P1
ffa043fe: IF !CC JUMP 0xffa04536
ffa04400: LOAD P1 = 0x4c08
ffa04404: LOAD P1.H = 0x3
ffa04408: ADD P1 = P3 + P1
ffa0440a: LOAD R0 = 0x3
ffa0440c: LOAD R1 = 0x0
ffa0440e: LOAD R2 = 0x0
ffa04410: STORE [SP + 0x28] = P1
ffa04412: STORE [SP + 0x38] = R0
ffa04414: STORE [FP + -0x20] = R1
ffa04416: STORE [FP + -0x24] = R2
ffa04418: LOAD P3 = [SP + 0x34]
ffa0441a: NOP
ffa0441c: LOAD R0 = W [P5++] (X)
ffa0441e: CALL 0xffa02948
ffa04422: LOAD R1 = [P4]
ffa04424: CALL 0xffa018f0
ffa04428: LOAD P0 = 0x3ffe
ffa0442c: STORE [SP + 0x34] = R0
ffa0442e: MOVE R7 = R0
ffa04430: LOAD R0 = W [P5 ++ P0] (X)
ffa04432: CALL 0xffa02948
ffa04436: LOAD R1 = [P4++]
ffa04438: CALL 0xffa018f0
ffa0443c: LOAD P1 = [FP + 0x1c]
ffa0443e: MOVE R6 = R0
ffa04440: LOAD R2 = B [P1 + 0x4] (Z)
ffa04444: CC = R2 == 0x3
ffa04446: IF !CC JUMP 0xffa0445a
ffa04448: NOP
ffa0444a: NOP
ffa0444c: LOAD P1 = [SP + 0x28]
ffa0444e: LOAD R0 = W [P1] (X)
ffa04450: CC = R0 == 0x1
ffa04452: IF CC JUMP 0xffa0451c
ffa04454: NOP
ffa04456: NOP
ffa04458: NOP
ffa0445a: LOAD R7 = [P3]
ffa0445c: MOVE R1 = R7
ffa0445e: LOAD R0 = [SP + 0x34]
ffa04460: CALL 0xffa018f0
ffa04464: LOAD R5 = [P3 + 0x4]
ffa04466: ROT|| R0 = rot R6 by 0
ffa0446a: _STORE [FP + -0x1c] = R0
ffa0446c: _NOP
ffa0446e: BITTGL (R5,0x1f)
ffa04470: MOVE R1 = R5
ffa04472: CALL 0xffa018f0
ffa04476: MOVE R1 = R0
ffa04478: LOAD R0 = [FP + -0x1c]
ffa0447a: CALL 0xffa01714
ffa0447e: ROT|| R1 = rot R7 by 0
ffa04482: _STORE [FP + -0x1c] = R0
ffa04484: _NOP
ffa04486: MOVE R0 = R6
ffa04488: CALL 0xffa018f0
ffa0448c: MOVE R7 = R0
ffa0448e: MOVE R0 = R5
ffa04490: LOAD R1 = [SP + 0x34]
ffa04492: CALL 0xffa018f0
ffa04496: MOVE R1 = R7
ffa04498: CALL 0xffa01716
ffa0449c: LOAD R6 = [P3 + 0x18]
ffa0449e: MOVE R7 = R0
ffa044a0: MOVE R0 = R6
ffa044a2: LOAD R1 = [FP + -0x1c]
ffa044a4: LOAD R4 = [P3 + 0x1c]
ffa044a6: CALL 0xffa018f0
ffa044aa: BITTGL (R4,0x1f)
ffa044ac: MOVE R5 = R0
ffa044ae: MOVE R1 = R7
ffa044b0: MOVE R0 = R4
ffa044b2: CALL 0xffa018f0
ffa044b6: MOVE R1 = R0
ffa044b8: MOVE R0 = R5
ffa044ba: CALL 0xffa01714
ffa044be: ROT|| R1 = rot R7 by 0
ffa044c2: _STORE [FP + 0x10] = R0
ffa044c4: _NOP
ffa044c6: MOVE R0 = R6
ffa044c8: CALL 0xffa018f0
ffa044cc: MOVE R7 = R0
ffa044ce: MOVE R0 = R4
ffa044d0: LOAD R1 = [FP + -0x1c]
ffa044d2: CALL 0xffa018f0
ffa044d6: MOVE R1 = R7
ffa044d8: CALL 0xffa01716
ffa044dc: STORE [FP + 0x14] = R0
ffa044de: LOAD R1 = [FP + -0x20]
ffa044e0: LOAD R0 = [FP + 0x10]
ffa044e2: CALL 0xffa01716
ffa044e6: MOVE R5 = R0
ffa044e8: ROT|| R7 = rot R0 by 0
ffa044ec: _LOAD R6 = [SP + 0x38]
ffa044ee: _NOP
ffa044f0: LOAD R1 = [FP + -0x24]
ffa044f2: LOAD R0 = [FP + 0x14]
ffa044f4: CALL 0xffa01716
ffa044f8: ADD R6 += -0x1
ffa044fa: CC = R6 == 0x0
ffa044fc: ROT|| R1 = rot R0 by 0
ffa04500: _STORE [FP + -0x20] = R5
ffa04502: _NOP
ffa04504: STORE [FP + -0x24] = R0
ffa04506: STORE [SP + 0x38] = R6
ffa04508: ADD P3 += 0x8
ffa0450a: IF !CC JUMP 0xffa0441a (bp)
ffa0450c: MOVE R0 = R7
ffa0450e: CALL 0xffa00ae4
ffa04512: ADD SP += 0xc
ffa04514: POP (R7:4,P5:3) = [SP++]
ffa04516: UNLINK
ffa0451a: RTS
ffa0451c: MOVE R0 = R7
ffa0451e: MOVE R1 = R6
ffa04520: CALL 0xffa00ae4
ffa04524: LOAD R2 = 0x0
ffa04526: LOAD R1 = 0x0
ffa04528: LOAD R1.H = 0x3fc0
ffa0452c: STORE [FP + 0x14] = R2
ffa0452e: CALL 0xffa018f0
ffa04532: STORE [FP + 0x10] = R0
ffa04534: JUMP.S 0xffa044de
ffa04536: MOVE P3 = FP
ffa04538: LOAD R0 = 0x0
ffa0453a: LOAD R1 = 0x0
ffa0453c: STORE [SP + 0x28] = R0
ffa0453e: STORE [SP + 0x38] = R1
ffa04540: ADD P3 += -0x18
ffa04542: MOVE P1 = P5
ffa04544: ADD P1 += 0x2
ffa04546: LOAD R0 = 0x0
ffa04548: LOAD P0 = [SP + 0x34]
ffa0454a: LOAD R1 = 0x0
ffa0454c: STORE [FP + -0x28] = P1
ffa0454e: STORE [FP + -0x20] = R0
ffa04550: STORE [FP + -0x1c] = P0
ffa04552: STORE [FP + -0x24] = R1
ffa04554: LOAD R5 = 0x0
ffa04556: LOAD R0 = [FP + 0x24]
ffa04558: CC = R0 == 0x0
ffa0455a: IF !CC JUMP 0xffa045b8
ffa0455c: LOAD R1 = [SP + 0x38]
ffa0455e: CC = R1 == R5
ffa04560: LOAD R4 = [FP + -0x20]
ffa04562: LOAD R0 = [FP + -0x24]
ffa04564: IF !CC JUMP 0xffa045b8
ffa04566: LOAD P2 = [FP + -0x28]
ffa04568: LOAD P0 = [FP + -0x1c]
ffa0456a: LOAD P1 = 0x4000
ffa0456e: ADD R5 += 0x1
ffa04570: ADD P1 = P2 + P1
ffa04572: ADD P0 += 0x8
ffa04574: LOAD P2 = 0x4000
ffa04578: CC = R5 < 0x3
ffa0457a: STORE [FP + -0x20] = R4
ffa0457c: STORE [FP + -0x24] = R0
ffa0457e: STORE [FP + -0x28] = P1
ffa04580: STORE [FP + -0x1c] = P0
ffa04582: ADD P5 = P5 + P2
ffa04584: ADD P4 += 0x4
ffa04586: IF CC JUMP 0xffa04556 (bp)
ffa04588: STORE [P3] = R4
ffa0458a: STORE [P3 + 0x4] = R0
ffa0458c: LOAD R7 = [SP + 0x38]
ffa0458e: LOAD R0 = [P3++]
ffa04590: LOAD R1 = [P3++]
ffa04592: CALL 0xffa00ae4
ffa04596: LOAD R1 = [SP + 0x28]
ffa04598: CALL 0xffa01716
ffa0459c: ADD R7 += 0x1
ffa0459e: CC = R7 < 0x3
ffa045a0: STORE [SP + 0x28] = R0
ffa045a2: STORE [SP + 0x38] = R7
ffa045a4: IF CC JUMP 0xffa04542 (bp)
ffa045a6: LOAD R1 = [FP + 0x24]
ffa045a8: CC = R1 == 0x0
ffa045aa: IF !CC JUMP 0xffa04512
ffa045ac: LOAD R1 = 0x0
ffa045ae: LOAD R1.H = 0x3fc0
ffa045b2: CALL 0xffa018f0
ffa045b6: JUMP.S 0xffa04512
ffa045b8: LOAD R0 = W [P5] (X)
ffa045ba: CALL 0xffa02948
ffa045be: LOAD R1 = [P4]
ffa045c0: CALL 0xffa018f0
ffa045c4: LOAD P1 = [FP + -0x28]
ffa045c6: STORE [SP + 0x2c] = R0
ffa045c8: MOVE R7 = R0
ffa045ca: LOAD R0 = W [P1] (X)
ffa045cc: CALL 0xffa02948
ffa045d0: LOAD R1 = [P4]
ffa045d2: CALL 0xffa018f0
ffa045d6: ROT|| R1 = rot R7 by 0
ffa045da: _LOAD P0 = [FP + -0x1c]
ffa045dc: _NOP
ffa045de: STORE [SP + 0x3c] = R0
ffa045e0: LOAD R7 = [P0]
ffa045e2: MOVE R0 = R7
ffa045e4: LOAD R6 = [P0 + 0x4]
ffa045e6: LOAD R4 = [P0 + 0x1c]
ffa045e8: CALL 0xffa018f0
ffa045ec: STORE [SP + 0x30] = R0
ffa045ee: BITTGL (R6,0x1f)
ffa045f0: ROT|| R0 = rot R6 by 0
ffa045f4: _LOAD R1 = [SP + 0x3c]
ffa045f6: _NOP
ffa045f8: CALL 0xffa018f0
ffa045fc: MOVE R1 = R0
ffa045fe: LOAD R0 = [SP + 0x30]
ffa04600: CALL 0xffa01714
ffa04604: LOAD R1 = [SP + 0x3c]
ffa04606: ROT|| R0 = rot R7 by 0
ffa0460a: _STORE [SP + 0x3c] = R0
ffa0460c: _NOP
ffa0460e: CALL 0xffa018f0
ffa04612: MOVE R7 = R0
ffa04614: ROT|| R0 = rot R6 by 0
ffa04618: _LOAD R1 = [SP + 0x2c]
ffa0461a: _NOP
ffa0461c: CALL 0xffa018f0
ffa04620: MOVE R1 = R7
ffa04622: CALL 0xffa01716
ffa04626: LOAD P1 = [FP + -0x1c]
ffa04628: MOVE R7 = R0
ffa0462a: LOAD R1 = [SP + 0x3c]
ffa0462c: BITTGL (R4,0x1f)
ffa0462e: LOAD R6 = [P1 + 0x18]
ffa04630: MOVE R0 = R6
ffa04632: CALL 0xffa018f0
ffa04636: ROT|| R1 = rot R7 by 0
ffa0463a: _STORE [SP + 0x30] = R0
ffa0463c: _NOP
ffa0463e: MOVE R0 = R4
ffa04640: CALL 0xffa018f0
ffa04644: ROT|| R1 = rot R7 by 0
ffa04648: _STORE [SP + 0x2c] = R0
ffa0464a: _NOP
ffa0464c: MOVE R0 = R6
ffa0464e: CALL 0xffa018f0
ffa04652: MOVE R6 = R0
ffa04654: MOVE R0 = R4
ffa04656: LOAD R1 = [SP + 0x3c]
ffa04658: CALL 0xffa018f0
ffa0465c: MOVE R7 = R0
ffa0465e: LOAD R1 = [FP + -0x20]
ffa04660: LOAD R0 = [SP + 0x30]
ffa04662: CALL 0xffa01716
ffa04666: LOAD R1 = [SP + 0x2c]
ffa04668: CALL 0xffa01714
ffa0466c: MOVE R4 = R0
ffa0466e: MOVE R0 = R6
ffa04670: LOAD R1 = [FP + -0x24]
ffa04672: CALL 0xffa01716
ffa04676: MOVE R1 = R7
ffa04678: CALL 0xffa01716
ffa0467c: JUMP.S 0xffa04566
ffa0467e: LINK 0x60
