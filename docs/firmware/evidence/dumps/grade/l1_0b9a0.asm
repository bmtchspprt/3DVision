ffa0b900: JUMP (P1)
ffa0b902: IF CC JUMP 0xffa0b92c
ffa0b904: MOVE P1 = R2
ffa0b906: MOVE P0 = P2
ffa0b908: ADD P0 += 0x1c
ffa0b90a: PACK R4 = pack(R7.L,R4.L)
ffa0b90e: LSETUP (0xffa0b912,0xffa0b926) LC0 = P4
ffa0b912: NOP
ffa0b914: STORE [P1 + 0x24] = R0
ffa0b916: STORE [P1 + 0x28] = R0
ffa0b918: LOAD R1 = [P2 + 0x18]
ffa0b91a: CC = R1 == 0x1
ffa0b91c: IF CC JUMP 0xffa0b948
ffa0b91e: STORE [P5] = P1
ffa0b920: LOAD R1 = [P1 + 0x2c]
ffa0b922: CC = R1 == 0x0
ffa0b924: LOAD P1 = [P1 + 0x2c]
ffa0b926: IF CC JUMP 0xffa0b92c
ffa0b928: JUMP.S 0xffa0b90a
ffa0b92c: LOAD R1 = B [P2 + 0x16] (Z)
ffa0b930: CC = R1 == 0x1
ffa0b932: IF !CC JUMP 0xffa0b944
ffa0b934: LOAD R1 = [P2 + 0x18]
ffa0b936: CC = R1 == 0x1
ffa0b938: IF !CC JUMP 0xffa0b944
ffa0b93a: NOP
ffa0b93c: NOP
ffa0b93e: NOP
ffa0b940: LOAD P1 = [P5]
ffa0b942: STORE [P1 + 0x20] = P1
ffa0b944: POP (R7:4,P5:3) = [SP++]
ffa0b946: RTS
ffa0b948: LOAD R1 = W [P0] (X)
ffa0b94a: LOAD R2 = [P1 + 0x1c]
ffa0b94c: MOVE P3 = P1
ffa0b94e: LSH|| R2 = R2 >> 0x1
ffa0b952: _STORE W [P1 + 0x8] = R1
ffa0b954: _NOP
ffa0b956: ADD P3 += 0x8
ffa0b958: PACK|| R5 = pack(R2.L,R5.L)
ffa0b95c: _LOAD R1 = W [P3] (Z)
ffa0b95e: _NOP
ffa0b960: DEPOSIT R2 = deposit(R1,R5)
ffa0b964: ROT|| R1 = rot R3 by 0
ffa0b968: _STORE W [P3] = R2.L
ffa0b96a: _NOP
ffa0b96c: LOAD R2 = W [P3] (Z)
ffa0b96e: DEPOSIT R2 = deposit(R2,R4)
ffa0b972: STORE W [P3] = R2.L
ffa0b974: LOAD R2 = W [P3] (X)
ffa0b976: BITCLR (R2,0x4)
ffa0b978: STORE W [P3] = R2.L
ffa0b97a: LOAD R2 = [P1 + 0x20]
ffa0b97c: CC = R2 == 0x0
ffa0b97e: IF !CC R1 = R6
ffa0b980: STORE W [P1 + 0x12] = R1
ffa0b982: LOAD R1 = W [P1 + 0x18] (X)
ffa0b984: STORE W [P1 + 0xa] = R1
ffa0b986: LOAD R1 = [P1 + 0x1c]
ffa0b988: STORE W [P1 + 0xc] = R1
ffa0b98a: LOAD R1 = [P1 + 0x14]
ffa0b98c: LSH|| R2.L = R1.H << 0x0
ffa0b990: STORE W [P1 + 0x4] = R1
ffa0b992: NOP
ffa0b994: LOAD R1 = [P1 + 0x2c]
ffa0b996: CC = R1 == 0x0
ffa0b998: STORE W [P1 + 0x6] = R2
ffa0b99a: IF CC JUMP 0xffa0b9a4
ffa0b99c: MOVE P3 = P1
ffa0b99e: STORE W [P3++] = R1
ffa0b9a0: STORE W [P3] = R1.H
ffa0b9a2: JUMP.S 0xffa0b91e
ffa0b9a4: MOVE I0 = P1
ffa0b9a6: STORE W [I0++] = R3.L
ffa0b9a8: STORE W [I0] = R0.H
ffa0b9aa: JUMP.S 0xffa0b91e
ffa0b9ac: CC = R2 == 0x0
ffa0b9ae: IF CC JUMP 0xffa0b9e8
ffa0b9b0: MOVE P1 = R2
ffa0b9b2: LOAD R5 = 0x202
ffa0b9b6: LOAD R6 = 0x101
ffa0b9ba: LOAD R1.H = 0x0
ffa0b9be: MOVE P0 = P2
ffa0b9c0: ADD P0 += 0x1c
ffa0b9c2: LOAD P4 = -0x1
ffa0b9c4: PACK R6 = pack(R7.L,R6.L)
ffa0b9c8: LSETUP (0xffa0b9cc,0xffa0b9e2) LC0 = P4
ffa0b9cc: NOP
ffa0b9ce: STORE [P1 + 0x30] = R0
ffa0b9d0: STORE [P1 + 0x34] = R0
ffa0b9d2: LOAD R2 = [P2 + 0x18]
ffa0b9d4: CC = R2 == 0x1
ffa0b9d6: MOVE I0 = P1
ffa0b9d8: IF CC JUMP 0xffa0ba04
ffa0b9da: STORE [P5] = P1
ffa0b9dc: LOAD R2 = [P1 + 0x38]
ffa0b9de: CC = R2 == 0x0
ffa0b9e0: LOAD P1 = [P1 + 0x38]
ffa0b9e2: IF CC JUMP 0xffa0b9e8
ffa0b9e4: JUMP.S 0xffa0b9c4
ffa0b9e8: LOAD R1 = B [P2 + 0x16] (Z)
ffa0b9ec: CC = R1 == 0x1
ffa0b9ee: IF !CC JUMP 0xffa0b944
ffa0b9f0: LOAD R1 = [P2 + 0x18]
ffa0b9f2: CC = R1 == 0x1
ffa0b9f4: IF !CC JUMP 0xffa0b944
ffa0b9f6: NOP
ffa0b9f8: NOP
ffa0b9fa: NOP
ffa0b9fc: LOAD P1 = [P5]
ffa0b9fe: STORE [P1 + 0x2c] = P1
ffa0ba00: POP (R7:4,P5:3) = [SP++]
ffa0ba02: RTS
ffa0ba04: LOAD R2 = W [P0] (X)
ffa0ba06: LOAD R3 = [P1 + 0x18]
ffa0ba08: MOVE P3 = P1
ffa0ba0a: LSH|| R3 = R3 >> 0x1
ffa0ba0e: _STORE W [P1 + 0x8] = R2
ffa0ba10: _NOP
ffa0ba12: ADD P3 += 0x8
ffa0ba14: PACK|| R5 = pack(R3.L,R5.L)
ffa0ba18: _LOAD R2 = W [P3] (Z)
ffa0ba1a: _NOP
ffa0ba1c: DEPOSIT R2 = deposit(R2,R5)
ffa0ba20: SUB|| R3.L = R3.L - R3.L (ns)
ffa0ba24: _STORE W [P3] = R2.L
ffa0ba26: _NOP
ffa0ba28: LOAD R2 = W [P3] (Z)
ffa0ba2a: DEPOSIT R2 = deposit(R2,R6)
ffa0ba2e: STORE W [P3] = R2.L
ffa0ba30: LOAD R2 = W [P3] (X)
ffa0ba32: BITSET (R2,0x4)
ffa0ba34: STORE W [P3] = R2.L
ffa0ba36: LOAD R2 = [P1 + 0x2c]
ffa0ba38: CC = R2 == 0x0
ffa0ba3a: LOAD R2 = W [P1 + 0x1c] (X)
ffa0ba3c: STORE W [P1 + 0xa] = R2
ffa0ba3e: LOAD R2 = [P1 + 0x20]
ffa0ba40: STORE W [P1 + 0xc] = R2
ffa0ba42: LOAD R2 = W [P1 + 0x24] (X)
ffa0ba46: STORE W [P1 + 0xe] = R2
ffa0ba48: LOAD R2 = [P1 + 0x28]
ffa0ba4a: IF !CC R3 = R1
ffa0ba4c: STORE W [P1 + 0x10] = R2
ffa0ba4e: LOAD R2 = [P1 + 0x14]
ffa0ba50: LSH|| R3.L = R2.H << 0x0
ffa0ba54: STORE W [P1 + 0x12] = R3
ffa0ba56: NOP
ffa0ba58: STORE W [P1 + 0x4] = R2
ffa0ba5a: LOAD R2 = [P1 + 0x38]
ffa0ba5c: CC = R2 == 0x0
ffa0ba5e: STORE W [P1 + 0x6] = R3
ffa0ba60: IF CC JUMP 0xffa0ba68
ffa0ba62: STORE W [I0++] = R2.L
ffa0ba64: STORE W [I0] = R2.H
ffa0ba66: JUMP.S 0xffa0b9da
ffa0ba68: STORE W [I0++] = R1.H
ffa0ba6a: STORE W [I0] = R0.H
ffa0ba6c: JUMP.S 0xffa0b9da
ffa0ba6e: MOVE P1 = R2
ffa0ba70: LOAD R1 = W [P2 + 0x1c] (X)
ffa0ba72: BITSET (R1,0x7)
ffa0ba74: STORE W [P2 + 0x1c] = R1
ffa0ba76: LOAD R1 = [P1 + 0x24]
ffa0ba78: CC = R1 == 0x0
ffa0ba7a: IF CC JUMP 0xffa0bac2
ffa0ba7c: CC = R1 == 0x1
ffa0ba7e: IF CC JUMP 0xffa0baa6
ffa0ba80: CC = R1 == 0x2
ffa0ba82: IF !CC JUMP 0xffa0ba90
ffa0ba84: NOP
ffa0ba86: NOP
ffa0ba88: NOP
ffa0ba8a: LOAD R1 = W [P2 + 0x1c] (X)
ffa0ba8c: BITCLR (R1,0x6)
ffa0ba8e: STORE W [P2 + 0x1c] = R1
ffa0ba90: LSH|| R1.H = R7.L << 0x0
ffa0ba94: LOAD R2 = W [P2 + 0x1c] (Z)
ffa0ba96: NOP
ffa0ba98: LOAD R1.L = 0x101
ffa0ba9c: DEPOSIT R1 = deposit(R2,R1)
ffa0baa0: STORE W [P2 + 0x1c] = R1
ffa0baa2: POP (R7:4,P5:3) = [SP++]
ffa0baa4: RTS
ffa0baa6: LOAD R1 = W [P2 + 0x1c] (X)
ffa0baa8: BITSET (R1,0x6)
ffa0baaa: LSH|| R1.H = R7.L << 0x0
ffa0baae: STORE W [P2 + 0x1c] = R1
ffa0bab0: NOP
ffa0bab2: LOAD R2 = W [P2 + 0x1c] (Z)
ffa0bab4: LOAD R1.L = 0x101
ffa0bab8: DEPOSIT R1 = deposit(R2,R1)
ffa0babc: STORE W [P2 + 0x1c] = R1
ffa0babe: POP (R7:4,P5:3) = [SP++]
ffa0bac0: RTS
ffa0bac2: LOAD R1 = W [P2 + 0x1c] (X)
ffa0bac4: BITCLR (R1,0x7)
ffa0bac6: LSH|| R1.H = R7.L << 0x0
ffa0baca: STORE W [P2 + 0x1c] = R1
ffa0bacc: NOP
ffa0bace: LOAD R2 = W [P2 + 0x1c] (Z)
ffa0bad0: LOAD R1.L = 0x101
ffa0bad4: DEPOSIT R1 = deposit(R2,R1)
ffa0bad8: STORE W [P2 + 0x1c] = R1
ffa0bada: POP (R7:4,P5:3) = [SP++]
ffa0badc: RTS
ffa0bade: CC = R2 == 0x0
ffa0bae0: IF CC JUMP 0xffa0bb1c
ffa0bae2: MOVE P1 = R2
ffa0bae4: LOAD R6 = 0x202
ffa0bae8: LOAD R5 = 0x101
ffa0baec: LOAD R4.H = 0x0
ffa0baf0: MOVE P0 = P2
ffa0baf2: ADD P0 += 0x1c
ffa0baf4: LOAD P4 = -0x1
ffa0baf6: LOAD R1 = 0x1
ffa0baf8: LSETUP (0xffa0bafc,0xffa0bb18) LC0 = P4
ffa0bafc: NOP
ffa0bafe: SUB|| R3 = R3 - R3 (ns)
ffa0bb02: _STORE [P1 + 0x24] = R0
ffa0bb04: _NOP
ffa0bb06: STORE [P1 + 0x28] = R0
ffa0bb08: LOAD R2 = [P2 + 0x18]
ffa0bb0a: CC = R2 == 0x1
ffa0bb0c: MOVE I0 = P1
ffa0bb0e: IF CC JUMP 0xffa0bb38
ffa0bb10: STORE [P5] = P1
ffa0bb12: LOAD R2 = [P1 + 0x2c]
ffa0bb14: CC = R2 == 0x0
ffa0bb16: LOAD P1 = [P1 + 0x2c]
ffa0bb18: IF CC JUMP 0xffa0bb1c
ffa0bb1a: JUMP.S 0xffa0baf8
ffa0bb1c: LOAD R1 = B [P2 + 0x16] (Z)
ffa0bb20: CC = R1 == 0x1
ffa0bb22: IF !CC JUMP 0xffa0b944
ffa0bb24: LOAD R1 = [P2 + 0x18]
ffa0bb26: CC = R1 == 0x1
ffa0bb28: IF !CC JUMP 0xffa0b944
ffa0bb2a: NOP
ffa0bb2c: NOP
ffa0bb2e: NOP
ffa0bb30: LOAD P1 = [P5]
ffa0bb32: STORE [P1 + 0x20] = P1
ffa0bb34: POP (R7:4,P5:3) = [SP++]
ffa0bb36: RTS
ffa0bb38: MOVE P3 = P1
ffa0bb3a: ADD P3 += 0x8
ffa0bb3c: LOAD R2 = [P1 + 0x1c]
ffa0bb3e: LOAD R7 = W [P0] (X)
ffa0bb40: LSH|| R2 = R2 >> 0x1
ffa0bb44: _STORE W [P1 + 0x8] = R7
ffa0bb46: _NOP
ffa0bb48: PACK|| R6 = pack(R2.L,R6.L)
ffa0bb4c: _LOAD R2 = W [P3] (Z)
ffa0bb4e: _NOP
ffa0bb50: DEPOSIT R2 = deposit(R2,R6)
ffa0bb54: STORE W [P3] = R2.L
ffa0bb56: LOAD R2 = [P1 + 0x34]
ffa0bb58: CC = R2 == 0x1
ffa0bb5a: IF CC R3 = R2
ffa0bb5c: PACK|| R5 = pack(R3.L,R5.L)
ffa0bb60: _LOAD R2 = W [P3] (Z)
ffa0bb62: _NOP
ffa0bb64: DEPOSIT R2 = deposit(R2,R5)
ffa0bb68: STORE W [P3] = R2.L
ffa0bb6a: LOAD R2 = W [P3] (X)
ffa0bb6c: BITCLR (R2,0x4)
ffa0bb6e: SUB|| R2.L = R2.L - R2.L (ns)
ffa0bb72: _STORE W [P3] = R2.L
ffa0bb74: _NOP
ffa0bb76: LOAD R3 = [P1 + 0x20]
ffa0bb78: CC = R3 == 0x0
ffa0bb7a: IF !CC R2 = R1
ffa0bb7c: STORE W [P1 + 0x12] = R2
ffa0bb7e: LOAD R2 = [P1 + 0x14]
ffa0bb80: STORE W [P1 + 0x4] = R2
ffa0bb82: LOAD R3 = W [P1 + 0x18] (X)
ffa0bb84: PACK|| R2 = pack(R2.H,R2.H)
ffa0bb88: _STORE W [P1 + 0xa] = R3
ffa0bb8a: _NOP
ffa0bb8c: STORE W [P1 + 0x6] = R2
ffa0bb8e: LOAD R2 = [P1 + 0x2c]
ffa0bb90: CC = R2 == 0x0
ffa0bb92: LOAD R3 = [P1 + 0x1c]
ffa0bb94: STORE W [P1 + 0xc] = R3
ffa0bb96: IF CC JUMP 0xffa0bb9e
ffa0bb98: STORE W [I0++] = R2.L
ffa0bb9a: STORE W [I0] = R2.H
ffa0bb9c: JUMP.S 0xffa0bb10
ffa0bb9e: STORE W [I0++] = R4.H
ffa0bba0: STORE W [I0] = R0.H
ffa0bba2: JUMP.S 0xffa0bb10
ffa0bba4: POP (R7:4,P5:3) = [SP++]
ffa0bba6: RTS
ffa0bba8: POP (R7:4,P5:3) = [SP++]
ffa0bbaa: RTS
ffa0bbac: MOVE P0 = R0
ffa0bbae: LOAD R0 = -0x1
ffa0bbb0: LOAD R0.H = 0xfffc
ffa0bbb4: ADD R0 = R1 + R0
ffa0bbb6: CC = R0 < 0x4 (IU)
ffa0bbb8: LINK 0xc
ffa0bbbc: IF !CC JUMP 0xffa0bc04
ffa0bbbe: MOVE P1 = R0
ffa0bbc0: LOAD P2.L = 0x3bcc
ffa0bbc4: LOAD P2.H = 0xff80
ffa0bbc8: LOAD R0 = 0x401
ffa0bbcc: LOAD R1 = 0x1
ffa0bbce: ADD P1 = P2 + (P1 << 2)
ffa0bbd0: LOAD P1 = [P1]
ffa0bbd2: JUMP (P1)
ffa0bbd4: MOVE P1 = R2
ffa0bbd6: LOAD R3 = W [P1 + 0x8] (X)
ffa0bbd8: EXTRACT R0 = extract(R3,R0.L) (z)
ffa0bbdc: CC = R0 == 0x0
ffa0bbde: IF !CC JUMP 0xffa0bbea
ffa0bbe0: STORE [P1 + 0x24] = R1
ffa0bbe2: ADD R2 += 0x20
ffa0bbe4: LOAD R0 = [P1 + 0x18]
ffa0bbe6: STORE [P1 + 0x28] = R0
ffa0bbe8: JUMP.S 0xffa0bbf6
ffa0bbea: STORE [P1 + 0x30] = R1
ffa0bbec: ADD R2 += 0x2c
ffa0bbee: LOAD R0 = [P1 + 0x1c]
ffa0bbf0: LOAD R1 = [P1 + 0x24]
ffa0bbf2: MULT R0 *= R1
ffa0bbf4: STORE [P1 + 0x34] = R0
ffa0bbf6: MOVE P1 = R2
ffa0bbf8: LOAD R0 = B [P0 + 0x16] (Z)
ffa0bbfc: CC = R0 == 0x0
ffa0bbfe: LOAD R1 = 0x1
ffa0bc00: LOAD R2 = [P1]
