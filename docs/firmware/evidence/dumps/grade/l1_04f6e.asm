ffa04f60: CC = BITTST (R5,0x0)
ffa04f62: IF CC R6 = R4
ffa04f64: CC = BITTST (R6,0x0)
ffa04f66: IF CC JUMP 0xffa04f6a (bp)
ffa04f68: JUMP.S 0xffa04930
ffa04f6a: STORE [P1] = R1
ffa04f6c: JUMP.S 0xffa04930
ffa04f6e: LOAD P1 = [FP + -0x5c]
ffa04f70: LOAD R2 = [FP + -0x24]
ffa04f72: LOAD R1 = [P1--]
ffa04f74: ASH R6 = R1 >>> 0xf
ffa04f78: ROT|| R1 = rot R6 by 0
ffa04f7c: _STORE [P1++] = R6
ffa04f7e: _NOP
ffa04f80: LOAD R7 = W [P1 + -0x6] (X)
ffa04f84: CC = R2 == R7
ffa04f86: STORE [FP + -0x1c] = P1
ffa04f88: IF !CC JUMP 0xffa04fe0
ffa04f8a: LOAD R2 = W [P5] (X)
ffa04f8c: MOVE P1 = R2
ffa04f8e: LOAD P0.L = 0x4888
ffa04f92: LOAD P0.H = 0xff80
ffa04f96: ADD R1 += 0x2
ffa04f98: ADD P0 = P0 + (P1 << 2)
ffa04f9a: LOAD R2 = [P0]
ffa04f9c: CC = R1 < R2
ffa04f9e: IF CC JUMP 0xffa04fa8
ffa04fa0: MOVE R1 = R6
ffa04fa2: ADD R1 += -0x2
ffa04fa4: CC = R2 < R1
ffa04fa6: IF !CC JUMP 0xffa04fe0
ffa04fa8: LOAD P0.L = 0x48f4
ffa04fac: LOAD P0.H = 0xff80
ffa04fb0: LOAD P2.L = 0x48ac
ffa04fb4: LOAD P2.H = 0xff80
ffa04fb8: ADD P0 = P0 + (P1 << 2)
ffa04fba: ADD P2 = P2 + (P1 << 2)
ffa04fbc: LOAD P3.L = 0x48d0
ffa04fc0: LOAD P3.H = 0xff80
ffa04fc4: STORE [P0] = R0
ffa04fc6: LOAD P0.L = 0x4918
ffa04fca: LOAD P0.H = 0xff80
ffa04fce: STORE [FP + -0x58] = P2
ffa04fd0: ADD P2 = P3 + (P1 << 2)
ffa04fd2: ADD P3 = P0 + (P1 << 2)
ffa04fd4: LOAD P1 = [FP + -0x1c]
ffa04fd6: LOAD P0 = [FP + -0x58]
ffa04fd8: LOAD R1 = [P1 + 0xc]
ffa04fda: STORE [P2] = R1
ffa04fdc: STORE [P3] = R1
ffa04fde: STORE [P0] = R6
ffa04fe0: LOAD R1 = 0x147a
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
