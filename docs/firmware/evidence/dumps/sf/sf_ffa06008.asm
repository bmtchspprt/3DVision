ffa06008: LINK 0x5c
ffa0600c: PUSH [--SP] = (R7:4,P5:3)
ffa0600e: ADD SP += -0x10
ffa06010: STORE B [FP + 0x10] = R2
ffa06014: STORE [FP + 0xc] = R1
ffa06016: STORE [FP + 0x8] = R0
ffa06018: MOVE P1 = FP
ffa0601a: ADD P1 += -0x3c
ffa0601c: MOVE R2 = CYCLES
ffa0601e: MOVE R1 = CYCLES2
ffa06020: STORE [P1] = R2
ffa06022: STORE [P1 + 0x4] = R1
ffa06024: LOAD R0 = [FP + -0x3c]
ffa06026: LOAD R1 = [FP + -0x38]
ffa06028: STORE [FP + -0x44] = R0
ffa0602a: STORE [FP + -0x40] = R1
ffa0602c: STORE [FP + -0xc] = R0
ffa0602e: STORE [FP + -0x8] = R0
ffa06030: LOAD P1 = 0x208
ffa06034: LOAD P1.H = 0xffc0
ffa06038: LOAD R6 = 0x0
ffa0603a: STORE [P1] = R6
ffa0603c: LOAD R0 = [FP + 0xc]
ffa0603e: CC = R0 == 0x0
ffa06040: IF CC JUMP 0xffa0604e
ffa06042: LOAD P1.L = 0x6eec
ffa06046: LOAD P1.H = 0xff80
ffa0604a: STORE [P1] = R0
ffa0604c: JUMP.S 0xffa0604e
ffa0604e: LOAD R0 = [FP + 0x8]
ffa06050: CC = R0 == 0x0
ffa06052: IF !CC JUMP 0xffa0608e
ffa06054: NOP
ffa06056: NOP
ffa06058: LOAD P1.L = 0x6ee0
ffa0605c: LOAD P1.H = 0xff80
ffa06060: LOAD R0 = [P1]
ffa06062: CC = !BITTST (R0,0x0)
ffa06064: IF CC JUMP 0xffa06070 (bp)
ffa06066: BITCLR (R0,0x0)
ffa06068: STORE [P1] = R0
ffa0606a: LOAD R1 = 0x1
ffa0606c: STORE [FP + -0x4] = R1
ffa0606e: JUMP.S 0xffa0645a
ffa06070: CC = !BITTST (R0,0x1)
ffa06072: IF CC JUMP 0xffa0607e (bp)
ffa06074: BITCLR (R0,0x1)
ffa06076: STORE [P1] = R0
ffa06078: LOAD R1 = 0x2
ffa0607a: STORE [FP + -0x4] = R1
ffa0607c: JUMP.S 0xffa0645a
ffa0607e: CC = !BITTST (R0,0x5)
ffa06080: IF CC JUMP 0xffa0608c (bp)
ffa06082: BITCLR (R0,0x5)
ffa06084: STORE [P1] = R0
ffa06086: LOAD R1 = 0x20
ffa06088: STORE [FP + -0x4] = R1
ffa0608a: JUMP.S 0xffa0645a
ffa0608c: JUMP.S 0xffa06058
ffa0608e: LOAD P5.L = 0x1a30
ffa06092: LOAD P5.H = 0xff80
ffa06096: LOAD R0 = [P5]
ffa06098: ASH R1 = R0 >>> 0x1f
ffa0609c: CC = R0 == -0x1
ffa0609e: NOT R1 = ~R1
ffa060a0: MOVE CC &= az
ffa060a2: IF CC JUMP 0xffa060b6
ffa060a4: NOP
ffa060a6: NOP
ffa060a8: NOP
ffa060aa: LOAD R0 = [P5]
ffa060ac: ASH R1 = R0 >>> 0x1f
ffa060b0: STORE [FP + -0x54] = R0
ffa060b2: STORE [FP + -0x50] = R1
ffa060b4: JUMP.S 0xffa060c6
ffa060b6: LOAD P1.L = 0x2e80
ffa060ba: LOAD P1.H = 0xff80
ffa060be: LOAD R0 = [P1++]
ffa060c0: LOAD R1 = [P1]
ffa060c2: STORE [FP + -0x54] = R0
ffa060c4: STORE [FP + -0x50] = R1
ffa060c6: LOAD R7 = [FP + 0x8]
ffa060c8: LOAD R2 = [FP + -0x54]
ffa060ca: LOAD R3 = [FP + -0x50]
ffa060cc: LSH R1 = R3 << 0xd
ffa060d0: LSH R2 = R2 >> 0x13
ffa060d4: OR R2 = R1 | R2
ffa060d6: ASH R3 = R3 >>> 0x13
ffa060da: LOAD P1.L = 0x2e88
ffa060de: LOAD P1.H = 0xff80
ffa060e2: LOAD R0 = [P1++]
ffa060e4: LOAD R1 = [P1]
ffa060e6: STORE [SP + 0xc] = R3
ffa060e8: CALL 0xffa01150
ffa060ec: CC = R7 <= R0 (IU)
ffa060ee: SUB R1 = R6 - R1 (s)
ffa060f2: MOVE CC &= az
ffa060f4: MOVE CC |= an
ffa060f6: IF CC JUMP 0xffa061aa
ffa060f8: NOP
ffa060fa: NOP
ffa060fc: NOP
ffa060fe: LOAD R0 = [P5]
ffa06100: ASH R1 = R0 >>> 0x1f
ffa06104: CC = R0 == -0x1
ffa06106: NOT R1 = ~R1
ffa06108: MOVE CC &= az
ffa0610a: IF CC JUMP 0xffa0611e
ffa0610c: NOP
ffa0610e: NOP
ffa06110: NOP
ffa06112: LOAD R0 = [P5]
ffa06114: ASH R1 = R0 >>> 0x1f
ffa06118: STORE [FP + -0x54] = R0
ffa0611a: STORE [FP + -0x50] = R1
ffa0611c: JUMP.S 0xffa0612e
ffa0611e: LOAD P1.L = 0x2e90
ffa06122: LOAD P1.H = 0xff80
ffa06126: LOAD R0 = [P1++]
ffa06128: LOAD R1 = [P1]
ffa0612a: STORE [FP + -0x54] = R0
ffa0612c: STORE [FP + -0x50] = R1
ffa0612e: LOAD R2 = [FP + -0x54]
ffa06130: LOAD R3 = [FP + -0x50]
ffa06132: LSH R7 = R3 << 0xd
ffa06136: LSH R2 = R2 >> 0x13
ffa0613a: OR R2 = R7 | R2
ffa0613c: ASH R3 = R3 >>> 0x13
ffa06140: LOAD P1.L = 0x2e98
ffa06144: LOAD P1.H = 0xff80
ffa06148: LOAD R0 = [P1++]
ffa0614a: LOAD R1 = [P1]
ffa0614c: STORE [SP + 0xc] = R3
ffa0614e: CALL 0xffa01150
ffa06152: LOAD R7 = [FP + 0x8]
ffa06154: SUB R0 = R7 - R0 (ns)
ffa06158: STORE [FP + 0x8] = R0
ffa0615a: LOAD R0 = [P5]
ffa0615c: ASH R1 = R0 >>> 0x1f
ffa06160: CC = R0 == -0x1
ffa06162: NOT R1 = ~R1
ffa06164: MOVE CC &= az
ffa06166: IF CC JUMP 0xffa0617a
ffa06168: NOP
ffa0616a: NOP
ffa0616c: NOP
ffa0616e: LOAD R0 = [P5]
ffa06170: ASH R1 = R0 >>> 0x1f
ffa06174: STORE [FP + -0x54] = R0
ffa06176: STORE [FP + -0x50] = R1
ffa06178: JUMP.S 0xffa0618a
ffa0617a: LOAD P1.L = 0x2ea0
ffa0617e: LOAD P1.H = 0xff80
ffa06182: LOAD R0 = [P1++]
ffa06184: LOAD R1 = [P1]
ffa06186: STORE [FP + -0x54] = R0
ffa06188: STORE [FP + -0x50] = R1
ffa0618a: LOAD R0 = [FP + 0x8]
ffa0618c: LOAD R2 = [FP + -0x54]
ffa0618e: LOAD R1 = [FP + -0x50]
ffa06190: STORE [SP + 0xc] = R1
ffa06192: LOAD R1 = 0x0
ffa06194: CALL 0xffa01c38
ffa06198: STORE [FP + -0x5c] = R0
ffa0619a: STORE [FP + -0x58] = R1
ffa0619c: LSH R2 = R1 << 0x2
ffa061a0: LSH R3 = R0 >> 0x1e
ffa061a4: OR R2 = R3 | R2
ffa061a6: STORE [FP + -0x10] = R2
ffa061a8: JUMP.S 0xffa061f8
ffa061aa: LOAD R0 = [P5]
ffa061ac: ASH R1 = R0 >>> 0x1f
ffa061b0: CC = R0 == -0x1
ffa061b2: NOT R1 = ~R1
ffa061b4: MOVE CC &= az
ffa061b6: IF CC JUMP 0xffa061ca
ffa061b8: NOP
ffa061ba: NOP
ffa061bc: NOP
ffa061be: LOAD R0 = [P5]
ffa061c0: ASH R1 = R0 >>> 0x1f
ffa061c4: STORE [FP + -0x54] = R0
ffa061c6: STORE [FP + -0x50] = R1
ffa061c8: JUMP.S 0xffa061da
ffa061ca: LOAD P1.L = 0x2ea8
ffa061ce: LOAD P1.H = 0xff80
ffa061d2: LOAD R0 = [P1++]
ffa061d4: LOAD R1 = [P1]
ffa061d6: STORE [FP + -0x54] = R0
ffa061d8: STORE [FP + -0x50] = R1
ffa061da: LOAD R0 = [FP + 0x8]
ffa061dc: LOAD R2 = [FP + -0x54]
ffa061de: LOAD R1 = [FP + -0x50]
ffa061e0: STORE [SP + 0xc] = R1
ffa061e2: LOAD R1 = 0x0
ffa061e4: CALL 0xffa01c38
ffa061e8: STORE [FP + -0x5c] = R0
ffa061ea: STORE [FP + -0x58] = R1
ffa061ec: LSH R2 = R1 << 0xc
ffa061f0: LSH R3 = R0 >> 0x14
ffa061f4: OR R2 = R3 | R2
ffa061f6: STORE [FP + -0x10] = R2
ffa061f8: LOAD R0 = [P5]
ffa061fa: ASH R1 = R0 >>> 0x1f
ffa061fe: CC = R0 == -0x1
ffa06200: NOT R1 = ~R1
ffa06202: MOVE CC &= az
ffa06204: IF CC JUMP 0xffa06218
ffa06206: NOP
ffa06208: NOP
ffa0620a: NOP
ffa0620c: LOAD R0 = [P5]
ffa0620e: ASH R1 = R0 >>> 0x1f
ffa06212: STORE [FP + -0x4c] = R0
ffa06214: STORE [FP + -0x48] = R1
ffa06216: JUMP.S 0xffa06228
ffa06218: LOAD P1.L = 0x2eb0
ffa0621c: LOAD P1.H = 0xff80
ffa06220: LOAD R0 = [P1++]
ffa06222: LOAD R1 = [P1]
ffa06224: STORE [FP + -0x4c] = R0
ffa06226: STORE [FP + -0x48] = R1
ffa06228: LOAD R0 = [FP + -0x10]
ffa0622a: LOAD R1 = [FP + -0x4c]
ffa0622c: LOAD R2 = [FP + -0x48]
ffa0622e: LSH R2 = R2 << 0xd
ffa06232: LSH R1 = R1 >> 0x13
ffa06236: OR R1 = R2 | R1
ffa06238: SUB R0 = R0 - R1 (ns)
ffa0623c: STORE [FP + -0x14] = R0
ffa0623e: LOAD R3 = B [FP + 0x10] (Z)
ffa06242: CC = R3 == 0x0
ffa06244: IF CC JUMP 0xffa0624c (bp)
ffa06246: CALL 0xffa0316c
ffa0624a: JUMP.S 0xffa0624c
ffa0624c: LOAD R0 = B [FP + 0x10] (Z)
ffa06250: CC = R0 == 0x0
ffa06252: IF CC JUMP 0xffa06432
ffa06254: LOAD R0 = [FP + -0x8]
ffa06256: LOAD R1 = [FP + -0xc]
ffa06258: SUB R0 = R0 - R1 (ns)
ffa0625c: LOAD R2 = [FP + -0x14]
ffa0625e: CC = R2 <= R0 (IU)
ffa06260: IF CC JUMP 0xffa0635e (bp)
ffa06262: CALL 0xffa0316c
ffa06266: LOAD P5.L = 0x6eec
ffa0626a: LOAD P5.H = 0xff80
ffa0626e: LOAD P1 = [P5]
ffa06270: LOAD P1 = [P1 + 0xf8]
ffa06274: LOAD P0 = -0x148c
ffa06278: LOAD P0.H = 0x4
ffa0627c: ADD P1 = P1 + P0
ffa0627e: LOAD R0 = [P1++]
ffa06280: LOAD R1 = [P1]
ffa06282: CC = R0 <= R6 (IU)
ffa06284: SUB R1 = R1 - R6 (s)
ffa06288: MOVE CC &= az
ffa0628a: MOVE CC |= an
ffa0628c: IF CC JUMP 0xffa0635c
ffa0628e: MOVE P1 = FP
ffa06290: ADD P1 += -0x2c
ffa06292: MOVE R2 = CYCLES
ffa06294: MOVE R1 = CYCLES2
ffa06296: STORE [P1] = R2
ffa06298: STORE [P1 + 0x4] = R1
ffa0629a: LOAD R4 = [FP + -0x2c]
ffa0629c: LOAD R5 = [FP + -0x28]
ffa0629e: STORE [FP + -0x34] = R4
ffa062a0: STORE [FP + -0x30] = R5
ffa062a2: STORE [FP + -0x5c] = R4
ffa062a4: STORE [FP + -0x58] = R5
ffa062a6: LOAD P1 = [P5]
ffa062a8: LOAD P3 = [P1 + 0xf8]
ffa062ac: LOAD P4 = -0x1484
ffa062b0: LOAD P4.H = 0x4
ffa062b4: ADD P1 = P3 + P4
ffa062b6: LOAD R7 = W [P1] (X)
ffa062b8: CC = R7 == 0x0
ffa062ba: IF CC JUMP 0xffa06308
ffa062bc: NOP
ffa062be: ADD P2 = P3 + P0
ffa062c0: MOVE P1 = P2
ffa062c2: LOAD R0 = [P2++]
ffa062c4: LOAD R3 = [P2]
ffa062c6: SUB R2 = R4 - R0 (ns)
ffa062ca: CC = R4 < R0 (IU)
ffa062cc: MOVE R1 = CC
ffa062ce: SUB R1 = R5 - R1 (ns)
ffa062d2: SUB R1 = R1 - R3 (ns)
ffa062d6: LOAD P2.L = 0x2eb8
ffa062da: LOAD P2.H = 0xff80
ffa062de: LOAD R0 = [P2++]
ffa062e0: LOAD R3 = [P2]
ffa062e2: CC = R2 <= R0 (IU)
ffa062e4: SUB R1 = R1 - R3 (s)
ffa062e8: MOVE CC &= az
ffa062ea: MOVE CC |= an
ffa062ec: IF CC JUMP 0xffa06308 (bp)
ffa062ee: STORE [P1++] = R4
ffa062f0: STORE [P1] = R5
ffa062f2: LOAD R0 = 0x1
ffa062f4: LOAD R0.H = 0xd
ffa062f8: CALL 0xffa08700
ffa062fc: LOAD P1 = [P5]
ffa062fe: LOAD P1 = [P1 + 0xf8]
ffa06302: ADD P1 = P1 + P4
ffa06304: STORE W [P1] = R6.L
ffa06306: JUMP.S 0xffa0635a
ffa06308: CC = R7 == 0x0
ffa0630a: IF !CC JUMP 0xffa0635a
ffa0630c: NOP
ffa0630e: ADD P0 = P3 + P0
ffa06310: MOVE P1 = P0
ffa06312: LOAD R0 = [P0++]
ffa06314: LOAD R1 = [P0]
ffa06316: SUB R3 = R4 - R0 (ns)
ffa0631a: CC = R4 < R0 (IU)
ffa0631c: MOVE R2 = CC
ffa0631e: SUB R2 = R5 - R2 (ns)
ffa06322: SUB R1 = R2 - R1 (ns)
ffa06326: LOAD P2.L = 0x2ec0
ffa0632a: LOAD P2.H = 0xff80
ffa0632e: LOAD R7 = [P2++]
ffa06330: LOAD R0 = [P2]
ffa06332: CC = R3 <= R7 (IU)
ffa06334: SUB R1 = R1 - R0 (s)
ffa06338: MOVE CC &= az
ffa0633a: MOVE CC |= an
ffa0633c: IF CC JUMP 0xffa0635a (bp)
ffa0633e: STORE [P1++] = R4
ffa06340: STORE [P1] = R5
ffa06342: LOAD R0 = 0x1
ffa06344: LOAD R0.H = 0xd
ffa06348: CALL 0xffa0872a
ffa0634c: LOAD P1 = [P5]
ffa0634e: LOAD P1 = [P1 + 0xf8]
ffa06352: ADD P1 = P1 + P4
ffa06354: LOAD R1 = 0x1
ffa06356: STORE W [P1] = R1.L
ffa06358: JUMP.S 0xffa0635a
ffa0635a: JUMP.S 0xffa0635c
ffa0635c: JUMP.S 0xffa0635e
ffa0635e: LOAD P5.L = 0x6ee0
ffa06362: LOAD P5.H = 0xff80
ffa06366: LOAD R0 = [P5]
ffa06368: CC = !BITTST (R0,0x7)
ffa0636a: IF CC JUMP 0xffa06372
ffa0636c: BITCLR (R0,0x7)
ffa0636e: STORE [P5] = R0
ffa06370: JUMP.S 0xffa06372
ffa06372: LOAD R0 = [P5]
ffa06374: CC = !BITTST (R0,0x2)
ffa06376: IF CC JUMP 0xffa06394 (bp)
ffa06378: BITCLR (R0,0x2)
ffa0637a: STORE [P5] = R0
ffa0637c: LOAD P1.L = 0x6eec
ffa06380: LOAD P1.H = 0xff80
ffa06384: LOAD R1 = [P1]
ffa06386: LOAD R0 = 0x0
ffa06388: LOAD P1.L = 0x8644
ffa0638c: LOAD P1.H = 0x2020
ffa06390: CALL (P1)
ffa06392: JUMP.S 0xffa06394
ffa06394: LOAD R2 = [P5]
ffa06396: CC = !BITTST (R2,0x8)
ffa06398: IF CC JUMP 0xffa063b6 (bp)
ffa0639a: BITCLR (R2,0x8)
ffa0639c: STORE [P5] = R2
ffa0639e: LOAD P1.L = 0x6eec
ffa063a2: LOAD P1.H = 0xff80
ffa063a6: LOAD R1 = [P1]
ffa063a8: LOAD R0 = 0x1
ffa063aa: LOAD P1.L = 0x8644
ffa063ae: LOAD P1.H = 0x2020
ffa063b2: CALL (P1)
ffa063b4: JUMP.S 0xffa063b6
ffa063b6: LOAD R1 = [P5]
ffa063b8: CC = !BITTST (R1,0x4)
ffa063ba: IF CC JUMP 0xffa063d6 (bp)
ffa063bc: BITCLR (R1,0x4)
ffa063be: STORE [P5] = R1
ffa063c0: LOAD P1.L = 0x6eec
ffa063c4: LOAD P1.H = 0xff80
ffa063c8: LOAD R0 = [P1]
ffa063ca: LOAD P1.L = 0xd9b6
ffa063ce: LOAD P1.H = 0x2020
ffa063d2: CALL (P1)
ffa063d4: JUMP.S 0xffa063d6
ffa063d6: LOAD R2 = [P5]
ffa063d8: CC = !BITTST (R2,0xc)
ffa063da: IF CC JUMP 0xffa063f8 (bp)
ffa063dc: BITCLR (R2,0xc)
ffa063de: STORE [P5] = R2
ffa063e0: LOAD P1.L = 0x6eec
ffa063e4: LOAD P1.H = 0xff80
ffa063e8: LOAD R1 = [P1]
ffa063ea: LOAD R0 = 0x2
ffa063ec: LOAD P1.L = 0xed1a
ffa063f0: LOAD P1.H = 0x2020
ffa063f4: CALL (P1)
