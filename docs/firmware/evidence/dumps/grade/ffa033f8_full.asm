ffa03300: IF CC JUMP 0xffa031b8
ffa03302: NOP
ffa03304: NOP
ffa03306: LOAD P1 = [SP + 0x20]
ffa03308: LOAD R0 = [P3]
ffa0330a: CC = R6 < R0 (IU)
ffa0330c: MOVE R3 = CC
ffa0330e: SUB R1 = R6 - R0
ffa03310: LOAD R0 = [P1]
ffa03312: SUB R3 = R7 - R3
ffa03314: LOAD R2 = [P3 + 0x4]
ffa03316: CC = R0 < R1 (IU)
ffa03318: SUB R2 = R3 - R2
ffa0331a: LOAD R1 = [P1 + 0x4]
ffa0331c: SUB R2 = R1 - R2 (s)
ffa03320: MOVE CC &= az
ffa03322: MOVE CC |= an
ffa03324: IF !CC JUMP 0xffa031b8
ffa03326: LOAD P1 = [SP + 0x24]
ffa03328: LOAD P0 = [SP + 0x24]
ffa0332a: LOAD R1 = W [P5] (X)
ffa0332c: LOAD R0 = [P1]
ffa0332e: BITSET (R0,0x2)
ffa03330: STORE [P0] = R0
ffa03332: STORE W [P4] = R1.L
ffa03334: JUMP.S 0xffa031b8
ffa03338: LINK 0x0
ffa0333c: PUSH [--SP] = (R7:4,P5:3)
ffa0333e: ADD SP += -0xc
ffa03340: CALL 0xffa070ae
ffa03344: LOAD P1.L = 0x8120
ffa03348: LOAD P1.H = 0x2023
ffa0334c: CALL (P1)
ffa0334e: ADD SP += 0xc
ffa03350: POP (R7:4,P5:3) = [SP++]
ffa03352: UNLINK
ffa03356: RTS
ffa03358: LINK 0x0
ffa0335c: PUSH [--SP] = (R7:4)
ffa0335e: MOVE R7 = R1
ffa03360: MOVE R4 = R2
ffa03362: MOVE R5 = R0
ffa03364: MOVE R6 = R0
ffa03366: ADD SP += -0xc
ffa03368: MOVE R1 = R4
ffa0336a: MOVE R0 = R7
ffa0336c: CALL 0xffa0165c
ffa03370: IF !CC JUMP 0xffa033b2
ffa03372: MOVE R1 = R5
ffa03374: MOVE R0 = R7
ffa03376: CALL 0xffa01630
ffa0337a: LOAD R0 = 0x0
ffa0337c: IF CC JUMP 0xffa033a8
ffa0337e: MOVE R0 = R6
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
ffa03604: JUMP.S 0xffa03462
ffa03606: LOAD R0.L = 0xa340
ffa0360a: LOAD R0.H = 0x2022
ffa0360e: STORE [FP + -0xc] = R0
ffa03610: LOAD R0 = [FP + -0xc]
ffa03612: POP (P5:3) = [SP++]
ffa03614: UNLINK
ffa03618: RTS
ffa0361a: LINK 0x30
ffa0361e: PUSH [--SP] = (R7:4,P5:3)
ffa03620: ADD SP += -0xc
ffa03622: MOVE P2 = R1
ffa03624: LOAD R1 = [FP + 0x18]
ffa03626: LOAD R3 = [FP + 0x14]
ffa03628: CC = R1 <= 0x0
ffa0362a: STORE [SP + 0x28] = R0
ffa0362c: STORE [SP + 0x30] = R3
ffa0362e: LOAD P5 = [FP + 0x14]
ffa03630: LOAD R0 = 0x3e9
ffa03634: IF CC JUMP 0xffa037fa
ffa03636: MOVE P0 = R2
ffa03638: ADD|| R7.H = R1.L + R3.L (ns)
ffa0363c: _LOAD R0 = [FP + 0x18]
ffa0363e: _NOP
ffa03640: CALL 0xffa01688
ffa03644: ASH|| R2 = R7 >>> 0x10
ffa03648: _LOAD P4 = [SP + 0x28]
ffa0364a: _NOP
ffa0364c: LOAD R3 = 0x0
ffa0364e: ADD P0 = P0 + (P5 << 2)
ffa03650: STORE [SP + 0x34] = P0
ffa03652: STORE [FP + 0x10] = P2
ffa03654: STORE [SP + 0x3c] = R0
ffa03656: STORE [SP + 0x2c] = P4
ffa03658: STORE [FP + -0x18] = R2
ffa0365a: STORE [SP + 0x38] = R3
ffa0365c: LOAD P1 = [SP + 0x34]
ffa0365e: LOAD P0 = [SP + 0x2c]
ffa03660: LOAD R1 = [SP + 0x38]
ffa03662: STORE [FP + -0x10] = P1
ffa03664: STORE [FP + -0x14] = P0
ffa03666: STORE [FP + -0xc] = R1
ffa03668: LOAD P5 = [FP + 0x10]
ffa0366a: SUB|| R0 = R0 - R0 (ns)
ffa0366e: _LOAD R1 = [FP + -0x18]
ffa03670: _NOP
ffa03672: SUB|| R5 = R5 - R5 (ns)
ffa03676: _LOAD R2 = [SP + 0x30]
ffa03678: _NOP
ffa0367a: CC = R2 < R1
ffa0367c: IF !CC JUMP 0xffa03728
ffa0367e: LOAD R0 = [FP + 0x14]
ffa03680: ADD R0 += 0x1
ffa03682: ADD R1 += 0x1
ffa03684: MOVE R0 = R0.L (X)
ffa03686: SUB|| R6 = R1 - R0 (ns)
ffa0368a: _LOAD R7 = [FP + -0x18]
ffa0368c: _NOP
ffa0368e: CC = R7 <= R0
ffa03690: LOAD R2 = 0x1
ffa03692: SUB|| R0 = R0 - R0 (ns)
ffa03696: _LOAD R3 = [FP + -0xc]
ffa03698: _NOP
ffa0369a: SUB|| R1 = R1 - R1 (ns)
ffa0369e: _LOAD R5 = [SP + 0x38]
ffa036a0: _NOP
ffa036a2: IF CC R6 = R2
ffa036a4: CC = R5 == R3
ffa036a6: IF !CC JUMP 0xffa03822
ffa036a8: NOP
ffa036aa: SUB|| R7 = R7 - R7 (ns)
ffa036ae: _LOAD P4 = [FP + -0x10]
ffa036b0: _NOP
ffa036b2: LOAD P3 = [SP + 0x34]
ffa036b4: LOAD R0 = W [P3++] (X)
ffa036b6: CALL 0xffa02948
ffa036ba: ADD R6 += -0x1
ffa036bc: LOAD P1 = [FP + 0x10]
ffa036be: LOAD R1 = [P1]
ffa036c0: CALL 0xffa018f0
ffa036c4: STORE [FP + 0x8] = R0
ffa036c6: LOAD R0 = W [P3++] (X)
ffa036c8: CALL 0xffa02948
ffa036cc: LOAD P0 = [FP + 0x10]
ffa036ce: LOAD R1 = [P0]
ffa036d0: CALL 0xffa018f0
ffa036d4: STORE [FP + 0xc] = R0
ffa036d6: LOAD R0 = W [P4++] (X)
ffa036d8: CALL 0xffa02948
ffa036dc: LOAD R1 = [P5]
ffa036de: CALL 0xffa018f0
ffa036e2: ROT|| R5 = rot R0 by 0
ffa036e6: _LOAD R0 = W [P4++] (X)
ffa036e8: _NOP
ffa036ea: CALL 0xffa02948
ffa036ee: LOAD R1 = [P5]
ffa036f0: CALL 0xffa018f0
ffa036f4: ROT|| R4 = rot R0 by 0
ffa036f8: _LOAD R1 = [FP + 0x8]
ffa036fa: _NOP
ffa036fc: MOVE R0 = R5
ffa036fe: CALL 0xffa018f0
ffa03702: ROT|| R5 = rot R0 by 0
ffa03706: _LOAD R1 = [FP + 0xc]
ffa03708: _NOP
ffa0370a: MOVE R0 = R4
ffa0370c: CALL 0xffa018f0
ffa03710: MOVE R4 = R0
ffa03712: MOVE R1 = R7
ffa03714: MOVE R0 = R5
ffa03716: CALL 0xffa01716
ffa0371a: MOVE R1 = R4
ffa0371c: CALL 0xffa01716
ffa03720: CC = R6 == 0x0
ffa03722: MOVE R7 = R0
ffa03724: IF !CC JUMP 0xffa036b4 (bp)
ffa03726: LOAD R5 = 0x0
ffa03728: LOAD P4 = [FP + 0x24]
ffa0372a: LOAD P1 = 0x4c08
ffa0372e: LOAD P1.H = 0x3
ffa03732: LOAD R2 = 0x5cfc
ffa03736: LOAD P0 = 0x578
ffa0373a: ADD P1 = P4 + P1
ffa0373c: LOAD R1 = W [P1] (X)
ffa0373e: MULT|| R1 = R1.L * R2.L (is)
ffa03742: LOAD R3 = [FP + 0x1c]
ffa03744: NOP
ffa03746: MOVE P1 = R1
ffa03748: ADD P0 = P4 + P0
ffa0374a: LOAD R2 = [SP + 0x38]
ffa0374c: LOAD R7 = 0x0
ffa0374e: ADD P1 = P0 + P1
ffa03750: LOAD R1 = B [P1 + 0x2] (Z)
ffa03754: CC = R1 <= R3
ffa03756: IF !CC JUMP 0xffa03804
ffa03758: LOAD R7 = 0x0
ffa0375a: LOAD R7.H = 0x4040
ffa0375e: MOVE R1 = R7
ffa03760: CALL 0xffa01814
ffa03764: MOVE R6 = R0
ffa03766: MOVE R0 = R5
ffa03768: MOVE R1 = R7
ffa0376a: CALL 0xffa01814
ffa0376e: MOVE R5 = R0
ffa03770: MOVE R0 = R6
ffa03772: LOAD P0 = [FP + -0x14]
ffa03774: LOAD R1 = [SP + 0x3c]
ffa03776: CALL 0xffa01814
ffa0377a: LOAD R1 = [SP + 0x3c]
ffa0377c: ROT|| R0 = rot R5 by 0
ffa03780: _STORE [P0++] = R0
ffa03782: _NOP
ffa03784: CALL 0xffa01814
ffa03788: SUB|| R1 = R1 - R1 (ns)
ffa0378c: _LOAD P1 = [FP + -0x10]
ffa0378e: _NOP
ffa03790: LOAD R7 = [FP + -0xc]
ffa03792: LOAD P2 = 0x4000
ffa03796: ADD R7 += 0x1
ffa03798: STORE [P0++] = R0
ffa0379a: ADD P1 = P1 + P2
ffa0379c: CC = R7 < 0x3
ffa0379e: STORE [FP + -0xc] = R7
ffa037a0: STORE [FP + -0x14] = P0
ffa037a2: STORE [FP + -0x10] = P1
ffa037a4: ADD P5 += 0x4
ffa037a6: IF CC JUMP 0xffa0366a (bp)
ffa037a8: LOAD P1 = [SP + 0x34]
ffa037aa: LOAD P4 = [SP + 0x2c]
ffa037ac: LOAD R0 = 0x1
ffa037ae: LOAD P5 = [FP + 0x10]
ffa037b0: LOAD R7 = [SP + 0x38]
ffa037b2: LOAD R2 = 0x1
ffa037b4: ADD P3 = P1 + P2
ffa037b6: CALL 0xffa06008
ffa037ba: ADD R7 += 0x1
ffa037bc: STORE [SP + 0x34] = P3
ffa037be: ADD P4 += 0x20
ffa037c0: ADD P5 += 0x4
ffa037c2: CC = R7 < 0x3
ffa037c4: STORE [SP + 0x38] = R7
ffa037c6: STORE [SP + 0x2c] = P4
ffa037c8: STORE [FP + 0x10] = P5
ffa037ca: LOAD P1 = [SP + 0x34]
ffa037cc: IF CC JUMP 0xffa0365e (bp)
ffa037ce: LOAD P1 = 0x3
ffa037d0: LOAD P0 = [SP + 0x28]
ffa037d2: LOAD P4 = 0x0
ffa037d4: LOAD P5 = [SP + 0x28]
ffa037d6: LOAD P3 = 0x14
ffa037d8: LSETUP (0xffa037dc,0xffa037f6) LC1 = P1
ffa037dc: CC = P4 <= 0x0
ffa037de: IF CC JUMP 0xffa037f2
ffa037e0: MOVE P1 = P0
ffa037e2: MOVE P2 = P5
ffa037e4: LSETUP (0xffa037e8,0xffa037f0) LC0 = P4
ffa037e8: LOAD R0 = [P2++]
ffa037ea: STORE [P1++] = R0
ffa037ec: LOAD R0 = [P2 ++ P3]
ffa037ee: BITTGL (R0,0x1f)
ffa037f0: STORE [P1++] = R0
ffa037f2: ADD P4 += 0x1
ffa037f4: ADD P5 += 0x8
ffa037f6: ADD P0 += 0x18
ffa037f8: LOAD R0 = 0x0
ffa037fa: ADD SP += 0xc
ffa037fc: POP (R7:4,P5:3) = [SP++]
ffa037fe: UNLINK
