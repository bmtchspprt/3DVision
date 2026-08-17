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
