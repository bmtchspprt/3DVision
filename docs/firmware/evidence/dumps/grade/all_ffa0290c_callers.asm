==== site 2021437e
2021433e: CC = R0 <= 0x0
20214340: IF CC JUMP 0x2021439e
20214342: LOAD R4 = 0x0
20214344: LOAD R6 = 0x0
20214346: LOAD P1 = [FP + -0x50]
20214348: MOVE I0 = P1
2021434a: LOAD P1 = -0x1
2021434c: LSETUP (0x20214350,0x20214398) LC1 = P1
20214350: ROT|| R1 = rot R7 by 0
20214354: _LOAD P1 = [FP + -0x24]
20214356: _LOAD R0 = [I0++]
20214358: LOAD R3 = 0x5cfc
2021435c: ADD R4 += 0x1
2021435e: LOAD R2 = W [P1] (X)
20214360: MULT|| R2 = R2.L * R3.L (is)
20214364: LOAD R3 = [FP + -0x18]
20214366: NOP
20214368: ADD R2 = R3 + R2
2021436a: LOAD R3 = 0x2938
2021436e: ADD R2 = R2 + R3
20214370: ADD R2 = R2 + R6
20214372: MOVE P0 = R2
20214374: LOAD P1.L = 0x1814
20214378: LOAD P1.H = 0xffa0
2021437c: CALL (P1)
2021437e: LOAD P1.L = 0x290c
20214382: LOAD P1.H = 0xffa0
20214386: CALL (P1)
20214388: LOAD P1 = [FP + 0x10]
2021438a: MOVE R1 = R4.L (X)
2021438c: STORE W [P0] = R0.L
2021438e: ADD R6 += 0x2
20214390: LOAD R0 = [P1 + 0xc]
20214392: ASHIFT R0 >>>= 0x11
20214394: ADD R0 += 0x1
20214396: CC = R1 < R0
20214398: IF !CC JUMP 0x2021439e
2021439a: MOVE P1 = I0
2021439c: JUMP.S 0x20214348
2021439e: ROT|| R7 = rot R5 by 0
202143a2: _LOAD P1 = [FP + 0x10]
202143a4: _NOP
202143a6: BITCLR (R5,0x1f)
202143a8: CC = R5 == 0x0
202143aa: LOAD R0 = [P1 + 0xc]
202143ac: ASHIFT R0 >>>= 0x12
202143ae: ADD R0 += 0x1
202143b0: IF CC JUMP 0x20214420
202143b2: CC = R0 <= 0x0
202143b4: IF CC JUMP 0x20214414
202143b6: LOAD R5 = 0x0
202143b8: LOAD P2 = [FP + -0x38]
202143ba: LOAD R4 = 0x4d5c
202143be: LOAD R6 = 0x0
202143c0: LOAD P1 = -0x1
202143c2: LSETUP (0x202143c6,0x2021440c) LC1 = P1
202143c6: ROT|| R1 = rot R7 by 0
202143ca: _LOAD P1 = [FP + -0x24]
202143cc: _NOP
202143ce: LOAD R3 = 0x5cfc
202143d2: ADD R6 += 0x1
202143d4: LOAD R0 = [P2++]
202143d6: LOAD R2 = W [P1] (X)
202143d8: MULT|| R2 = R2.L * R3.L (is)
202143dc: LOAD R3 = [FP + -0x18]
202143de: NOP
202143e0: ADD R2 = R3 + R2
202143e2: ADD R2 = R2 + R4
202143e4: ADD R2 = R2 + R5
202143e6: MOVE P0 = R2
202143e8: LOAD P1.L = 0x1814
202143ec: LOAD P1.H = 0xffa0
202143f0: CALL (P1)
202143f2: LOAD P1.L = 0x290c
202143f6: LOAD P1.H = 0xffa0
202143fa: CALL (P1)
202143fc: LOAD P1 = [FP + 0x10]
202143fe: MOVE R1 = R6.L (X)

==== site 202143f2
202143b2: CC = R0 <= 0x0
202143b4: IF CC JUMP 0x20214414
202143b6: LOAD R5 = 0x0
202143b8: LOAD P2 = [FP + -0x38]
202143ba: LOAD R4 = 0x4d5c
202143be: LOAD R6 = 0x0
202143c0: LOAD P1 = -0x1
202143c2: LSETUP (0x202143c6,0x2021440c) LC1 = P1
202143c6: ROT|| R1 = rot R7 by 0
202143ca: _LOAD P1 = [FP + -0x24]
202143cc: _NOP
202143ce: LOAD R3 = 0x5cfc
202143d2: ADD R6 += 0x1
202143d4: LOAD R0 = [P2++]
202143d6: LOAD R2 = W [P1] (X)
202143d8: MULT|| R2 = R2.L * R3.L (is)
202143dc: LOAD R3 = [FP + -0x18]
202143de: NOP
202143e0: ADD R2 = R3 + R2
202143e2: ADD R2 = R2 + R4
202143e4: ADD R2 = R2 + R5
202143e6: MOVE P0 = R2
202143e8: LOAD P1.L = 0x1814
202143ec: LOAD P1.H = 0xffa0
202143f0: CALL (P1)
202143f2: LOAD P1.L = 0x290c
202143f6: LOAD P1.H = 0xffa0
202143fa: CALL (P1)
202143fc: LOAD P1 = [FP + 0x10]
202143fe: MOVE R1 = R6.L (X)
20214400: STORE W [P0] = R0.L
20214402: ADD R5 += 0x2
20214404: LOAD R0 = [P1 + 0xc]
20214406: ASHIFT R0 >>>= 0x12
20214408: ADD R0 += 0x1
2021440a: CC = R1 < R0
2021440c: IF !CC JUMP 0x20214410
2021440e: JUMP.S 0x202143c0
20214410: STORE W [P3 + -0x4] = R6
20214414: ADD SP += 0x24
20214416: POP (R7:4,P5:3) = [SP++]
20214418: UNLINK
2021441c: LOAD R0 = 0x0
2021441e: RTS
20214420: CC = R0 <= 0x0
20214422: IF CC JUMP 0x20214414
20214424: LOAD P0 = -0x1
20214426: LOAD R3 = 0x4d5c
2021442a: LOAD R2 = 0x0
2021442c: LOAD R1 = 0x0
2021442e: LOAD R6 = [FP + -0x18]
20214430: LOAD P2 = [FP + 0x10]
20214432: LSETUP (0x20214436,0x2021445a) LC0 = P0
20214436: LOAD P1 = [FP + -0x24]
20214438: LOAD R7.H = 0x5cfc
2021443c: ADD R1 += 0x1
2021443e: LOAD R0 = W [P1] (X)
20214440: MULT R0 = R0.L * R7.H (is)
20214444: ADD R0 = R6 + R0
20214446: ADD R0 = R0 + R3
20214448: ADD R0 = R0 + R2
2021444a: MOVE P1 = R0
2021444c: MOVE R7 = R1.L (X)
2021444e: ADD R2 += 0x2
20214450: STORE W [P1] = R3.H
20214452: LOAD R0 = [P2 + 0xc]
20214454: ASHIFT R0 >>>= 0x12
20214456: ADD R0 += 0x1
20214458: CC = R7 < R0
2021445a: IF !CC JUMP 0x2021445e
2021445c: JUMP.S 0x20214432
2021445e: STORE W [P3 + -0x4] = R1
20214462: JUMP.S 0x20214414
20214464: CC = R0 <= 0x0
20214466: IF CC JUMP 0x2021439e
20214468: LOAD P0 = -0x1
2021446a: LOAD R1 = 0x0
2021446c: LOAD R3 = 0x2938
20214470: LOAD R2 = 0x0
20214472: LOAD P2 = [FP + 0x10]

==== site 20231e14
20231dd4: LOAD P0 = [FP + -0x40]
20231dd6: LOAD R3 = W [P1] (X)
20231dd8: ADD R3 += 0x1
20231dda: LOAD R0 = W [P0] (X)
20231ddc: SUB R0.L = R3.L - R0.L (s)
20231de0: MOVE CC = an
20231de2: STORE W [P3 + -0xac] = R3
20231de6: IF CC JUMP 0x20231c80 (bp)
20231de8: LOAD P1 = [FP + -0x40]
20231dea: STORE W [P3 + -0xac] = R4
20231dee: LOAD R0 = W [P1] (X)
20231df0: CC = R0 <= 0x0
20231df2: IF CC JUMP 0x20231e38
20231df4: LOAD P0 = [FP + -0x50]
20231df6: LOAD P1 = 0x4c20
20231dfa: LOAD P1.H = 0x3
20231dfe: LOAD P2 = 0x0
20231e00: LOAD R3 = 0x0
20231e02: ADD P0 = P0 + P1
20231e04: LOAD P5 = 0x18
20231e06: LOAD P1 = -0x1
20231e08: LSETUP (0x20231e0c,0x20231e30) LC0 = P1
20231e0c: LOAD P4 = [P3 + 0x24]
20231e0e: NOP
20231e10: NOP
20231e12: LOAD R0 = [P0 ++ P5]
20231e14: LOAD P1.L = 0x290c
20231e18: LOAD P1.H = 0xffa0
20231e1c: CALL (P1)
20231e1e: LOAD P1 = [FP + -0x40]
20231e20: ADD P4 = P4 + P2
20231e22: STORE W [P4] = R0.L
20231e24: ADD R3 += 0x1
20231e26: LOAD R0 = W [P1] (X)
20231e28: SUB R0.L = R3.L - R0.L (s)
20231e2c: MOVE CC = an
20231e2e: ADD P2 += 0x2
20231e30: IF !CC JUMP 0x20231e34
20231e32: JUMP.S 0x20231e06
20231e34: STORE W [P3 + -0xac] = R3
20231e38: LOAD P0 = [FP + -0x40]
20231e3a: LOAD R0 = [P3 + 0x24]
20231e3c: LOAD R1 = W [P0] (X)
20231e3e: LOAD P1.L = 0x33f8
20231e42: LOAD P1.H = 0xffa0
20231e46: CALL (P1)
20231e48: LOAD P1 = [FP + -0x40]
20231e4a: STORE [P3 + 0x3c] = R0
20231e4c: STORE W [P3 + -0xac] = R4
20231e50: LOAD R1 = W [P1] (X)
20231e52: CC = R1 <= 0x0
20231e54: IF CC JUMP 0x20231eee
20231e56: LOAD R1 = 0x0
20231e58: LOAD P5 = -0x1
20231e5a: MOVE P1 = R1
20231e5c: LOAD P0 = [P3 + 0x3c]
20231e5e: LOAD R2 = [FP + -0x34]
20231e60: ADD P1 = P0 + (P1 << 1)
20231e62: LOAD R0 = W [P1] (X)
20231e64: CC = R1 == R0
20231e66: IF CC JUMP 0x20231ec4
20231e68: LOAD R1 = W [P3 + -0xac] (X)
20231e6c: CALL 0x2022e55e
20231e70: LOAD R0 = W [P3 + -0xac] (X)
20231e74: MOVE P1 = R0
20231e76: ROT|| R1 = rot R0 by 0
20231e7a: _LOAD P0 = [P3 + 0x3c]
20231e7c: _NOP
20231e7e: ADD P2 = P0 + (P1 << 1)
20231e80: MOVE P1 = P2
20231e82: LSETUP (0x20231e86,0x20231ea4) LC0 = P5
20231e86: ROT|| R2 = rot R1 by 0
20231e8a: _LOAD R3 = W [P1++] (X)
20231e8c: _NOP
20231e8e: CC = R0 == R3
20231e90: ADD R2 += 0x1
20231e92: IF CC JUMP 0x20231ea8
20231e94: NOP

==== site 202ec894
202ec854: LOAD R0 = 0x0
202ec856: PACK|| R5 = pack(R5.H,R0.L)
202ec85a: _LOAD P5 = [SP + 0x34]
202ec85c: _NOP
202ec85e: MOVE I0 = P0
202ec860: MOVE I1 = P2
202ec862: LOAD R5.H = 0x4700
202ec866: LSETUP (0x202ec86a,0x202ec8ce) LC1 = P1
202ec86a: MNOP||
202ec86e: _LOAD R0 = W [P4] (X)
202ec870: _LOAD R6 = [I2++]
202ec872: LOAD P1.L = 0x1688
202ec876: LOAD P1.H = 0xffa0
202ec87a: CALL (P1)
202ec87c: LOAD R1 = [P5++]
202ec87e: LOAD P1.L = 0x18f0
202ec882: LOAD P1.H = 0xffa0
202ec886: CALL (P1)
202ec888: MOVE R1 = R5
202ec88a: LOAD P1.L = 0x1814
202ec88e: LOAD P1.H = 0xffa0
202ec892: CALL (P1)
202ec894: LOAD P1.L = 0x290c
202ec898: LOAD P1.H = 0xffa0
202ec89c: CALL (P1)
202ec89e: STORE W [I0++] = R0.L
202ec8a0: LOAD R0 = W [P4++] (X)
202ec8a2: LOAD P1.L = 0x1688
202ec8a6: LOAD P1.H = 0xffa0
202ec8aa: CALL (P1)
202ec8ac: MOVE R1 = R6
202ec8ae: LOAD P1.L = 0x18f0
202ec8b2: LOAD P1.H = 0xffa0
202ec8b6: CALL (P1)
202ec8b8: MOVE R1 = R5
202ec8ba: LOAD P1.L = 0x1814
202ec8be: LOAD P1.H = 0xffa0
202ec8c2: CALL (P1)
202ec8c4: LOAD P1.L = 0x290c
202ec8c8: LOAD P1.H = 0xffa0
202ec8cc: CALL (P1)
202ec8ce: STORE W [I1++] = R0.L
202ec8d0: STORE W [P3 + 0x0] = R7
202ec8d2: LOAD R2 = 0x1
202ec8d4: LOAD R1 = 0x0
202ec8d6: LOAD R0 = 0x1
202ec8d8: LOAD P1.L = 0x6008
202ec8dc: LOAD P1.H = 0xffa0
202ec8e0: CALL (P1)
202ec8e2: LOAD R0 = W [P3 + 0x10] (Z)
202ec8e4: ADD SP += 0x10
202ec8e6: POP (R7:4,P5:3) = [SP++]
202ec8e8: UNLINK
202ec8ec: RTS
202ec8ee: STORE W [P0] = R0.L
202ec8f0: JUMP.S 0x202ec832
202ec8f2: LSETUP (0x202ec8f6,0x202ec8f6) LC0 = P2
202ec8f6: STORE W [P0++] = R0
202ec8f8: JUMP.S 0x202ec832
202ec8fa: LOAD R0 = [FP + 0x18]
202ec8fc: LOAD P1.L = 0x16d4
202ec900: LOAD P1.H = 0xffa0
202ec904: CALL (P1)
202ec906: STORE [SP + 0xc] = R6
202ec908: MOVE R1 = R0
202ec90a: MOVE R0 = P4
202ec90c: LOAD R2 = 0x1
202ec90e: CALL 0x202ec468
202ec912: JUMP.S 0x202ec834
202ec914: LINK 0x0

==== site 202ec8c4
202ec886: CALL (P1)
202ec888: MOVE R1 = R5
202ec88a: LOAD P1.L = 0x1814
202ec88e: LOAD P1.H = 0xffa0
202ec892: CALL (P1)
202ec894: LOAD P1.L = 0x290c
202ec898: LOAD P1.H = 0xffa0
202ec89c: CALL (P1)
202ec89e: STORE W [I0++] = R0.L
202ec8a0: LOAD R0 = W [P4++] (X)
202ec8a2: LOAD P1.L = 0x1688
202ec8a6: LOAD P1.H = 0xffa0
202ec8aa: CALL (P1)
202ec8ac: MOVE R1 = R6
202ec8ae: LOAD P1.L = 0x18f0
202ec8b2: LOAD P1.H = 0xffa0
202ec8b6: CALL (P1)
202ec8b8: MOVE R1 = R5
202ec8ba: LOAD P1.L = 0x1814
202ec8be: LOAD P1.H = 0xffa0
202ec8c2: CALL (P1)
202ec8c4: LOAD P1.L = 0x290c
202ec8c8: LOAD P1.H = 0xffa0
202ec8cc: CALL (P1)
202ec8ce: STORE W [I1++] = R0.L
202ec8d0: STORE W [P3 + 0x0] = R7
202ec8d2: LOAD R2 = 0x1
202ec8d4: LOAD R1 = 0x0
202ec8d6: LOAD R0 = 0x1
202ec8d8: LOAD P1.L = 0x6008
202ec8dc: LOAD P1.H = 0xffa0
202ec8e0: CALL (P1)
202ec8e2: LOAD R0 = W [P3 + 0x10] (Z)
202ec8e4: ADD SP += 0x10
202ec8e6: POP (R7:4,P5:3) = [SP++]
202ec8e8: UNLINK
202ec8ec: RTS
202ec8ee: STORE W [P0] = R0.L
202ec8f0: JUMP.S 0x202ec832
202ec8f2: LSETUP (0x202ec8f6,0x202ec8f6) LC0 = P2
202ec8f6: STORE W [P0++] = R0
202ec8f8: JUMP.S 0x202ec832
202ec8fa: LOAD R0 = [FP + 0x18]
202ec8fc: LOAD P1.L = 0x16d4
202ec900: LOAD P1.H = 0xffa0
202ec904: CALL (P1)
202ec906: STORE [SP + 0xc] = R6
202ec908: MOVE R1 = R0
202ec90a: MOVE R0 = P4
202ec90c: LOAD R2 = 0x1
202ec90e: CALL 0x202ec468
202ec912: JUMP.S 0x202ec834
202ec914: LINK 0x0
202ec918: PUSH [--SP] = (R7:6,P5:3)
202ec91a: MOVE P3 = R0
202ec91c: MOVE R7 = R1
202ec91e: ADD SP += -0xc
202ec920: LOAD R6 = 0x0
202ec922: LOAD P4.L = 0xadb0
202ec926: LOAD P4.H = 0x202e
202ec92a: CC = R7 <= 0x0
202ec92c: STORE [P4] = R6
202ec92e: LOAD P5.L = 0x64f4
202ec932: LOAD P5.H = 0x2020
202ec936: IF CC JUMP 0x202ec96c
202ec938: MOVE P1 = R7
202ec93a: MOVE P0 = P3
202ec93c: LOAD R1 = 0x0
202ec93e: LOAD R2 = B [P5] (Z)
202ec940: LOAD R0 = B [P0++] (Z)
202ec942: ADD P1 += -0x1
202ec944: SUB R0 = R0 - R2

==== site ffa04baa
ffa04b6a: MOVE P2 = R1
ffa04b6c: ADD P1 = P0 + (P1 << 2)
ffa04b6e: LOAD R2 = [P1]
ffa04b70: ADD P2 = P3 + P2
ffa04b72: STORE [P2 + 0x5ce8] = R2
ffa04b76: IF CC JUMP 0xffa04be2
ffa04b78: NOP
ffa04b7a: LOAD P1 = [FP + 0x18]
ffa04b7c: LOAD P0 = [FP + -0x5c]
ffa04b7e: LOAD R0 = [P1 + 0xc]
ffa04b80: ASHIFT R0 >>>= 0xf
ffa04b82: ADD R0 += 0x1
ffa04b84: CC = R0 <= 0x0
ffa04b86: STORE W [P0 + -0x6] = R7
ffa04b8a: IF CC JUMP 0xffa04be2
ffa04b8c: LOAD P0 = 0x0
ffa04b8e: LOAD R6 = 0x0
ffa04b90: LOAD P2 = 0x44
ffa04b94: LOAD P1 = [FP + -0x44]
ffa04b96: MOVE I0 = P1
ffa04b98: LOAD P1 = -0x1
ffa04b9a: LSETUP (0xffa04b9e,0xffa04bd6) LC1 = P1
ffa04b9e: MNOP||
ffa04ba2: _LOAD R1 = [FP + 0x8]
ffa04ba4: _LOAD R0 = [I0++]
ffa04ba6: CALL 0xffa01814
ffa04baa: CALL 0xffa0290c
ffa04bae: LOAD R4 = W [P5] (X)
ffa04bb0: LOAD R1 = 0x5cfc
ffa04bb4: MULT|| R1 = R4.L * R1.L (is)
ffa04bb8: LOAD P3 = [FP + 0xc]
ffa04bba: NOP
ffa04bbc: MOVE P1 = R1
ffa04bbe: ADD R6 += 0x1
ffa04bc0: MOVE R2 = R6.L (X)
ffa04bc2: ADD P1 = P3 + P1
ffa04bc4: LOAD P3 = [FP + 0x18]
ffa04bc6: ADD P1 = P1 + P2
ffa04bc8: ADD P1 = P1 + P0
ffa04bca: STORE W [P1] = R0.L
ffa04bcc: LOAD R0 = [P3 + 0xc]
ffa04bce: ASHIFT R0 >>>= 0xf
ffa04bd0: ADD R0 += 0x1
ffa04bd2: CC = R2 < R0
ffa04bd4: ADD P0 += 0x2
ffa04bd6: IF !CC JUMP 0xffa04bdc
ffa04bd8: MOVE P1 = I0
ffa04bda: JUMP.S 0xffa04b96
ffa04bdc: LOAD P1 = [FP + -0x5c]
ffa04bde: STORE W [P1 + -0x6] = R6
ffa04be2: MOVE R6 = R5
ffa04be4: BITCLR (R5,0x1f)
ffa04be6: CC = R5 == 0x0
ffa04be8: IF CC JUMP 0xffa04c54
ffa04bea: NOP
ffa04bec: LOAD P1 = [FP + 0x18]
ffa04bee: LOAD P0 = [FP + -0x5c]
ffa04bf0: LOAD R0 = [P1 + 0xc]
ffa04bf2: ASHIFT R0 >>>= 0x12
ffa04bf4: ADD R0 += 0x1
ffa04bf6: CC = R0 <= 0x0
ffa04bf8: STORE W [P0 + -0x6] = R7
ffa04bfc: IF CC JUMP 0xffa04c54
ffa04bfe: LOAD P0 = 0x0
ffa04c00: LOAD R5 = 0x0
ffa04c02: LOAD P2 = [FP + -0x4c]
ffa04c04: LOAD P1 = -0x1
ffa04c06: LOAD R1 = W [P5] (X)
ffa04c08: LSETUP (0xffa04c0c,0xffa04c4a) LC1 = P1
ffa04c0c: LOAD R1.H = 0x5cfc
ffa04c10: MULT|| R1 = R1.L * R1.H (is)
ffa04c14: LOAD R0 = [P2++]
ffa04c16: NOP
ffa04c18: ROT|| R1 = rot R6 by 0
ffa04c1c: _STORE [FP + -0x58] = R1
ffa04c1e: _NOP
ffa04c20: CALL 0xffa01814
ffa04c24: CALL 0xffa0290c
ffa04c28: LOAD P3 = [FP + -0x58]
ffa04c2a: LOAD P1 = [FP + 0xc]

==== site ffa04c24
ffa04be4: BITCLR (R5,0x1f)
ffa04be6: CC = R5 == 0x0
ffa04be8: IF CC JUMP 0xffa04c54
ffa04bea: NOP
ffa04bec: LOAD P1 = [FP + 0x18]
ffa04bee: LOAD P0 = [FP + -0x5c]
ffa04bf0: LOAD R0 = [P1 + 0xc]
ffa04bf2: ASHIFT R0 >>>= 0x12
ffa04bf4: ADD R0 += 0x1
ffa04bf6: CC = R0 <= 0x0
ffa04bf8: STORE W [P0 + -0x6] = R7
ffa04bfc: IF CC JUMP 0xffa04c54
ffa04bfe: LOAD P0 = 0x0
ffa04c00: LOAD R5 = 0x0
ffa04c02: LOAD P2 = [FP + -0x4c]
ffa04c04: LOAD P1 = -0x1
ffa04c06: LOAD R1 = W [P5] (X)
ffa04c08: LSETUP (0xffa04c0c,0xffa04c4a) LC1 = P1
ffa04c0c: LOAD R1.H = 0x5cfc
ffa04c10: MULT|| R1 = R1.L * R1.H (is)
ffa04c14: LOAD R0 = [P2++]
ffa04c16: NOP
ffa04c18: ROT|| R1 = rot R6 by 0
ffa04c1c: _STORE [FP + -0x58] = R1
ffa04c1e: _NOP
ffa04c20: CALL 0xffa01814
ffa04c24: CALL 0xffa0290c
ffa04c28: LOAD P3 = [FP + -0x58]
ffa04c2a: LOAD P1 = [FP + 0xc]
ffa04c2c: ADD R5 += 0x1
ffa04c2e: MOVE R1 = R5.L (X)
ffa04c30: ADD P1 = P1 + P3
ffa04c32: LOAD P3 = 0x3374
ffa04c36: ADD P1 = P1 + P3
ffa04c38: LOAD P3 = [FP + 0x18]
ffa04c3a: ADD P1 = P1 + P0
ffa04c3c: STORE W [P1] = R0.L
ffa04c3e: ADD P0 += 0x2
ffa04c40: LOAD R0 = [P3 + 0xc]
ffa04c42: ASHIFT R0 >>>= 0x12
ffa04c44: ADD R0 += 0x1
ffa04c46: CC = R1 < R0
ffa04c48: IF !CC JUMP 0xffa04c4e
ffa04c4a: LOAD R1 = W [P5] (X)
ffa04c4c: JUMP.S 0xffa04c04
ffa04c4e: LOAD P1 = [FP + -0x5c]
ffa04c50: STORE W [P1 + -0x6] = R5
ffa04c54: LOAD R0 = [FP + 0x10]
ffa04c56: BITCLR (R0,0x1f)
ffa04c58: CC = R0 == 0x0
ffa04c5a: IF CC JUMP 0xffa04cc6
ffa04c5c: NOP
ffa04c5e: LOAD P1 = [FP + 0x18]
ffa04c60: LOAD P0 = [FP + -0x5c]
ffa04c62: LOAD R0 = [P1 + 0xc]
ffa04c64: ASHIFT R0 >>>= 0x12
ffa04c66: ADD R0 += 0x1
ffa04c68: CC = R0 <= 0x0
ffa04c6a: STORE W [P0 + -0x6] = R7
ffa04c6e: IF CC JUMP 0xffa04cc6
ffa04c70: LOAD P0 = 0x0
ffa04c72: LOAD R6 = 0x0
ffa04c74: LOAD P2 = 0x3892
ffa04c78: LOAD P1 = [FP + -0x54]
ffa04c7a: MOVE I0 = P1
ffa04c7c: LOAD P1 = -0x1
ffa04c7e: LSETUP (0xffa04c82,0xffa04cba) LC1 = P1
ffa04c82: MNOP||
ffa04c86: _LOAD R1 = [FP + 0x10]
ffa04c88: _LOAD R0 = [I0++]
ffa04c8a: CALL 0xffa01814
ffa04c8e: CALL 0xffa0290c
ffa04c92: LOAD R5 = W [P5] (X)
ffa04c94: LOAD R1 = 0x5cfc
ffa04c98: MULT|| R1 = R5.L * R1.L (is)
ffa04c9c: LOAD P3 = [FP + 0xc]
ffa04c9e: NOP
ffa04ca0: MOVE P1 = R1
ffa04ca2: ADD R6 += 0x1
ffa04ca4: MOVE R2 = R6.L (X)

==== site ffa04c8e
ffa04c4e: LOAD P1 = [FP + -0x5c]
ffa04c50: STORE W [P1 + -0x6] = R5
ffa04c54: LOAD R0 = [FP + 0x10]
ffa04c56: BITCLR (R0,0x1f)
ffa04c58: CC = R0 == 0x0
ffa04c5a: IF CC JUMP 0xffa04cc6
ffa04c5c: NOP
ffa04c5e: LOAD P1 = [FP + 0x18]
ffa04c60: LOAD P0 = [FP + -0x5c]
ffa04c62: LOAD R0 = [P1 + 0xc]
ffa04c64: ASHIFT R0 >>>= 0x12
ffa04c66: ADD R0 += 0x1
ffa04c68: CC = R0 <= 0x0
ffa04c6a: STORE W [P0 + -0x6] = R7
ffa04c6e: IF CC JUMP 0xffa04cc6
ffa04c70: LOAD P0 = 0x0
ffa04c72: LOAD R6 = 0x0
ffa04c74: LOAD P2 = 0x3892
ffa04c78: LOAD P1 = [FP + -0x54]
ffa04c7a: MOVE I0 = P1
ffa04c7c: LOAD P1 = -0x1
ffa04c7e: LSETUP (0xffa04c82,0xffa04cba) LC1 = P1
ffa04c82: MNOP||
ffa04c86: _LOAD R1 = [FP + 0x10]
ffa04c88: _LOAD R0 = [I0++]
ffa04c8a: CALL 0xffa01814
ffa04c8e: CALL 0xffa0290c
ffa04c92: LOAD R5 = W [P5] (X)
ffa04c94: LOAD R1 = 0x5cfc
ffa04c98: MULT|| R1 = R5.L * R1.L (is)
ffa04c9c: LOAD P3 = [FP + 0xc]
ffa04c9e: NOP
ffa04ca0: MOVE P1 = R1
ffa04ca2: ADD R6 += 0x1
ffa04ca4: MOVE R2 = R6.L (X)
ffa04ca6: ADD P1 = P3 + P1
ffa04ca8: LOAD P3 = [FP + 0x18]
ffa04caa: ADD P1 = P1 + P2
ffa04cac: ADD P1 = P1 + P0
ffa04cae: STORE W [P1] = R0.L
ffa04cb0: LOAD R0 = [P3 + 0xc]
ffa04cb2: ASHIFT R0 >>>= 0x12
ffa04cb4: ADD R0 += 0x1
ffa04cb6: CC = R2 < R0
ffa04cb8: ADD P0 += 0x2
ffa04cba: IF !CC JUMP 0xffa04cc0
ffa04cbc: MOVE P1 = I0
ffa04cbe: JUMP.S 0xffa04c7a
ffa04cc0: LOAD P1 = [FP + -0x5c]
ffa04cc2: STORE W [P1 + -0x6] = R6
ffa04cc6: LOAD R0 = [FP + -0x24]
ffa04cc8: BITCLR (R0,0x1f)
ffa04cca: CC = R0 == 0x0
ffa04ccc: LOAD R5 = [FP + -0x24]
ffa04cce: IF CC JUMP 0xffa04d38
ffa04cd0: NOP
ffa04cd2: LOAD P1 = [FP + 0x18]
ffa04cd4: LOAD P0 = [FP + -0x5c]
ffa04cd6: LOAD R0 = [P1 + 0xc]
ffa04cd8: ASHIFT R0 >>>= 0x12
ffa04cda: ADD R0 += 0x1
ffa04cdc: CC = R0 <= 0x0
ffa04cde: STORE W [P0 + -0x6] = R7
ffa04ce2: IF CC JUMP 0xffa04d38
ffa04ce4: LOAD P0 = 0x0
ffa04ce6: LOAD R6 = 0x0
ffa04ce8: LOAD P2 = 0x3db0
ffa04cec: LOAD P1 = [FP + -0x50]
ffa04cee: MOVE I0 = P1
ffa04cf0: LOAD P1 = -0x1
ffa04cf2: LSETUP (0xffa04cf6,0xffa04d2c) LC1 = P1
ffa04cf6: ROT|| R1 = rot R5 by 0
ffa04cfa: _LOAD R4 = W [P5] (X)
ffa04cfc: _LOAD R0 = [I0++]
ffa04cfe: CALL 0xffa01814
ffa04d02: CALL 0xffa0290c
ffa04d06: LOAD R1 = 0x5cfc
ffa04d0a: MULT|| R1 = R4.L * R1.L (is)
ffa04d0e: LOAD P3 = [FP + 0xc]

==== site ffa04d02
ffa04cc2: STORE W [P1 + -0x6] = R6
ffa04cc6: LOAD R0 = [FP + -0x24]
ffa04cc8: BITCLR (R0,0x1f)
ffa04cca: CC = R0 == 0x0
ffa04ccc: LOAD R5 = [FP + -0x24]
ffa04cce: IF CC JUMP 0xffa04d38
ffa04cd0: NOP
ffa04cd2: LOAD P1 = [FP + 0x18]
ffa04cd4: LOAD P0 = [FP + -0x5c]
ffa04cd6: LOAD R0 = [P1 + 0xc]
ffa04cd8: ASHIFT R0 >>>= 0x12
ffa04cda: ADD R0 += 0x1
ffa04cdc: CC = R0 <= 0x0
ffa04cde: STORE W [P0 + -0x6] = R7
ffa04ce2: IF CC JUMP 0xffa04d38
ffa04ce4: LOAD P0 = 0x0
ffa04ce6: LOAD R6 = 0x0
ffa04ce8: LOAD P2 = 0x3db0
ffa04cec: LOAD P1 = [FP + -0x50]
ffa04cee: MOVE I0 = P1
ffa04cf0: LOAD P1 = -0x1
ffa04cf2: LSETUP (0xffa04cf6,0xffa04d2c) LC1 = P1
ffa04cf6: ROT|| R1 = rot R5 by 0
ffa04cfa: _LOAD R4 = W [P5] (X)
ffa04cfc: _LOAD R0 = [I0++]
ffa04cfe: CALL 0xffa01814
ffa04d02: CALL 0xffa0290c
ffa04d06: LOAD R1 = 0x5cfc
ffa04d0a: MULT|| R1 = R4.L * R1.L (is)
ffa04d0e: LOAD P3 = [FP + 0xc]
ffa04d10: NOP
ffa04d12: MOVE P1 = R1
ffa04d14: ADD R6 += 0x1
ffa04d16: MOVE R2 = R6.L (X)
ffa04d18: ADD P1 = P3 + P1
ffa04d1a: LOAD P3 = [FP + 0x18]
ffa04d1c: ADD P1 = P1 + P2
ffa04d1e: ADD P1 = P1 + P0
ffa04d20: STORE W [P1] = R0.L
ffa04d22: LOAD R0 = [P3 + 0xc]
ffa04d24: ASHIFT R0 >>>= 0x12
ffa04d26: ADD R0 += 0x1
ffa04d28: CC = R2 < R0
ffa04d2a: ADD P0 += 0x2
ffa04d2c: IF !CC JUMP 0xffa04d32
ffa04d2e: MOVE P1 = I0
ffa04d30: JUMP.S 0xffa04cee
ffa04d32: LOAD P1 = [FP + -0x5c]
ffa04d34: STORE W [P1 + -0x6] = R6
ffa04d38: LOAD R0 = 0x5
ffa04d3a: LOAD R1 = [FP + 0x28]
ffa04d3c: CC = R1 == R0
ffa04d3e: IF !CC JUMP 0xffa04e04
ffa04d40: LOAD R0 = 0xff
ffa04d44: LSHIFT R0 <<= 0x17
ffa04d46: STORE [FP + 0x8] = R0
ffa04d48: LOAD P1 = 0x147
ffa04d4c: MOVE P0 = P4
ffa04d4e: LOAD R1 = [FP + -0x8]
ffa04d50: LSETUP (0xffa04d54,0xffa04d98) LC0 = P1
ffa04d54: ROT|| R0 = rot R1 by 0
ffa04d58: _LOAD R2 = [P0++]
ffa04d5a: _NOP
ffa04d5c: AND R4 = R1 & R2
ffa04d5e: LSH|| R4 = R4 >> 0x1f
ffa04d62: _LOAD R5 = [FP + 0x8]
ffa04d64: _NOP
ffa04d66: ROT|| R3 = rot R2 by 0
ffa04d6a: _STORE [FP + -0x58] = R4
ffa04d6c: _NOP
ffa04d6e: BITCLR (R0,0x1f)
ffa04d70: BITCLR (R3,0x1f)
ffa04d72: CC = R5 < R0
ffa04d74: LOAD R4 = [FP + 0x8]
ffa04d76: OR R5 = R0 | R3
ffa04d78: MOVE R0 = CC
ffa04d7a: CC = R4 < R3
ffa04d7c: LOAD R6 = 0x1
ffa04d7e: IF !CC R6 = R0
ffa04d80: CC = R2 < R1

==== site ffa04dfc
ffa04dbc: CC = R1 == 0x0
ffa04dbe: STORE [P0 + 0x5cf8] = R4
ffa04dc2: STORE W [P2] = R0.L
ffa04dc4: IF CC JUMP 0xffa04e04
ffa04dc6: LOAD P0 = [FP + 0xc]
ffa04dc8: LOAD R0 = 0x578
ffa04dcc: LOAD R6 = 0x0
ffa04dce: LOAD R1 = [FP + -0x40]
ffa04dd0: MOVE I0 = P0
ffa04dd2: ADD R5 = R1 + R0
ffa04dd4: ADD I0 += M0
ffa04dd6: LSETUP (0xffa04dda,0xffa04e02) LC1 = P1
ffa04dda: MNOP||
ffa04dde: _LOAD R0 = [P4++]
ffa04de0: _LOAD R1.L = W [I0]
ffa04de2: LOAD R2 = 0x5cfc
ffa04de6: MULT R1 = R1.L * R2.L (is)
ffa04dea: ADD R1 = R5 + R1
ffa04dec: LOAD R3 = 0x5a26
ffa04df0: ADD R1 = R1 + R3
ffa04df2: ADD R1 = R1 + R6
ffa04df4: MOVE P0 = R1
ffa04df6: MOVE R1 = R4
ffa04df8: CALL 0xffa01814
ffa04dfc: CALL 0xffa0290c
ffa04e00: ADD R6 += 0x2
ffa04e02: STORE W [P0] = R0.L
ffa04e04: LOAD R0 = [FP + 0x28]
ffa04e06: LOAD R1 = 0x7
ffa04e08: CC = R0 == R1
ffa04e0a: IF !CC JUMP 0xffa04ed4
ffa04e0c: LOAD P0 = [FP + -0x48]
ffa04e0e: LOAD R0 = 0xff
ffa04e12: LSHIFT R0 <<= 0x17
ffa04e14: STORE [FP + 0x8] = R0
ffa04e16: LOAD P2 = 0x147
ffa04e1a: MOVE P1 = P0
ffa04e1c: LOAD R1 = [FP + -0x4]
ffa04e1e: LSETUP (0xffa04e22,0xffa04e6a) LC0 = P2
ffa04e22: ROT|| R0 = rot R1 by 0
ffa04e26: _LOAD R3 = [P1++]
ffa04e28: _NOP
ffa04e2a: AND R4 = R0 & R3
ffa04e2c: LSH|| R4 = R4 >> 0x1f
ffa04e30: _LOAD R5 = [FP + 0x8]
ffa04e32: _NOP
ffa04e34: ROT|| R2 = rot R3 by 0
ffa04e38: _STORE [FP + -0x58] = R4
ffa04e3a: _NOP
ffa04e3c: BITCLR (R1,0x1f)
ffa04e3e: BITCLR (R2,0x1f)
ffa04e40: CC = R5 < R1
ffa04e42: LOAD R4 = [FP + 0x8]
ffa04e44: OR R5 = R1 | R2
ffa04e46: MOVE R1 = CC
ffa04e48: CC = R4 < R2
ffa04e4a: LOAD R6 = 0x1
ffa04e4c: IF !CC R6 = R1
ffa04e4e: CC = R3 < R0
ffa04e50: MOVE R4 = CC
ffa04e52: ROT|| R1 = rot R3 by 0
ffa04e56: _LOAD R2 = [FP + -0x58]
ffa04e58: _NOP
ffa04e5a: CC = R0 == R3
ffa04e5c: XOR R2 = R2 ^ R4
ffa04e5e: IF !CC R4 = R2
ffa04e60: CC = R5 == 0x0
ffa04e62: IF CC R4 = R5
ffa04e64: CC = BITTST (R6,0x0)
ffa04e66: IF CC R4 = R7
ffa04e68: CC = BITTST (R4,0x0)
ffa04e6a: IF CC R1 = R0
ffa04e6c: LOAD R0 = W [P5] (X)
ffa04e6e: LOAD R2 = 0x5cfc
ffa04e72: MULT|| R0 = R0.L * R2.L (is)
ffa04e76: STORE [FP + -0x4] = R1
ffa04e78: NOP
ffa04e7a: MOVE P1 = R0
ffa04e7c: LOAD P4 = [FP + -0x5c]

==== site ffa04ecc
ffa04e8c: LOAD R5 = [FP + -0x4]
ffa04e8e: CC = R1 == 0x0
ffa04e90: STORE [P1 + 0x5cf4] = R5
ffa04e94: STORE W [P4] = R2.H
ffa04e96: IF CC JUMP 0xffa04ed4
ffa04e98: LOAD P1 = [FP + 0xc]
ffa04e9a: LOAD R0 = 0x578
ffa04e9e: LOAD R6 = 0x5798
ffa04ea2: LOAD R1 = [FP + -0x40]
ffa04ea4: MOVE I0 = P1
ffa04ea6: ADD R4 = R1 + R0
ffa04ea8: ADD I0 += M0
ffa04eaa: LSETUP (0xffa04eae,0xffa04ed2) LC1 = P2
ffa04eae: MNOP||
ffa04eb2: _LOAD R0 = [P0++]
ffa04eb4: _LOAD R1.L = W [I0]
ffa04eb6: LOAD R2 = 0x5cfc
ffa04eba: MULT R1 = R1.L * R2.L (is)
ffa04ebe: ADD R1 = R4 + R1
ffa04ec0: ADD R1 = R1 + R6
ffa04ec2: ADD R1 = R1 + R7
ffa04ec4: MOVE P2 = R1
ffa04ec6: MOVE R1 = R5
ffa04ec8: CALL 0xffa01814
ffa04ecc: CALL 0xffa0290c
ffa04ed0: ADD R7 += 0x2
ffa04ed2: STORE W [P2] = R0.L
ffa04ed4: ADD SP += 0x20
ffa04ed6: POP (R7:4,P5:3) = [SP++]
ffa04ed8: UNLINK
ffa04edc: LOAD R0 = 0x0
ffa04ede: RTS
ffa04ee0: LOAD P1 = [P2 + 0x4]
ffa04ee2: ADD P1 = P4 + (P1 << 2)
ffa04ee4: STORE [P1] = R6
ffa04ee6: JUMP.S 0xffa04930
ffa04ee8: LOAD P1 = [P2 + 0x4]
ffa04eea: LOAD R6 = [P2 + 0x18]
ffa04eec: MOVE R1 = R6
ffa04eee: ADD P0 = P4 + (P1 << 2)
ffa04ef0: LOAD R0 = [P0]
ffa04ef2: CALL 0xffa0165c
ffa04ef6: IF CC JUMP 0xffa04efa (bp)
ffa04ef8: JUMP.S 0xffa04930
ffa04efa: STORE [P0] = R6
ffa04efc: JUMP.S 0xffa04930
ffa04efe: LOAD R0 = [FP + 0x28]
ffa04f00: LOAD R1 = 0x7
ffa04f02: CC = R0 == R1
ffa04f04: IF CC JUMP 0xffa04f08 (bp)
ffa04f06: JUMP.S 0xffa04930
ffa04f08: LOAD P1 = [FP + -0x5c]
ffa04f0a: LOAD P3 = [FP + -0x5c]
ffa04f0c: LOAD R2 = 0xff
ffa04f10: LSH R6 = R2 << 0x17
ffa04f14: LOAD P1 = [P1 + 0x4]
ffa04f16: LOAD R1 = [P3 + 0xc]
ffa04f18: LOAD R0 = [P3 + 0x14]
ffa04f1a: STORE [FP + 0x20] = P1
ffa04f1c: CALL 0xffa018f0
ffa04f20: ROT|| R1 = rot R0 by 0
ffa04f24: _LOAD P1 = [FP + 0x20]
ffa04f26: _NOP
ffa04f28: LOAD P0 = [FP + -0x48]
ffa04f2a: BITCLR (R0,0x1f)
ffa04f2c: CC = R6 < R0
ffa04f2e: LOAD R5 = 0x1
ffa04f30: ADD P1 = P0 + (P1 << 2)
ffa04f32: LOAD R3 = [P1]
ffa04f34: AND R4 = R1 & R3
ffa04f36: LSHIFT R4 >>= 0x1f
ffa04f38: ROT|| R2 = rot R3 by 0
ffa04f3c: _STORE [FP + 0x20] = R4
ffa04f3e: _NOP
ffa04f40: BITCLR (R2,0x1f)
ffa04f42: MOVE R4 = CC
ffa04f44: CC = R6 < R2
ffa04f46: IF !CC R5 = R4
ffa04f48: CC = R3 < R1
ffa04f4a: OR R0 = R0 | R2

