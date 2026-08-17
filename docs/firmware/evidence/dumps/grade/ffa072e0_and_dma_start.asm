######## FFA072E0 (JUMP.L from emit parent)
ffa072e0: PUSH [--SP] = (P5:3)
ffa072e2: LOAD P1 = [P0++]
ffa072e4: LOAD P2 = 0x0
ffa072e6: ADD P4 = P0 + (P1 << 2)
ffa072e8: ADD P4 += 0x4
ffa072ea: LSETUP (0xffa072ee,0xffa07304) LC0 = P1
ffa072ee: CC = P1 <= P2
ffa072f0: IF CC JUMP 0xffa07306
ffa072f2: ADD P3 = P1 + P2
ffa072f4: LSHIFT P3 = P3 >> 1
ffa072f6: ADD P5 = P0 + (P3 << 2)
ffa072f8: LOAD R1 = [P5]
ffa072fa: CC = R1 == R0
ffa072fc: IF CC JUMP 0xffa07308
ffa072fe: CC = R1 < R0 (IU)
ffa07300: IF !CC P1 = P3
ffa07302: ADD P3 += 0x1
ffa07304: IF CC P2 = P3
ffa07306: LOAD P3 = -0x1
ffa07308: ADD P1 = P4 + (P3 << 2)
ffa0730a: LOAD P1 = [P1]
ffa0730c: POP (P5:3) = [SP++]
ffa0730e: JUMP (P1)
ffa07310: ???
ffa07312: ???
ffa07314: ???
ffa07316: ???
ffa07318: ???
ffa0731a: ???
ffa0731c: ???
ffa0731e: ???
ffa07320: ???
ffa07322: ???
ffa07324: LINK 0x0
ffa07328: PUSH [--SP] = (P5:4)
ffa0732a: ADD SP += -0xc
ffa0732c: LOAD P4.L = 0x1a34
ffa07330: LOAD P4.H = 0xff80
ffa07334: LOAD P1 = [P4]
ffa07336: LOAD R0 = [P1 + 0x4]
ffa07338: CC = R0 == 0x0
ffa0733a: IF CC JUMP 0xffa07352
ffa0733c: LOAD P5 = 0x4
ffa0733e: LOAD P1 = [P4]
ffa07340: ADD P1 = P1 + P5
ffa07342: LOAD P1 = [P1]
ffa07344: ADD P5 += 0x4
ffa07346: CALL (P1)
ffa07348: LOAD P1 = [P4]
ffa0734a: ADD P1 = P1 + P5
ffa0734c: LOAD R0 = [P1]
ffa0734e: CC = R0 == 0x0
ffa07350: IF !CC JUMP 0xffa0733e (bp)
ffa07352: ADD SP += 0xc
ffa07354: POP (P5:4) = [SP++]
ffa07356: UNLINK
ffa0735a: RTS
ffa0735c: ADD R1 += -0x7
ffa0735e: LOAD R0 = 0x8
ffa07360: CC = R1 < R0 (IU)
ffa07362: IF !CC JUMP 0xffa07376
ffa07364: MOVE P1 = R1
ffa07366: LOAD P0.L = 0x3660
ffa0736a: LOAD P0.H = 0xff80
ffa0736e: ADD P1 = P0 + (P1 << 2)
ffa07370: LOAD P1 = [P1]
ffa07372: JUMP (P1)
ffa07374: RAISE 0x7
ffa07376: RTS
ffa07378: RAISE 0x8
ffa0737a: RTS
ffa0737c: RAISE 0x9
ffa0737e: RTS
ffa07380: RAISE 0xa
ffa07382: RTS
ffa07384: RAISE 0xb
ffa07386: RTS
ffa07388: RAISE 0xc
ffa0738a: RTS
ffa0738c: RAISE 0xd
ffa0738e: RTS
ffa07390: RAISE 0xe
ffa07392: RTS
ffa07394: LINK 0x0
ffa07398: PUSH [--SP] = (R7:4,P5:3)
ffa0739a: MOVE P4 = R0
ffa0739c: ADD SP += -0xc
ffa0739e: LOAD P5.L = 0x75bc
ffa073a2: LOAD P5.H = 0xff80
ffa073a6: ROT|| R6 = rot R0 by 0
ffa073aa: _LOAD R0 = [P5]
ffa073ac: _NOP
ffa073ae: MOVE R4 = R2
ffa073b0: MOVE R5 = R1
ffa073b2: CALL 0xffa08cea
ffa073b6: SUB|| R1 = R1 - R1 (ns)
ffa073ba: _LOAD R2 = W [P4 + 0x10] (Z)
ffa073bc: _NOP
ffa073be: LSH|| R3.L = R2.L << 0x0
ffa073c2: LOAD P2 = [P4 + 0xc]
ffa073c4: NOP
ffa073c6: LOAD R7 = 0x18
ffa073c8: ADD R2 += 0x2
ffa073ca: MULT|| R3 = R3.L * R7.L (fu)
ffa073ce: LOAD P0 = [P4 + 0x14]
ffa073d0: NOP
ffa073d2: MOVE P3 = R3
ffa073d4: MOVE P1 = R2
ffa073d6: ADD P2 = P2 + P3
ffa073d8: LSETUP (0xffa073dc,0xffa073f0) LC0 = P1
ffa073dc: ADD P0 += 0x18
ffa073de: MOVE P1 = P0
ffa073e0: CC = P2 <= P0
ffa073e2: SUB P1 -= P3
ffa073e4: IF CC P0 = P1
ffa073e6: ADD R1 += 0x1
ffa073e8: MOVE R2 = P0
ffa073ea: STORE [P4 + 0x14] = R2
ffa073ec: LOAD R2 = [P0]
ffa073ee: CC = R2 == -0x1
ffa073f0: IF CC JUMP 0xffa07404
ffa073f2: LOAD P0 = [P4 + 0x14]
ffa073f4: ADD R1 += 0x1
ffa073f6: ADD P0 += 0x18
ffa073f8: MOVE P1 = P0
ffa073fa: CC = P2 <= P1
ffa073fc: SUB P0 -= P3
ffa073fe: IF CC P1 = P0
ffa07400: MOVE R2 = P1
ffa07402: STORE [P4 + 0x14] = R2
ffa07404: LOAD R2 = W [P4 + 0x10] (Z)
ffa07406: CC = R2 < R1 (IU)
ffa07408: LOAD R7 = 0x1
ffa0740a: BITSET (R7,0x11)
ffa0740c: IF !CC JUMP 0xffa07420
ffa0740e: CALL 0xffa08d0c
ffa07412: ADD SP += 0xc
ffa07414: MOVE R0 = R7
ffa07416: LOAD P0 = [FP + 0x4]
ffa07418: POP (R7:4,P5:3) = [SP++]
ffa0741a: UNLINK
ffa0741e: JUMP (P0)
ffa07420: LOAD P1 = [P4 + 0x14]
ffa07422: LOAD R7 = [FP + 0x1c]
ffa07424: STORE [P1] = R5
ffa07426: LOAD P3 = [P4 + 0x14]
ffa07428: CALL 0xffa08d0c
ffa0742c: LOAD P0.L = 0x1a38
ffa07430: LOAD P0.H = 0xff80
ffa07434: LOAD R1 = [P0]
ffa07436: STORE [P3 + 0x4] = R1
ffa07438: ADD R1 += 0x1
ffa0743a: LOAD R3 = [SP + 0x3c]
ffa0743c: LOAD R2 = [FP + 0x18]
ffa0743e: LOAD P1.L = 0x1a38
ffa07442: LOAD P1.H = 0xff80
ffa07446: STORE [P3 + 0x14] = R7
ffa07448: STORE [P3 + 0xc] = R3
ffa0744a: STORE [P3 + 0x10] = R2
ffa0744c: STORE [P1] = R1
ffa0744e: LOAD R0 = [P5]
ffa07450: CALL 0xffa08cea
ffa07454: ROT|| R3 = rot R0 by 0
ffa07458: _LOAD R1 = W [P4 + 0x12] (Z)
ffa0745a: _NOP
ffa0745c: CC = R1 == 0x0
ffa0745e: IF !CC JUMP 0xffa07482
ffa07460: STORE [P4 + 0x1c] = P3
ffa07462: MOVE R2 = R5.L (Z)
ffa07464: ROT|| R0 = rot R6 by 0
ffa07468: _LOAD R1 = W [P4 + 0x12] (X)
ffa0746a: _NOP
ffa0746c: ADD R1 += 0x1
ffa0746e: SUB|| R7 = R7 - R7 (ns)
ffa07472: _STORE W [P4 + 0x12] = R1
ffa07474: _NOP
ffa07476: STORE [P3 + 0x8] = R4
ffa07478: LOAD R1 = W [P4 + 0x8] (Z)
ffa0747a: CALL 0xffa0735c
ffa0747e: MOVE R0 = R3
ffa07480: JUMP.S 0xffa0740e
ffa07482: LOAD P1 = [P4 + 0x1c]
ffa07484: LOAD R0 = [P4 + 0x1c]
ffa07486: CC = R0 == 0x0
ffa07488: IF CC JUMP 0xffa07462
ffa0748a: NOP
ffa0748c: NOP
ffa0748e: NOP
ffa07490: LOAD R0 = [P1]
ffa07492: LOAD R1 = [P3]
ffa07494: CC = R1 < R0 (IU)
ffa07496: IF !CC JUMP 0xffa07462
ffa07498: STORE [P4 + 0x1c] = P3
ffa0749a: JUMP.S 0xffa07462
ffa0749c: MOVE P2 = R0
ffa0749e: PUSH [--SP] = (R7:5,P5:3)
ffa074a0: LOAD R2 = 0x4
ffa074a2: LOAD P4 = -0x1
ffa074a4: LOAD R0 = [P2 + 0x3c]
ffa074a6: CC = R0 < 0x4 (IU)

######## stores to FFC00xxx in L1 DMA region FFA07B00-FFA08300
--- @ffa07bba
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

--- @ffa07cb0
ffa07c9a: STORE [P5 + 0x40] = R1
ffa07c9e: JUMP.S 0xffa07bc8
ffa07ca0: STORE [P5 + 0x40] = R5
ffa07ca4: MOVE R0 = R7
ffa07ca6: JUMP.S 0xffa07bc8
ffa07ca8: LOAD R1 = [P5 + 0x60]
ffa07cac: CC = R1 == 0x0
ffa07cae: IF CC JUMP 0xffa07cc8
ffa07cb0: STORE [P5 + 0x58] = R1
ffa07cb4: LOAD R0 = [P5 + 0x64]
ffa07cb8: STORE [P5 + 0x5c] = R0
ffa07cbc: LOAD R0 = 0x0

--- @ffa07df8
ffa07dde: LOAD R7.H = 0x3
ffa07de2: LOAD R0 = [P1 + 0x4]
ffa07de4: CALL 0xffa08cea
ffa07de8: LOAD R2 = [P4 + 0x40]
ffa07dec: CC = R2 == 0x0
ffa07dee: IF !CC JUMP 0xffa07e0a
ffa07df0: STORE B [P4 + 0x47] = R2
ffa07df4: STORE [P4 + 0x54] = R2
ffa07df8: STORE [P4 + 0x58] = R2
ffa07dfc: STORE [P4 + 0x5c] = R2
ffa07e00: STORE [P4 + 0x60] = R2
ffa07e04: STORE [P4 + 0x64] = R2

--- @ffa08120
ffa0810c: LOAD R1 = B [P4 + 0x46] (Z)
ffa08110: CC = R1 == 0x0
ffa08112: LOAD R2 = B [P4 + 0x45] (Z)
ffa08116: LOAD R1 = W [P5] (Z)
ffa08118: IF !CC JUMP 0xffa081b4
ffa0811a: CC = R2 == 0x0
ffa0811c: IF !CC JUMP 0xffa081a6
ffa0811e: CC = R1 == 0x0
ffa08120: STORE [P4 + 0x58] = R1
ffa08124: IF CC JUMP 0xffa081a0
ffa08126: LOAD R1 = [P4 + 0x60]
ffa0812a: CC = R1 == 0x0
ffa0812c: IF CC JUMP 0xffa0814e

--- @ffa08198
ffa08184: LOAD P0 = [P4]
ffa08186: LOAD R2 = W [P1 + 0x6] (X)
ffa08188: STORE W [P0] = R2.L
ffa0818a: LOAD R7 = W [P5 + 0x10] (Z)
ffa0818c: JUMP.S 0xffa08096

--- @ffa081ba
ffa081aa: LSHIFT R3 <<= 0x10
ffa081ac: AND R2 = R2 & R3
ffa081ae: OR R1 = R1 | R2
ffa081b0: MOVE P1 = R1
ffa081b2: JUMP.S 0xffa08152
ffa081b4: CC = R2 == 0x0
ffa081b6: IF !CC JUMP 0xffa081c6
ffa081b8: CC = R1 == 0x0
ffa081ba: STORE [P4 + 0x58] = R1
ffa081be: IF !CC JUMP 0xffa0818a (bp)
ffa081c0: STORE [P4 + 0x5c] = R1
ffa081c4: JUMP.S 0xffa0818a
ffa081c6: MOVE R2 = P5

--- @ffa081ea
ffa081d6: LOAD R1 = B [P4 + 0x45] (Z)
ffa081da: IF !CC JUMP 0xffa08276
ffa081dc: CC = R1 == 0x0
ffa081de: LOAD R1 = W [P5 + 0x2] (X)
ffa081e0: PACK R1 = pack(R1.L,R1.L)
ffa081e4: LOAD R1.L = W [P5]
ffa081e6: IF !CC JUMP 0xffa08272
ffa081e8: CC = R1 == 0x0
ffa081ea: STORE [P4 + 0x58] = R1
ffa081ee: IF CC JUMP 0xffa0826c
ffa081f0: LOAD R1 = [P4 + 0x60]
ffa081f4: CC = R1 == 0x0
ffa081f6: IF CC JUMP 0xffa0821e

--- @ffa08264
ffa08250: LOAD P0 = [P4]
ffa08252: LOAD R2 = W [P1 + 0x8] (X)
ffa08254: STORE W [P0] = R2.L
ffa08256: LOAD R7 = W [P5 + 0x12] (Z)
ffa08258: JUMP.S 0xffa08096

--- @ffa08284
ffa08272: MOVE P1 = R1
ffa08274: JUMP.S 0xffa08222
ffa08276: CC = R1 == 0x0
ffa08278: LOAD R1 = W [P5 + 0x2] (X)
ffa0827a: LSH R1.H = R1.L << 0x0
ffa0827e: LOAD R1.L = W [P5]
ffa08280: IF !CC JUMP 0xffa08256
ffa08282: CC = R1 == 0x0
ffa08284: STORE [P4 + 0x58] = R1
ffa08288: IF !CC JUMP 0xffa08256 (bp)
ffa0828a: STORE [P4 + 0x5c] = R1
ffa0828e: JUMP.S 0xffa08256
ffa08290: MOVE P1 = R0


######## after 0x147a/0x28f4 load: next stores
--- site 20211e4e
20211e4e: LOAD R3 = 0x147a
20211e52: LOAD R1 = 0x44
20211e56: MIN R3 = min(R2,R3)
20211e5a: ADD R0 = R0 + R1
20211e5c: STORE W [P5 + 0x58] = R3
20211e60: LSH R2 = R3 << 0x1
20211e64: LOAD R1 = 0x0
20211e66: LOAD P1.L = 0x5f2e
20211e6a: LOAD P1.H = 0xffa0
20211e6e: CALL (P1)
20211e70: LOAD R1 = [P5 + 0x44]
20211e74: ASH|| R1 = R1 >>> 0x12
20211e78: _LOAD R0 = [P5 + 0x3c]
20211e7a: _NOP
20211e7c: ADD R1 += -0x1
20211e7e: MAX R2 = max(R1,R4)
20211e82: MULT R0 = R0.L * R6.H (is)
20211e86: MIN R3 = min(R2,R7)
20211e8a: ADD R0 = R5 + R0
20211e8c: LOAD R2 = 0x3374
20211e90: ADD R0 = R0 + R2
20211e92: STORE W [P5 + 0x58] = R3
20211e96: LSH R2 = R3 << 0x1
20211e9a: LOAD R1 = 0x0
20211e9c: LOAD P1.L = 0x5f2e

--- site 20211f14
20211f14: LOAD R3 = 0x147a
20211f18: MULT R0 = R0.L * R6.H (is)
20211f1c: MIN R3 = min(R1,R3)
20211f20: ADD R0 = R5 + R0
20211f22: LOAD R1 = 0x44
20211f26: LOAD R2 = 0x147a
20211f2a: ADD R0 = R0 + R1
20211f2c: LSH R1 = R3 << 0x1
20211f30: SUB R2 = R2 - R3
20211f32: ADD R0 = R0 + R1
20211f34: STORE W [P5 + 0x58] = R3
20211f38: LSHIFT R2 <<= 0x1
20211f3a: LOAD R1 = 0x0
20211f3c: LOAD P1.L = 0x5f2e
20211f40: LOAD P1.H = 0xffa0
20211f44: CALL (P1)
20211f46: LOAD R1 = [P5 + 0x48]
20211f4a: ASH|| R1 = R1 >>> 0x12
20211f4e: _LOAD R0 = [P5 + 0x3c]
20211f50: _NOP
20211f52: MAX R1 = max(R1,R4)
20211f56: MULT R0 = R0.L * R6.H (is)
20211f5a: MIN R3 = min(R1,R7)
20211f5e: ADD R0 = R5 + R0
20211f60: LOAD R2 = 0x3374

--- site 20211f26
20211f26: LOAD R2 = 0x147a
20211f2a: ADD R0 = R0 + R1
20211f2c: LSH R1 = R3 << 0x1
20211f30: SUB R2 = R2 - R3
20211f32: ADD R0 = R0 + R1
20211f34: STORE W [P5 + 0x58] = R3
20211f38: LSHIFT R2 <<= 0x1
20211f3a: LOAD R1 = 0x0
20211f3c: LOAD P1.L = 0x5f2e
20211f40: LOAD P1.H = 0xffa0
20211f44: CALL (P1)
20211f46: LOAD R1 = [P5 + 0x48]
20211f4a: ASH|| R1 = R1 >>> 0x12
20211f4e: _LOAD R0 = [P5 + 0x3c]
20211f50: _NOP
20211f52: MAX R1 = max(R1,R4)
20211f56: MULT R0 = R0.L * R6.H (is)
20211f5a: MIN R3 = min(R1,R7)
20211f5e: ADD R0 = R5 + R0
20211f60: LOAD R2 = 0x3374
20211f64: ADD R0 = R0 + R2
20211f66: LSH R1 = R3 << 0x1
20211f6a: SUB R2 = R7 - R3
20211f6c: ADD R0 = R0 + R1
20211f6e: STORE W [P5 + 0x58] = R3

--- site 20211d62
20211d62: LOAD R2 = 0x28f4
20211d66: LOAD R1 = 0x0
20211d68: LOAD P1.L = 0x5f2e
20211d6c: LOAD P1.H = 0xffa0
20211d70: CALL (P1)
20211d72: LOAD R0 = [P5 + 0x3c]
20211d74: MULT R0 = R0.L * R6.H (is)
20211d78: ADD R0 = R5 + R0
20211d7a: LOAD R3 = 0x3374
20211d7e: ADD R0 = R0 + R3
20211d80: LOAD R1 = 0x0
20211d82: LOAD R2 = 0x51e
20211d86: LOAD P1.L = 0x5f2e
20211d8a: LOAD P1.H = 0xffa0
20211d8e: CALL (P1)
20211d90: LOAD R0 = [P5 + 0x3c]
20211d92: MULT R0 = R0.L * R6.H (is)
20211d96: ADD R0 = R5 + R0
20211d98: LOAD R3 = 0x3892
20211d9c: ADD R0 = R0 + R3
20211d9e: LOAD R1 = 0x0
20211da0: LOAD R2 = 0x51e
20211da4: LOAD P1.L = 0x5f2e
20211da8: LOAD P1.H = 0xffa0
20211dac: CALL (P1)

--- site ffa03b00
ffa03b00: LOAD R7 = 0x147a
ffa03b04: ADD R2 += 0x1
ffa03b06: ADD R0 += 0x1
ffa03b08: CC = R1 < R7
ffa03b0a: MOVE P1 = P4
ffa03b0c: ASH|| R2 = R3 >>> 0x2
ffa03b10: _STORE [FP + 0x28] = R2
ffa03b12: _NOP
ffa03b14: STORE [SP + 0x2c] = R0
ffa03b16: ADD P4 += 0x2
ffa03b18: IF !CC JUMP 0xffa03c2a
ffa03b1a: LOAD P0 = [P5 + 0x8]
ffa03b1c: STORE [SP + 0x3c] = R2
ffa03b1e: LOAD R6 = 0xff
ffa03b22: LSH R4 = R6 << 0x17
ffa03b26: ADD P1 = P0 + P1
ffa03b28: LOAD R0 = W [P1] (X)
ffa03b2a: CALL 0xffa02948
ffa03b2e: LOAD R1 = [P5 + 0x10]
ffa03b30: CALL 0xffa018f0
ffa03b34: ROT|| R7 = rot R0 by 0
ffa03b38: _LOAD P3 = [P5 + 0xc]
ffa03b3a: _NOP
ffa03b3c: ROT|| R5 = rot R0 by 0
ffa03b40: _LOAD P1 = [SP + 0x3c]

--- site ffa04fe0
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

