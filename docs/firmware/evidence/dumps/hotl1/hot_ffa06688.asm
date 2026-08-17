ffa06688: LINK 0x2c
ffa0668c: PUSH [--SP] = (R7:4,P5:3)
ffa0668e: STORE [SP + 0x30] = R2
ffa06690: LOAD R3 = [FP + 0x18]
ffa06692: LOAD R2 = 0x1
ffa06694: LSHIFT R2 <<= R3
ffa06696: STORE [FP + 0x10] = R2
ffa06698: MOVE I1 = R1
ffa0669a: MOVE I0 = R0
ffa0669c: SUB|| R2 = R2 - R2 (ns)
ffa066a0: _STORE [SP + 0x24] = R2
ffa066a2: _NOP
ffa066a4: LOAD R1 = [FP + 0x10]
ffa066a6: ADD R1 += -0x1
ffa066a8: CC = R1 < 0x1
ffa066aa: LOAD R5 = 0x1
ffa066ac: IF CC JUMP 0xffa06710
ffa066ae: MOVE P2 = R1
ffa066b0: MOVE P3 = I0
ffa066b2: MOVE P1 = I1
ffa066b4: SUB P3 -= P1
ffa066b6: STORE [SP + 0x1c] = P3
ffa066b8: MOVE P0 = I1
ffa066ba: MOVE P3 = I0
ffa066bc: SUB P0 -= P3
ffa066be: MOVE P4 = I0
ffa066c0: STORE [SP + 0x28] = P0
ffa066c2: ADD P4 += 0x2
ffa066c4: LOAD P5 = -0x1
ffa066c6: LOAD R7 = 0x1
ffa066c8: LSETUP (0xffa066cc,0xffa0670e) LC1 = P2
ffa066cc: LOAD R0 = [FP + 0x10]
ffa066ce: LSETUP (0xffa066d2,0xffa066de) LC0 = P5
ffa066d2: ASH|| R0 = R0 >>> 0x1
ffa066d6: _LOAD P2 = [SP + 0x28]
ffa066d8: _NOP
ffa066da: ADD R6 = R2 + R0
ffa066dc: CC = R1 < R6
ffa066de: IF !CC JUMP 0xffa066e2
ffa066e0: JUMP.S 0xffa066ce
ffa066e2: MOVE R6 = R0
ffa066e4: ADD R6 += -0x1
ffa066e6: AND R2 = R2 & R6
ffa066e8: ADD R2 = R0 + R2
ffa066ea: CC = R2 <= R7
ffa066ec: IF CC JUMP 0xffa0670c
ffa066ee: NOP
ffa066f0: MOVE P3 = R2
ffa066f2: MOVE P1 = I0
ffa066f4: LOAD R0 = W [P4] (X)
ffa066f6: MOVE P0 = I1
ffa066f8: ADD P1 = P1 + (P3 << 1)
ffa066fa: LOAD R6 = W [P1] (X)
ffa066fc: STORE W [P4 ++ P2] = R6.L
ffa066fe: LOAD P2 = [SP + 0x1c]
ffa06700: STORE W [P1] = R0.L
ffa06702: ADD P0 = P0 + (P3 << 1)
ffa06704: LOAD R0 = W [P4] (X)
ffa06706: LOAD R6 = W [P0] (X)
ffa06708: STORE W [P4 ++ P2] = R6.L
ffa0670a: STORE W [P0] = R0.L
ffa0670c: ADD R7 += 0x1
ffa0670e: ADD P4 += 0x2
ffa06710: SUB|| R1 = R1 - R1 (ns)
ffa06714: _LOAD R0 = [FP + 0x10]
ffa06716: _NOP
ffa06718: CC = R0 <= 0x1
ffa0671a: ADD R3 += -0x1
ffa0671c: IF CC JUMP 0xffa068d8
ffa0671e: LSH|| R0 = R0 >> 0x2
ffa06722: _STORE [SP + 0x2c] = R3
ffa06724: _NOP
ffa06726: LOAD P1 = 0x1
ffa06728: STORE [SP + 0x28] = R0
ffa0672a: STORE [SP + 0x38] = P1
ffa0672c: LOAD P3 = -0x1
ffa0672e: SUB|| R2 = R2 - R2 (ns)
ffa06732: _LOAD P2 = [SP + 0x24]
ffa06734: _NOP
ffa06736: MOVE P1 = I0
ffa06738: MOVE P0 = I1
ffa0673a: LSETUP (0xffa0673e,0xffa06770) LC0 = P2
ffa0673e: LOAD R0 = W [P1++] (X)
ffa06740: ABS|| R6 = abs R0
ffa06744: LOAD R3 = W [P0++] (X)
ffa06746: NOP
ffa06748: LOAD R7 = 0x6a09
ffa0674c: CC = R7 < R6
ffa0674e: ABS R3 = abs R3
ffa06752: IF CC JUMP 0xffa068d0
ffa06754: LOAD R0 = 0x6a09
ffa06758: CC = R0 < R3
ffa0675a: IF CC JUMP 0xffa068cc
ffa0675c: LOAD R7 = 0x3504
ffa06760: CC = R7 < R6
ffa06762: LOAD R0 = 0x1
ffa06764: IF CC JUMP 0xffa06770
ffa06766: LOAD R0 = 0x3504
ffa0676a: CC = R0 < R3
ffa0676c: IF CC R2 = R5
ffa0676e: MOVE R0 = R2
ffa06770: MOVE R2 = R0
ffa06772: ADD|| R1 = R1 + R0 (ns)
ffa06776: _LOAD P2 = [SP + 0x38]
ffa06778: _NOP
ffa0677a: SUB|| R1 = R1 - R1 (ns)
ffa0677e: _STORE [SP + 0x20] = R1
ffa06780: _NOP
ffa06782: ADD P0 = P2 + P2
ffa06784: STORE [SP + 0x34] = P0
ffa06786: LOAD P1 = [SP + 0x34]
ffa06788: CC = P2 <= 0x0
ffa0678a: STORE [FP + -0x4] = P1
ffa0678c: IF CC JUMP 0xffa068ae
ffa0678e: STORE [FP + -0x8] = R1
ffa06790: MOVE P1 = I0
ffa06792: MOVE P0 = I1
ffa06794: STORE [SP + 0x1c] = P1
ffa06796: STORE [SP + 0x3c] = P0
ffa06798: LSETUP (0xffa0679c,0xffa068ac) LC1 = P2
ffa0679c: LOAD R2 = [FP + -0x8]
ffa0679e: LOAD R1 = [SP + 0x2c]
ffa067a0: LSHIFT R2 <<= R1
ffa067a2: LOAD R4 = [SP + 0x28]
ffa067a4: ADD|| R1 = R4 + R2 (ns)
ffa067a8: _LOAD R3 = [FP + 0x14]
ffa067aa: _NOP
ffa067ac: LSHIFT R2 <<= R3
ffa067ae: MOVE P0 = R2
ffa067b0: LOAD P2 = [SP + 0x30]
ffa067b2: LSHIFT R1 <<= R3
ffa067b4: MOVE P1 = R1
ffa067b6: LOAD R6 = [FP + 0x1c]
ffa067b8: ADD P0 = P2 + (P0 << 1)
ffa067ba: LOAD R7.L = W [P0]
ffa067bc: CC = R6 == 0x0
ffa067be: NEG R2 = -R7
ffa067c0: ADD P1 = P2 + (P1 << 1)
ffa067c2: IF !CC R2 = R7
ffa067c4: CC = R0 == 0x0
ffa067c6: LOAD R3 = W [P1] (X)
ffa067c8: IF CC JUMP 0xffa067d0
ffa067ca: MOVE R2 = R2.L (X)
ffa067cc: ASHIFT R3 >>>= R0
ffa067ce: ASHIFT R2 >>>= R0
ffa067d0: LOAD R1 = [FP + 0x10]
ffa067d2: LOAD R7 = [FP + -0x8]
ffa067d4: CC = R7 < R1
ffa067d6: IF !CC JUMP 0xffa0689c
ffa067d8: LOAD P2 = [SP + 0x38]
ffa067da: STORE W [FP + 0xc] = R3
ffa067dc: STORE W [FP + 0x8] = R2
ffa067de: LOAD P1 = [SP + 0x1c]
ffa067e0: ADD P2 = (P2 + P2) << 1
ffa067e2: LOAD P0 = [SP + 0x3c]
ffa067e4: LOAD R1 = [FP + -0x8]
ffa067e6: LOAD P5 = [SP + 0x34]
ffa067e8: LOAD P4 = [SP + 0x34]
ffa067ea: ADD P5 = P5 + P0
ffa067ec: ADD P4 = P4 + P1
ffa067ee: LSETUP (0xffa067f2,0xffa06898) LC0 = P3
ffa067f2: NOP
ffa067f4: NOP
ffa067f6: NOP
ffa067f8: LOAD R3 = W [P4] (X)
ffa067fa: LOAD R7 = [FP + 0xc]
ffa067fc: MULT R7 = R7.L * R3.L (is)
ffa06800: ASH|| R7 = R7 >>> 0xe
ffa06804: _LOAD R4 = [FP + 0x8]
ffa06806: _NOP
ffa06808: MULT|| R3 = R4.L * R3.L (is)
ffa0680c: LOAD R2 = W [P5] (X)
ffa0680e: NOP
ffa06810: ASH|| R4 = R3 >>> 0xe
ffa06814: _LOAD R6 = [FP + 0x8]
ffa06816: _NOP
ffa06818: MULT R6 = R6.L * R2.L (is)
ffa0681c: ASH R2.H = R4.L >>> 0x1
ffa06820: AND R4 = R4 & R5
ffa06822: ASHIFT R6 >>>= 0xe
ffa06824: ADD R2.H = R4.L + R2.H (ns)
ffa06828: AND R4 = R6 & R5
ffa0682a: ASH R3.H = R7.L >>> 0x1
ffa0682e: AND R7 = R7 & R5
ffa06830: ASH R6.H = R6.L >>> 0x1
ffa06834: ADD|| R3.H = R7.L + R3.H (ns)
ffa06838: _LOAD R7 = W [P0] (X)
ffa0683a: _NOP
ffa0683c: ADD|| R6.H = R4.L + R6.H (ns)
ffa06840: _LOAD R4 = [FP + 0xc]
ffa06842: _NOP
ffa06844: SUB R6.H = R3.H - R6.H (ns)
ffa06848: MOVE R3 = R7
ffa0684a: CC = R0 == 0x0
ffa0684c: ASHIFT R3 >>>= R0
ffa0684e: IF !CC R7 = R3
ffa06850: MULT|| R3 = R4.L * R2.L (is)
ffa06854: LOAD R4 = W [P1] (X)
ffa06856: NOP
ffa06858: ASHIFT R3 >>>= 0xe
ffa0685a: ASH R2.L = R3.L >>> 0x1
ffa0685e: AND R3 = R3 & R5
ffa06860: ADD R2.L = R3.L + R2.L (ns)
ffa06864: MOVE R3 = R4
ffa06866: ASHIFT R3 >>>= R0
ffa06868: IF !CC R4 = R3
ffa0686a: ADD R7.H = R2.L + R2.H (ns)
ffa0686e: SUB R3.L = R4.L - R6.H (ns)
ffa06872: ADD|| R3.H = R6.H + R4.L (ns)
ffa06876: _STORE W [P4 ++ P2] = R3.L
ffa06878: _NOP
ffa0687a: SUB|| R2.H = R7.L - R7.H (ns)
ffa0687e: _LOAD R6 = [FP + -0x4]
ffa06880: _NOP
ffa06882: ADD|| R2.L = R7.H + R7.L (ns)
ffa06886: _STORE W [P5 ++ P2] = R2.H
ffa06888: _NOP
ffa0688a: ADD|| R1 = R6 + R1 (ns)
ffa0688e: _LOAD R7 = [FP + 0x10]
ffa06890: _NOP
ffa06892: STORE W [P1 ++ P2] = R3.H
ffa06894: CC = R1 < R7
ffa06896: STORE W [P0 ++ P2] = R2.L
ffa06898: IF !CC JUMP 0xffa0689c
ffa0689a: JUMP.S 0xffa067e6
ffa0689c: LOAD P1 = [SP + 0x1c]
ffa0689e: LOAD P0 = [SP + 0x3c]
ffa068a0: LOAD R1 = [FP + -0x8]
ffa068a2: ADD R1 += 0x1
ffa068a4: STORE [FP + -0x8] = R1
ffa068a6: ADD P1 += 0x2
ffa068a8: ADD P0 += 0x2
ffa068aa: STORE [SP + 0x1c] = P1
ffa068ac: STORE [SP + 0x3c] = P0
ffa068ae: LOAD P1 = [SP + 0x34]
ffa068b0: LOAD P2 = [SP + 0x24]
ffa068b2: LOAD R0 = [SP + 0x2c]
ffa068b4: ADD R0 += -0x1
ffa068b6: STORE [SP + 0x38] = P1
ffa068b8: CC = P1 < P2
ffa068ba: STORE [SP + 0x2c] = R0
ffa068bc: LOAD R1 = [SP + 0x20]
ffa068be: IF CC JUMP 0xffa0672e (bp)
ffa068c0: LOAD P0 = [FP + 0x4]
ffa068c2: LOAD R0 = [SP + 0x20]
ffa068c4: POP (R7:4,P5:3) = [SP++]
ffa068c6: UNLINK
ffa068ca: JUMP (P0)
ffa068cc: LOAD R0 = 0x2
ffa068ce: JUMP.S 0xffa06772
ffa068d0: LOAD R0 = 0x2
ffa068d2: JUMP.S 0xffa06772
ffa068d8: SUB|| R0 = R0 - R0 (ns)
ffa068dc: _LOAD P0 = [FP + 0x4]
ffa068de: _NOP
ffa068e0: POP (R7:4,P5:3) = [SP++]
ffa068e2: UNLINK
ffa068e6: JUMP (P0)
