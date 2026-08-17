ffa02980: STORE W [FP + 0x10] = R2
ffa02982: STORE [FP + 0xc] = R1
ffa02984: STORE W [FP + 0x8] = R0
ffa02986: LOAD P5.L = 0x3e2c
ffa0298a: LOAD P5.H = 0xff80
ffa0298e: LOAD R3 = 0x0
ffa02990: STORE [P5] = R3
ffa02992: LOAD P2.L = 0x3e30
ffa02996: LOAD P2.H = 0xff80
ffa0299a: STORE [P2] = R3
ffa0299c: LOAD P0 = 0x500
ffa029a0: LOAD P0.H = 0xffc0
ffa029a4: LOAD R0 = W [P0] (Z)
ffa029a6: BITSET (R0,0xe)
ffa029a8: STORE W [P0] = R0.L
ffa029aa: LOAD R0 = W [FP + 0x8] (X)
ffa029ac: LOAD P1 = 0x50c
ffa029b0: LOAD P1.H = 0xffc0
ffa029b4: STORE W [P1] = R0.L
ffa029b6: LOAD P1 = 0x508
ffa029ba: LOAD P1.H = 0xffc0
ffa029be: LOAD R0 = W [P1] (Z)
ffa029c0: CC = BITTST (R0,0x5)
ffa029c2: IF CC JUMP 0xffa029e6
ffa029c4: LOAD R0 = [P2]
ffa029c6: CC = R0 == 0x0
ffa029c8: IF !CC JUMP 0xffa029e6
ffa029ca: LOAD R0 = [P5]
ffa029cc: ADD R0 += 0x1
ffa029ce: STORE [P5] = R0
ffa029d0: MOVE P1 = FP
ffa029d2: ADD P1 += 0x10
ffa029d4: LOAD R1 = W [P1] (Z)
ffa029d6: CC = R0 <= R1 (IU)
ffa029d8: IF CC JUMP 0xffa029e4
ffa029da: LOAD R0 = 0x2
ffa029dc: LOAD R0.H = 0xf000
ffa029e0: STORE [P2] = R0
ffa029e2: JUMP.S 0xffa029e4
ffa029e4: JUMP.S 0xffa029b6
ffa029e6: LOAD R0 = [P2]
ffa029e8: CC = R0 == 0x0
ffa029ea: IF !CC JUMP 0xffa029fa
ffa029ec: LOAD R0 = [P5]
ffa029ee: CC = R0 == 0x0
ffa029f0: IF CC JUMP 0xffa029f8
ffa029f2: ADD R0 += -0x1
ffa029f4: STORE [P5] = R0
ffa029f6: JUMP.S 0xffa029ec
ffa029f8: JUMP.S 0xffa029fa
ffa029fa: LOAD R0 = W [P0] (Z)
ffa029fc: LOAD R1 = 0xbfff
ffa02a00: AND R0 = R0 & R1
ffa02a02: STORE W [P0] = R0.L
ffa02a04: LOAD P1 = 0x510
ffa02a08: LOAD P1.H = 0xffc0
ffa02a0c: LOAD R0 = W [P1] (X)
ffa02a0e: LOAD P1 = [FP + 0xc]
ffa02a10: STORE W [P1] = R0.L
ffa02a12: LOAD R0 = [P2]
ffa02a14: LOAD P5 = [SP++]
ffa02a16: UNLINK
ffa02a1a: RTS
ffa02a1c: MOVE P1 = R0
ffa02a1e: LINK 0x10
ffa02a22: PUSH [--SP] = (R7:7,P5:4)
ffa02a24: ADD SP += -0xc
ffa02a26: LOAD P4.L = 0x3e34
ffa02a2a: LOAD P4.H = 0xff80
ffa02a2e: LOAD P0 = [P1 + 0x10]
ffa02a30: STORE [P4] = P1
ffa02a32: LOAD R0 = [P0 + 0x18]
ffa02a34: LOAD R1 = [P0 + 0x28]
ffa02a36: CC = R0 <= R1 (IU)
ffa02a38: STORE [P4 + 0x4] = R0
ffa02a3a: IF !CC JUMP 0xffa02a46
ffa02a3c: ADD SP += 0xc
ffa02a3e: POP (R7:7,P5:4) = [SP++]
ffa02a40: UNLINK
ffa02a44: RTS
ffa02a46: LOAD R1 = [P0 + 0x14]
ffa02a48: LOAD R0 = [P1 + 0x8]
ffa02a4a: CC = R0 == 0x0
ffa02a4c: STORE [P4 + 0x8] = R1
ffa02a4e: LOAD P5.L = 0x18
ffa02a52: LOAD P5.H = 0xff80
ffa02a56: IF !CC JUMP 0xffa02ac2
ffa02a58: LOAD R0 = W [P5] (Z)
ffa02a5a: LOAD R1 = [P4 + 0x8]
ffa02a5c: LOAD R2 = 0x3c
ffa02a5e: CALL 0xffa0297a
ffa02a62: LOAD P1 = [P4]
ffa02a64: STORE [P4 + 0xc] = R0
ffa02a66: LOAD R0 = [P1 + 0x14]
ffa02a68: CC = R0 == 0x0
ffa02a6a: IF CC JUMP 0xffa02a88
ffa02a6c: MOVE P1 = FP
ffa02a6e: ADD P1 += 0x8
ffa02a70: MOVE R2 = CYCLES
ffa02a72: MOVE R1 = CYCLES2
ffa02a74: STORE [P1] = R2
ffa02a76: STORE [P1 + 0x4] = R1
ffa02a78: LOAD R0 = [SP + 0x30]
ffa02a7a: LOAD R1 = [SP + 0x34]
ffa02a7c: LOAD P1 = [P4 + 0x0]
ffa02a7e: SUB R0 = R0 - R7
ffa02a80: LOAD P1 = [P1 + 0x14]
ffa02a82: LOAD R1 = [P1 + 0x4]
ffa02a84: ADD R0 = R0 + R1
ffa02a86: STORE [P1 + 0x4] = R0
ffa02a88: LOAD P1 = [P4]
ffa02a8a: LOAD R0 = [P4 + 0x8]
ffa02a8c: ADD R0 += 0x2
ffa02a8e: LOAD R2 = [P4 + 0x4]
ffa02a90: LOAD P0 = [P1 + 0x10]
ffa02a92: STORE [P4 + 0x8] = R0
ffa02a94: LOAD R1 = [P0 + 0x28]
ffa02a96: ADD R1 += 0x1
ffa02a98: STORE [P0 + 0x28] = R1
ffa02a9a: LOAD P0 = [P1 + 0x10]
ffa02a9c: STORE [P0 + 0x14] = R0
ffa02a9e: LOAD P1 = [P1 + 0x10]
ffa02aa0: LOAD R0 = [P1 + 0x28]
ffa02aa2: CC = R2 <= R0 (IU)
ffa02aa4: IF !CC JUMP 0xffa02a3c (bp)
ffa02aa6: LOAD R1 = 0x0
ffa02aa8: LOAD R0 = 0x5
ffa02aaa: LOAD R0.H = 0x7
ffa02aae: CALL 0xffa0add0
ffa02ab2: LOAD P1.L = 0x6ee0
ffa02ab6: LOAD P1.H = 0xff80
ffa02aba: LOAD R0 = [P1]
ffa02abc: BITSET (R0,0x0)
ffa02abe: STORE [P1] = R0
ffa02ac0: JUMP.S 0xffa02a3c
ffa02ac2: LOAD R0 = W [P5] (Z)
ffa02ac4: LOAD R2 = 0x3c
ffa02ac6: CALL 0xffa0297a
ffa02aca: LOAD P1 = [P4]
ffa02acc: STORE [P4 + 0xc] = R0
ffa02ace: LOAD R0 = [P1 + 0x14]
ffa02ad0: CC = R0 == 0x0
ffa02ad2: IF CC JUMP 0xffa02ae4
ffa02ad4: MOVE P1 = FP
ffa02ad6: ADD P1 += -0x10
ffa02ad8: MOVE R2 = CYCLES
ffa02ada: MOVE R1 = CYCLES2
ffa02adc: STORE [P1] = R2
ffa02ade: STORE [P1 + 0x4] = R1
ffa02ae0: LOAD R7 = [SP + 0x18]
ffa02ae2: LOAD R0 = [SP + 0x1c]
ffa02ae4: LOAD R0 = W [P5] (Z)
ffa02ae6: LOAD R1 = [P4 + 0x8]
ffa02ae8: ADD R1 += 0x2
ffa02aea: STORE [P4 + 0x8] = R1
ffa02aec: LOAD R2 = 0x3c
ffa02aee: CALL 0xffa0297a
ffa02af2: LOAD P1 = [P4]
ffa02af4: STORE [P4 + 0xc] = R0
ffa02af6: LOAD R0 = [P1 + 0x14]
ffa02af8: CC = R0 == 0x0
ffa02afa: IF CC JUMP 0xffa02b18
ffa02afc: MOVE P1 = FP
ffa02afe: ADD P1 += -0x8
ffa02b00: MOVE R2 = CYCLES
ffa02b02: MOVE R1 = CYCLES2
ffa02b04: STORE [P1] = R2
ffa02b06: STORE [P1 + 0x4] = R1
ffa02b08: LOAD R0 = [SP + 0x20]
ffa02b0a: LOAD R1 = [SP + 0x24]
ffa02b0c: LOAD P1 = [P4 + 0x0]
ffa02b0e: SUB R0 = R0 - R7
ffa02b10: LOAD P1 = [P1 + 0x14]
ffa02b12: LOAD R1 = [P1]
ffa02b14: ADD R0 = R0 + R1
ffa02b16: STORE [P1] = R0
ffa02b18: LOAD R0 = [P4 + 0x8]
ffa02b1a: ADD R0 += 0x2
ffa02b1c: STORE [P4 + 0x8] = R0
ffa02b1e: JUMP.S 0xffa02a58
ffa02b20: LINK 0x0
ffa02b24: PUSH [--SP] = (R7:6,P5:5)
ffa02b26: ADD SP += -0x24
ffa02b28: LOAD P5.L = 0x20
ffa02b2c: LOAD P5.H = 0xff80
ffa02b30: ROT|| R7 = rot R0 by 0
ffa02b34: _LOAD R6 = [P5]
ffa02b36: _NOP
ffa02b38: CC = R6 == 0x0
ffa02b3a: IF !CC JUMP 0xffa02bb2 (bp)
ffa02b3c: LOAD R0 = 0x1
ffa02b3e: STORE [P5--] = R0
ffa02b40: LOAD R0 = 0x2
ffa02b42: LOAD R0.H = 0x9
ffa02b46: CALL 0xffa0872a
ffa02b4a: STORE [SP + 0x10] = P5
ffa02b4c: STORE [SP + 0xc] = P5
ffa02b4e: LOAD P1 = 0x0
ffa02b50: STORE [SP + 0x1c] = P1
ffa02b52: STORE [SP + 0x18] = P1
ffa02b54: LOAD P1.L = 0x6ff8
ffa02b58: LOAD P1.H = 0xff80
ffa02b5c: LOAD R0 = [P1]
ffa02b5e: LOAD P1.L = 0x2970
ffa02b62: LOAD P1.H = 0xffa0
ffa02b66: STORE [SP + 0x20] = P1
ffa02b68: LOAD P1 = 0x3
ffa02b6a: STORE [SP + 0x14] = P1
ffa02b6c: LOAD R2 = 0x0
ffa02b6e: LOAD R1.L = 0x2060
ffa02b72: LOAD R1.H = 0xff80
ffa02b76: CALL 0xffa0bce4
ffa02b7a: LOAD R1 = 0x4
ffa02b7c: BITSET (R1,0x1e)
ffa02b7e: LOAD R0 = [P5]
ffa02b80: LOAD R2.L = 0x5f24
ffa02b84: LOAD R2.H = 0x2020
ffa02b88: CALL 0xffa10684
ffa02b8c: LOAD R0 = 0xa
ffa02b8e: LOAD R0.H = 0x410
ffa02b92: CALL 0xffa08c20
ffa02b96: LOAD P1.L = 0x5c20
ffa02b9a: LOAD P1.H = 0x2020
ffa02b9e: CALL (P1)
ffa02ba0: LOAD P1 = [P5 + 0x10]
ffa02ba2: MOVE R0 = R7
ffa02ba4: MOVE R1 = FP
ffa02ba6: ADD R1 += 0xc
ffa02ba8: STORE [P1 + 0x28] = R6
ffa02baa: LOAD R2 = 0x3e8
ffa02bae: CALL 0xffa0297a
ffa02bb2: ADD SP += 0x24
ffa02bb4: POP (R7:6,P5:5) = [SP++]
ffa02bb6: UNLINK
ffa02bba: RTS
ffa02bf0: LINK 0x0
ffa02bf4: UNLINK
ffa02bf8: RTS
ffa02bfa: LINK 0x1c
ffa02bfe: PUSH [--SP] = (R7:5,P5:3)
ffa02c00: ADD SP += -0xc
ffa02c02: STORE [FP + 0x10] = R2
ffa02c04: STORE [FP + 0xc] = R1
ffa02c06: STORE [FP + 0x8] = R0
ffa02c08: LOAD P5.L = 0x47
ffa02c0c: LOAD P5.H = 0xff80
ffa02c10: LOAD R3 = B [P5] (Z)
ffa02c12: CC = R3 == 0x0
ffa02c14: IF CC JUMP 0xffa02c1c (bp)
ffa02c16: LOAD R0 = 0x0
ffa02c18: STORE B [P5] = R0
ffa02c1a: JUMP.S 0xffa02eca
ffa02c1c: LOAD P2.L = 0x48
ffa02c20: LOAD P2.H = 0xff80
ffa02c24: LOAD P1 = [P2]
ffa02c26: LOAD R0 = [P1 + 0x8]
ffa02c28: CC = R0 == 0x1
ffa02c2a: IF !CC JUMP 0xffa02c4c (bp)
ffa02c2c: LOAD R2 = 0x1
ffa02c2e: STORE B [P5] = R2
ffa02c30: LOAD R1 = 0x0
ffa02c32: LOAD R0 = 0x5
ffa02c34: LOAD R0.H = 0x7
ffa02c38: CALL 0xffa0add0
ffa02c3c: LOAD P1.L = 0x6ee0
ffa02c40: LOAD P1.H = 0xff80
ffa02c44: LOAD R0 = [P1]
ffa02c46: BITSET (R0,0x1)
ffa02c48: STORE [P1] = R0
ffa02c4a: JUMP.S 0xffa02eca
ffa02c4c: LOAD P0 = [P1 + 0x4]
ffa02c4e: LOAD R0 = B [P0] (Z)
ffa02c50: STORE W [FP + -0x4] = R0
ffa02c54: LOAD R0 = [P1 + 0x4]
ffa02c56: ADD R0 += 0x1
ffa02c58: STORE [P1 + 0x4] = R0
ffa02c5a: LOAD P1 = [P2]
ffa02c5c: LOAD R0 = [P1 + 0x8]
ffa02c5e: ADD R0 += -0x1
ffa02c60: STORE [P1 + 0x8] = R0
ffa02c62: LOAD R0 = W [FP + -0x4] (Z)
ffa02c66: LSH R0 = R0 << 0x6
ffa02c6a: MOVE R0 = R0.L (Z)
ffa02c6c: STORE W [FP + -0x4] = R0
ffa02c70: LOAD P4.L = 0x44
ffa02c74: LOAD P4.H = 0xff80
ffa02c78: LOAD R1 = W [P4] (Z)
ffa02c7a: LSH R1 = R1 << 0xe
ffa02c7e: OR R1 = R0 | R1
ffa02c80: STORE W [FP + -0x4] = R1
ffa02c84: LOAD P1.L = 0x4c
ffa02c88: LOAD P1.H = 0xff80
ffa02c8c: LOAD R2 = B [P1] (Z)
ffa02c8e: CC = R2 == 0x0
ffa02c90: IF CC JUMP 0xffa02cf4
ffa02c92: NOP
ffa02c94: NOP
ffa02c96: LOAD P1 = 0x500
ffa02c9a: LOAD P1.H = 0xffc0
ffa02c9e: LOAD R0 = W [P1] (Z)
ffa02ca0: BITSET (R0,0xe)
ffa02ca2: STORE W [P1] = R0.L
ffa02ca4: LOAD R0 = W [FP + -0x4] (X)
ffa02ca8: LOAD P0 = 0x50c
ffa02cac: LOAD P0.H = 0xffc0
ffa02cb0: STORE W [P0] = R0.L
ffa02cb2: LOAD R1 = 0x0
ffa02cb4: STORE [FP + -0x8] = R1
ffa02cb6: LOAD R0 = [FP + -0x8]
ffa02cb8: LOAD R1 = 0x3c
ffa02cba: CC = R1 <= R0
ffa02cbc: IF CC JUMP 0xffa02cda
ffa02cbe: NOP
ffa02cc0: NOP
ffa02cc2: LOAD P0 = 0x508
ffa02cc6: LOAD P0.H = 0xffc0
ffa02cca: LOAD R0 = W [P0] (Z)
ffa02ccc: CC = !BITTST (R0,0x5)
ffa02cce: IF CC JUMP 0xffa02cd2 (bp)
ffa02cd0: JUMP.S 0xffa02cda
ffa02cd2: LOAD R0 = [FP + -0x8]
ffa02cd4: ADD R0 += 0x1
ffa02cd6: STORE [FP + -0x8] = R0
ffa02cd8: JUMP.S 0xffa02cb6
ffa02cda: LOAD R0 = W [P1] (Z)
ffa02cdc: LOAD R1 = 0xbfff
ffa02ce0: AND R0 = R0 & R1
ffa02ce2: STORE W [P1] = R0.L
ffa02ce4: LOAD P0 = 0x510
ffa02ce8: LOAD P0.H = 0xffc0
ffa02cec: LOAD R0 = W [P0] (X)
ffa02cee: STORE W [FP + -0x2] = R0
ffa02cf2: JUMP.S 0xffa02eca
ffa02cf4: LOAD P1.L = 0x3c
ffa02cf8: LOAD P1.H = 0xff80
ffa02cfc: STORE [FP + -0x14] = P1
ffa02cfe: LOAD R1 = 0x0
ffa02d00: STORE B [P1] = R1
ffa02d02: LOAD P0 = 0x504
ffa02d06: LOAD P0.H = 0xffc0
ffa02d0a: STORE [FP + -0xc] = P0
ffa02d0c: LOAD R2 = 0x2
ffa02d0e: STORE W [P0] = R2.L
ffa02d10: LOAD P0 = 0x500
ffa02d14: LOAD P0.H = 0xffc0
ffa02d18: LOAD R0 = W [P0] (Z)
ffa02d1a: BITSET (R0,0xe)
ffa02d1c: STORE W [P0] = R0.L
ffa02d1e: LOAD R0 = W [FP + -0x4] (X)
ffa02d22: LOAD P1 = 0x50c
ffa02d26: LOAD P1.H = 0xffc0
ffa02d2a: STORE [FP + -0x10] = P1
ffa02d2c: STORE W [P1] = R0.L
ffa02d2e: STORE [FP + -0x8] = R1
ffa02d30: LOAD R0 = [FP + -0x8]
ffa02d32: LOAD R7 = 0x3c
ffa02d34: CC = R7 <= R0
ffa02d36: IF CC JUMP 0xffa02d54
ffa02d38: NOP
ffa02d3a: NOP
ffa02d3c: LOAD P1 = 0x508
ffa02d40: LOAD P1.H = 0xffc0
ffa02d44: LOAD R0 = W [P1] (Z)
ffa02d46: CC = !BITTST (R0,0x5)
ffa02d48: IF CC JUMP 0xffa02d4c (bp)
ffa02d4a: JUMP.S 0xffa02d54
ffa02d4c: LOAD R0 = [FP + -0x8]
ffa02d4e: ADD R0 += 0x1
ffa02d50: STORE [FP + -0x8] = R0
ffa02d52: JUMP.S 0xffa02d30
ffa02d54: LOAD R0 = W [P0] (Z)
ffa02d56: LOAD R3 = 0xbfff
ffa02d5a: AND R0 = R0 & R3
ffa02d5c: STORE W [P0] = R0.L
ffa02d5e: LOAD P1 = 0x510
ffa02d62: LOAD P1.H = 0xffc0
ffa02d66: STORE [FP + -0x1c] = P1
ffa02d68: LOAD R0 = W [P1] (X)
ffa02d6a: STORE W [FP + -0x2] = R0
ffa02d6e: LOAD R6 = [FP + -0x8]
ffa02d70: CC = R6 == R7
ffa02d72: IF !CC JUMP 0xffa02d84 (bp)
ffa02d74: LOAD R0 = 0x5
ffa02d76: LOAD R0.H = 0x7
ffa02d7a: CALL 0xffa0add0
ffa02d7e: LOAD R2 = 0x1
ffa02d80: STORE B [P5] = R2
ffa02d82: JUMP.S 0xffa02eca
ffa02d84: LOAD P1.L = 0x46
ffa02d88: LOAD P1.H = 0xff80
ffa02d8c: STORE [FP + -0x18] = P1
ffa02d8e: LOAD R0 = B [P1] (Z)
ffa02d90: CC = R0 == 0x0
ffa02d92: IF CC JUMP 0xffa02dcc
ffa02d94: NOP
ffa02d96: NOP
ffa02d98: LOAD P1 = [P2]
ffa02d9a: LOAD P3 = [P1 + 0x4]
ffa02d9c: LOAD R0 = B [P3] (Z)
ffa02d9e: STORE W [FP + -0x4] = R0
ffa02da2: LOAD R0 = [P1 + 0x4]
ffa02da4: ADD R0 += 0x1
ffa02da6: STORE [P1 + 0x4] = R0
ffa02da8: LOAD P1 = [P2]
ffa02daa: LOAD R0 = [P1 + 0x8]
ffa02dac: ADD R0 += -0x1
ffa02dae: STORE [P1 + 0x8] = R0
ffa02db0: LOAD R0 = W [FP + -0x4] (Z)
ffa02db4: LSH R0 = R0 << 0x6
ffa02db8: MOVE R0 = R0.L (Z)
ffa02dba: STORE W [FP + -0x4] = R0
ffa02dbe: LOAD R6 = W [P4] (Z)
ffa02dc0: LSH R6 = R6 << 0xe
ffa02dc4: OR R6 = R0 | R6
ffa02dc6: STORE W [FP + -0x4] = R6
ffa02dca: JUMP.S 0xffa02dcc
ffa02dcc: LOAD R6 = 0x1
ffa02dce: LOAD P3 = [FP + -0x14]
ffa02dd0: STORE B [P3] = R6
ffa02dd2: LOAD R0 = 0x4
ffa02dd4: LOAD P1 = [FP + -0xc]
ffa02dd6: STORE W [P1] = R0.L
ffa02dd8: LOAD R0 = W [P0] (Z)
ffa02dda: BITSET (R0,0xe)
ffa02ddc: STORE W [P0] = R0.L
ffa02dde: LOAD R0 = W [FP + -0x4] (X)
ffa02de2: LOAD P3 = [FP + -0x10]
ffa02de4: STORE W [P3] = R0.L
ffa02de6: STORE [FP + -0x8] = R1
ffa02de8: LOAD R0 = [FP + -0x8]
ffa02dea: CC = R7 <= R0
ffa02dec: IF CC JUMP 0xffa02e0a
ffa02dee: NOP
ffa02df0: NOP
ffa02df2: LOAD P1 = 0x508
ffa02df6: LOAD P1.H = 0xffc0
ffa02dfa: LOAD R0 = W [P1] (Z)
ffa02dfc: CC = !BITTST (R0,0x5)
ffa02dfe: IF CC JUMP 0xffa02e02 (bp)
ffa02e00: JUMP.S 0xffa02e0a
