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
