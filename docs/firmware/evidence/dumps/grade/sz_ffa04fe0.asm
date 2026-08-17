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
