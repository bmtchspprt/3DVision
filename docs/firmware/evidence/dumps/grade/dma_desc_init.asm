######## FFA0774C DMA programmer
ffa0774c: LOAD R2.L = 0x3690
ffa07750: LOAD R2.H = 0xff80
ffa07754: ADD R0 = R2 + R0
ffa07756: MOVE P1 = R0
ffa07758: MOVE P0 = R1
ffa0775a: LOAD R0 = 0x0
ffa0775c: LOAD R1 = [P1 + 0x8]
ffa0775e: STORE [P0] = R1
ffa07760: RTS
ffa07762: LSHIFT R1 <<= 0x4
ffa07764: LOAD R2.L = 0x3690
ffa07768: LOAD R2.H = 0xff80
ffa0776c: ADD R1 = R2 + R1
ffa0776e: MOVE P1 = R1
ffa07770: LOAD R2 = 0xfff
ffa07774: LSH R1.L = R0.H << 0xc
ffa07778: LOAD R0 = 0x0
ffa0777a: LOAD P1 = [P1]
ffa0777c: LOAD R3 = W [P1 + 0x2c] (X)
ffa07780: AND R2 = R3 & R2
ffa07782: OR R1 = R2 | R1
ffa07784: STORE W [P1 + 0x2c] = R1
ffa07788: RTS
ffa0778c: LOAD P1.L = 0x3690
ffa07790: LOAD P1.H = 0xff80
ffa07794: LOAD P2 = 0x10
ffa07796: PUSH [--SP] = (R7:4)
ffa07798: LSH R5 = R0 >> 0x10
ffa0779c: MOVE R6 = R0.B (Z)
ffa0779e: ADD P1 += 0x4
ffa077a0: LOAD R2 = 0x0
ffa077a2: LOAD R7 = 0xf000
ffa077a6: LOAD R0 = 0x0
ffa077a8: LSETUP (0xffa077ac,0xffa077ba) LC0 = P2
ffa077ac: ROT|| R3 = rot R2 by 0
ffa077b0: _LOAD R4 = [P1 ++ P2]
ffa077b2: _NOP
ffa077b4: CC = R6 == R4
ffa077b6: ADD R3 += 0x1
ffa077b8: IF CC JUMP 0xffa077c8
ffa077ba: MOVE R2 = R3
ffa077bc: POP (R7:4) = [SP++]
ffa077be: LOAD R0 = 0x4
ffa077c0: LOAD R0.H = 0x3
ffa077c4: RTS
ffa077c8: LOAD P0 = [P1 + -0x14]
ffa077cc: ADD P0 += 0x2c
ffa077ce: LOAD R4 = W [P0] (X)
ffa077d0: AND R4 = R4 & R7
ffa077d2: ASHIFT R4 >>>= 0xc
ffa077d4: CC = R5 == R4
ffa077d6: IF !CC JUMP 0xffa077ba (bp)
ffa077d8: MOVE P1 = R1
ffa077da: STORE [P1] = R2
ffa077dc: POP (R7:4) = [SP++]
ffa077de: RTS
ffa077e0: LINK 0x0
ffa077e4: PUSH [--SP] = (R7:4,P5:3)
ffa077e6: MOVE P4 = R0
ffa077e8: ADD SP += -0x10
ffa077ea: MOVE R5 = R1
ffa077ec: MOVE R4 = R2
ffa077ee: LOAD P3 = 0x44
ffa077f2: LOAD R0 = [P4 + 0x4]
ffa077f4: CALL 0xffa08cea
ffa077f8: LOAD P5 = [P4 + 0x8]
ffa077fa: LOAD P1 = [P4]
ffa077fc: LOAD R1 = [P4]
ffa077fe: CC = R1 == 0x0
ffa07800: ADD P0 = P5 + P3
ffa07802: IF CC JUMP 0xffa07822
ffa07804: NOP
ffa07806: LOAD P2 = 0x70
ffa0780a: LSETUP (0xffa0780e,0xffa07820) LC0 = P1
ffa0780e: NOP
ffa07810: SUB|| R6 = R6 - R6 (ns)
ffa07814: _LOAD R1 = B [P0] (Z)
ffa07816: _NOP
ffa07818: CC = R1 == 0x0
ffa0781a: ADD P1 = P5 + P2
ffa0781c: IF CC JUMP 0xffa079a4
ffa0781e: ADD P0 = P0 + P2
ffa07820: MOVE P5 = P1
ffa07822: LOAD R6 = 0xc
ffa07824: LOAD R6.H = 0x3
ffa07828: CALL 0xffa08d0c
ffa0782c: CC = R6 == 0x0
ffa0782e: MOVE R0 = R6
ffa07830: IF CC JUMP 0xffa07840
ffa07832: ADD SP += 0x10
ffa07834: LOAD P0 = [FP + 0x4]
ffa07836: POP (R7:4,P5:3) = [SP++]
ffa07838: UNLINK
ffa0783c: JUMP (P0)
ffa07840: LSH R2 = R5 << 0x4
ffa07844: MOVE P1 = R2
ffa07846: LOAD P0.L = 0x3690
ffa0784a: LOAD P0.H = 0xff80
ffa0784e: LOAD R3 = 0x11
ffa07850: PACK|| R7 = pack(R7.H,R3.L)
ffa07854: _STORE [SP + 0x3c] = P5
ffa07856: _NOP
ffa07858: MOVE R1 = R5
ffa0785a: ADD P3 = P0 + P1
ffa0785c: LOAD R3 = [P3]
ffa0785e: ROT|| R2 = rot R3 by 0
ffa07862: _STORE [P5 + 0x34] = R5
ffa07864: _NOP
ffa07866: LOAD R5 = [FP + 0x18]
ffa07868: ROT|| R5 = rot R3 by 0
ffa0786c: _STORE [P5 + 0x3c] = R5
ffa0786e: _NOP
ffa07870: ADD R2 += 0x8
ffa07872: ADD R5 += 0x10
ffa07874: ROT|| R2 = rot R3 by 0
ffa07878: _STORE [P5] = R2
ffa0787a: _NOP
ffa0787c: ROT|| R5 = rot R3 by 0
ffa07880: _STORE [P5 + 0xc] = R5
ffa07882: _NOP
ffa07884: ADD R2 += 0x14
ffa07886: ADD R5 += 0x18
ffa07888: ROT|| R2 = rot R3 by 0
ffa0788c: _STORE [P5 + 0x14] = R2
ffa0788e: _NOP
ffa07890: ROT|| R5 = rot R3 by 0
ffa07894: _STORE [P5 + 0x10] = R5
ffa07896: _NOP
ffa07898: ADD R2 += 0x1c
ffa0789a: ADD R5 += 0x24
ffa0789c: ROT|| R2 = rot R3 by 0
ffa078a0: _STORE [P5 + 0x18] = R2
ffa078a2: _NOP
ffa078a4: ROT|| R5 = rot R3 by 0
ffa078a8: _STORE [P5 + 0x1c] = R5
ffa078aa: _NOP
ffa078ac: ADD R2 += 0x28
ffa078ae: ADD R5 += 0x2c
ffa078b0: ROT|| R2 = rot R3 by 0
ffa078b4: _STORE [P5 + 0x28] = R2
ffa078b6: _NOP
ffa078b8: ROT|| R5 = rot R3 by 0
ffa078bc: _STORE [P5 + 0x2c] = R5
ffa078be: _NOP
ffa078c0: STORE [P5 + 0x4] = R3
ffa078c2: ADD R2 += 0x38
ffa078c4: ADD R5 += 0x30
ffa078c6: ADD R3 += 0x4
ffa078c8: STORE [P5 + 0x20] = R5
ffa078ca: STORE [P5 + 0x8] = R3
ffa078cc: STORE [P5 + 0x40] = R6
ffa078d0: STORE B [P5 + 0x45] = R6
ffa078d4: STORE B [P5 + 0x46] = R6
ffa078d8: STORE B [P5 + 0x47] = R6
ffa078dc: STORE [P5 + 0x54] = R6
ffa078e0: STORE [P5 + 0x58] = R6
ffa078e4: STORE [P5 + 0x5c] = R6
ffa078e8: STORE [P5 + 0x60] = R6
ffa078ec: STORE [P5 + 0x64] = R6
ffa078f0: STORE [P5 + 0x4c] = R6
ffa078f4: STORE [P5 + 0x24] = R2
ffa078f6: LOAD R2 = [P3 + 0x8]
ffa078f8: LOAD R5 = [FP + 0x1c]
ffa078fa: LOAD R3 = [FP + 0x20]
ffa078fc: STORE [P5 + 0x6c] = R3
ffa07900: STORE [P5 + 0x38] = R2
ffa07902: STORE [P5 + 0x50] = R4
ffa07906: STORE [P5 + 0x68] = R5
ffa0790a: LOAD R0 = [SP + 0x3c]
ffa0790c: CALL 0xffa075be
ffa07910: LOAD P1 = [FP + 0x14]
ffa07912: MOVE R1 = FP
ffa07914: ADD R1 += 0xc
ffa07916: LOAD P4 = 0x1
ffa07918: STORE [P1] = P5
ffa0791a: LOAD R0 = [P5 + 0x38]
ffa0791c: CALL 0xffa08be8
ffa07920: MOVE R1 = FP
ffa07922: LOAD R0 = [P3 + 0xc]
ffa07924: ADD R1 += 0x8
ffa07926: CALL 0xffa08be8
ffa0792a: STORE [SP + 0xc] = P4
ffa0792c: LOAD R1.L = 0x7fc2
ffa07930: LOAD R1.H = 0xffa0
ffa07934: LOAD R2 = [SP + 0x3c]
ffa07936: LOAD R0 = [SP + 0x34]
ffa07938: CALL 0xffa08dd0
ffa0793c: CC = R0 == 0x0
ffa0793e: LOAD R7.H = 0x3
ffa07942: IF CC JUMP 0xffa0795c
ffa07944: CC = R7 == 0x0
ffa07946: LOAD R0 = 0x0
ffa07948: IF CC JUMP 0xffa07832
ffa0794a: STORE B [P5 + 0x44] = R6
ffa0794e: ADD SP += 0x10
ffa07950: MOVE R0 = R7
ffa07952: LOAD P0 = [FP + 0x4]
ffa07954: POP (R7:4,P5:3) = [SP++]
ffa07956: UNLINK
ffa0795a: JUMP (P0)
ffa0795c: STORE [SP + 0xc] = P4
ffa0795e: LOAD R1.L = 0x8290
ffa07962: LOAD R1.H = 0xffa0
ffa07966: LOAD R2 = [SP + 0x3c]
ffa07968: LOAD R0 = [SP + 0x38]
ffa0796a: CALL 0xffa08dd0
ffa0796e: CC = R0 == 0x0
ffa07970: IF CC JUMP 0xffa07984
ffa07972: LOAD R1.L = 0x7fc2
ffa07976: LOAD R1.H = 0xffa0
ffa0797a: LOAD R2 = [SP + 0x3c]
ffa0797c: LOAD R0 = [SP + 0x34]
ffa0797e: CALL 0xffa08eb8
ffa07982: JUMP.S 0xffa07944
ffa07984: LOAD R0 = [P5 + 0x38]
ffa07986: LOAD R1 = 0x1
ffa07988: CALL 0xffa08ba4
ffa0798c: LOAD R0 = [P5 + 0x38]
ffa0798e: CALL 0xffa08c4c
ffa07992: LOAD R0 = [P3 + 0xc]
ffa07994: LOAD R1 = 0x1
ffa07996: CALL 0xffa08ba4
ffa0799a: LOAD R0 = [P3 + 0xc]
ffa0799c: CALL 0xffa08c4c
ffa079a0: LOAD R7 = 0x0
ffa079a2: JUMP.S 0xffa07944
ffa079a4: LOAD R1 = 0x1
ffa079a6: STORE B [P5 + 0x44] = R1
ffa079aa: JUMP.S 0xffa07828
ffa079ac: LINK 0x0
ffa079b0: PUSH [--SP] = (R7:6,P5:3)
ffa079b2: MOVE R7 = R0
ffa079b4: MOVE P5 = R7
ffa079b6: ADD SP += -0xc
ffa079b8: STORE [SP + 0x2c] = R1
ffa079ba: MOVE R1 = FP
ffa079bc: ADD R1 += 0x8
ffa079be: LOAD P3 = [P5 + 0x34]
ffa079c0: LOAD R0 = [P5 + 0x38]
ffa079c2: CALL 0xffa08be8
ffa079c6: LOAD P4.L = 0x3690
ffa079ca: LOAD P4.H = 0xff80
ffa079ce: ADD P1 = P3 + P3
ffa079d0: ADD P1 = (P1 + P1) << 2
ffa079d2: ADD P1 = P4 + P1
ffa079d4: MOVE R1 = FP
ffa079d6: LOAD R0 = [P1 + 0xc]
ffa079d8: ADD R1 += 0x10
ffa079da: CALL 0xffa08be8
ffa079de: LOAD R0 = [SP + 0x2c]
ffa079e0: CC = R0 == 0x0
ffa079e2: IF CC JUMP 0xffa079fc
ffa079e4: LOAD R6 = 0x8
ffa079e6: LOAD R6.H = 0x3
ffa079ea: MOVE R2 = FP
ffa079ec: ADD R2 += 0xc
ffa079ee: MOVE R1 = R6
ffa079f0: MOVE R0 = R7
ffa079f2: CALL 0xffa07cd0
ffa079f6: LOAD R0 = [SP + 0x2c]
ffa079f8: CC = R0 == 0x0
ffa079fa: IF !CC JUMP 0xffa079ea (bp)
ffa079fc: SUB|| R6 = R6 - R6 (ns)
ffa07a00: _LOAD P1 = [P5]
ffa07a02: _NOP
ffa07a04: LOAD R0 = W [P1] (X)
ffa07a06: BITCLR (R0,0x0)
ffa07a08: STORE W [P1] = R0.L
ffa07a0a: LOAD R0 = [P5 + 0x38]
ffa07a0c: CALL 0xffa08c20
ffa07a10: SUB|| R1 = R1 - R1 (ns)
ffa07a14: _LOAD R0 = [P5 + 0x38]
ffa07a16: _NOP
ffa07a18: CALL 0xffa08ba4
ffa07a1c: LOAD R1.L = 0x8290
ffa07a20: LOAD R1.H = 0xffa0
ffa07a24: ROT|| R2 = rot R7 by 0
ffa07a28: _LOAD R0 = [SP + 0x28]
ffa07a2a: _NOP
ffa07a2c: CALL 0xffa08eb8
ffa07a30: CC = R0 == 0x0
ffa07a32: IF CC JUMP 0xffa07a48
ffa07a34: ADD SP += 0xc
ffa07a36: LOAD P0 = [FP + 0x4]
ffa07a38: POP (R7:6,P5:3) = [SP++]
ffa07a3a: UNLINK
ffa07a3e: LOAD R0 = 0x12
ffa07a40: LOAD R0.H = 0x3
ffa07a44: JUMP (P0)
ffa07a48: ROT|| R2 = rot R7 by 0
ffa07a4c: _LOAD R0 = [SP + 0x30]
ffa07a4e: _NOP
ffa07a50: LOAD R1.L = 0x7fc2
ffa07a54: LOAD R1.H = 0xffa0
ffa07a58: CALL 0xffa08eb8
ffa07a5c: CC = R0 == 0x0
ffa07a5e: IF !CC JUMP 0xffa07a70
ffa07a60: STORE B [P5 + 0x44] = R6
ffa07a64: ADD SP += 0xc
ffa07a66: LOAD P0 = [FP + 0x4]
ffa07a68: POP (R7:6,P5:3) = [SP++]
ffa07a6a: UNLINK
ffa07a6e: JUMP (P0)
ffa07a70: ADD SP += 0xc
ffa07a72: LOAD P0 = [FP + 0x4]
ffa07a74: POP (R7:6,P5:3) = [SP++]
ffa07a76: UNLINK
ffa07a7a: LOAD R0 = 0x12
ffa07a7c: LOAD R0.H = 0x3
ffa07a80: JUMP (P0)
ffa07a84: MOVE P1 = R0
ffa07a86: LINK 0x0
ffa07a8a: PUSH [--SP] = (R7:4)
ffa07a8c: ADD SP += -0xc
ffa07a8e: STORE [SP + 0x2c] = R2
ffa07a90: LOAD R2 = [P1 + 0x40]
ffa07a94: CC = R2 == 0x2
ffa07a96: LOAD R6 = [SP + 0x3c]
ffa07a98: LOAD R5 = [SP + 0x30]
ffa07a9a: LOAD R7 = [SP + 0x34]
ffa07a9c: LOAD R3 = [SP + 0x38]
ffa07a9e: IF !CC JUMP 0xffa07ab2
ffa07aa0: ADD SP += 0xc
ffa07aa2: LOAD P0 = [FP + 0x4]
ffa07aa4: POP (R7:4) = [SP++]
ffa07aa6: UNLINK
ffa07aaa: LOAD R0 = 0x3
ffa07aac: LOAD R0.H = 0x3
ffa07ab0: JUMP (P0)
ffa07ab2: LOAD R2 = W [FP + 0x10] (X)
ffa07ab4: BITCLR (R2,0xf)
ffa07ab6: STORE W [FP + 0x10] = R2
ffa07ab8: LOAD R2 = [P1 + 0x3c]
ffa07aba: CC = R2 == 0x2
ffa07abc: IF CC JUMP 0xffa07b38
ffa07abe: LOAD R2 = W [FP + 0x10] (Z)
ffa07ac0: LOAD R4 = 0xc03
ffa07ac4: DEPOSIT R2 = deposit(R2,R4)
ffa07ac8: STORE W [FP + 0x10] = R2
ffa07aca: LOAD R2 = W [FP + 0x10] (Z)
ffa07acc: LOAD R4 = 0x804
ffa07ad0: DEPOSIT R2 = deposit(R2,R4)
ffa07ad4: STORE W [FP + 0x10] = R2
ffa07ad6: LOAD R2 = W [FP + 0x10] (X)
ffa07ad8: BITCLR (R2,0x0)
ffa07ada: STORE W [FP + 0x10] = R2
ffa07adc: LOAD R2 = W [FP + 0x10] (X)
ffa07ade: BITCLR (R2,0x5)
ffa07ae0: STORE W [FP + 0x10] = R2
ffa07ae2: LOAD P0 = [P1 + 0x8]
ffa07ae4: LOAD R2 = 0x1
ffa07ae6: STORE [P0] = R1
ffa07ae8: LOAD P0 = [P1 + 0xc]
ffa07aea: STORE W [P0] = R5.L
ffa07aec: LOAD P0 = [P1 + 0x14]
ffa07aee: STORE W [P0] = R7.L
ffa07af0: LOAD P0 = [P1 + 0x10]
ffa07af2: STORE W [P0] = R3.L
ffa07af4: LOAD P0 = [P1 + 0x18]
ffa07af6: STORE W [P0] = R6.L
ffa07af8: LOAD P0 = [P1]
ffa07afa: LOAD R1 = [SP + 0x2c]
ffa07afc: STORE W [P0] = R1.L
ffa07afe: STORE B [P1 + 0x47] = R2
ffa07b02: LOAD R1 = [P1 + 0x40]
ffa07b06: CC = R1 == 0x1
ffa07b08: IF CC JUMP 0xffa07b1c
ffa07b0a: ADD SP += 0xc
ffa07b0c: SUB|| R0 = R0 - R0 (ns)
ffa07b10: _LOAD P0 = [FP + 0x4]
ffa07b12: _NOP
ffa07b14: POP (R7:4) = [SP++]
ffa07b16: UNLINK
ffa07b1a: JUMP (P0)
ffa07b1c: LOAD R1 = 0x6
ffa07b1e: LOAD R1.H = 0x3
ffa07b22: CALL 0xffa07cd0
ffa07b26: ADD SP += 0xc
ffa07b28: SUB|| R0 = R0 - R0 (ns)
ffa07b2c: _LOAD P0 = [FP + 0x4]
ffa07b2e: _NOP
ffa07b30: POP (R7:4) = [SP++]
ffa07b32: UNLINK
ffa07b36: JUMP (P0)
ffa07b38: LOAD R6 = 0xc03
ffa07b3c: BITSET (R6,0x10)
ffa07b3e: ASH R2.H = R7.L >>> 0x1
ffa07b42: LOAD R4 = W [FP + 0x10] (Z)
ffa07b44: DEPOSIT|| R4 = deposit(R4,R6)
ffa07b48: LOAD R6 = [SP + 0x34]
ffa07b4a: NOP
ffa07b4c: STORE W [FP + 0x10] = R4
ffa07b4e: LOAD R4 = W [FP + 0x10] (X)
ffa07b50: BITSET (R4,0x4)
ffa07b52: STORE W [FP + 0x10] = R4
ffa07b54: LOAD R2.L = 0x202
ffa07b58: LOAD R4 = W [FP + 0x10] (Z)
ffa07b5a: DEPOSIT R2 = deposit(R4,R2)
ffa07b5e: STORE W [FP + 0x10] = R2
ffa07b60: JUMP.S 0xffa07aca
ffa07b64: LINK 0x0
ffa07b68: PUSH [--SP] = (R7:5,P5:5)
ffa07b6a: MOVE P5 = R0
ffa07b6c: ADD SP += -0xc
ffa07b6e: MOVE R5 = R1
ffa07b70: CC = R5 == 0x1
ffa07b72: MOVE R6 = R0
ffa07b74: LOAD P1 = [P5 + 0x30]
ffa07b76: LOAD R0 = [P1 + 0x4]
ffa07b78: IF !CC JUMP 0xffa07ba4
ffa07b7a: CALL 0xffa08cea
ffa07b7e: MOVE R7 = R0
ffa07b80: LOAD R0 = [P5 + 0x40]
ffa07b84: CC = R0 == 0x2
ffa07b86: MOVE R0 = R7
ffa07b88: IF CC JUMP 0xffa07bc8
ffa07b8a: LOAD P1 = [P5 + 0x3c]
ffa07b8c: LOAD P0.L = 0x37a0
ffa07b90: LOAD P0.H = 0xff80
ffa07b94: ADD P1 += -0x1
ffa07b96: CC = P1 < 0x5 (IU)
ffa07b98: IF !CC JUMP 0xffa07bc8
ffa07b9a: NOP
ffa07b9c: NOP
ffa07b9e: ADD P1 = P0 + (P1 << 2)
ffa07ba0: LOAD P1 = [P1]
ffa07ba2: JUMP (P1)
ffa07ba4: CALL 0xffa08cea
ffa07ba8: SUB|| R2 = R2 - R2 (ns)
ffa07bac: _LOAD P1 = [P5++]
ffa07bae: _NOP
ffa07bb0: LOAD R1 = W [P1] (X)
ffa07bb2: BITCLR (R1,0x0)
ffa07bb4: STORE W [P1] = R1.L
ffa07bb6: STORE [P5 + 0x54] = R2
ffa07bba: STORE [P5 + 0x58] = R2
ffa07bbe: STORE [P5 + 0x5c] = R2
ffa07bc2: STORE [P5 + 0x60] = R2
ffa07bc6: STORE [P5 + 0x3c] = R2
ffa07bc8: CALL 0xffa08d0c
ffa07bcc: ADD SP += 0xc
ffa07bce: SUB|| R0 = R0 - R0 (ns)
ffa07bd2: _LOAD P0 = [FP + 0x4]
ffa07bd4: _NOP
ffa07bd6: POP (R7:5,P5:5) = [SP++]
ffa07bd8: UNLINK
ffa07bdc: JUMP (P0)
ffa07bde: LOAD P1 = [P5++]
ffa07be0: LOAD R2 = 0x2
ffa07be2: LOAD R1 = W [P1] (X)
ffa07be4: BITSET (R1,0x0)
ffa07be6: STORE W [P1] = R1.L
ffa07be8: STORE [P5 + 0x3c] = R2
ffa07bea: JUMP.S 0xffa07bc8
ffa07bec: LOAD R0 = B [P5 + 0x46] (Z)
ffa07bf0: CC = R0 == 0x0
ffa07bf2: IF CC JUMP 0xffa07ca8
ffa07bf4: LOAD R1 = [P5 + 0x58]
ffa07bf8: CC = R1 == 0x0
ffa07bfa: IF CC JUMP 0xffa07ca0
ffa07bfc: MOVE R0 = R6
ffa07bfe: CALL 0xffa0763c

##### 0x3690 / 0xff803690 sites with context
--- ffa0774c
ffa07726: RTS
ffa07728: STORE [P0 + 0x54] = P1
ffa0772c: POP (R7:6,P5:5) = [SP++]
ffa0772e: RTS
ffa07730: STORE [P0 + 0x54] = P1
ffa07734: POP (R7:6,P5:5) = [SP++]
ffa07736: RTS
ffa07738: LOAD R0 = B [P0 + 0x46] (Z)
ffa0773c: CC = R0 == 0x1
ffa0773e: IF !CC JUMP 0xffa07648 (bp)
ffa07740: LOAD R0 = 0x0
ffa07742: STORE [P0 + 0x54] = R0
ffa07746: POP (R7:6,P5:5) = [SP++]
ffa07748: RTS
ffa0774a: LSHIFT R0 <<= 0x4
ffa0774c: LOAD R2.L = 0x3690
ffa07750: LOAD R2.H = 0xff80
ffa07754: ADD R0 = R2 + R0
ffa07756: MOVE P1 = R0
ffa07758: MOVE P0 = R1
ffa0775a: LOAD R0 = 0x0
ffa0775c: LOAD R1 = [P1 + 0x8]
ffa0775e: STORE [P0] = R1
ffa07760: RTS
ffa07762: LSHIFT R1 <<= 0x4
ffa07764: LOAD R2.L = 0x3690
ffa07768: LOAD R2.H = 0xff80
ffa0776c: ADD R1 = R2 + R1
ffa0776e: MOVE P1 = R1
ffa07770: LOAD R2 = 0xfff
ffa07774: LSH R1.L = R0.H << 0xc
ffa07778: LOAD R0 = 0x0
ffa0777a: LOAD P1 = [P1]
ffa0777c: LOAD R3 = W [P1 + 0x2c] (X)
ffa07780: AND R2 = R3 & R2
ffa07782: OR R1 = R2 | R1
ffa07784: STORE W [P1 + 0x2c] = R1
ffa07788: RTS
ffa0778c: LOAD P1.L = 0x3690

--- ffa07764
ffa07740: LOAD R0 = 0x0
ffa07742: STORE [P0 + 0x54] = R0
ffa07746: POP (R7:6,P5:5) = [SP++]
ffa07748: RTS
ffa0774a: LSHIFT R0 <<= 0x4
ffa0774c: LOAD R2.L = 0x3690
ffa07750: LOAD R2.H = 0xff80
ffa07754: ADD R0 = R2 + R0
ffa07756: MOVE P1 = R0
ffa07758: MOVE P0 = R1
ffa0775a: LOAD R0 = 0x0
ffa0775c: LOAD R1 = [P1 + 0x8]
ffa0775e: STORE [P0] = R1
ffa07760: RTS
ffa07762: LSHIFT R1 <<= 0x4
ffa07764: LOAD R2.L = 0x3690
ffa07768: LOAD R2.H = 0xff80
ffa0776c: ADD R1 = R2 + R1
ffa0776e: MOVE P1 = R1
ffa07770: LOAD R2 = 0xfff
ffa07774: LSH R1.L = R0.H << 0xc
ffa07778: LOAD R0 = 0x0
ffa0777a: LOAD P1 = [P1]
ffa0777c: LOAD R3 = W [P1 + 0x2c] (X)
ffa07780: AND R2 = R3 & R2
ffa07782: OR R1 = R2 | R1
ffa07784: STORE W [P1 + 0x2c] = R1
ffa07788: RTS
ffa0778c: LOAD P1.L = 0x3690
ffa07790: LOAD P1.H = 0xff80
ffa07794: LOAD P2 = 0x10
ffa07796: PUSH [--SP] = (R7:4)
ffa07798: LSH R5 = R0 >> 0x10
ffa0779c: MOVE R6 = R0.B (Z)
ffa0779e: ADD P1 += 0x4
ffa077a0: LOAD R2 = 0x0
ffa077a2: LOAD R7 = 0xf000
ffa077a6: LOAD R0 = 0x0
ffa077a8: LSETUP (0xffa077ac,0xffa077ba) LC0 = P2

--- ffa0778c
ffa07760: RTS
ffa07762: LSHIFT R1 <<= 0x4
ffa07764: LOAD R2.L = 0x3690
ffa07768: LOAD R2.H = 0xff80
ffa0776c: ADD R1 = R2 + R1
ffa0776e: MOVE P1 = R1
ffa07770: LOAD R2 = 0xfff
ffa07774: LSH R1.L = R0.H << 0xc
ffa07778: LOAD R0 = 0x0
ffa0777a: LOAD P1 = [P1]
ffa0777c: LOAD R3 = W [P1 + 0x2c] (X)
ffa07780: AND R2 = R3 & R2
ffa07782: OR R1 = R2 | R1
ffa07784: STORE W [P1 + 0x2c] = R1
ffa07788: RTS
ffa0778c: LOAD P1.L = 0x3690
ffa07790: LOAD P1.H = 0xff80
ffa07794: LOAD P2 = 0x10
ffa07796: PUSH [--SP] = (R7:4)
ffa07798: LSH R5 = R0 >> 0x10
ffa0779c: MOVE R6 = R0.B (Z)
ffa0779e: ADD P1 += 0x4
ffa077a0: LOAD R2 = 0x0
ffa077a2: LOAD R7 = 0xf000
ffa077a6: LOAD R0 = 0x0
ffa077a8: LSETUP (0xffa077ac,0xffa077ba) LC0 = P2
ffa077ac: ROT|| R3 = rot R2 by 0
ffa077b0: _LOAD R4 = [P1 ++ P2]
ffa077b2: _NOP
ffa077b4: CC = R6 == R4
ffa077b6: ADD R3 += 0x1
ffa077b8: IF CC JUMP 0xffa077c8
ffa077ba: MOVE R2 = R3
ffa077bc: POP (R7:4) = [SP++]
ffa077be: LOAD R0 = 0x4
ffa077c0: LOAD R0.H = 0x3
ffa077c4: RTS
ffa077c8: LOAD P0 = [P1 + -0x14]

--- ffa07846
ffa0781e: ADD P0 = P0 + P2
ffa07820: MOVE P5 = P1
ffa07822: LOAD R6 = 0xc
ffa07824: LOAD R6.H = 0x3
ffa07828: CALL 0xffa08d0c
ffa0782c: CC = R6 == 0x0
ffa0782e: MOVE R0 = R6
ffa07830: IF CC JUMP 0xffa07840
ffa07832: ADD SP += 0x10
ffa07834: LOAD P0 = [FP + 0x4]
ffa07836: POP (R7:4,P5:3) = [SP++]
ffa07838: UNLINK
ffa0783c: JUMP (P0)
ffa07840: LSH R2 = R5 << 0x4
ffa07844: MOVE P1 = R2
ffa07846: LOAD P0.L = 0x3690
ffa0784a: LOAD P0.H = 0xff80
ffa0784e: LOAD R3 = 0x11
ffa07850: PACK|| R7 = pack(R7.H,R3.L)
ffa07854: _STORE [SP + 0x3c] = P5
ffa07856: _NOP
ffa07858: MOVE R1 = R5
ffa0785a: ADD P3 = P0 + P1
ffa0785c: LOAD R3 = [P3]
ffa0785e: ROT|| R2 = rot R3 by 0
ffa07862: _STORE [P5 + 0x34] = R5
ffa07864: _NOP
ffa07866: LOAD R5 = [FP + 0x18]
ffa07868: ROT|| R5 = rot R3 by 0
ffa0786c: _STORE [P5 + 0x3c] = R5
ffa0786e: _NOP
ffa07870: ADD R2 += 0x8
ffa07872: ADD R5 += 0x10
ffa07874: ROT|| R2 = rot R3 by 0
ffa07878: _STORE [P5] = R2
ffa0787a: _NOP
ffa0787c: ROT|| R5 = rot R3 by 0
ffa07880: _STORE [P5 + 0xc] = R5
ffa07882: _NOP

--- ffa079c6
ffa079a2: JUMP.S 0xffa07944
ffa079a4: LOAD R1 = 0x1
ffa079a6: STORE B [P5 + 0x44] = R1
ffa079aa: JUMP.S 0xffa07828
ffa079ac: LINK 0x0
ffa079b0: PUSH [--SP] = (R7:6,P5:3)
ffa079b2: MOVE R7 = R0
ffa079b4: MOVE P5 = R7
ffa079b6: ADD SP += -0xc
ffa079b8: STORE [SP + 0x2c] = R1
ffa079ba: MOVE R1 = FP
ffa079bc: ADD R1 += 0x8
ffa079be: LOAD P3 = [P5 + 0x34]
ffa079c0: LOAD R0 = [P5 + 0x38]
ffa079c2: CALL 0xffa08be8
ffa079c6: LOAD P4.L = 0x3690
ffa079ca: LOAD P4.H = 0xff80
ffa079ce: ADD P1 = P3 + P3
ffa079d0: ADD P1 = (P1 + P1) << 2
ffa079d2: ADD P1 = P4 + P1
ffa079d4: MOVE R1 = FP
ffa079d6: LOAD R0 = [P1 + 0xc]
ffa079d8: ADD R1 += 0x10
ffa079da: CALL 0xffa08be8
ffa079de: LOAD R0 = [SP + 0x2c]
ffa079e0: CC = R0 == 0x0
ffa079e2: IF CC JUMP 0xffa079fc
ffa079e4: LOAD R6 = 0x8
ffa079e6: LOAD R6.H = 0x3
ffa079ea: MOVE R2 = FP
ffa079ec: ADD R2 += 0xc
ffa079ee: MOVE R1 = R6
ffa079f0: MOVE R0 = R7
ffa079f2: CALL 0xffa07cd0
ffa079f6: LOAD R0 = [SP + 0x2c]
ffa079f8: CC = R0 == 0x0
ffa079fa: IF !CC JUMP 0xffa079ea (bp)
ffa079fc: SUB|| R6 = R6 - R6 (ns)
ffa07a00: _LOAD P1 = [P5]
ffa07a02: _NOP

--- ffa07cee
ffa07cc6: JUMP.S 0xffa07bfc
ffa07cc8: STORE [P5 + 0x40] = R5
ffa07ccc: MOVE R0 = R7
ffa07cce: JUMP.S 0xffa07bc8
ffa07cd0: LINK 0x0
ffa07cd4: PUSH [--SP] = (R7:6,P5:3)
ffa07cd6: MOVE P1 = R1
ffa07cd8: MOVE P4 = R0
ffa07cda: MOVE R6 = R0
ffa07cdc: MOVE P5 = R2
ffa07cde: ADD SP += -0xc
ffa07ce0: LOAD P0 = -0x1
ffa07ce2: LOAD P0.H = 0xfffc
ffa07ce6: LOAD P2.L = 0x37b4
ffa07cea: LOAD P2.H = 0xff80
ffa07cee: LOAD R3.L = 0x3680
ffa07cf2: LOAD R3.H = 0xff80
ffa07cf6: LOAD P3 = -0x1
ffa07cf8: LSETUP (0xffa07cfe,0xffa07d30) LC0 = P3
ffa07cfc: LOAD P3 = 0xb
ffa07cfe: ADD P1 = P1 + P0
ffa07d00: CC = P1 < P3 (IU)
ffa07d02: IF !CC JUMP 0xffa07d0e
ffa07d04: NOP
ffa07d06: NOP
ffa07d08: ADD P1 = P2 + (P1 << 2)
ffa07d0a: LOAD P1 = [P1]
ffa07d0c: JUMP (P1)
ffa07d0e: ADD SP += 0xc
ffa07d10: LOAD P0 = [FP + 0x4]
ffa07d12: POP (R7:6,P5:3) = [SP++]
ffa07d14: UNLINK
ffa07d18: LOAD R0 = 0xd
ffa07d1a: LOAD R0.H = 0x3
ffa07d1e: JUMP (P0)
ffa07d20: LOAD R0 = 0x0
ffa07d22: ADD SP += 0xc
ffa07d24: LOAD P0 = [FP + 0x4]
ffa07d26: POP (R7:6,P5:3) = [SP++]
ffa07d28: UNLINK

##### ADD 0x5bc or compute grade abs offset then STORE ptr
202b5202: LOAD R2 = 0x5bc
  202b5206: STORE [SP + 0x4c] = R5
  202b520a: STORE [FP + -0x3c] = R4
  202b520c: STORE [P0 + 0x10] = R2
  202b520e: LOAD R4 = [FP + -0x38]
  202b5210: LOAD R0 = [FP + -0x20]
  202b5212: LOAD R1 = -0x5c
  202b5216: LOAD R5 = 0x147a
  202b521a: STORE [P0 + 0x14] = R5
  202b521c: ADD R1 = R4 + R1
  202b521e: ADD R0 += 0x18
  202b5220: LOAD R2 = 0x6
  202b5222: LOAD P1.L = 0x5f92
  202b5226: LOAD P1.H = 0xffa0
  202b522a: CALL (P1)
  202b522c: LOAD P1 = [P4 + 0x38]
  202b522e: LOAD P0 = [FP + -0x64]
  202b5230: LOAD R1 = -0x54
  202b5234: ADD R1 = R4 + R1
  202b5236: LOAD R5 = [P1 + 0x4]
  202b5238: LOAD R4 = 0x51e
