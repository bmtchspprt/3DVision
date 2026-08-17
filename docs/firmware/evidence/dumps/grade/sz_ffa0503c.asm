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
