ffa005fc: MAC|| A1 += R4.H * R0.L (m)
ffa00600: LOAD R4 = [SP + 0x28]
ffa00602: NOP
ffa00604: MAC A1 += R2.L * R2.L (fu)
ffa00608: ASH A1 = A1 >>> 0xf
ffa0060c: MOVE R2 = (A0 += A1)
ffa00610: ADD R2 = R2 + R4 (s)
ffa00614: CC = BITTST (R1,0x0)
ffa00616: ASH R4 = R2 >>> 0x1f
ffa0061a: ROT|| R1 = rot R3 by -0x1
ffa0061e: STORE [SP + 0xc] = R4
ffa00620: NOP
ffa00622: LSH R0 = R3 << 0x1f
ffa00626: CALL 0xffa01258
ffa0062a: CALL 0xffa02894
ffa0062e: MOVE R1 = R6
ffa00630: CALL 0xffa018f0
ffa00634: MOVE R1 = R6
ffa00636: CALL 0xffa01716
ffa0063a: MOVE R1 = R7
ffa0063c: CALL 0xffa01716
ffa00640: ADD SP += 0x10
ffa00642: ROT|| R1 = rot R0 by 0
ffa00646: _LOAD P0 = [FP + 0x4]
ffa00648: _NOP
ffa0064a: CC = R5 < 0x0
ffa0064c: POP (R7:4) = [SP++]
ffa0064e: BITTGL (R1,0x1f)
ffa00650: UNLINK
ffa00654: IF CC R0 = R1
ffa00656: JUMP (P0)
ffa00658: ADD SP += 0x10
ffa0065a: LOAD P0 = [FP + 0x4]
ffa0065c: POP (R7:4) = [SP++]
ffa0065e: UNLINK
ffa00662: JUMP (P0)
ffa00664: MAC A1 = R0.L * R0.L (fu)
ffa00668: LOAD R1 = 0x80
ffa0066c: MAC A1 += R1.L * R1.L 
ffa00670: LSH A1 = A1 >> 0x10
ffa00674: MAC A1 += R0.H * R0.L (m),A0 = R0.H * R0.H 
ffa00678: MAC A1 += R0.H * R0.L (m)
