202ecb14: CALL (P1)
202ecb16: STORE W [P3 + 0x2] = R0
202ecb18: LOAD R2 = 0x1
202ecb1a: LOAD R1 = 0x0
202ecb1c: LOAD R0 = 0x1
202ecb1e: LOAD P1.L = 0x6008
202ecb22: LOAD P1.H = 0xffa0
202ecb26: CALL (P1)
202ecb28: CC = R7 <= 0x0
202ecb2a: STORE W [P3 + 0x4] = R5
202ecb2c: STORE W [P3] = R5.L
202ecb2e: IF CC JUMP 0x202ecb74
202ecb30: LOAD P2 = [FP + 0x14]
202ecb32: MOVE P1 = P4
202ecb34: MOVE P0 = P5
202ecb36: LOAD R0 = W [P1++] (X)
202ecb38: ADD P2 += -0x1
202ecb3a: ABS|| R0 = abs R0
202ecb3e: LOAD R1 = W [P0++] (X)
202ecb40: NOP
202ecb42: LOAD R2 = 0x0
202ecb44: CC = P2 == 0x0
202ecb46: MAX R0 = max(R0,R2)
202ecb4a: ABS R1 = abs R1
202ecb4e: IF CC JUMP 0x202ecb6e
202ecb50: LSETUP (0x202ecb54,0x202ecb6a) LC0 = P2
202ecb54: MAX|| R0 = max(R0,R1)
202ecb58: _LOAD R1 = W [P0++] (X)
202ecb5a: _NOP
202ecb5c: ABS|| R1 = abs R1
202ecb60: LOAD R2 = W [P1++] (X)
202ecb62: NOP
202ecb64: ABS R2 = abs R2
202ecb68: MOVE R0 = R0.L (X)
202ecb6a: MAX R0 = max(R2,R0)
202ecb6e: MAX R0 = max(R0,R1)
202ecb72: STORE W [P3 + 0x4] = R0
202ecb74: CC = R7 <= 0x0
202ecb76: IF CC JUMP 0x202ecbc6
202ecb78: MOVE P1 = R5
202ecb7a: LOAD R1 = W [P3 + 0x4] (X)
202ecb7c: ADD R1 = R1 + R6
202ecb7e: ADD P1 = P4 + (P1 << 1)
202ecb80: LOAD R0 = W [P1] (X)
202ecb82: LOAD P1.L = 0x5ee4
202ecb86: LOAD P1.H = 0xffa0
202ecb8a: CALL (P1)
202ecb8c: LOAD R2 = W [P3] (X)
202ecb8e: MOVE P1 = R2
202ecb90: LOAD P0 = [FP + 0x1c]
202ecb92: LOAD R1 = W [P3 + 0x4] (X)
202ecb94: ADD R1 = R1 + R6
202ecb96: ADD P0 = P0 + (P1 << 2)
202ecb98: STORE W [P0] = R0.H
202ecb9a: ADD P2 = P5 + (P1 << 1)
202ecb9c: LOAD R0 = W [P2] (X)
202ecb9e: LOAD P1.L = 0x5ee4
202ecba2: LOAD P1.H = 0xffa0
202ecba6: CALL (P1)
202ecba8: LSH|| R0.L = R0.H << 0x0
202ecbac: LOAD R1 = W [P3] (X)
202ecbae: NOP
202ecbb0: MOVE P1 = R1
202ecbb2: ADD|| R2 = R1 + R6 (ns)
202ecbb6: _LOAD P0 = [FP + 0x1c]
202ecbb8: _NOP
202ecbba: MOVE R5 = R2.L (X)
202ecbbc: CC = R5 < R7
202ecbbe: STORE W [P3] = R2.L
202ecbc0: ADD P1 = P0 + (P1 << 2)
202ecbc2: STORE W [P1 + 0x2] = R0
202ecbc4: IF CC JUMP 0x202ecb78 (bp)
202ecbc6: LOAD R2 = 0x1
202ecbc8: LOAD R1 = 0x0
202ecbca: LOAD R0 = 0x1
202ecbcc: LOAD P1.L = 0x6008
202ecbd0: LOAD P1.H = 0xffa0
202ecbd4: CALL (P1)
202ecbd6: LOAD R0 = [FP + 0x14]
202ecbd8: LOAD P1.L = 0x16d4
202ecbdc: LOAD P1.H = 0xffa0
202ecbe0: CALL (P1)
202ecbe2: MOVE R7 = R0
202ecbe4: LOAD R0 = W [P3 + 0x4] (X)
202ecbe6: ADD R0 += 0x1
202ecbe8: LOAD P1.L = 0x1688
202ecbec: LOAD P1.H = 0xffa0
202ecbf0: CALL (P1)
202ecbf2: MOVE R1 = R0
202ecbf4: MOVE R0 = R7
202ecbf6: LOAD P1.L = 0x1814
202ecbfa: LOAD P1.H = 0xffa0
202ecbfe: CALL (P1)
202ecc00: ROT|| R7 = rot R0 by 0
202ecc04: _LOAD R1 = W [P3 + 0x2] (X)
202ecc06: _NOP
202ecc08: ASH R0 = ashift R6 by R1.L
202ecc0c: LOAD P1.L = 0x1688
202ecc10: LOAD P1.H = 0xffa0
202ecc14: CALL (P1)
202ecc16: MOVE R1 = R0
202ecc18: MOVE R0 = R7
202ecc1a: LOAD P1.L = 0x1814
202ecc1e: LOAD P1.H = 0xffa0
202ecc22: CALL (P1)
202ecc24: LOAD P1 = [FP + 0x20]
202ecc26: STORE [P1] = R0
202ecc28: LOAD R0 = [FP + 0xc]
202ecc2a: JUMP.S 0x202ecaf4
