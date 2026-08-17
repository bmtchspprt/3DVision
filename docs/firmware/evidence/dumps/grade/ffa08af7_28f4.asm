ffa08800: LOAD P0.L = 0x761c
ffa08804: LOAD P0.H = 0xff80
ffa08808: LSH|| R1.L = R0.H << 0x0
ffa0880c: LOAD R0 = [P0]
ffa0880e: NOP
ffa08810: LOAD P0.L = 0x3814
ffa08814: LOAD P0.H = 0xff80
ffa08818: LOAD R2 = 0xf
ffa0881a: ADD P5 = P0 + P1
ffa0881c: AND R6 = R1 & R2
ffa0881e: CALL 0xffa08cea
ffa08822: LOAD P1 = [P5 + 0x28]
ffa08824: LOAD R1 = 0x1
ffa08826: ASH R1.L = ashift R1.L by R6.L
ffa0882a: CC = R7 == 0x0
ffa0882c: LOAD R2 = W [P1] (X)
ffa0882e: LOAD P1 = [P5 + 0x38]
ffa08830: NOT R7 = ~R1
ffa08832: LOAD R3 = W [P1] (X)
ffa08834: IF CC JUMP 0xffa0883c
ffa08836: OR R2 = R1 | R2
ffa08838: AND R1 = R7 & R3
ffa0883a: JUMP.S 0xffa08840
ffa0883c: AND R2 = R7 & R2
ffa0883e: OR R1 = R1 | R3
ffa08840: LOAD P1 = [P5 + 0x28]
ffa08842: STORE W [P1] = R2.L
ffa08844: LOAD P1 = [P5 + 0x38]
ffa08846: STORE W [P1] = R1.L
ffa08848: CALL 0xffa08d0c
ffa0884c: ADD SP += 0xc
ffa0884e: SUB|| R0 = R0 - R0 (ns)
ffa08852: _LOAD P0 = [FP + 0x4]
ffa08854: _NOP
ffa08856: POP (R7:6,P5:5) = [SP++]
ffa08858: UNLINK
ffa0885c: JUMP (P0)
ffa08874: LINK 0xc
ffa08878: LOAD R2 = 0x1
ffa0887a: CALL 0xffa08670
ffa0887e: LOAD P0 = [FP + 0x4]
ffa08880: UNLINK
ffa08884: JUMP (P0)
ffa08888: LINK 0x0
ffa0888c: PUSH [--SP] = (R7:5,P5:5)
ffa0888e: MOVE R7 = R1
ffa08890: MOVE R1 = R0.B (Z)
ffa08892: LOAD R2 = 0x3c
ffa08894: ADD SP += -0xc
ffa08896: MULT R1 = R1.L * R2.L (fu)
ffa0889a: MOVE P1 = R1
ffa0889c: LOAD P0.L = 0x761c
ffa088a0: LOAD P0.H = 0xff80
ffa088a4: LSH|| R1.L = R0.H << 0x0
ffa088a8: LOAD R0 = [P0]
ffa088aa: NOP
ffa088ac: LOAD P0.L = 0x3814
ffa088b0: LOAD P0.H = 0xff80
ffa088b4: LOAD R2 = 0xf
ffa088b6: ADD P5 = P0 + P1
ffa088b8: AND R6 = R1 & R2
ffa088ba: CALL 0xffa08cea
ffa088be: LOAD P1 = [P5 + 0x2c]
ffa088c0: LOAD R1 = 0x1
ffa088c2: ASH R5.L = ashift R1.L by R6.L
ffa088c6: CC = R7 < 0x7 (IU)
ffa088c8: LOAD R1.L = W [P1]
ffa088ca: LOAD P1 = [P5 + 0x30]
ffa088cc: NOT R3 = ~R5
ffa088ce: LOAD R6.L = W [P1]
ffa088d0: LOAD P1 = [P5 + 0x34]
ffa088d2: LOAD P0.L = 0x38c8
ffa088d6: LOAD P0.H = 0xff80
ffa088da: LOAD R2.L = W [P1]
ffa088dc: IF !CC JUMP 0xffa088ee
ffa088de: NOP
ffa088e0: MOVE P1 = R7
ffa088e2: ADD P1 = P0 + (P1 << 2)
ffa088e4: LOAD P1 = [P1]
ffa088e6: JUMP (P1)
ffa088e8: AND R1 = R3 & R1
ffa088ea: AND R6 = R3 & R6
ffa088ec: AND R2 = R3 & R2
ffa088ee: LOAD P1 = [P5 + 0x2c]
ffa088f0: STORE W [P1] = R1.L
ffa088f2: LOAD P1 = [P5 + 0x30]
ffa088f4: STORE W [P1] = R6.L
ffa088f6: LOAD P1 = [P5 + 0x34]
ffa088f8: STORE W [P1] = R2.L
ffa088fa: CALL 0xffa08d0c
ffa088fe: ADD SP += 0xc
ffa08900: SUB|| R0 = R0 - R0 (ns)
ffa08904: _LOAD P0 = [FP + 0x4]
ffa08906: _NOP
ffa08908: POP (R7:5,P5:5) = [SP++]
ffa0890a: UNLINK
ffa0890e: JUMP (P0)
ffa08910: AND R1 = R3 & R1
ffa08912: AND R2 = R3 & R2
ffa08914: OR R6 = R5 | R6
ffa08916: JUMP.S 0xffa088ee
ffa08918: AND R1 = R3 & R1
ffa0891a: OR R6 = R5 | R6
ffa0891c: OR R2 = R5 | R2
ffa0891e: JUMP.S 0xffa088ee
ffa08920: OR R1 = R5 | R1
ffa08922: AND R6 = R3 & R6
ffa08924: AND R2 = R3 & R2
ffa08926: JUMP.S 0xffa088ee
ffa08928: AND R2 = R3 & R2
ffa0892a: OR R1 = R5 | R1
ffa0892c: OR R6 = R5 | R6
ffa0892e: JUMP.S 0xffa088ee
ffa08b3c: LOAD R1 = 0x505
ffa08b40: EXTRACT R1 = extract(R0,R1.L) (z)
ffa08b44: MOVE P1 = R1
ffa08b46: LOAD R1 = 0x1f
ffa08b48: LOAD P0 = 0x120
ffa08b4c: LOAD P0.H = 0xffc0
ffa08b50: AND R1 = R0 & R1
ffa08b52: LOAD R0 = 0x1
ffa08b54: ADD P1 = P0 + (P1 << 2)
ffa08b56: LSHIFT R0 <<= R1
ffa08b58: LOAD R3 = [P1]
ffa08b5a: AND R0 = R3 & R0
ffa08b5c: CC = R0 == 0x0
ffa08b5e: LOAD R2 = 0x5
ffa08b60: LOAD R2.H = 0x5
ffa08b64: LOAD R0 = 0x6
ffa08b66: LOAD R0.H = 0x5
ffa08b6a: IF !CC R0 = R2
ffa08b6c: RTS
ffa08b72: CC = R0 == 0x1
ffa08b74: MOVE P1 = R1
ffa08b76: LOAD P0 = 0x124
ffa08b7a: LOAD P0.H = 0xffc0
ffa08b7e: IF !CC JUMP 0xffa08b90
ffa08b80: LOAD R0 = [P1]
ffa08b82: SUB|| R0 = R0 - R0 (ns)
ffa08b86: _STORE [P0] = R0
ffa08b88: _NOP
ffa08b8a: RTS
ffa08b90: SUB|| R1 = R1 - R1 (ns)
ffa08b94: _LOAD R0 = [P0]
ffa08b96: _NOP
ffa08b98: SUB|| R0 = R0 - R0 (ns)
ffa08b9c: _STORE [P1] = R0
ffa08b9e: _NOP
ffa08ba0: STORE [P0] = R1
ffa08ba2: RTS
ffa08ba4: CC = R1 == 0x0
ffa08ba6: LOAD R1 = 0xf05
ffa08baa: EXTRACT R1 = extract(R0,R1.L) (z)
ffa08bae: MOVE P1 = R1
ffa08bb0: LOAD R1 = 0x1f
ffa08bb2: AND R1 = R0 & R1
ffa08bb4: LOAD P0 = 0x124
ffa08bb8: LOAD P0.H = 0xffc0
ffa08bbc: LOAD R0 = 0x1
ffa08bbe: LSHIFT R0 <<= R1
ffa08bc0: ADD P1 = P0 + (P1 << 2)
ffa08bc2: IF CC JUMP 0xffa08bd8
ffa08bc4: NOP
ffa08bc6: NOP
ffa08bc8: NOP
ffa08bca: LOAD R1 = [P1]
ffa08bcc: OR R0 = R0 | R1
ffa08bce: SUB|| R0 = R0 - R0 (ns)
ffa08bd2: _STORE [P1] = R0
ffa08bd4: _NOP
ffa08bd6: RTS
ffa08bd8: LOAD R1 = [P1]
ffa08bda: NOT R0 = ~R0
ffa08bdc: AND R0 = R0 & R1
ffa08bde: SUB|| R0 = R0 - R0 (ns)
ffa08be2: _STORE [P1] = R0
ffa08be4: _NOP
ffa08be6: RTS
ffa08be8: LOAD R2 = 0x1405
ffa08bec: EXTRACT R2 = extract(R0,R2.L) (z)
ffa08bf0: MOVE P1 = R2
ffa08bf2: LOAD R2 = 0x1903
ffa08bf6: LOAD P2 = 0x110
ffa08bfa: LOAD P2.H = 0xffc0
ffa08bfe: EXTRACT R0 = extract(R0,R2.L) (z)
ffa08c02: MOVE P0 = R1
ffa08c04: ADD P1 = P2 + (P1 << 2)
ffa08c06: LSH|| R1 = R0 << 0x2
ffa08c0a: _LOAD R0 = [P1]
ffa08c0c: _NOP
ffa08c0e: LSHIFT R0 >>= R1
ffa08c10: LOAD R1 = 0xf
ffa08c12: AND R0 = R0 & R1
ffa08c14: ADD R0 += 0x7
ffa08c16: SUB|| R0 = R0 - R0 (ns)
ffa08c1a: _STORE [P0] = R0
ffa08c1c: _NOP
ffa08c1e: RTS
ffa08c20: LOAD R1 = 0xa05
ffa08c24: EXTRACT R1 = extract(R0,R1.L) (z)
ffa08c28: MOVE P1 = R1
ffa08c2a: LOAD R1 = 0x1f
ffa08c2c: AND R1 = R0 & R1
ffa08c2e: LOAD P0 = 0x10c
ffa08c32: LOAD P0.H = 0xffc0
ffa08c36: LOAD R0 = 0x1
ffa08c38: ADD P1 = P0 + (P1 << 2)
ffa08c3a: LSHIFT R0 <<= R1
ffa08c3c: LOAD R2 = [P1]
ffa08c3e: NOT R1 = ~R0
ffa08c40: AND R1 = R1 & R2
ffa08c42: SUB|| R0 = R0 - R0 (ns)
ffa08c46: _STORE [P1] = R1
ffa08c48: _NOP
ffa08c4a: RTS
ffa08c4c: LOAD R1 = 0xa05
ffa08c50: EXTRACT R1 = extract(R0,R1.L) (z)
ffa08c54: MOVE P1 = R1
ffa08c56: LOAD R1 = 0x1f
ffa08c58: LOAD P0 = 0x10c
ffa08c5c: LOAD P0.H = 0xffc0
ffa08c60: AND R0 = R0 & R1
ffa08c62: LOAD R1 = 0x1
ffa08c64: ADD P1 = P0 + (P1 << 2)
ffa08c66: LSHIFT R1 <<= R0
ffa08c68: SUB|| R0 = R0 - R0 (ns)
ffa08c6c: _LOAD R2 = [P1]
ffa08c6e: _NOP
ffa08c70: OR R1 = R1 | R2
ffa08c72: STORE [P1] = R1
ffa08c74: RTS
ffa08c78: LOAD P2.L = 0x7628
ffa08c7c: LOAD P2.H = 0xff80
ffa08c80: MOVE P0 = P2
ffa08c82: ADD P0 += 0x8
ffa08c84: MOVE I0 = P0
ffa08c86: LOAD P0 = 0x10
ffa08c88: MOVE P1 = R2
ffa08c8a: LOAD M0 = 0xc
ffa08c8e: SUB|| R2 = R2 - R2 (ns)
ffa08c92: _LOAD R3 = [SP + 0xc]
ffa08c94: _NOP
ffa08c96: LSETUP (0xffa08c9a,0xffa08c9c) LC0 = P0
ffa08c9a: STORE [I0 ++ M0] = R2
ffa08c9c: STORE [I0++] = R2
ffa08c9e: LSH|| R1 = R1 >> 0x4
ffa08ca2: _STORE [P2] = R3
ffa08ca4: _NOP
ffa08ca6: CC = R1 == 0x0
ffa08ca8: STORE [P1] = R1
ffa08caa: IF CC JUMP 0xffa08ce0
ffa08cac: STORE [P2 + 0x4] = R0
ffa08cae: LOAD R1 = [P1]
ffa08cb0: CC = R1 == 0x0
ffa08cb2: ROT|| R1 = rot R0 by 0
ffa08cb6: _LOAD P1 = [P1]
ffa08cb8: _NOP
ffa08cba: IF CC JUMP 0xffa08cd6
ffa08cbc: ADD R0 += 0xc
ffa08cbe: MOVE I0 = R0
ffa08cc0: ADD R1 += 0x10
ffa08cc2: LOAD R3 = 0x10
ffa08cc4: LOAD M0 = 0x10
ffa08cc8: LSETUP (0xffa08ccc,0xffa08cce) LC0 = P1
ffa08ccc: MOVE R0 = R1
ffa08cce: ADD|| R1 = R0 + R3 (ns)
ffa08cd2: _STORE [I0 ++ M0] = R0
ffa08cd4: _NOP
ffa08cd6: MOVE P1 = R0
ffa08cd8: LOAD R0 = 0x0
ffa08cda: STORE [P1 + -0x4] = R2
ffa08cde: RTS
ffa08ce0: SUB|| R0 = R0 - R0 (ns)
ffa08ce4: _STORE [P2 + 0x4] = R2
ffa08ce6: _NOP
ffa08ce8: RTS
ffa08cea: CLI R1
ffa08cec: LOAD P1.L = 0x1ad4
ffa08cf0: LOAD P1.H = 0xff80
ffa08cf4: LOAD R0 = [P1]
ffa08cf6: CC = R0 == 0x0
ffa08cf8: ADD R0 += 0x1
ffa08cfa: STORE [P1] = R0
ffa08cfc: LOAD P1.L = 0x7624
ffa08d00: LOAD P1.H = 0xff80
ffa08d04: IF !CC JUMP 0xffa08d08
ffa08d06: STORE [P1] = R1
ffa08d08: LOAD R0 = [P1]
ffa08d0a: RTS
ffa08d0c: LOAD P1.L = 0x1ad4
ffa08d10: LOAD P1.H = 0xff80
ffa08d14: LOAD R0 = [P1]
ffa08d16: ADD R0 += -0x1
ffa08d18: CC = R0 == 0x0
ffa08d1a: STORE [P1] = R0
ffa08d1c: IF !CC JUMP 0xffa08d2e
ffa08d1e: NOP
ffa08d20: NOP
ffa08d22: LOAD P1.L = 0x7624
ffa08d26: LOAD P1.H = 0xff80
ffa08d2a: LOAD R0 = [P1]
ffa08d2c: STI R0
ffa08d2e: RTS
ffa08d30: LINK 0xc
ffa08d34: LOAD P1.L = 0x1ad4
ffa08d38: LOAD P1.H = 0xff80
ffa08d3c: ROT|| R2 = rot R0 by 0
ffa08d40: _LOAD R0 = [P1]
ffa08d42: _NOP
ffa08d44: CC = R0 == 0x0
ffa08d46: LOAD P0.L = 0x7624
ffa08d4a: LOAD P0.H = 0xff80
ffa08d4e: IF CC JUMP 0xffa08d60
ffa08d50: LOAD R0 = [P0]
ffa08d52: OR R0 = R2 | R0
ffa08d54: STORE [P0] = R0
ffa08d56: LOAD P0 = [FP + 0x4]
ffa08d58: UNLINK
ffa08d5c: JUMP (P0)
ffa08d60: LOAD P1.L = 0x7628
ffa08d64: LOAD P1.H = 0xff80
ffa08d68: LOAD R0 = [P1]
ffa08d6a: CALL 0xffa08cea
ffa08d6e: LOAD R1 = [P0]
ffa08d70: OR R1 = R2 | R1
ffa08d72: STORE [P0] = R1
ffa08d74: CALL 0xffa08d0c
ffa08d78: LOAD P0 = [FP + 0x4]
ffa08d7a: UNLINK
ffa08d7e: JUMP (P0)
ffa08d80: LINK 0xc
ffa08d84: LOAD P1.L = 0x1ad4
ffa08d88: LOAD P1.H = 0xff80
ffa08d8c: LOAD R1 = [P1]
ffa08d8e: CC = R1 == 0x0
ffa08d90: LOAD P0.L = 0x7624
ffa08d94: LOAD P0.H = 0xff80
ffa08d98: IF CC JUMP 0xffa08dac
ffa08d9a: LOAD R1 = [P0]
ffa08d9c: NOT R0 = ~R0
ffa08d9e: AND R0 = R0 & R1
ffa08da0: STORE [P0] = R0
ffa08da2: LOAD P0 = [FP + 0x4]
ffa08da4: UNLINK
ffa08da8: JUMP (P0)
ffa08dac: LOAD P1.L = 0x7628
ffa08db0: LOAD P1.H = 0xff80
ffa08db4: NOT R2 = ~R0
ffa08db6: LOAD R0 = [P1]
ffa08db8: CALL 0xffa08cea
ffa08dbc: LOAD R1 = [P0]
ffa08dbe: AND R1 = R2 & R1
ffa08dc0: STORE [P0] = R1
ffa08dc2: CALL 0xffa08d0c
ffa08dc6: LOAD P0 = [FP + 0x4]
ffa08dc8: UNLINK
ffa08dcc: JUMP (P0)
ffa08dd0: LINK 0x0
ffa08dd4: PUSH [--SP] = (R7:4,P5:5)
ffa08dd6: MOVE R6 = R0
ffa08dd8: LSH R0 = R6 << 0x4
ffa08ddc: MOVE P1 = R0
ffa08dde: LOAD P5.L = 0x7628
ffa08de2: LOAD P5.H = 0xff80
ffa08de6: MOVE P0 = P5
ffa08de8: ADD SP += -0xc
ffa08dea: ADD P0 += 0x8
ffa08dec: ROT|| R7 = rot R1 by 0
ffa08df0: _LOAD R0 = [P5]
ffa08df2: _NOP
ffa08df4: ADD P2 = P0 + P1
ffa08df6: CALL 0xffa08cea
ffa08dfa: ROT|| R3 = rot R0 by 0
ffa08dfe: _LOAD R5 = [P2]
ffa08e00: _NOP
ffa08e02: CC = R5 == 0x0
ffa08e04: LOAD R4 = [SP + 0x34]
ffa08e06: IF CC JUMP 0xffa08e82
ffa08e08: MOVE P1 = P2
ffa08e0a: LOAD P0 = -0x1
ffa08e0c: LSETUP (0xffa08e10,0xffa08e20) LC0 = P0
ffa08e10: CC = P1 == 0x0
ffa08e12: IF CC JUMP 0xffa08e7e
ffa08e14: NOP
ffa08e16: NOP
ffa08e18: NOP
ffa08e1a: LOAD R0 = [P1]
ffa08e1c: CC = R7 == R0
ffa08e1e: IF CC JUMP 0xffa08e24
ffa08e20: LOAD P1 = [P1 + 0xc]
ffa08e22: JUMP.S 0xffa08e0c
ffa08e24: LOAD R0 = [P1 + 0x4]
ffa08e26: CC = R2 == R0
ffa08e28: IF !CC JUMP 0xffa08e20 (bp)
ffa08e2a: LOAD R0 = [P1 + 0x8]
ffa08e2c: ADD R0 += 0x1
ffa08e2e: STORE [P1 + 0x8] = R0
ffa08e30: LOAD R0 = 0x1
ffa08e32: CC = R0 == 0x0
ffa08e34: LOAD R5 = 0x0
ffa08e36: IF !CC JUMP 0xffa08e66
ffa08e38: LOAD R0 = 0x4
ffa08e3a: PACK|| R5 = pack(R5.H,R0.L)
ffa08e3e: _LOAD P1 = [P5 + 0x4]
ffa08e40: _NOP
ffa08e42: LOAD R5.H = 0x5
ffa08e46: LOAD R0 = [P5 + 0x4]
ffa08e48: CC = R0 == 0x0
ffa08e4a: IF CC JUMP 0xffa08e66
ffa08e4c: NOP
ffa08e4e: NOP
ffa08e50: NOP
ffa08e52: LOAD R0 = [P1 + 0xc]
ffa08e54: STORE [P5 + 0x4] = R0
ffa08e56: STORE [P1] = R7
ffa08e58: STORE [P1 + 0x4] = R2
ffa08e5a: LOAD R0 = 0x1
ffa08e5c: STORE [P1 + 0x8] = R0
ffa08e5e: LOAD R0 = [P2 + 0xc]
ffa08e60: STORE [P1 + 0xc] = R0
ffa08e62: STORE [P2 + 0xc] = P1
ffa08e64: LOAD R5 = 0x0
ffa08e66: MOVE R0 = R3
ffa08e68: CALL 0xffa08d0c
ffa08e6c: ADD SP += 0xc
ffa08e6e: ROT|| R0 = rot R5 by 0
ffa08e72: _LOAD P0 = [FP + 0x4]
ffa08e74: _NOP
ffa08e76: POP (R7:4,P5:5) = [SP++]
ffa08e78: UNLINK
ffa08e7c: JUMP (P0)
ffa08e7e: LOAD R0 = 0x0
ffa08e80: JUMP.S 0xffa08e32
ffa08e82: CC = R4 == 0x0
ffa08e84: STORE [P2] = R7
ffa08e86: STORE [P2 + 0x4] = R2
ffa08e88: LOAD P0.L = 0x1ad8
ffa08e8c: LOAD P0.H = 0xff80
ffa08e90: LOAD P1.L = 0x1b18
ffa08e94: LOAD P1.H = 0xff80
ffa08e98: IF CC P0 = P1
ffa08e9a: MOVE P1 = R6
ffa08e9c: LOAD R0 = 0x1
ffa08e9e: LOAD P5 = 0x2000
ffa08ea2: LOAD P5.H = 0xffe0
ffa08ea6: STORE [P2 + 0x8] = R0
ffa08ea8: LSHIFT R0 <<= R6
ffa08eaa: ADD P0 = P0 + (P1 << 2)
ffa08eac: ADD P1 = P5 + (P1 << 2)
ffa08eae: LOAD R1 = [P0]
ffa08eb0: STORE [P1] = R1
ffa08eb2: CALL 0xffa08d30
ffa08eb6: JUMP.S 0xffa08e66
ffa08eb8: MOVE R3 = R0
ffa08eba: LINK 0x0
ffa08ebe: PUSH [--SP] = (R7:5,P5:3)
ffa08ec0: LOAD R6 = 0x7
ffa08ec2: LSH R0 = R3 << 0x4
ffa08ec6: MOVE P1 = R0
ffa08ec8: LOAD P0.L = 0x7628
ffa08ecc: LOAD P0.H = 0xff80
ffa08ed0: ADD SP += -0xc
ffa08ed2: MOVE P4 = P0
ffa08ed4: ADD P0 += 0x8
ffa08ed6: ROT|| R5 = rot R1 by 0
ffa08eda: _LOAD R0 = [P4]
ffa08edc: _NOP
ffa08ede: ADD P5 = P0 + P1
ffa08ee0: CALL 0xffa08cea
ffa08ee4: ROT|| R7 = rot R0 by 0
ffa08ee8: _LOAD R0 = [P5]
ffa08eea: _NOP
ffa08eec: CC = R0 == 0x0
ffa08eee: LOAD R6.H = 0x5
ffa08ef2: IF CC JUMP 0xffa08f32
ffa08ef4: CC = R5 == R0
ffa08ef6: IF CC JUMP 0xffa08f4a
ffa08ef8: LOAD P0 = -0x1
ffa08efa: LSETUP (0xffa08efe,0xffa08f12) LC0 = P0
ffa08efe: LOAD P1 = [P5 + 0xc]
ffa08f00: LOAD R0 = [P5 + 0xc]
ffa08f02: CC = R0 == 0x0
ffa08f04: IF CC JUMP 0xffa08f32
ffa08f06: NOP
ffa08f08: NOP
ffa08f0a: NOP
ffa08f0c: LOAD R0 = [P1]
ffa08f0e: CC = R5 == R0
ffa08f10: IF CC JUMP 0xffa08f16
ffa08f12: MOVE P5 = P1
ffa08f14: JUMP.S 0xffa08efa
ffa08f16: LOAD R0 = [P1 + 0x4]
ffa08f18: CC = R2 == R0
ffa08f1a: IF !CC JUMP 0xffa08f12 (bp)
ffa08f1c: LOAD R0 = [P1 + 0x8]
ffa08f1e: ADD R0 += -0x1
ffa08f20: CC = R0 == 0x0
ffa08f22: STORE [P1 + 0x8] = R0
ffa08f24: IF !CC JUMP 0xffa08f30
ffa08f26: LOAD R0 = [P1 + 0xc]
ffa08f28: STORE [P5 + 0xc] = R0
ffa08f2a: LOAD R0 = [P4 + 0x4]
ffa08f2c: STORE [P1 + 0xc] = R0
ffa08f2e: STORE [P4 + 0x4] = P1
ffa08f30: LOAD R6 = 0x0
ffa08f32: MOVE R0 = R7
ffa08f34: CALL 0xffa08d0c
ffa08f38: ADD SP += 0xc
ffa08f3a: ROT|| R0 = rot R6 by 0
ffa08f3e: _LOAD P0 = [FP + 0x4]
ffa08f40: _NOP
ffa08f42: POP (R7:5,P5:3) = [SP++]
ffa08f44: UNLINK
ffa08f48: JUMP (P0)
ffa08f4a: LOAD R0 = [P5 + 0x4]
ffa08f4c: CC = R2 == R0
ffa08f4e: IF !CC JUMP 0xffa08ef8 (bp)
ffa08f50: LOAD R6 = [P5 + 0x8]
ffa08f52: ADD R6 += -0x1
ffa08f54: CC = R6 == 0x0
ffa08f56: STORE [P5 + 0x8] = R6
ffa08f58: IF !CC JUMP 0xffa08f70
ffa08f5a: LOAD R1 = [P5 + 0xc]
ffa08f5c: CC = R1 == 0x0
ffa08f5e: LOAD P3 = [P5 + 0xc]
ffa08f60: IF CC JUMP 0xffa08f74
ffa08f62: MOVE R0 = P5
ffa08f64: LOAD R2 = 0x10
ffa08f66: CALL 0xffa0281c
ffa08f6a: LOAD R0 = [P4 + 0x4]
ffa08f6c: STORE [P3 + 0xc] = R0
ffa08f6e: STORE [P4 + 0x4] = P3
ffa08f70: LOAD R6 = 0x0
ffa08f72: JUMP.S 0xffa08f32
ffa08f74: MOVE P2 = R3
ffa08f76: LOAD R0 = 0x1
ffa08f78: LSHIFT R0 <<= R3
ffa08f7a: LOAD P4 = 0x2000
ffa08f7e: LOAD P4.H = 0xffe0
ffa08f82: CALL 0xffa08d80
ffa08f86: ADD P1 = P4 + (P2 << 2)
ffa08f88: STORE [P1] = R6
ffa08f8a: STORE [P5] = R6
ffa08f8c: JUMP.S 0xffa08f70
ffa08f90: PUSH [--SP] = RETI
ffa08f92: PUSH [--SP] = ASTAT
ffa08f94: PUSH [--SP] = FP
ffa08f96: PUSH [--SP] = (R7:1,P5:0)
ffa08f98: PUSH [--SP] = I0
ffa08f9a: PUSH [--SP] = I1
ffa08f9c: PUSH [--SP] = I2
ffa08f9e: PUSH [--SP] = I3
ffa08fa0: PUSH [--SP] = B0
ffa08fa2: PUSH [--SP] = B1
ffa08fa4: PUSH [--SP] = B2
ffa08fa6: PUSH [--SP] = B3
ffa08fa8: PUSH [--SP] = L0
ffa08faa: PUSH [--SP] = L1
ffa08fac: PUSH [--SP] = L2
ffa08fae: PUSH [--SP] = L3
ffa08fb0: PUSH [--SP] = M0
ffa08fb2: PUSH [--SP] = M1
ffa08fb4: PUSH [--SP] = M2
ffa08fb6: PUSH [--SP] = M3
ffa08fb8: MOVE R1.L = A0.X
ffa08fbc: PUSH [--SP] = R1
ffa08fbe: MOVE R1 = A0.W
ffa08fc0: PUSH [--SP] = R1
ffa08fc2: MOVE R1.L = A1.X
ffa08fc6: PUSH [--SP] = R1
ffa08fc8: MOVE R1 = A1.W
ffa08fca: PUSH [--SP] = R1
ffa08fcc: PUSH [--SP] = LC0
ffa08fce: LOAD R3 = 0x0
ffa08fd0: MOVE LC0 = R3
ffa08fd2: PUSH [--SP] = LC1
ffa08fd4: LOAD R3 = 0x0
ffa08fd6: MOVE LC1 = R3
ffa08fd8: PUSH [--SP] = LT0
ffa08fda: PUSH [--SP] = LT1
ffa08fdc: PUSH [--SP] = LB0
ffa08fde: PUSH [--SP] = LB1
ffa08fe0: ADD SP += -0xc
ffa08fe2: LOAD L0 = 0x0
ffa08fe6: LOAD L1 = 0x0
ffa08fea: LOAD L2 = 0x0
ffa08fee: LOAD L3 = 0x0
ffa08ff2: LINK 0x14
ffa08ff6: MOVE P3 = R0
ffa08ff8: NOP
ffa08ffa: NOP
ffa08ffc: NOP
ffa08ffe: NOP
