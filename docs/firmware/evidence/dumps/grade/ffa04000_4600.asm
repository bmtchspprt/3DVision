ffa04000: MOVE R3 = A1.W
ffa04002: ASH A1 = A1 >>> 0x10
ffa04006: MAC R5 = (A1 += R0.H * R0.H) (is)
ffa0400a: MAC R7 = (A1 = R2.L * R2.L) (fu)
ffa0400e: LSH A1 = A1 >> 0x10
ffa04012: MAC A1 += R2.H * R2.L (m,is)
ffa04016: MAC A1 += R2.H * R2.L (m,is)
ffa0401a: MOVE R6 = A1.W
ffa0401c: ASH A1 = A1 >>> 0x10
ffa04020: PACK R1 = pack(R3.L,R1.L)
ffa04024: MAC R3 = (A1 += R2.H * R2.H) (is)
ffa04028: PACK R0 = pack(R6.L,R7.L)
ffa0402c: ADD R0 = R1 + R0
ffa0402e: MOVE CC = ac0
ffa04030: MOVE R1 = CC
ffa04032: ADD|| R1 = R5 + R1 (ns)
ffa04036: _STORE [FP + -0x3c] = R0
ffa04038: _NOP
ffa0403a: ADD|| R1 = R1 + R3 (ns)
ffa0403e: _LOAD R5 = [FP + -0x38]
ffa04040: _NOP
ffa04042: LSH|| R7 = R0 >> 0xc
ffa04046: _STORE [FP + 0x2c] = R1
ffa04048: _NOP
ffa0404a: LSH|| R2 = R1 << 0x14
ffa0404e: _LOAD R0 = [FP + -0x48]
ffa04050: _NOP
ffa04052: OR R2 = R2 | R7
ffa04054: ASH|| R6 = R1 >>> 0xc
ffa04058: _LOAD R7 = [FP + -0x4c]
ffa0405a: _NOP
ffa0405c: ADD|| R2 = R4 + R2 (ns)
ffa04060: _LOAD R4 = [FP + -0x3c]
ffa04062: _NOP
ffa04064: MOVE CC = ac0
ffa04066: MOVE R1 = CC
ffa04068: ADD|| R1 = R7 + R1 (ns)
ffa0406c: _STORE [FP + -0x50] = R2
ffa0406e: _NOP
ffa04070: ADD R0 += 0x1
ffa04072: CC = R5 < R4 (IU)
ffa04074: ADD|| R1 = R1 + R6 (ns)
ffa04078: _LOAD R3 = [FP + -0x34]
ffa0407a: _NOP
ffa0407c: LOAD R2 = [FP + 0x2c]
ffa0407e: SUB|| R0 = R3 - R2 (s)
ffa04082: STORE [FP + -0x48] = R0
ffa04084: NOP
ffa04086: MOVE CC &= az
ffa04088: MOVE CC |= an
ffa0408a: STORE [FP + -0x4c] = R1
ffa0408c: LOAD R7 = [SP + 0x2c]
ffa0408e: IF !CC JUMP 0xffa0422a
ffa04090: LOAD R0 = [FP + -0x5c]
ffa04092: CC = R0 == 0x0
ffa04094: IF CC JUMP 0xffa0422a
ffa04096: LOAD R1 = [FP + 0xc]
ffa04098: LOAD R0 = 0x0
ffa0409a: LSH R4 = R1 << 0x3
ffa0409e: PACK|| R6 = pack(R6.H,R0.L)
ffa040a2: _LOAD R2 = [FP + 0x10]
ffa040a4: _NOP
ffa040a6: MOVE R0 = R4
ffa040a8: LSH R5 = R2 << 0x3
ffa040ac: CALL 0xffa02894
ffa040b0: MOVE R7 = R0
ffa040b2: MOVE R0 = R5
ffa040b4: CALL 0xffa02894
ffa040b8: LOAD P1 = [FP + -0x40]
ffa040ba: ROT|| R0 = rot R7 by 0
ffa040be: _STORE [FP + 0xc] = R0
ffa040c0: _NOP
ffa040c2: MOVE P5 = FP
ffa040c4: ADD P3 += 0x8
ffa040c6: LOAD R1 = [P1]
ffa040c8: CALL 0xffa018f0
ffa040cc: ROT|| R7 = rot R0 by 0
ffa040d0: _LOAD P0 = [FP + -0x40]
ffa040d2: _NOP
ffa040d4: LOAD R0 = [FP + 0xc]
ffa040d6: ADD P5 += -0x28
ffa040d8: LOAD R6.H = 0x3f80
ffa040dc: LOAD R1 = [P0 + 0x4]
ffa040de: CALL 0xffa018f0
ffa040e2: MOVE R1 = R7
ffa040e4: CALL 0xffa01716
ffa040e8: ROT|| R0 = rot R4 by 0
ffa040ec: _STORE [FP + -0x60] = R0
ffa040ee: _NOP
ffa040f0: CALL 0xffa02894
ffa040f4: MOVE R7 = R0
ffa040f6: MOVE R0 = R5
ffa040f8: CALL 0xffa02894
ffa040fc: ROT|| R5 = rot R0 by 0
ffa04100: _LOAD P0 = [FP + -0x40]
ffa04102: _NOP
ffa04104: BITTGL (R7,0x1f)
ffa04106: MOVE R1 = R7
ffa04108: LOAD R0 = [P0 + 0x4]
ffa0410a: CALL 0xffa018f0
ffa0410e: ROT|| R7 = rot R0 by 0
ffa04112: _LOAD P1 = [FP + -0x40]
ffa04114: _NOP
ffa04116: MOVE R1 = R5
ffa04118: LOAD R0 = [P1]
ffa0411a: CALL 0xffa018f0
ffa0411e: MOVE R1 = R7
ffa04120: CALL 0xffa01716
ffa04124: STORE [FP + -0x64] = R0
ffa04126: LOAD R1 = 0x2
ffa04128: ROT|| R5 = rot R6 by 0
ffa0412c: _LOAD R2 = [P5++]
ffa0412e: _NOP
ffa04130: LSH|| R4 = R2 << 0x3
ffa04134: _LOAD R3 = [P5++]
ffa04136: _NOP
ffa04138: LSHIFT R3 <<= 0x3
ffa0413a: LOAD R0 = 0xff
ffa0413e: LSH|| R0 = R0 << 0x17
ffa04142: _STORE [FP + 0xc] = R3
ffa04144: _NOP
ffa04146: ROT|| R0 = rot R4 by 0
ffa0414a: _STORE [FP + 0x8] = R0
ffa0414c: _NOP
ffa0414e: ADD R1 += -0x1
ffa04150: STORE [FP + 0x10] = R1
ffa04152: CALL 0xffa02894
ffa04156: ROT|| R7 = rot R0 by 0
ffa0415a: _LOAD R0 = [FP + 0xc]
ffa0415c: _NOP
ffa0415e: CALL 0xffa02894
ffa04162: MOVE R1 = R7
ffa04164: ROT|| R7 = rot R0 by 0
ffa04168: _LOAD R0 = [P3++]
ffa0416a: _NOP
ffa0416c: CALL 0xffa018f0
ffa04170: ROT|| R0 = rot R7 by 0
ffa04174: _STORE [FP + 0x1c] = R0
ffa04176: _NOP
ffa04178: LOAD R1 = [P3]
ffa0417a: CALL 0xffa018f0
ffa0417e: BITCLR (R5,0x1f)
ffa04180: LOAD R1 = [FP + 0x1c]
ffa04182: CALL 0xffa01716
ffa04186: ROT|| R0 = rot R4 by 0
ffa0418a: _STORE [FP + 0x1c] = R0
ffa0418c: _NOP
ffa0418e: CALL 0xffa02894
ffa04192: ROT|| R7 = rot R0 by 0
ffa04196: _LOAD R0 = [FP + 0xc]
ffa04198: _NOP
ffa0419a: CALL 0xffa02894
ffa0419e: ROT|| R4 = rot R0 by 0
ffa041a2: _LOAD R0 = [P3++]
ffa041a4: _NOP
ffa041a6: MOVE R1 = R7
ffa041a8: CALL 0xffa018f0
ffa041ac: MOVE R7 = R0
ffa041ae: MOVE R1 = R4
ffa041b0: LOAD R0 = [P3 + -0x8]
ffa041b4: CALL 0xffa018f0
ffa041b8: MOVE R1 = R0
ffa041ba: MOVE R0 = R7
ffa041bc: CALL 0xffa01714
ffa041c0: ROT|| R7 = rot R0 by 0
ffa041c4: _LOAD R1 = [FP + -0x60]
ffa041c6: _NOP
ffa041c8: LOAD R0 = [FP + 0x1c]
ffa041ca: CALL 0xffa018f0
ffa041ce: ROT|| R4 = rot R0 by 0
ffa041d2: _LOAD R1 = [FP + -0x64]
ffa041d4: _NOP
ffa041d6: MOVE R0 = R7
ffa041d8: CALL 0xffa018f0
ffa041dc: MOVE R1 = R0
ffa041de: MOVE R0 = R4
ffa041e0: CALL 0xffa01714
ffa041e4: ROT|| R1 = rot R0 by 0
ffa041e8: _LOAD R3 = [FP + 0x8]
ffa041ea: _NOP
ffa041ec: BITCLR (R1,0x1f)
ffa041ee: CC = R3 < R1
ffa041f0: MOVE R4 = CC
ffa041f2: CC = R3 < R5
ffa041f4: LOAD R2 = 0x1
ffa041f6: OR R7 = R1 | R5
ffa041f8: IF !CC R2 = R4
ffa041fa: CC = R6 < R0
ffa041fc: AND R1 = R0 & R6
ffa041fe: LSH|| R1 = R1 >> 0x1f
ffa04202: _LOAD R4 = [FP + 0x10]
ffa04204: _NOP
ffa04206: MOVE R3 = CC
ffa04208: CC = R0 == R6
ffa0420a: XOR R1 = R1 ^ R3
ffa0420c: IF !CC R3 = R1
ffa0420e: CC = R7 == 0x0
ffa04210: IF CC R3 = R7
ffa04212: CC = BITTST (R2,0x0)
ffa04214: LOAD R5 = 0x0
ffa04216: IF CC R3 = R5
ffa04218: CC = BITTST (R3,0x0)
ffa0421a: IF CC R0 = R6
ffa0421c: CC = R4 == 0x0
ffa0421e: ROT|| R6 = rot R0 by 0
ffa04222: _LOAD R1 = [FP + 0x10]
ffa04224: _NOP
ffa04226: IF !CC JUMP 0xffa04128
ffa04228: MOVE R7 = R0
ffa0422a: LOAD R3 = [FP + -0x38]
ffa0422c: LOAD R4 = [FP + -0x3c]
ffa0422e: CC = R3 < R4 (IU)
ffa04230: LOAD R1 = [FP + 0x2c]
ffa04232: LOAD R2 = [FP + -0x34]
ffa04234: SUB|| R1 = R2 - R1 (s)
ffa04238: LOAD R5 = [FP + -0x58]
ffa0423a: NOP
ffa0423c: MOVE CC &= az
ffa0423e: MOVE CC |= an
ffa04240: LOAD R6 = [FP + -0x54]
ffa04242: LOAD R0 = [FP + -0x38]
ffa04244: LOAD R4 = [FP + -0x34]
ffa04246: IF !CC JUMP 0xffa04282
ffa04248: LOAD R0 = [FP + -0x5c]
ffa0424a: CC = R0 == 0x0
ffa0424c: IF !CC JUMP 0xffa04368
ffa0424e: LOAD R0 = [FP + -0x5c]
ffa04250: CC = R0 == 0x0
ffa04252: IF !CC JUMP 0xffa04358
ffa04254: LOAD P5 = [FP + -0x40]
ffa04256: LOAD R6 = 0x3
ffa04258: ADD R6 += -0x1
ffa0425a: LOAD R0 = [P4++]
ffa0425c: LSH|| R0 = R0 << 0x3
ffa04260: _LOAD R5 = [P4++]
ffa04262: _NOP
ffa04264: CALL 0xffa02894
ffa04268: LSH|| R0 = R5 << 0x3
ffa0426c: _STORE [P5++] = R0
ffa0426e: _NOP
ffa04270: CALL 0xffa02894
ffa04274: CC = R6 == 0x0
ffa04276: STORE [P5++] = R0
ffa04278: IF !CC JUMP 0xffa04258 (bp)
ffa0427a: LOAD R5 = [FP + -0x44]
ffa0427c: LOAD R0 = [FP + -0x3c]
ffa0427e: LOAD R6 = [FP + -0x6c]
ffa04280: LOAD R4 = [FP + 0x2c]
ffa04282: LOAD R2 = [FP + -0x44]
ffa04284: LOAD R3 = [FP + -0x68]
ffa04286: ADD|| R2 = R3 + R2 (ns)
ffa0428a: _LOAD R1 = [FP + -0x70]
ffa0428c: _NOP
ffa0428e: CC = R2 <= R1
ffa04290: LOAD R1 = [FP + 0x24]
ffa04292: SUB|| R1 = R1 - R3 (ns)
ffa04296: _STORE [FP + -0x58] = R5
ffa04298: _NOP
ffa0429a: STORE [FP + -0x54] = R6
ffa0429c: STORE [FP + -0x38] = R0
ffa0429e: STORE [FP + -0x34] = R4
ffa042a0: STORE [SP + 0x2c] = R7
ffa042a2: STORE [FP + -0x44] = R2
ffa042a4: STORE [FP + 0x24] = R1
ffa042a6: IF !CC JUMP 0xffa042aa
ffa042a8: JUMP.S 0xffa03dda
ffa042aa: LOAD R3 = [FP + -0x50]
ffa042ac: STORE [SP + 0x2c] = R3
ffa042ae: LOAD R1 = [FP + -0x4c]
ffa042b0: LOAD R2 = [FP + -0x6c]
ffa042b2: LOAD R3 = [SP + 0x44]
ffa042b6: ADD|| R2 = R3 + R2 (ns)
ffa042ba: _LOAD R3 = [SP + 0x2c]
ffa042bc: _NOP
ffa042be: STORE [FP + -0x50] = R3
ffa042c0: LOAD R3 = [SP + 0x48]
ffa042c4: STORE [FP + -0x6c] = R2
ffa042c6: CC = R2 < R3
ffa042c8: STORE [SP + 0x28] = R0
ffa042ca: STORE [FP + -0x34] = R4
ffa042cc: STORE [FP + -0x4c] = R1
ffa042ce: IF !CC JUMP 0xffa042d2
ffa042d0: JUMP.S 0xffa03d66
ffa042d2: ROT|| R7 = rot R0 by 0
ffa042d6: _LOAD R2 = [SP + 0x2c]
ffa042d8: _NOP
ffa042da: STORE [FP + -0x74] = R1
ffa042dc: STORE [FP + -0x6c] = R2
ffa042de: LOAD R2 = 0x1
ffa042e0: LOAD R1 = 0x0
ffa042e2: LOAD R0 = 0x1
ffa042e4: CALL 0xffa06008
ffa042e8: MOVE R0 = R6
ffa042ea: CALL 0xffa02894
ffa042ee: LOAD R1 = [SP + 0x38]
ffa042f0: CALL 0xffa018f0
ffa042f4: LOAD P1 = [SP + 0x34]
ffa042f6: ROT|| R0 = rot R5 by 0
ffa042fa: _STORE [P1 + 0x4] = R0
ffa042fc: _NOP
ffa042fe: CALL 0xffa02894
ffa04302: LOAD R1 = [SP + 0x38]
ffa04304: CALL 0xffa018f0
ffa04308: ROT|| R1 = rot R4 by 0
ffa0430c: _LOAD P0 = [SP + 0x34]
ffa0430e: _NOP
ffa04310: ROT|| R0 = rot R7 by 0
ffa04314: _STORE [P0 + 0x8] = R0
ffa04316: _NOP
ffa04318: CALL 0xffa015b4
ffa0431c: MOVE R7 = R0
ffa0431e: LOAD R1 = [FP + -0x74]
ffa04320: LOAD R0 = [FP + -0x6c]
ffa04322: CALL 0xffa015b4
ffa04326: LOAD R1 = 0x0
ffa04328: LOAD R1.H = 0x4580
ffa0432c: CALL 0xffa018f0
ffa04330: MOVE R6 = R0
ffa04332: LOAD R0 = [FP + -0x48]
ffa04334: CALL 0xffa01688
ffa04338: MOVE R1 = R0
ffa0433a: MOVE R0 = R6
ffa0433c: CALL 0xffa01814
ffa04340: MOVE R1 = R0
ffa04342: MOVE R0 = R7
ffa04344: CALL 0xffa01714
ffa04348: LOAD P1 = [SP + 0x30]
ffa0434a: STORE [P1] = R0
ffa0434c: ADD SP += 0xc
ffa0434e: POP (R7:4,P5:3) = [SP++]
ffa04350: UNLINK
ffa04354: LOAD R0 = 0x0
ffa04356: RTS
ffa04358: LOAD P1 = [SP + 0x3c]
ffa0435a: LOAD R0 = [FP + -0x3c]
ffa0435c: LOAD R4 = [FP + 0x2c]
ffa0435e: STORE [P1] = R7
ffa04360: LOAD R5 = [FP + -0x44]
ffa04362: LOAD R6 = [FP + -0x6c]
ffa04364: JUMP.S 0xffa04282
ffa04368: ROT|| R0 = rot R7 by 0
ffa0436c: _LOAD R1 = [FP + -0x78]
ffa0436e: _NOP
ffa04370: LOAD R2 = 0xff
ffa04374: LSH R5 = R2 << 0x17
ffa04378: BITCLR (R1,0x1f)
ffa0437a: CC = R5 < R1
ffa0437c: BITCLR (R0,0x1f)
ffa0437e: MOVE R4 = CC
ffa04380: CC = R5 < R0
ffa04382: OR R6 = R1 | R0
ffa04384: LOAD R2 = 0x1
ffa04386: LOAD R3 = [FP + -0x78]
ffa04388: LOAD R1 = [FP + -0x78]
ffa0438a: IF !CC R2 = R4
ffa0438c: CC = R7 <= R1
ffa0438e: AND R3 = R3 & R7
ffa04390: LSH|| R3 = R3 >> 0x1f
ffa04394: _LOAD R5 = [FP + -0x78]
ffa04396: _NOP
ffa04398: MOVE R1 = CC
ffa0439a: CC = R5 == R7
ffa0439c: XOR R3 = R3 ^ R1
ffa0439e: IF !CC R1 = R3
ffa043a0: CC = R6 == 0x0
ffa043a2: LOAD R0 = 0x1
ffa043a4: IF CC R1 = R0
ffa043a6: CC = BITTST (R2,0x0)
ffa043a8: LOAD R5 = 0x0
ffa043aa: IF CC R1 = R5
ffa043ac: CC = BITTST (R1,0x0)
ffa043ae: IF CC JUMP 0xffa0424e (bp)
ffa043b0: LOAD R5 = [FP + -0x58]
ffa043b2: LOAD R6 = [FP + -0x54]
ffa043b4: LOAD R0 = [FP + -0x38]
ffa043b6: LOAD R4 = [FP + -0x34]
ffa043b8: JUMP.S 0xffa04282
ffa043ba: LOAD R0 = [FP + -0x7c]
ffa043bc: CALL 0xffa05ee4
ffa043c0: STORE [FP + -0x68] = R0
ffa043c2: JUMP.S 0xffa03da8
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
ffa04682: PUSH [--SP] = (R7:4,P5:3)
ffa04684: ADD SP += -0x20
ffa04686: LOAD P5 = [FP + 0x1c]
ffa04688: LOAD P1.L = 0x5060
ffa0468c: LOAD P1.H = 0x2021
ffa04690: LOAD P2 = 0x8514
ffa04694: LOAD P4 = 0x8a30
ffa04698: ADD P2 = P1 + P2
ffa0469a: STORE [FP + -0x44] = P1
ffa0469c: ADD P4 = P1 + P4
ffa0469e: LOAD P1 = 0x4c08
ffa046a2: LOAD P1.H = 0x3
ffa046a6: ADD P5 = P5 + P1
ffa046a8: STORE [FP + 0x10] = R0
ffa046aa: STORE [FP + 0x8] = R2
ffa046ac: LOAD R2 = W [P5] (X)
ffa046ae: LOAD R0 = 0x5cfc
ffa046b2: LOAD P3.L = 0x4864
ffa046b6: LOAD P3.H = 0xff80
ffa046ba: MULT|| R0 = R2.L * R0.L (is)
ffa046be: STORE [FP + -0x5c] = P3
ffa046c0: NOP
ffa046c2: MOVE P1 = R0
ffa046c4: LOAD P3 = [FP + 0x1c]
ffa046c6: LOAD P0 = 0x578
ffa046ca: STORE [FP + -0x24] = R1
ffa046cc: LOAD R1 = 0x0
ffa046ce: ADD P0 = P3 + P0
ffa046d0: PACK|| R7 = pack(R7.H,R1.L)
ffa046d4: _STORE [FP + -0x48] = P2
ffa046d6: _NOP
ffa046d8: ADD P2 = P0 + P1
ffa046da: LOAD R7.H = 0x4700
ffa046de: LOAD R0 = [P2 + 0x5cd4]
ffa046e2: MOVE R1 = R7
ffa046e4: CALL 0xffa01814
ffa046e8: ROT|| R1 = rot R7 by 0
ffa046ec: _STORE [FP + -0x2c] = R0
ffa046ee: _NOP
ffa046f0: LOAD R0 = [P2 + 0x5cdc]
ffa046f4: CALL 0xffa01814
ffa046f8: ROT|| R1 = rot R7 by 0
ffa046fc: _STORE [FP + -0x14] = R0
ffa046fe: _NOP
ffa04700: LOAD R0 = [P2 + 0x5ce0]
ffa04704: CALL 0xffa01814
ffa04708: ROT|| R1 = rot R7 by 0
ffa0470c: _STORE [FP + -0x10] = R0
ffa0470e: _NOP
ffa04710: LOAD R0 = [P2 + 0x5ce4]
ffa04714: CALL 0xffa01814
ffa04718: ROT|| R1 = rot R7 by 0
ffa0471c: _LOAD P1 = [FP + 0x18]
ffa0471e: _NOP
ffa04720: LOAD R2 = [FP + -0x2c]
ffa04722: STORE [FP + -0xc] = R0
ffa04724: LOAD R0 = [P2 + 0x5cf8]
ffa04728: STORE [FP + -0x28] = P1
ffa0472a: STORE [FP + -0x40] = P3
ffa0472c: STORE [FP + -0x18] = R2
ffa0472e: CALL 0xffa01814
ffa04732: ROT|| R4 = rot R0 by 0
ffa04736: _STORE [FP + -0x8] = R0
ffa04738: _NOP
ffa0473a: LOAD R0 = [P2 + 0x5cf4]
ffa0473e: MOVE R1 = R7
ffa04740: CALL 0xffa01814
ffa04744: ROT|| R5 = rot R0 by 0
ffa04748: _STORE [FP + -0x4] = R0
ffa0474a: _NOP
ffa0474c: LOAD R1 = [FP + -0x40]
ffa0474e: LOAD R0 = [FP + -0x28]
ffa04750: STORE [FP + 0xc] = P0
ffa04752: LOAD P1.L = 0xd05e
ffa04756: LOAD P1.H = 0x2022
ffa0475a: CALL (P1)
ffa0475c: LOAD R2 = [FP + 0x28]
ffa0475e: LOAD R3 = 0x7
ffa04760: CC = R2 == R3
ffa04762: IF CC JUMP 0xffa04766 (bp)
ffa04764: JUMP.S 0xffa054c6
ffa04766: LOAD R0 = 0x578
ffa0476a: LOAD R1 = [FP + -0x40]
ffa0476c: LOAD P1 = 0x147
ffa04770: ADD R6 = R1 + R0
ffa04772: MOVE I0 = P4
ffa04774: LOAD P3 = [FP + -0x48]
ffa04776: LOAD R7 = 0x0
ffa04778: LSETUP (0xffa0477c,0xffa047c4) LC0 = P1
ffa0477c: LOAD R0 = W [P5] (X)
ffa0477e: LOAD R1 = 0x5cfc
ffa04782: MULT R0 = R0.L * R1.L (is)
ffa04786: ADD R0 = R6 + R0
ffa04788: LOAD R2 = 0x5a26
ffa0478c: ADD R0 = R0 + R2
ffa0478e: ADD R0 = R0 + R7
ffa04790: MOVE P1 = R0
ffa04792: LOAD R0 = W [P1] (X)
ffa04794: CALL 0xffa01688
ffa04798: MOVE R1 = R4
ffa0479a: CALL 0xffa018f0
ffa0479e: STORE [I0++] = R0
ffa047a0: LOAD R0 = W [P5] (X)
ffa047a2: LOAD R1 = 0x5cfc
ffa047a6: MULT R0 = R0.L * R1.L (is)
ffa047aa: ADD R0 = R6 + R0
ffa047ac: LOAD R2 = 0x5798
ffa047b0: ADD R0 = R0 + R2
ffa047b2: ADD R0 = R0 + R7
ffa047b4: MOVE P1 = R0
ffa047b6: ADD R7 += 0x2
ffa047b8: LOAD R0 = W [P1] (X)
ffa047ba: CALL 0xffa01688
ffa047be: MOVE R1 = R5
ffa047c0: CALL 0xffa018f0
ffa047c4: STORE [P3++] = R0
ffa047c6: LOAD P1 = [FP + -0x5c]
ffa047c8: LOAD R0 = 0x147
ffa047cc: ADD P1 += -0x6
ffa047ce: STORE W [P1] = R0.L
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
ffa04892: CC = R3 == R1
ffa04894: LOAD R7 = W [P0 + -0x6] (X)
ffa04898: IF !CC JUMP 0xffa0489c (bp)
ffa0489a: JUMP.S 0xffa04f6e
ffa0489c: LOAD R0 = 0x5
ffa0489e: LOAD R1 = [FP + 0x28]
ffa048a0: CC = R1 == R0
ffa048a2: IF CC JUMP 0xffa048a6 (bp)
ffa048a4: JUMP.S 0xffa04efe
ffa048a6: LOAD P1 = [FP + 0x2c]
ffa048a8: LOAD P0 = [FP + 0x18]
ffa048aa: LOAD P2 = [FP + -0x5c]
ffa048ac: LOAD R0 = [P1 + 0xc]
ffa048ae: LOAD R1 = [P0 + 0x18]
ffa048b0: SUB R0 = R0 - R1
ffa048b2: LOAD R4 = [P2]
ffa048b4: CC = R0 <= R4
ffa048b6: IF !CC JUMP 0xffa04930
ffa048b8: ASH|| R2 = R4 >>> 0x13
ffa048bc: _LOAD R0 = [P1 + 0x8]
ffa048be: _NOP
ffa048c0: SUB R0 = R0 - R1
ffa048c2: ASHIFT R0 >>>= 0x13
ffa048c4: CC = R2 < R0
ffa048c6: IF !CC JUMP 0xffa04930
ffa048c8: LOAD R0 = B [P1 + 0x4] (Z)
ffa048cc: CC = R0 == 0x0
ffa048ce: STORE [P2 + 0x4] = R2
ffa048d0: IF !CC JUMP 0xffa048d4 (bp)
ffa048d2: JUMP.S 0xffa04ee8
ffa048d4: LOAD R5 = [P2 + 0x14]
ffa048d6: CC = !BITTST (R5,0x1f)
ffa048d8: LOAD R1 = 0x0
ffa048da: LOAD R1.H = 0x7f80
ffa048de: MOVE R0 = CC
ffa048e0: CC = R5 <= R1
ffa048e2: LOAD R6 = 0x0
ffa048e4: IF !CC R0 = R6
ffa048e6: CC = R5 == 0x0
ffa048e8: IF CC R0 = R5
ffa048ea: CC = BITTST (R0,0x0)
ffa048ec: IF CC JUMP 0xffa048f0 (bp)
ffa048ee: JUMP.S 0xffa04ee0
ffa048f0: LOAD R0 = B [P1 + 0x2] (Z)
ffa048f4: CC = R0 == 0x0
ffa048f6: IF CC JUMP 0xffa04920
ffa048f8: LOAD R0 = W [P5] (X)
ffa048fa: LOAD R1 = 0x5cfc
ffa048fe: MULT R0 = R0.L * R1.L (is)
ffa04902: MOVE P1 = R0
ffa04904: LOAD P3 = [FP + 0xc]
ffa04906: LOAD P2.L = 0x2cdc
ffa0490a: LOAD P2.H = 0xff80
ffa0490e: LOAD P0.L = 0x2cf0
ffa04912: LOAD P0.H = 0xff80
ffa04916: STORE [FP + -0x38] = P2
ffa04918: ADD P1 = P3 + P1
ffa0491a: LOAD R0 = [P1 + 0x4]
ffa0491c: JUMP.L 0xffa072e0
ffa04920: LOAD P0 = [P2 + 0x4]
ffa04922: MOVE R1 = R5
ffa04924: LOAD P2 = [FP + 0x2c]
ffa04926: LOAD R0 = [P2 + 0x10]
ffa04928: CALL 0xffa01814
ffa0492c: ADD P1 = P4 + (P0 << 2)
ffa0492e: STORE [P1] = R0
ffa04930: LOAD P1 = [FP + -0x5c]
ffa04932: ADD R7 += 0x1
ffa04934: MOVE R0 = R7.L (X)
ffa04936: LOAD R1 = [FP + 0x8]
ffa04938: CC = R0 <= R1
ffa0493a: STORE W [P1 + -0x6] = R7
ffa0493e: IF CC JUMP 0xffa0482c (bp)
ffa04940: LOAD R2 = 0x1
ffa04942: LOAD R1 = 0x0
ffa04944: LOAD R0 = 0x1
ffa04946: CALL 0xffa06008
ffa0494a: LOAD P1 = [FP + 0x18]
ffa0494c: LOAD P0 = [FP + -0x5c]
ffa0494e: LOAD R7 = 0x0
ffa04950: LOAD R0 = [P1 + 0xc]
ffa04952: ASH|| R6 = R0 >>> 0xf
ffa04956: _STORE [FP + 0x8] = R0
ffa04958: _NOP
ffa0495a: ADD R6 += 0x1
ffa0495c: CC = R6 <= 0x0
ffa0495e: STORE W [P0 + -0x6] = R7
ffa04962: IF CC JUMP 0xffa049b4
ffa04964: MOVE P1 = R6
ffa04966: LOAD P0 = [FP + -0x44]
ffa04968: LOAD R3 = 0xff
ffa0496c: LSHIFT R3 <<= 0x17
ffa0496e: LOAD R2 = [FP + -0x2c]
ffa04970: LSETUP (0xffa04974,0xffa049b0) LC0 = P1
