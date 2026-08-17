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
