ffa05ee4: NEG R2 = -R0
ffa05ee6: NEG R3 = -R1
ffa05ee8: MAX R2 = max(R2,R0)
ffa05eec: MAX R3 = max(R3,R1)
ffa05ef0: CC = R3 <= R2
ffa05ef2: LINK 0x10
ffa05ef6: ASH R2 = R1 >>> 0x1f
ffa05efa: ASH|| R3 = R0 >>> 0x1f
ffa05efe: _STORE [SP + 0xc] = R2
ffa05f00: _NOP
ffa05f02: IF !CC JUMP 0xffa05f1a
ffa05f04: MOVE R2 = R1
ffa05f06: MOVE R1 = R3
ffa05f08: CALL 0xffa01c38
ffa05f0c: CC = R1 < 0x0
ffa05f0e: LOAD R1 = 0x0
ffa05f10: BITSET (R1,0x1f)
ffa05f12: LOAD R0 = -0x1
ffa05f14: LSHIFT R0 >>= 0x1
ffa05f16: IF CC R0 = R1
ffa05f18: JUMP.S 0xffa05f28
ffa05f1a: CC = BITTST (R3,0x0)
ffa05f1c: MOVE R2 = R1
ffa05f1e: ROT R1 = rot R0 by -0x1
ffa05f22: LSHIFT R0 <<= 0x1f
ffa05f24: CALL 0xffa01150
ffa05f28: UNLINK
ffa05f2c: RTS
ffa05f2e: LINK 0x0
