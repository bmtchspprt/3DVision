202ecec8: LINK 0x14
202ececc: PUSH [--SP] = (R7:4,P5:3)
202ecece: ADD SP += -0x20
202eced0: STORE [FP + -0xc] = R1
202eced2: LOAD P0 = [FP + -0xc]
202eced4: LOAD R6 = 0x0
202eced6: LOAD R6.H = 0x3f80
202eceda: LOAD P5.L = 0xadcc
202ecede: LOAD P5.H = 0x202e
202ecee2: LOAD R2 = W [P0 + 0x57bc] (X)
202ecee6: ADD R2 += -0x1
202ecee8: LOAD R0 = W [P0 + 0x57c4] (X)
202eceec: CC = BITTST (R2,0xf)
202eceee: LSH|| R2.H = R0.L << 0x0
202ecef2: STORE [P5 + 0xc] = R6
202ecef4: NOP
202ecef6: LOAD R3 = 0x0
202ecef8: STORE [P5] = R2
202ecefa: STORE [P5 + 0x8] = R3
202ecefc: IF CC JUMP 0x202ed044
202ecefe: LOAD P2 = [FP + -0xc]
202ecf00: MOVE P1 = P5
202ecf02: LOAD P0 = 0x578c
202ecf06: MOVE P4 = P5
202ecf08: ADD P0 = P2 + P0
202ecf0a: ADD P1 += 0x8
202ecf0c: LOAD R7 = 0xc
202ecf0e: LOAD R0 = 0x1
202ecf10: LOAD R5.L = 0xd088
202ecf14: LOAD R5.H = 0x202e
202ecf18: LOAD R4 = -0x200
202ecf1c: PACK|| R7 = pack(R0.L,R7.L)
202ecf20: _STORE [FP + 0xc] = P0
202ecf22: _NOP
202ecf24: STORE [FP + -0x10] = P1
202ecf26: STORE [SP + 0x3c] = R5
202ecf28: ADD P4 += 0x2
202ecf2a: LOAD R4.H = 0x46ff
202ecf2e: MULT|| R2 = R2.L * R7.L (is)
202ecf32: LOAD P1 = [FP + -0x10]
202ecf34: NOP
202ecf36: ROT|| R0 = rot R5 by 0
202ecf3a: _LOAD R1 = W [P4] (X)
202ecf3c: _NOP
202ecf3e: MOVE P2 = R2
202ecf40: LSH R2.L = R7.H << 0x0
202ecf44: LOAD R3 = W [P1] (X)
202ecf46: SUB R1.H = R1.L - R3.L (ns)
202ecf4a: ASH R1 = R1 >>> 0x10
202ecf4e: LOAD P1.L = 0x705c
202ecf52: LOAD P1.H = 0xffa0
202ecf56: CALL (P1)
202ecf58: LOAD P1 = [FP + 0xc]
202ecf5a: CC = R0 <= 0x0
202ecf5c: STORE W [P5 + 0x4] = R0
202ecf5e: ADD P0 = P1 + P2
202ecf60: LOAD P2 = [P0]
202ecf62: IF CC JUMP 0x202ecf78
202ecf64: LOAD R2 = 0x7fff
202ecf68: MOVE R1 = R0.L (Z)
202ecf6a: MOVE R0 = R2.L (Z)
202ecf6c: LOAD P1.L = 0x1038
202ecf70: LOAD P1.H = 0xffa0
202ecf74: CALL (P1)
202ecf76: MOVE R2 = R0
202ecf78: STORE W [P2 + 0x18] = R2
202ecf7a: LOAD P3 = [P0]
202ecf7c: LOAD R2 = [P0 + 0x8]
202ecf7e: STORE [FP + -0x8] = R2
202ecf80: LOAD R0 = W [P3 + 0x10] (X)
202ecf82: LOAD P1.L = 0x1688
202ecf86: LOAD P1.H = 0xffa0
202ecf8a: CALL (P1)
202ecf8c: ROT|| R1 = rot R0 by 0
202ecf90: _LOAD R3 = W [P3 + 0x18] (X)
202ecf92: _NOP
202ecf94: ROT|| R0 = rot R4 by 0
202ecf98: _LOAD R2 = [P3 + 0x14]
202ecf9a: _NOP
202ecf9c: STORE [FP + 0x8] = R3
202ecf9e: STORE [FP + 0x10] = R2
202ecfa0: LOAD P1.L = 0x1814
202ecfa4: LOAD P1.H = 0xffa0
202ecfa8: CALL (P1)
202ecfaa: LOAD R1 = [P5 + 0xc]
202ecfac: LOAD P1.L = 0x18f0
202ecfb0: LOAD P1.H = 0xffa0
202ecfb4: CALL (P1)
202ecfb6: STORE [FP + -0x4] = R0
202ecfb8: LOAD R0 = [FP + 0x8]
202ecfba: LOAD P1.L = 0x1688
202ecfbe: LOAD P1.H = 0xffa0
202ecfc2: CALL (P1)
202ecfc4: ROT|| R1 = rot R0 by 0
202ecfc8: _LOAD P0 = [SP + 0x3c]
202ecfca: _NOP
202ecfcc: LOAD R0 = [FP + -0x4]
202ecfce: LOAD P1.L = 0x1814
202ecfd2: LOAD P1.H = 0xffa0
202ecfd6: CALL (P1)
202ecfd8: LOAD P1 = [FP + -0xc]
202ecfda: LOAD R2 = [FP + 0x10]
202ecfdc: LOAD R1 = [FP + 0x8]
202ecfde: LOAD R3 = [FP + -0x8]
202ecfe0: ROT|| R0 = rot R5 by 0
202ecfe4: _STORE [P5 + 0xc] = R0
202ecfe6: _NOP
202ecfe8: STORE [SP + 0xc] = R2
202ecfea: STORE [SP + 0x14] = R1
202ecfec: STORE [SP + 0x1c] = P4
202ecfee: STORE [SP + 0x18] = P0
202ecff0: STORE [SP + 0x10] = R3
202ecff2: LOAD R2 = [P3 + 0xc]
202ecff4: LOAD R1 = [P1 + 0x57c4]
202ecff8: LOAD P1.L = 0x6cfc
202ecffc: LOAD P1.H = 0xffa0
202ed000: CALL (P1)
202ed002: LOAD R1 = W [P5] (X)
202ed004: MULT|| R1 = R1.L * R7.L (is)
202ed008: LOAD P0 = [FP + 0xc]
202ed00a: NOP
202ed00c: MOVE P1 = R1
202ed00e: LOAD R0 = W [P5 + 0x2] (Z)
202ed010: ADD P1 = P0 + P1
202ed012: LOAD P0 = [P1]
202ed014: LOAD R3 = [P1 + 0x8]
202ed016: LOAD R1 = [P0 + 0x14]
202ed018: ADD R1 += -0x1
202ed01a: MULT R3 *= R1
202ed01c: SUB|| R0 = R0 - R3 (ns)
202ed020: _STORE [P5 + 0x8] = R3
202ed022: _NOP
202ed024: LSH R1 = R3 << 0x1
202ed028: LSH R2 = R0 << 0x1
202ed02c: ADD R1 = R5 + R1
202ed02e: MOVE R0 = R5
202ed030: LOAD P1.L = 0x5f92
202ed034: LOAD P1.H = 0xffa0
202ed038: CALL (P1)
202ed03a: LOAD R2.L = W [P5]
202ed03c: ADD R2 += -0x1
202ed03e: CC = BITTST (R2,0xf)
202ed040: STORE W [P5] = R2.L
202ed042: IF !CC JUMP 0x202ecf2e (bp)
202ed044: LOAD R2 = 0x1
202ed046: LOAD R1 = 0x0
202ed048: LOAD R0 = 0x1
202ed04a: LOAD P1.L = 0x6008
202ed04e: LOAD P1.H = 0xffa0
202ed052: CALL (P1)
202ed054: LOAD R7 = -0x1
202ed056: LOAD R1 = [P5 + 0xc]
202ed058: LSHIFT R7 <<= 0x17
202ed05a: CC = R1 <= R7
202ed05c: LSH R0 = R1 >> 0x1f
202ed060: LOAD R3 = 0x0
202ed062: IF !CC R0 = R3
202ed064: CC = R1 == 0x0
202ed066: LOAD R2 = 0x1
202ed068: IF CC R0 = R2
202ed06a: CC = BITTST (R0,0x0)
202ed06c: IF !CC JUMP 0x202ed070
202ed06e: STORE [P5 + 0xc] = R6
202ed070: LOAD R0 = [P5 + 0xc]
202ed072: ADD SP += 0x20
202ed074: POP (R7:4,P5:3) = [SP++]
202ed076: UNLINK
202ed07a: RTS
