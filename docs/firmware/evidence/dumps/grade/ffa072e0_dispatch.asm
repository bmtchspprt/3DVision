ffa072e0: PUSH [--SP] = (P5:3)
ffa072e2: LOAD P1 = [P0++]
ffa072e4: LOAD P2 = 0x0
ffa072e6: ADD P4 = P0 + (P1 << 2)
ffa072e8: ADD P4 += 0x4
ffa072ea: LSETUP (0xffa072ee,0xffa07304) LC0 = P1
ffa072ee: CC = P1 <= P2
ffa072f0: IF CC JUMP 0xffa07306
ffa072f2: ADD P3 = P1 + P2
ffa072f4: LSHIFT P3 = P3 >> 1
ffa072f6: ADD P5 = P0 + (P3 << 2)
ffa072f8: LOAD R1 = [P5]
ffa072fa: CC = R1 == R0
ffa072fc: IF CC JUMP 0xffa07308
ffa072fe: CC = R1 < R0 (IU)
ffa07300: IF !CC P1 = P3
ffa07302: ADD P3 += 0x1
ffa07304: IF CC P2 = P3
ffa07306: LOAD P3 = -0x1
ffa07308: ADD P1 = P4 + (P3 << 2)
ffa0730a: LOAD P1 = [P1]
ffa0730c: POP (P5:3) = [SP++]
ffa0730e: JUMP (P1)
ffa07324: LINK 0x0
ffa07328: PUSH [--SP] = (P5:4)
ffa0732a: ADD SP += -0xc
ffa0732c: LOAD P4.L = 0x1a34
ffa07330: LOAD P4.H = 0xff80
ffa07334: LOAD P1 = [P4]
ffa07336: LOAD R0 = [P1 + 0x4]
ffa07338: CC = R0 == 0x0
ffa0733a: IF CC JUMP 0xffa07352
ffa0733c: LOAD P5 = 0x4
ffa0733e: LOAD P1 = [P4]
ffa07340: ADD P1 = P1 + P5
ffa07342: LOAD P1 = [P1]
ffa07344: ADD P5 += 0x4
ffa07346: CALL (P1)
ffa07348: LOAD P1 = [P4]
ffa0734a: ADD P1 = P1 + P5
ffa0734c: LOAD R0 = [P1]
ffa0734e: CC = R0 == 0x0
ffa07350: IF !CC JUMP 0xffa0733e (bp)
ffa07352: ADD SP += 0xc
ffa07354: POP (P5:4) = [SP++]
ffa07356: UNLINK
ffa0735a: RTS
ffa0735c: ADD R1 += -0x7
ffa0735e: LOAD R0 = 0x8
ffa07360: CC = R1 < R0 (IU)
ffa07362: IF !CC JUMP 0xffa07376
ffa07364: MOVE P1 = R1
ffa07366: LOAD P0.L = 0x3660
ffa0736a: LOAD P0.H = 0xff80
ffa0736e: ADD P1 = P0 + (P1 << 2)
ffa07370: LOAD P1 = [P1]
ffa07372: JUMP (P1)
ffa07374: RAISE 0x7
ffa07376: RTS
ffa07378: RAISE 0x8
ffa0737a: RTS
ffa0737c: RAISE 0x9
ffa0737e: RTS
ffa07380: RAISE 0xa
ffa07382: RTS
ffa07384: RAISE 0xb
ffa07386: RTS
ffa07388: RAISE 0xc
ffa0738a: RTS
ffa0738c: RAISE 0xd
ffa0738e: RTS
ffa07390: RAISE 0xe
ffa07392: RTS
ffa07394: LINK 0x0
ffa07398: PUSH [--SP] = (R7:4,P5:3)
ffa0739a: MOVE P4 = R0
ffa0739c: ADD SP += -0xc
ffa0739e: LOAD P5.L = 0x75bc
ffa073a2: LOAD P5.H = 0xff80
ffa073a6: ROT|| R6 = rot R0 by 0
ffa073aa: _LOAD R0 = [P5]
ffa073ac: _NOP
ffa073ae: MOVE R4 = R2
ffa073b0: MOVE R5 = R1
ffa073b2: CALL 0xffa08cea
ffa073b6: SUB|| R1 = R1 - R1 (ns)
ffa073ba: _LOAD R2 = W [P4 + 0x10] (Z)
ffa073bc: _NOP
ffa073be: LSH|| R3.L = R2.L << 0x0
ffa073c2: LOAD P2 = [P4 + 0xc]
ffa073c4: NOP
ffa073c6: LOAD R7 = 0x18
ffa073c8: ADD R2 += 0x2
ffa073ca: MULT|| R3 = R3.L * R7.L (fu)
ffa073ce: LOAD P0 = [P4 + 0x14]
ffa073d0: NOP
ffa073d2: MOVE P3 = R3
ffa073d4: MOVE P1 = R2
ffa073d6: ADD P2 = P2 + P3
ffa073d8: LSETUP (0xffa073dc,0xffa073f0) LC0 = P1
ffa073dc: ADD P0 += 0x18
ffa073de: MOVE P1 = P0
ffa073e0: CC = P2 <= P0
ffa073e2: SUB P1 -= P3
ffa073e4: IF CC P0 = P1
ffa073e6: ADD R1 += 0x1
ffa073e8: MOVE R2 = P0
ffa073ea: STORE [P4 + 0x14] = R2
ffa073ec: LOAD R2 = [P0]
ffa073ee: CC = R2 == -0x1
ffa073f0: IF CC JUMP 0xffa07404
ffa073f2: LOAD P0 = [P4 + 0x14]
ffa073f4: ADD R1 += 0x1
ffa073f6: ADD P0 += 0x18
ffa073f8: MOVE P1 = P0
ffa073fa: CC = P2 <= P1
ffa073fc: SUB P0 -= P3
ffa073fe: IF CC P1 = P0
ffa07400: MOVE R2 = P1
ffa07402: STORE [P4 + 0x14] = R2
ffa07404: LOAD R2 = W [P4 + 0x10] (Z)
ffa07406: CC = R2 < R1 (IU)
ffa07408: LOAD R7 = 0x1
ffa0740a: BITSET (R7,0x11)
ffa0740c: IF !CC JUMP 0xffa07420
ffa0740e: CALL 0xffa08d0c
ffa07412: ADD SP += 0xc
ffa07414: MOVE R0 = R7
ffa07416: LOAD P0 = [FP + 0x4]
ffa07418: POP (R7:4,P5:3) = [SP++]
ffa0741a: UNLINK
ffa0741e: JUMP (P0)
ffa07420: LOAD P1 = [P4 + 0x14]
ffa07422: LOAD R7 = [FP + 0x1c]
ffa07424: STORE [P1] = R5
ffa07426: LOAD P3 = [P4 + 0x14]
ffa07428: CALL 0xffa08d0c
ffa0742c: LOAD P0.L = 0x1a38
ffa07430: LOAD P0.H = 0xff80
ffa07434: LOAD R1 = [P0]
ffa07436: STORE [P3 + 0x4] = R1
ffa07438: ADD R1 += 0x1
ffa0743a: LOAD R3 = [SP + 0x3c]
ffa0743c: LOAD R2 = [FP + 0x18]
ffa0743e: LOAD P1.L = 0x1a38
ffa07442: LOAD P1.H = 0xff80
ffa07446: STORE [P3 + 0x14] = R7
ffa07448: STORE [P3 + 0xc] = R3
ffa0744a: STORE [P3 + 0x10] = R2
ffa0744c: STORE [P1] = R1
ffa0744e: LOAD R0 = [P5]
ffa07450: CALL 0xffa08cea
ffa07454: ROT|| R3 = rot R0 by 0
ffa07458: _LOAD R1 = W [P4 + 0x12] (Z)
ffa0745a: _NOP
ffa0745c: CC = R1 == 0x0
ffa0745e: IF !CC JUMP 0xffa07482
ffa07460: STORE [P4 + 0x1c] = P3
ffa07462: MOVE R2 = R5.L (Z)
ffa07464: ROT|| R0 = rot R6 by 0
ffa07468: _LOAD R1 = W [P4 + 0x12] (X)
ffa0746a: _NOP
ffa0746c: ADD R1 += 0x1
ffa0746e: SUB|| R7 = R7 - R7 (ns)
ffa07472: _STORE W [P4 + 0x12] = R1
ffa07474: _NOP
ffa07476: STORE [P3 + 0x8] = R4
ffa07478: LOAD R1 = W [P4 + 0x8] (Z)
ffa0747a: CALL 0xffa0735c
ffa0747e: MOVE R0 = R3
ffa07480: JUMP.S 0xffa0740e
ffa07482: LOAD P1 = [P4 + 0x1c]
ffa07484: LOAD R0 = [P4 + 0x1c]
ffa07486: CC = R0 == 0x0
ffa07488: IF CC JUMP 0xffa07462
ffa0748a: NOP
ffa0748c: NOP
ffa0748e: NOP
ffa07490: LOAD R0 = [P1]
ffa07492: LOAD R1 = [P3]
ffa07494: CC = R1 < R0 (IU)
ffa07496: IF !CC JUMP 0xffa07462
ffa07498: STORE [P4 + 0x1c] = P3
ffa0749a: JUMP.S 0xffa07462
ffa0749c: MOVE P2 = R0
ffa0749e: PUSH [--SP] = (R7:5,P5:3)
ffa074a0: LOAD R2 = 0x4
ffa074a2: LOAD P4 = -0x1
ffa074a4: LOAD R0 = [P2 + 0x3c]
ffa074a6: CC = R0 < 0x4 (IU)
ffa074a8: IF CC JUMP 0xffa075ae
ffa074aa: CC = R0 == R2
ffa074ac: IF CC JUMP 0xffa07530
ffa074ae: LOAD R2 = 0x5
ffa074b0: CC = R0 == R2
ffa074b2: IF !CC JUMP 0xffa075b2
ffa074b4: LOAD R0 = [P2 + 0x48]
ffa074b8: CC = R0 == 0x2
ffa074ba: LOAD R2.L = 0x1a68
ffa074be: LOAD R2.H = 0xff80
ffa074c2: LOAD R0.L = 0x1a44
ffa074c6: LOAD R0.H = 0xff80
ffa074ca: IF CC R0 = R2
ffa074cc: CC = R1 == 0x0
ffa074ce: MOVE P0 = R0
ffa074d0: IF CC JUMP 0xffa07520
ffa074d2: LOAD P5 = -0x1
ffa074d4: LOAD R2 = 0x3e
ffa074d6: MOVE P1 = R1
ffa074d8: LSETUP (0xffa074dc,0xffa0751c) LC0 = P5
ffa074dc: NOP
ffa074de: NOP
ffa074e0: LOAD R0 = W [P1 + 0x2] (X)
ffa074e2: LSH|| R1.H = R0.L << 0x0
ffa074e6: LOAD R1.L = W [P1]
ffa074e8: NOP
ffa074ea: CC = R1 == 0x0
ffa074ec: LOAD R7 = B [P2 + 0x46] (Z)
ffa074f0: LOAD R0 = B [P2 + 0x45] (Z)
ffa074f4: LSH|| R6 = R0 << 0x2
ffa074f8: _LOAD R0 = W [P1 + 0x8] (X)
ffa074fa: _NOP
ffa074fc: AND R3 = R0 & R2
ffa074fe: LSH|| R0 = R7 << 0x3
ffa07502: _LOAD R7 = W [P1 + 0x12] (Z)
ffa07504: _NOP
ffa07506: ADD R0 = R0 + R6
ffa07508: IF CC JUMP 0xffa07526
ffa0750a: LSHIFT R7 <<= 0x1
ffa0750c: ADD R0 = R0 + R7
ffa0750e: MOVE P4 = R0
ffa07510: MOVE I0 = R1
ffa07512: ADD P4 = P0 + (P4 << 1)
ffa07514: LOAD R0.L = W [P4]
ffa07516: OR R0 = R3 | R0
ffa07518: STORE W [P1 + 0x8] = R0
ffa0751a: IF CC JUMP 0xffa07520
ffa0751c: MOVE P1 = I0
ffa0751e: JUMP.S 0xffa074d6
ffa07520: POP (R7:5,P5:3) = [SP++]
ffa07522: MOVE R0 = P1
ffa07524: RTS
ffa07526: LSHIFT R7 <<= 0x1
ffa07528: ADD R0 = R0 + R7
ffa0752a: ADD R0 += 0x1
ffa0752c: JUMP.S 0xffa0750e
ffa07530: LOAD R0 = [P2 + 0x48]
ffa07534: CC = R0 == 0x2
ffa07536: LOAD R0 = -0x1
ffa07538: LSHIFT R0 <<= 0x10
ffa0753a: AND R2 = R1 & R0
ffa0753c: LOAD R3.L = 0x1ab0
ffa07540: LOAD R3.H = 0xff80
ffa07544: LOAD R0.L = 0x1a8c
ffa07548: LOAD R0.H = 0xff80
ffa0754c: IF CC R0 = R3
ffa0754e: MOVE P0 = R0
ffa07550: MOVE R0 = R1.L (Z)
ffa07552: CC = R0 == 0x0
ffa07554: IF CC JUMP 0xffa07520
ffa07556: LOAD R7 = 0x3e
ffa07558: MOVE P1 = R1
ffa0755a: LSETUP (0xffa0755e,0xffa075a4) LC0 = P4
ffa0755e: LOAD R0 = B [P2 + 0x46] (Z)
ffa07562: LOAD R1 = B [P2 + 0x45] (Z)
ffa07566: LSH|| R1 = R1 << 0x2
ffa0756a: _LOAD R6 = W [P1] (Z)
ffa0756c: _NOP
ffa0756e: CC = R6 == 0x0
ffa07570: LSH|| R3 = R0 << 0x3
ffa07574: _LOAD R0 = W [P1 + 0x6] (X)
ffa07576: _NOP
ffa07578: ADD|| R5 = R3 + R1 (ns)
ffa0757c: _LOAD R1 = W [P1 + 0x10] (Z)
ffa0757e: _NOP
ffa07580: AND R3 = R0 & R7
ffa07582: IF CC JUMP 0xffa0758c
ffa07584: LSH R0 = R1 << 0x1
ffa07588: ADD R0 = R5 + R0
ffa0758a: JUMP.S 0xffa07594
ffa0758c: LSH R0 = R1 << 0x1
ffa07590: ADD R0 = R5 + R0
ffa07592: ADD R0 += 0x1
ffa07594: MOVE P3 = R0
ffa07596: OR R1 = R2 | R6
ffa07598: MOVE P5 = R1
ffa0759a: ADD P3 = P0 + (P3 << 1)
ffa0759c: LOAD R0.L = W [P3]
ffa0759e: OR R0 = R3 | R0
ffa075a0: STORE W [P1 + 0x6] = R0
ffa075a2: IF CC JUMP 0xffa075a8
ffa075a4: MOVE P1 = P5
ffa075a6: JUMP.S 0xffa07558
ffa075a8: POP (R7:5,P5:3) = [SP++]
ffa075aa: MOVE R0 = P1
ffa075ac: RTS
ffa075ae: CC = R0 == 0x3
ffa075b0: IF CC JUMP 0xffa075b8
ffa075b2: POP (R7:5,P5:3) = [SP++]
ffa075b4: LOAD R0 = 0x0
ffa075b6: RTS
ffa075b8: POP (R7:5,P5:3) = [SP++]
ffa075ba: LOAD R0 = 0x0
ffa075bc: RTS
ffa075be: MOVE P2 = R0
ffa075c0: PUSH [--SP] = (P5:4)
ffa075c2: LOAD R0 = 0x1
ffa075c4: LOAD P0 = 0x2
ffa075c6: LOAD P1.L = 0x3790
ffa075ca: LOAD P1.H = 0xff80
ffa075ce: STORE [P2 + 0x48] = R0
ffa075d2: LSETUP (0xffa075d6,0xffa075e0) LC0 = P0
ffa075d6: LOAD R2 = [P1++]
ffa075d8: CC = R1 == R2
ffa075da: IF CC JUMP 0xffa07632
ffa075dc: LOAD R2 = [P1++]
ffa075de: CC = R1 == R2
ffa075e0: IF CC JUMP 0xffa07626
ffa075e2: CC = R0 == 0x1
ffa075e4: IF CC JUMP 0xffa07610
ffa075e6: NOP
ffa075e8: LOAD P1 = [P2 + 0x30]
ffa075ea: LOAD P5 = 0x70
ffa075ee: LOAD P0 = [P1 + 0x8]
ffa075f0: LOAD P4 = [P1]
ffa075f2: LOAD R0 = [P1]
ffa075f4: CC = R0 == 0x0
ffa075f6: MOVE P1 = P0
ffa075f8: ADD P0 += 0x34
ffa075fa: IF CC JUMP 0xffa07610
ffa075fc: NOP
ffa075fe: NOP
