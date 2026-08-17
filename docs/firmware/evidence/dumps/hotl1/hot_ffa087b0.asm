ffa087b0: LOAD R1 = 0x1004
ffa087b4: EXTRACT R1 = extract(R0,R1.L) (z)
ffa087b8: MOVE R0 = R0.B (Z)
ffa087ba: LSHIFT R1 <<= 0x8
ffa087bc: LSHIFT R0 <<= 0x10
ffa087be: LINK 0x10
ffa087c2: OR R1 = R0 | R1
ffa087c4: STORE [SP + 0xc] = R7
ffa087c6: MOVE R0 = SP
ffa087c8: LOAD R2 = 0x18
ffa087ca: ADD|| R0 = R0 + R2 (ns)
ffa087ce: _STORE [SP + 0x18] = R1
ffa087d0: _NOP
ffa087d2: LOAD R1 = 0x1
ffa087d4: LOAD R2 = 0x1
ffa087d6: CALL 0xffa09b40
ffa087da: LOAD R7 = 0x5
ffa087dc: LOAD P0 = [FP + 0x4]
ffa087de: CC = R0 == 0x0
ffa087e0: BITSET (R7,0x13)
ffa087e2: IF !CC R0 = R7
ffa087e4: LOAD R7 = [SP + 0xc]
ffa087e6: UNLINK
ffa087ea: JUMP (P0)
