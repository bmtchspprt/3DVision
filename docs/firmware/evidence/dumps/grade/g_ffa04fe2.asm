ffa04fe4: CC = R6 < R1
ffa04fe6: IF CC JUMP 0xffa04fea (bp)
ffa04fe8: JUMP.S 0xffa0489c
ffa04fea: LOAD R1 = W [P5] (X)
ffa04fec: MOVE P2 = R1
ffa04fee: LOAD P1.L = 0x48ac
ffa04ff2: LOAD P1.H = 0xff80
ffa04ff6: ADD P1 = P1 + (P2 << 2)
ffa04ff8: LOAD R1 = [P1]
ffa04ffa: CC = R1 < R6
ffa04ffc: IF !CC JUMP 0xffa052ec
ffa04ffe: NOP
ffa05000: LOAD P1.L = 0x4888
ffa05004: LOAD P1.H = 0xff80
ffa05008: ADD P1 = P1 + (P2 << 2)
ffa0500a: LOAD R3 = [P1]
ffa0500c: CC = R3 < R6
ffa0500e: IF CC JUMP 0xffa05018
ffa05010: MOVE R2 = R6
ffa05012: ADD R2 += 0xa
ffa05014: CC = R2 < R3
ffa05016: IF !CC JUMP 0xffa052ec
ffa05018: LOAD R0 = 0x5
ffa0501a: LOAD R2 = [FP + 0x28]
ffa0501c: CC = R2 == R0
ffa0501e: IF CC JUMP 0xffa05026
ffa05020: LOAD R0 = 0x4
ffa05022: CC = R2 == R0
ffa05024: IF !CC JUMP 0xffa051d4
ffa05026: ASHIFT R1 >>>= 0x3
ffa05028: MOVE P1 = R1
ffa0502a: LOAD P0.L = 0x48d0
ffa0502e: LOAD P0.H = 0xff80
ffa05032: LOAD P3 = [FP + -0x4c]
ffa05034: ADD P0 = P0 + (P2 << 2)
ffa05036: LOAD R4 = [P0]
ffa05038: ADD P1 = P3 + (P1 << 2)
ffa0503a: LOAD R5 = [P1]
ffa0503c: LOAD R7 = [P1 + 0xa3c]
ffa05040: MOVE R1 = R7
ffa05042: MOVE R0 = R5
ffa05044: CALL 0xffa0165c
ffa05048: IF CC R7 = R5
ffa0504a: MOVE R1 = R7
ffa0504c: MOVE R0 = R4
ffa0504e: CALL 0xffa0165c
ffa05052: LOAD P1 = [FP + -0x1c]
ffa05054: IF CC R7 = R4
ffa05056: STORE [P1 + 0x18] = R7
ffa05058: LOAD R0 = W [P5] (X)
ffa0505a: MOVE P1 = R0
ffa0505c: LOAD P0.L = 0x48ac
ffa05060: LOAD P0.H = 0xff80
ffa05064: ASHIFT R6 >>>= 0x3
ffa05066: ADD P0 = P0 + (P1 << 2)
ffa05068: LOAD R2 = [P0]
ffa0506a: ASHIFT R2 >>>= 0x3
ffa0506c: CC = R2 == R6
ffa0506e: IF !CC JUMP 0xffa050e0
ffa05070: LOAD P2.L = 0x4918
ffa05074: LOAD P2.H = 0xff80
ffa05078: LOAD P0.L = 0x48d0
ffa0507c: LOAD P0.H = 0xff80
ffa05080: ADD P2 = P2 + (P1 << 2)
ffa05082: ADD P0 = P0 + (P1 << 2)
ffa05084: LOAD R7 = [P2]
ffa05086: ROT|| R1 = rot R7 by 0
ffa0508a: _LOAD R6 = [P0]
ffa0508c: _NOP
ffa0508e: MOVE R0 = R6
ffa05090: CALL 0xffa0165c
ffa05094: IF CC R6 = R7
ffa05096: STORE [P2] = R6
ffa05098: LOAD R0 = W [P5] (X)
ffa0509a: LOAD P3 = [FP + -0x5c]
ffa0509c: MOVE P1 = R0
ffa0509e: LOAD P2 = [FP + -0x1c]
ffa050a0: LOAD R7 = W [P3 + -0x6] (X)
ffa050a4: LOAD P3.L = 0x48d0
ffa050a8: LOAD P3.H = 0xff80
ffa050ac: ADD P0 = P3 + (P1 << 2)
ffa050ae: LOAD R1 = [P2 + 0xc]
ffa050b0: STORE [P0] = R1
ffa050b2: LOAD P0.L = 0x48ac
ffa050b6: LOAD P0.H = 0xff80
ffa050ba: LOAD R2 = [P2 + 0x14]
ffa050bc: LOAD R3 = [P2 + -0x4]
ffa050c0: ADD P0 = P0 + (P1 << 2)
ffa050c2: LOAD P3.L = 0x4888
ffa050c6: LOAD P3.H = 0xff80
ffa050ca: LOAD P2.L = 0x48f4
ffa050ce: LOAD P2.H = 0xff80
ffa050d2: ADD P3 = P3 + (P1 << 2)
ffa050d4: ADD P2 = P2 + (P1 << 2)
ffa050d6: LOAD R0 = [P0]
ffa050d8: STORE [P2] = R2
ffa050da: STORE [P0] = R3
ffa050dc: STORE [P3] = R0
ffa050de: JUMP.S 0xffa0489c
ffa050e0: LOAD P2 = [FP + -0x1c]
ffa050e2: LOAD R7 = 0x0
ffa050e4: STORE [FP + 0x20] = R2
ffa050e6: LOAD R7.H = 0x4100
ffa050ea: LOAD R1 = [P2 + 0x1c]
ffa050ec: MOVE R0 = R7
ffa050ee: CALL 0xffa018f0
ffa050f2: LOAD P1 = [FP + 0x20]
ffa050f4: LOAD P3 = [FP + -0x50]
ffa050f6: ADD P1 = P3 + (P1 << 2)
ffa050f8: STORE [FP + 0x20] = P1
ffa050fa: LOAD P3 = [FP + 0x20]
ffa050fc: LOAD R1 = [P1]
ffa050fe: CALL 0xffa018f0
ffa05102: LOAD P2.L = 0x4918
ffa05106: LOAD P2.H = 0xff80
ffa0510a: STORE [P3] = R0
ffa0510c: LOAD R0 = W [P5] (X)
ffa0510e: MOVE P1 = R0
ffa05110: LOAD P3 = [FP + -0x50]
ffa05112: ADD P1 = P2 + (P1 << 2)
ffa05114: LOAD R0 = [P1]
ffa05116: BITCLR (R0,0x1f)
ffa05118: CALL 0xffa0248c
ffa0511c: LOAD R1 = W [P5] (X)
ffa0511e: MOVE P1 = R1
ffa05120: LOAD P0.L = 0x48ac
ffa05124: LOAD P0.H = 0xff80
ffa05128: ADD P1 = P0 + (P1 << 2)
ffa0512a: LOAD R2 = [P1]
ffa0512c: ASHIFT R2 >>>= 0x3
ffa0512e: MOVE P1 = R2
ffa05130: ADD P1 = P3 + (P1 << 2)
ffa05132: LOAD R1 = [P1]
ffa05134: STORE [FP + 0x20] = P1
ffa05136: CALL 0xffa01716
ffa0513a: LOAD P0 = [FP + 0x20]
ffa0513c: MOVE R1 = R7
ffa0513e: LOAD P2 = [FP + -0x1c]
ffa05140: STORE [P0] = R0
ffa05142: LOAD R3 = W [P5] (X)
ffa05144: LOAD R0 = [P2 + 0x1c]
ffa05146: STORE [FP + 0x20] = R3
ffa05148: CALL 0xffa018f0
ffa0514c: LOAD R1 = 0x0
ffa0514e: LOAD R1.H = 0x3f80
ffa05152: CALL 0xffa01716
ffa05156: LOAD P0 = [FP + 0x20]
ffa05158: MOVE R1 = R0
ffa0515a: LOAD P1.L = 0x48ac
ffa0515e: LOAD P1.H = 0xff80
ffa05162: LOAD P2.L = 0x48ac
ffa05166: LOAD P2.H = 0xff80
ffa0516a: ADD P1 = P1 + (P0 << 2)
ffa0516c: LOAD R2 = [P1]
ffa0516e: ASHIFT R2 >>>= 0x3
ffa05170: MOVE P1 = R2
ffa05172: ADD P0 = P3 + (P1 << 2)
ffa05174: LOAD R0 = [P0]
ffa05176: CALL 0xffa01814
ffa0517a: STORE [P0] = R0
ffa0517c: LOAD R0 = W [P5] (X)
ffa0517e: MOVE P1 = R0
ffa05180: LOAD P3 = [FP + -0x4c]
ffa05182: LOAD P0.L = 0x48ac
ffa05186: LOAD P0.H = 0xff80
ffa0518a: ADD P1 = P2 + (P1 << 2)
ffa0518c: LOAD R0 = [P1]
ffa0518e: ASHIFT R0 >>>= 0x3
ffa05190: MOVE P1 = R0
ffa05192: LOAD P2.L = 0x4918
ffa05196: LOAD P2.H = 0xff80
ffa0519a: ADD P1 = P3 + (P1 << 2)
ffa0519c: LOAD R0 = [P1]
ffa0519e: STORE [P1 + 0xa3c] = R0
ffa051a2: LOAD R0 = W [P5] (X)
ffa051a4: MOVE P1 = R0
ffa051a6: ADD P0 = P0 + (P1 << 2)
ffa051a8: LOAD R0 = [P0]
ffa051aa: ASHIFT R0 >>>= 0x3
ffa051ac: MOVE P0 = R0
ffa051ae: ADD P2 = P2 + (P1 << 2)
ffa051b0: LOAD R1 = [P2]
ffa051b2: LOAD P2.L = 0x4918
ffa051b6: LOAD P2.H = 0xff80
ffa051ba: ADD P0 = P3 + (P0 << 2)
ffa051bc: STORE [P0] = R1
ffa051be: LOAD R0 = W [P5] (X)
ffa051c0: MOVE P1 = R0
ffa051c2: LOAD P3.L = 0x48d0
ffa051c6: LOAD P3.H = 0xff80
ffa051ca: ADD P0 = P3 + (P1 << 2)
ffa051cc: ADD P2 = P2 + (P1 << 2)
ffa051ce: LOAD R0 = [P0]
ffa051d0: STORE [P2] = R0
ffa051d2: JUMP.S 0xffa05098
ffa051d4: ASHIFT R1 >>>= 0x3
ffa051d6: LOAD P3.L = 0x48d0
ffa051da: LOAD P3.H = 0xff80
ffa051de: MOVE P1 = R1
ffa051e0: ADD P2 = P3 + (P2 << 2)
ffa051e2: LOAD P3 = [FP + -0x4c]
ffa051e4: LOAD R0 = W [P5] (X)
ffa051e6: LOAD R1 = 0x5cfc
ffa051ea: MULT R0 = R0.L * R1.L (is)
ffa051ee: LOAD R5 = [P2]
ffa051f0: MOVE P0 = R0
ffa051f2: ADD P3 = P3 + (P1 << 2)
ffa051f4: LOAD P2 = [FP + 0xc]
ffa051f6: MOVE R7 = R5
ffa051f8: LOAD R2 = [P3]
ffa051fa: LOAD R3 = [P3 + 0xa3c]
ffa051fe: STORE [FP + -0x34] = R3
ffa05200: STORE [FP + 0x20] = R2
ffa05202: ADD P0 = P2 + P0
ffa05204: LOAD P2 = 0x42ce
ffa05208: ADD P0 = P0 + P2
ffa0520a: LOAD R0 = [FP + 0x20]
ffa0520c: LOAD R1 = [FP + -0x34]
ffa0520e: ADD P0 = P0 + P1
ffa05210: CALL 0xffa0165c
ffa05214: LOAD R4 = -0x3333
ffa05218: LOAD R2 = [FP + 0x20]
ffa0521a: LOAD R4.H = 0x3fb4
ffa0521e: LOAD R0 = [FP + -0x34]
ffa05220: MOVE R1 = R4
ffa05222: IF CC R0 = R2
ffa05224: STORE [FP + -0x38] = P0
ffa05226: CALL 0xffa018f0
ffa0522a: STORE [FP + 0x20] = R0
ffa0522c: MOVE R1 = R5
ffa0522e: CALL 0xffa0165c
ffa05232: LOAD P1 = [FP + -0x1c]
ffa05234: MOVE R1 = R4
ffa05236: LOAD R2 = [FP + 0x20]
ffa05238: IF CC R7 = R2
ffa0523a: MOVE R0 = R7
ffa0523c: STORE [P1 + 0x18] = R7
ffa0523e: CALL 0xffa018f0
ffa05242: MOVE R1 = R5
ffa05244: CALL 0xffa01630
ffa05248: IF !CC JUMP 0xffa052d8
ffa0524a: LOAD P1 = [FP + -0x38]
ffa0524c: LOAD R0 = 0x0
ffa0524e: STORE B [P1] = R0
ffa05250: LOAD R1 = W [P5] (X)
ffa05252: MOVE P1 = R1
ffa05254: LOAD P3 = [FP + -0x1c]
ffa05256: LOAD P0.L = 0x48ac
ffa0525a: LOAD P0.H = 0xff80
ffa0525e: ADD P1 = P0 + (P1 << 2)
ffa05260: LOAD R5 = [P3 + 0x1c]
ffa05262: LOAD P1 = [P1]
ffa05264: MOVE R0 = R5
ffa05266: LOAD P3 = [FP + -0x44]
ffa05268: ADD P1 = P3 + (P1 << 2)
ffa0526a: STORE [FP + 0x20] = P1
ffa0526c: LOAD P3 = [FP + 0x20]
ffa0526e: LOAD R1 = [P1]
ffa05270: CALL 0xffa018f0
ffa05274: LOAD P0.L = 0x48ac
ffa05278: LOAD P0.H = 0xff80
ffa0527c: STORE [P3] = R0
ffa0527e: MOVE R1 = R7
ffa05280: LOAD R0 = W [P5] (X)
ffa05282: MOVE P1 = R0
ffa05284: LOAD P2.L = 0x48f4
ffa05288: LOAD P2.H = 0xff80
ffa0528c: ADD P0 = P0 + (P1 << 2)
ffa0528e: ADD P2 = P2 + (P1 << 2)
ffa05290: LOAD P0 = [P0]
ffa05292: LOAD R0 = [P2]
ffa05294: STORE [FP + 0x20] = P0
ffa05296: CALL 0xffa018f0
ffa0529a: LOAD P3 = [FP + 0x20]
ffa0529c: LOAD P1 = [FP + -0x44]
ffa0529e: ADD P3 = P1 + (P3 << 2)
ffa052a0: LOAD R1 = [P3]
ffa052a2: CALL 0xffa01716
ffa052a6: STORE [P3] = R0
ffa052a8: MOVE R1 = R5
ffa052aa: STORE [FP + 0x20] = P3
ffa052ac: LOAD R2 = W [P5] (X)
ffa052ae: LOAD R0 = 0x0
ffa052b0: LOAD R0.H = 0x3f80
ffa052b4: STORE [FP + 0x20] = R2
ffa052b6: CALL 0xffa01716
ffa052ba: LOAD P0 = [FP + 0x20]
ffa052bc: MOVE R1 = R0
ffa052be: LOAD P1.L = 0x48ac
ffa052c2: LOAD P1.H = 0xff80
ffa052c6: LOAD P2 = [FP + -0x44]
ffa052c8: ADD P1 = P1 + (P0 << 2)
ffa052ca: LOAD P1 = [P1]
ffa052cc: ADD P0 = P2 + (P1 << 2)
ffa052ce: LOAD R0 = [P0]
ffa052d0: CALL 0xffa01814
ffa052d4: STORE [P0] = R0
ffa052d6: JUMP.S 0xffa05058
ffa052d8: LOAD P1 = [FP + -0x38]
ffa052da: LOAD R1 = 0xff
ffa052de: LOAD R0 = B [P1] (Z)
ffa052e0: CC = R0 < R1
ffa052e2: IF !CC JUMP 0xffa05250
ffa052e4: ADD R0 += 0x1
ffa052e6: STORE B [P1] = R0
ffa052e8: JUMP.S 0xffa05250
ffa052ec: LOAD P1.L = 0x48f4
ffa052f0: LOAD P1.H = 0xff80
ffa052f4: LOAD R6 = 0xff
ffa052f8: LSHIFT R6 <<= 0x17
ffa052fa: ADD P1 = P1 + (P2 << 2)
ffa052fc: LOAD P0.L = 0x48d0
ffa05300: LOAD P0.H = 0xff80
ffa05304: ROT|| R1 = rot R0 by 0
ffa05308: _STORE [FP + 0x20] = R6
ffa0530a: _NOP
ffa0530c: ADD P0 = P0 + (P2 << 2)
ffa0530e: LOAD R3 = [P1]
ffa05310: ROT|| R2 = rot R3 by 0
ffa05314: _LOAD P2 = [FP + -0x1c]
ffa05316: _NOP
ffa05318: AND R5 = R3 & R0
ffa0531a: BITCLR (R1,0x1f)
ffa0531c: BITCLR (R2,0x1f)
ffa0531e: LSH|| R5 = R5 >> 0x1f
ffa05322: _LOAD R6 = [P0]
ffa05324: _NOP
ffa05326: OR R4 = R2 | R1
ffa05328: ROT|| R1 = rot R6 by 0
ffa0532c: _STORE [FP + -0x38] = R1
ffa0532e: _NOP
ffa05330: STORE [FP + -0x3c] = R5
ffa05332: STORE [FP + -0x20] = R4
ffa05334: BITCLR (R6,0x1f)
ffa05336: LOAD R5 = [FP + 0x20]
ffa05338: LOAD R4 = [P2 + 0xc]
ffa0533a: CC = R5 < R6
ffa0533c: MOVE R5 = R4
ffa0533e: BITCLR (R5,0x1f)
ffa05340: OR R6 = R6 | R5
ffa05342: STORE [FP + -0x30] = R6
ffa05344: AND R6 = R1 & R4
ffa05346: LSHIFT R6 >>= 0x1f
ffa05348: STORE [FP + -0x34] = R6
ffa0534a: MOVE R6 = CC
ffa0534c: STORE [FP + -0x1c] = R6
ffa0534e: LOAD R6 = [FP + 0x20]
ffa05350: CC = R6 < R5
ffa05352: LOAD R5 = 0x1
ffa05354: LOAD R6 = [FP + -0x1c]
ffa05356: STORE [FP + -0x58] = R5
ffa05358: IF !CC R5 = R6
ffa0535a: CC = R4 < R1
ffa0535c: STORE [FP + -0x58] = R5
ffa0535e: MOVE R6 = CC
ffa05360: LOAD R5 = [FP + -0x34]
ffa05362: CC = R1 == R4
ffa05364: XOR R5 = R5 ^ R6
ffa05366: IF !CC R6 = R5
ffa05368: STORE [FP + -0x1c] = R5
ffa0536a: LOAD R5 = [FP + -0x30]
ffa0536c: CC = R5 == 0x0
ffa0536e: IF CC R6 = R5
ffa05370: LOAD R5 = [FP + -0x58]
ffa05372: CC = BITTST (R5,0x0)
ffa05374: LOAD R5 = 0x0
ffa05376: IF CC R6 = R5
ffa05378: CC = BITTST (R6,0x0)
ffa0537a: IF CC R4 = R1
ffa0537c: LOAD R1 = [FP + 0x20]
ffa0537e: CC = R1 < R2
ffa05380: STORE [P0] = R4
ffa05382: LOAD R4 = [FP + -0x38]
ffa05384: MOVE R2 = CC
ffa05386: CC = R1 < R4
ffa05388: LOAD R5 = 0x1
ffa0538a: IF !CC R5 = R2
ffa0538c: CC = R0 < R3
ffa0538e: MOVE R1 = CC
ffa05390: LOAD R2 = [FP + -0x3c]
ffa05392: CC = R3 == R0
ffa05394: XOR R6 = R2 ^ R1
ffa05396: SUB|| R2 = R2 - R2 (ns)
ffa0539a: _LOAD R4 = [FP + -0x20]
ffa0539c: _NOP
ffa0539e: IF !CC R1 = R6
ffa053a0: CC = R4 == 0x0
ffa053a2: IF CC R1 = R4
ffa053a4: CC = BITTST (R5,0x0)
ffa053a6: IF CC R1 = R2
ffa053a8: CC = BITTST (R1,0x0)
ffa053aa: IF CC R0 = R3
ffa053ac: STORE [P1] = R0
ffa053ae: JUMP.S 0xffa0489c
ffa053b0: LOAD R3 = W [P5] (X)
ffa053b2: LOAD R0 = 0x5cfc
ffa053b6: MULT|| R0 = R3.L * R0.L (is)
ffa053ba: STORE [SP + 0x10] = R3
ffa053bc: NOP
ffa053be: LOAD R2 = W [P1 + -0x6] (X)
ffa053c2: LOAD P0 = [FP + 0x1c]
ffa053c4: MOVE P1 = R0
ffa053c6: STORE [SP + 0x18] = P0
ffa053c8: LOAD P0 = [FP + 0xc]
ffa053ca: LOAD R1 = 0xc5e8
ffa053ce: LOAD R4 = [FP + 0x14]
ffa053d0: BITSET (R1,0x11)
ffa053d2: ADD P1 = P0 + P1
ffa053d4: LOAD R5 = B [P1 + 0x2] (Z)
ffa053d8: LOAD R6 = [FP + 0x24]
ffa053da: CC = R5 <= R4
ffa053dc: LOAD R7 = 0x85e8
ffa053e0: ADD|| R6 = R6 + R1 (ns)
