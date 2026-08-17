ffa03380: MOVE R1 = R4
ffa03382: CALL 0xffa01630
ffa03386: LOAD R0 = 0x0
ffa03388: LOAD R0.H = 0x3f80
ffa0338c: IF CC JUMP 0xffa033a8
ffa0338e: MOVE R1 = R7
ffa03390: MOVE R0 = R6
ffa03392: CALL 0xffa01714
ffa03396: MOVE R6 = R0
ffa03398: MOVE R1 = R7
ffa0339a: MOVE R0 = R4
ffa0339c: CALL 0xffa01714
ffa033a0: MOVE R1 = R0
ffa033a2: MOVE R0 = R6
ffa033a4: CALL 0xffa01814
ffa033a8: ADD SP += 0xc
ffa033aa: POP (R7:4) = [SP++]
ffa033ac: UNLINK
ffa033b0: RTS
ffa033b2: MOVE R1 = R7
ffa033b4: MOVE R0 = R4
ffa033b6: LOAD R6 = 0x0
ffa033b8: CALL 0xffa0165c
ffa033bc: LOAD R6.H = 0x3f80
ffa033c0: MOVE R0 = R6
ffa033c2: IF !CC JUMP 0xffa033a8
ffa033c4: MOVE R1 = R7
ffa033c6: MOVE R0 = R5
ffa033c8: CALL 0xffa01630
ffa033cc: LOAD R0 = 0x0
ffa033ce: IF CC JUMP 0xffa033a8
ffa033d0: MOVE R1 = R5
ffa033d2: MOVE R0 = R4
ffa033d4: CALL 0xffa01630
ffa033d8: MOVE R0 = R6
ffa033da: IF CC JUMP 0xffa033a8
ffa033dc: MOVE R1 = R5
ffa033de: MOVE R0 = R7
ffa033e0: CALL 0xffa01714
ffa033e4: MOVE R6 = R0
ffa033e6: MOVE R1 = R4
ffa033e8: MOVE R0 = R7
ffa033ea: CALL 0xffa01714
ffa033ee: MOVE R1 = R0
ffa033f0: MOVE R0 = R6
ffa033f2: CALL 0xffa01814
ffa033f6: JUMP.S 0xffa033a8
ffa033f8: LINK 0x14
ffa033fc: PUSH [--SP] = (P5:3)
ffa033fe: STORE W [FP + 0xc] = R1
ffa03400: STORE [FP + 0x8] = R0
ffa03402: LOAD R2 = 0x0
ffa03404: STORE W [FP + -0x8] = R2
ffa03408: MOVE P0 = FP
ffa0340a: ADD P0 += -0x8
ffa0340c: LOAD R0 = W [P0] (X)
ffa0340e: MOVE P1 = FP
ffa03410: ADD P1 += 0xc
ffa03412: LOAD R1 = W [P1] (X)
ffa03414: CC = R1 <= R0
ffa03416: IF CC JUMP 0xffa03430
ffa03418: MOVE P1 = R0
ffa0341a: LOAD P2.L = 0xa340
ffa0341e: LOAD P2.H = 0x2022
ffa03422: ADD P1 = P2 + (P1 << 1)
ffa03424: STORE W [P1] = R0.L
ffa03426: LOAD R0 = W [P0] (X)
ffa03428: ADD R0 += 0x1
ffa0342a: STORE W [FP + -0x8] = R0
ffa0342e: JUMP.S 0xffa03408
ffa03430: LOAD R0 = W [FP + 0xc] (X)
ffa03432: LOAD R1 = 0x1000
ffa03436: CC = R1 < R0
ffa03438: IF CC JUMP 0xffa0343e
ffa0343a: CC = R0 == 0x0
ffa0343c: IF !CC JUMP 0xffa0344a (bp)
ffa0343e: LOAD R0.L = 0xa340
ffa03442: LOAD R0.H = 0x2022
ffa03446: STORE [FP + -0xc] = R0
ffa03448: JUMP.S 0xffa03610
ffa0344a: LOAD P2.L = 0x5f40
ffa0344e: LOAD P2.H = 0x2022
ffa03452: STORE W [P2] = R2.L
ffa03454: LOAD P0.L = 0x8140
ffa03458: LOAD P0.H = 0x2022
ffa0345c: STORE W [P0] = R0.L
ffa0345e: STORE W [FP + -0x8] = R2
ffa03462: LOAD R0 = W [FP + -0x8] (X)
ffa03466: CC = R0 < 0x0
ffa03468: IF CC JUMP 0xffa03606
ffa0346a: NOP
ffa0346c: MOVE P1 = R0
ffa0346e: ADD P5 = P2 + (P1 << 1)
ffa03470: LOAD R2.L = W [P5]
ffa03472: STORE W [FP + -0x6] = R2
ffa03476: ADD P4 = P0 + (P1 << 1)
ffa03478: LOAD R1 = W [P4] (X)
ffa0347a: ADD R1 += -0x1
ffa0347c: STORE W [FP + -0x4] = R1
ffa03480: SUB R1.H = R2.L - R1.L (s)
ffa03484: MOVE CC = an
ffa03486: IF !CC JUMP 0xffa035fe
ffa03488: LOAD R0 = W [FP + -0x6] (X)
ffa0348c: MOVE P1 = R0
ffa0348e: LOAD P5.L = 0xa340
ffa03492: LOAD P5.H = 0x2022
ffa03496: ADD P1 = P5 + (P1 << 1)
ffa03498: LOAD R0 = W [P1] (X)
ffa0349a: STORE W [FP + 0x12] = R0
ffa0349c: LOAD P4 = [FP + 0x8]
ffa0349e: MOVE P1 = R0
ffa034a0: ADD P1 = P4 + (P1 << 1)
ffa034a2: LOAD R0.L = W [P1]
ffa034a4: STORE W [FP + 0x10] = R0
ffa034a6: LOAD R2 = W [FP + -0x6] (X)
ffa034aa: LOAD R0 = W [FP + -0x4] (X)
ffa034ae: CC = R0 <= R2
ffa034b0: IF CC JUMP 0xffa03550
ffa034b2: LOAD P4 = [FP + 0x8]
ffa034b4: MOVE P1 = FP
ffa034b6: ADD P1 += -0x4
ffa034b8: STORE [FP + -0x14] = P1
ffa034ba: LOAD R0 = W [P1] (X)
ffa034bc: MOVE P1 = R0
ffa034be: ADD P1 = P5 + (P1 << 1)
ffa034c0: LOAD R1 = W [P1] (X)
ffa034c2: MOVE P1 = R1
ffa034c4: ADD P1 = P4 + (P1 << 1)
ffa034c6: LOAD R1 = W [P1] (X)
ffa034c8: MOVE P4 = FP
ffa034ca: ADD P4 += 0x10
ffa034cc: LOAD R3 = W [P4] (X)
ffa034ce: CC = R3 < R1
ffa034d0: IF CC JUMP 0xffa034de
ffa034d2: CC = R0 <= R2
ffa034d4: IF CC JUMP 0xffa034de
ffa034d6: ADD R0 += -0x1
ffa034d8: STORE W [FP + -0x4] = R0
ffa034dc: JUMP.S 0xffa034b2
ffa034de: LOAD R0 = W [FP + -0x4] (X)
ffa034e2: CC = R0 <= R2
ffa034e4: IF CC JUMP 0xffa034fc
ffa034e6: NOP
ffa034e8: MOVE P1 = R0
ffa034ea: ADD P1 = P5 + (P1 << 1)
ffa034ec: LOAD R0.L = W [P1]
ffa034ee: MOVE P1 = R2
ffa034f0: ADD P1 = P5 + (P1 << 1)
ffa034f2: STORE W [P1] = R0.L
ffa034f4: ADD R2 += 0x1
ffa034f6: STORE W [FP + -0x6] = R2
ffa034fa: JUMP.S 0xffa034fc
ffa034fc: MOVE P1 = FP
ffa034fe: ADD P1 += -0x6
ffa03500: LOAD R0 = W [P1] (X)
ffa03502: MOVE P1 = R0
ffa03504: ADD P1 = P5 + (P1 << 1)
ffa03506: LOAD R1 = W [P1] (X)
ffa03508: STORE [FP + -0x10] = R1
ffa0350a: LOAD P1 = [FP + 0x8]
ffa0350c: LOAD P3 = [FP + -0x10]
ffa0350e: ADD P1 = P1 + (P3 << 1)
ffa03510: LOAD R2 = W [P1] (X)
ffa03512: LOAD R3 = W [P4] (X)
ffa03514: CC = R2 < R3
ffa03516: IF CC JUMP 0xffa0352c
ffa03518: NOP
ffa0351a: NOP
ffa0351c: LOAD P1 = [FP + -0x14]
ffa0351e: LOAD R1 = W [P1] (X)
ffa03520: CC = R1 <= R0
ffa03522: IF CC JUMP 0xffa0352c
ffa03524: ADD R0 += 0x1
ffa03526: STORE W [FP + -0x6] = R0
ffa0352a: JUMP.S 0xffa034fc
ffa0352c: LOAD R0 = W [FP + -0x6] (X)
ffa03530: LOAD R1 = W [FP + -0x4] (X)
ffa03534: CC = R1 <= R0
ffa03536: IF CC JUMP 0xffa0354e
ffa03538: NOP
ffa0353a: MOVE P1 = R0
ffa0353c: ADD P1 = P5 + (P1 << 1)
ffa0353e: LOAD R0.L = W [P1]
ffa03540: MOVE P4 = R1
ffa03542: ADD P4 = P5 + (P4 << 1)
ffa03544: STORE W [P4] = R0.L
ffa03546: ADD R1 += -0x1
ffa03548: STORE W [FP + -0x4] = R1
ffa0354c: JUMP.S 0xffa0354e
ffa0354e: JUMP.S 0xffa034a6
ffa03550: LOAD R1 = W [FP + 0x12] (X)
ffa03552: LOAD R0 = W [FP + -0x6] (X)
ffa03556: MOVE P1 = R0
ffa03558: ADD P1 = P5 + (P1 << 1)
ffa0355a: STORE W [P1] = R1.L
ffa0355c: LOAD R1 = W [FP + -0x6] (X)
ffa03560: ADD R1 += 0x1
ffa03562: LOAD R0 = W [FP + -0x8] (X)
ffa03566: ADD R0 += 0x1
ffa03568: MOVE P1 = R0
ffa0356a: ADD P1 = P2 + (P1 << 1)
ffa0356c: STORE W [P1] = R1.L
ffa0356e: LOAD R0 = W [FP + -0x8] (X)
ffa03572: MOVE P1 = R0
ffa03574: ADD P1 = P0 + (P1 << 1)
ffa03576: LOAD R1.L = W [P1]
ffa03578: ADD R0 += 0x1
ffa0357a: MOVE P5 = R0
ffa0357c: ADD P5 = P0 + (P5 << 1)
ffa0357e: STORE W [P5] = R1.L
ffa03580: LOAD R2 = W [FP + -0x6] (X)
ffa03584: LOAD R0 = W [FP + -0x8] (X)
ffa03588: MOVE P1 = R0
ffa0358a: ADD P1 = P0 + (P1 << 1)
ffa0358c: STORE W [P1] = R2.L
ffa0358e: ADD R0 += 0x1
ffa03590: MOVE R1 = R0.L (X)
ffa03592: STORE W [FP + -0x8] = R0
ffa03596: MOVE P5 = R1
ffa03598: ADD P4 = P0 + (P5 << 1)
ffa0359a: LOAD R0 = W [P4] (X)
ffa0359c: ADD P5 = P2 + (P5 << 1)
ffa0359e: LOAD R2 = W [P5] (X)
ffa035a0: SUB R0 = R0 - R2 (ns)
ffa035a4: ADD R1 += -0x1
ffa035a6: MOVE P1 = R1
ffa035a8: ADD P4 = P0 + (P1 << 1)
ffa035aa: LOAD R3 = W [P4] (X)
ffa035ac: ADD P1 = P2 + (P1 << 1)
ffa035ae: LOAD R1 = W [P1] (X)
ffa035b0: SUB R1 = R3 - R1 (ns)
ffa035b4: CC = R0 <= R1
ffa035b6: IF CC JUMP 0xffa035fc
ffa035b8: LOAD R0.L = W [P5]
ffa035ba: STORE W [FP + -0x2] = R0
ffa035be: LOAD R0.L = W [P1]
ffa035c0: STORE W [P5] = R0.L
ffa035c2: LOAD R1 = W [FP + -0x2] (X)
ffa035c6: LOAD R0 = W [FP + -0x8] (X)
ffa035ca: ADD R0 += -0x1
ffa035cc: MOVE P1 = R0
ffa035ce: ADD P1 = P2 + (P1 << 1)
ffa035d0: STORE W [P1] = R1.L
ffa035d2: LOAD R0 = W [FP + -0x8] (X)
ffa035d6: MOVE P1 = R0
ffa035d8: ADD P1 = P0 + (P1 << 1)
ffa035da: LOAD R1.L = W [P1]
ffa035dc: STORE W [FP + -0x2] = R1
ffa035e0: ADD R0 += -0x1
ffa035e2: MOVE P5 = R0
ffa035e4: ADD P5 = P0 + (P5 << 1)
ffa035e6: LOAD R0.L = W [P5]
ffa035e8: STORE W [P1] = R0.L
ffa035ea: LOAD R1 = W [FP + -0x2] (X)
ffa035ee: LOAD R0 = W [FP + -0x8] (X)
ffa035f2: ADD R0 += -0x1
ffa035f4: MOVE P1 = R0
ffa035f6: ADD P1 = P0 + (P1 << 1)
ffa035f8: STORE W [P1] = R1.L
ffa035fa: JUMP.S 0xffa035fc
ffa035fc: JUMP.S 0xffa03604
ffa035fe: ADD R0 += -0x1
ffa03600: STORE W [FP + -0x8] = R0
