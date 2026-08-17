2022ec8a: MAC A1 += R1.H * R0.L (m),A0 = R1.H * R0.H 
2022ec8e: MAC A1 += R0.H * R1.L (m)
2022ec92: ASH A1 = A1 >>> 0xf
2022ec96: MOVE R0 = (A0 += A1)
2022ec9a: ASH|| R0 = ashift R0 by R2.L
2022ec9e: STORE [P5 + 0x1c] = R3
2022eca0: NOP
2022eca2: STORE [P5 + 0x20] = R0
2022eca4: LOAD R0 = [P5 + 0x1c]
2022eca6: LOAD P1.L = 0x2894
2022ecaa: LOAD P1.H = 0xffa0
2022ecae: CALL (P1)
2022ecb0: STORE [FP + 0x10] = R0
2022ecb2: LOAD R0 = [P3 + 0x8c]
2022ecb6: LOAD R7 = 0xfdb
2022ecba: LOAD P1.L = 0x2894
2022ecbe: LOAD P1.H = 0xffa0
2022ecc2: CALL (P1)
2022ecc4: LOAD R7.H = 0x40c9
2022ecc8: MOVE R1 = R7
2022ecca: LOAD P1.L = 0x18f0
2022ecce: LOAD P1.H = 0xffa0
2022ecd2: CALL (P1)
2022ecd4: LOAD P1.L = 0x2538
2022ecd8: LOAD P1.H = 0xffa0
2022ecdc: CALL (P1)
2022ecde: LOAD R1 = [FP + 0x10]
2022ece0: LOAD P1.L = 0x18f0
2022ece4: LOAD P1.H = 0xffa0
2022ece8: CALL (P1)
2022ecea: LOAD R4 = [P5 + 0x20]
2022ecec: NEG R2 = -R4
2022ecee: STORE [P5 + 0x60] = R0
2022ecf2: MAX R0 = max(R2,R4)
2022ecf6: LOAD P1.L = 0x2894
2022ecfa: LOAD P1.H = 0xffa0
2022ecfe: CALL (P1)
2022ed00: LOAD R1 = [P5 + 0x60]
2022ed04: LOAD P1.L = 0x1714
2022ed08: LOAD P1.H = 0xffa0
