ffa087ec: LINK 0x0
ffa087f0: PUSH [--SP] = (R7:6,P5:5)
ffa087f2: MOVE R7 = R1
ffa087f4: MOVE R1 = R0.B (Z)
ffa087f6: LOAD R2 = 0x3c
ffa087f8: ADD SP += -0xc
ffa087fa: MULT R1 = R1.L * R2.L (fu)
ffa087fe: MOVE P1 = R1
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
