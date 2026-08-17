ffa00280: STI R0
ffa00282: LOAD P0.L = 0x0
ffa00286: LOAD P0.H = 0x0
ffa0028a: LOAD R0 = [P0]
ffa0028c: STORE [P0] = R0
ffa0028e: FLUSH [P0]
ffa00290: LOAD R4 = W [P1] (Z)
ffa00292: CC = BITTST (R4,0x1)
ffa00294: IF CC JUMP 0xffa00290
ffa00296: POP (R7:4,P5:3) = [SP++]
ffa00298: LOAD P0 = [FP + 0x4]
ffa0029a: UNLINK
ffa0029e: JUMP (P0)
ffa002a0: LOAD P0.H = 0xffc0
ffa002a4: LOAD P0.L = 0x0
ffa002a8: CLI R1
ffa002aa: NOP
ffa002ac: NOP
ffa002ae: STORE W [P0] = R0
ffa002b0: CSYNC
ffa002b2: IDLE
ffa002b4: STI R1
ffa002b6: RTS
ffa002e8: LINK 0x0
ffa002ec: PUSH [--SP] = (R7:4,P5:5)
ffa002ee: MOVE R5 = R0
ffa002f0: BITCLR (R5,0x1f)
ffa002f2: LOAD R1 = 0x0
ffa002f4: LOAD R1.H = 0x3f80
ffa002f8: CC = R5 <= R1
ffa002fa: MOVE R6 = R0
ffa002fc: ADD SP += -0x10
ffa002fe: IF !CC JUMP 0xffa0049e
ffa00300: LOAD R1 = 0x4f3
ffa00304: MOVE R0 = R1
ffa00306: LOAD R0.H = 0x39b5
ffa0030a: CC = R0 <= R5
ffa0030c: IF !CC JUMP 0xffa00498
ffa0030e: MOVE R0 = R5
ffa00310: CALL 0xffa028c8
ffa00314: LOAD R1 = 0x0
ffa00316: BITSET (R1,0x1e)
ffa00318: CC = R1 < R0
ffa0031a: IF !CC JUMP 0xffa00470
ffa0031c: SUB R0 = R1 - R0 (s)
ffa00320: ADD R0 = R0 + R1 (s)
ffa00324: ASH R7 = R0 >>> 0x1
ffa00328: MOVE R0 = R7
ffa0032a: CALL 0xffa0236c
ffa0032e: NEG R0 = -R0 (s)
ffa00332: ASH R0 = R0 << 0x1 (s)
ffa00336: CALL 0xffa02894
ffa0033a: MOVE R5 = R0
ffa0033c: LOAD P5 = 0x0
ffa0033e: LOAD P1.L = 0x3418
ffa00342: LOAD P1.H = 0xff80
ffa00346: LOAD R1 = [P1]
ffa00348: MAC|| A1 = R1.L * R7.L (fu)
ffa0034c: LOAD R3 = [P1 + 0x4]
ffa0034e: NOP
ffa00350: LOAD R2 = 0x80
ffa00354: MAC|| A1 += R2.L * R2.L 
ffa00358: LOAD R0 = [P1 + 0x8]
ffa0035a: NOP
ffa0035c: LSH|| A1 = A1 >> 0x10
ffa00360: LOAD R4 = [P1 + 0xc]
ffa00362: NOP
ffa00364: MAC|| A1 += R1.H * R7.L (m),A0 = R1.H * R7.H 
ffa00368: STORE [SP + 0x30] = R4
ffa0036a: NOP
ffa0036c: MAC|| A1 += R7.H * R1.L (m)
ffa00370: LOAD R4 = [P1 + 0x10]
ffa00372: NOP
ffa00374: MAC|| A1 += R2.L * R2.L (fu)
ffa00378: STORE [SP + 0x2c] = R4
ffa0037a: NOP
ffa0037c: ASH A1 = A1 >>> 0xf
ffa00380: MOVE R1 = (A0 += A1)
ffa00384: ADD R1 = R1 + R3 (s)
ffa00388: MAC A1 = R1.L * R7.L (fu)
ffa0038c: MAC A1 += R2.L * R2.L 
ffa00390: LSH A1 = A1 >> 0x10
ffa00394: MAC A1 += R1.H * R7.L (m),A0 = R1.H * R7.H 
ffa00398: MAC|| A1 += R7.H * R1.L (m)
ffa0039c: LOAD R1 = [SP + 0x30]
ffa0039e: NOP
ffa003a0: MAC A1 += R2.L * R2.L (fu)
ffa003a4: ASH A1 = A1 >>> 0xf
ffa003a8: MOVE R3 = (A0 += A1)
ffa003ac: MAC A1 = R0.L * R7.L (fu)
ffa003b0: MAC A1 += R2.L * R2.L 
ffa003b4: LSH A1 = A1 >> 0x10
ffa003b8: MAC A1 += R0.H * R7.L (m),A0 = R0.H * R7.H 
ffa003bc: MAC A1 += R7.H * R0.L (m)
ffa003c0: MAC A1 += R2.L * R2.L (fu)
ffa003c4: ASH A1 = A1 >>> 0xf
ffa003c8: MOVE R0 = (A0 += A1)
ffa003cc: ADD R0 = R0 + R1 (s)
ffa003d0: ASH R4 = R3 >>> 0x1f
ffa003d4: MAC A1 = R0.L * R7.L (fu)
ffa003d8: MAC A1 += R2.L * R2.L 
ffa003dc: LSH A1 = A1 >> 0x10
ffa003e0: MAC A1 += R0.H * R7.L (m),A0 = R0.H * R7.H 
ffa003e4: MAC A1 += R7.H * R0.L (m)
ffa003e8: MAC A1 += R2.L * R2.L (fu)
ffa003ec: ASH A1 = A1 >>> 0xf
ffa003f0: CC = BITTST (R4,0x0)
ffa003f2: MOVE|| R2 = (A0 += A1)
ffa003f6: LOAD R4 = [SP + 0x2c]
ffa003f8: NOP
ffa003fa: ADD R2 = R2 + R4 (s)
ffa003fe: ASH R7 = R2 >>> 0x1f
ffa00402: LSH|| R0 = R3 << 0x1f
ffa00406: _STORE [SP + 0xc] = R7
ffa00408: _NOP
ffa0040a: ROT R1 = rot R3 by -0x1
ffa0040e: CALL 0xffa01258
ffa00412: CALL 0xffa02894
ffa00416: MOVE R1 = R5
ffa00418: CALL 0xffa018f0
ffa0041c: MOVE R1 = R5
ffa0041e: CALL 0xffa01716
ffa00422: CC = R6 < 0x0
ffa00424: LOAD P1.L = 0x342c
ffa00428: LOAD P1.H = 0xff80
ffa0042c: IF !CC JUMP 0xffa0044e
ffa0042e: NOP
ffa00430: ADD P5 += 0x2
ffa00432: ADD P1 = P1 + (P5 << 2)
ffa00434: LOAD R7 = [P1]
ffa00436: MOVE R1 = R7
ffa00438: CALL 0xffa01716
ffa0043c: MOVE R1 = R7
ffa0043e: CALL 0xffa01716
ffa00442: ADD SP += 0x10
ffa00444: LOAD P0 = [FP + 0x4]
ffa00446: POP (R7:4,P5:5) = [SP++]
ffa00448: UNLINK
ffa0044c: JUMP (P0)
ffa0044e: ADD P1 = P1 + (P5 << 2)
ffa00450: ROT|| R1 = rot R0 by 0
ffa00454: _LOAD R7 = [P1]
ffa00456: _NOP
ffa00458: MOVE R0 = R7
ffa0045a: CALL 0xffa01714
ffa0045e: MOVE R1 = R7
ffa00460: CALL 0xffa01716
ffa00464: ADD SP += 0x10
ffa00466: LOAD P0 = [FP + 0x4]
ffa00468: POP (R7:4,P5:5) = [SP++]
ffa0046a: UNLINK
ffa0046e: JUMP (P0)
ffa00470: MAC A1 = R0.L * R0.L (fu)
ffa00474: LOAD R1 = 0x80
ffa00478: MAC A1 += R1.L * R1.L 
ffa0047c: LSH A1 = A1 >> 0x10
ffa00480: MAC A1 += R0.H * R0.L (m),A0 = R0.H * R0.H 
ffa00484: MAC A1 += R0.H * R0.L (m)
ffa00488: MAC A1 += R1.L * R1.L (fu)
ffa0048c: ASH A1 = A1 >>> 0xf
ffa00490: LOAD P5 = 0x1
ffa00492: MOVE R7 = (A0 += A1)
ffa00496: JUMP.S 0xffa0033e
ffa00498: MOVE R0 = R5
ffa0049a: LOAD P5 = 0x1
ffa0049c: JUMP.S 0xffa00422
ffa0049e: ADD SP += 0x10
ffa004a0: LOAD P0 = [FP + 0x4]
ffa004a2: POP (R7:4,P5:5) = [SP++]
ffa004a4: UNLINK
ffa004a8: LOAD R0 = 0x0
ffa004aa: JUMP (P0)
ffa004ac: MOVE R2 = R0
ffa004ae: MOVE R0 = R1
ffa004b0: LINK 0xc
ffa004b4: MOVE R1 = R2
ffa004b6: CALL 0xffa0069c
ffa004ba: UNLINK
ffa004be: RTS
ffa004c0: CC = R2 < 0x0
ffa004c2: IF CC JUMP 0xffa004da
ffa004c4: LOAD R3 = 0x40
ffa004c8: MIN R3 = min(R2,R3)
ffa004cc: ADD R3 += -0x20
ffa004ce: LSH R3 = lshift R0 by R3.L
ffa004d2: LSHIFT R0 <<= R2
ffa004d4: LSHIFT R1 <<= R2
ffa004d6: OR R1 = R1 | R3
ffa004d8: RTS
ffa004da: LOAD R3 = -0x40
ffa004dc: MAX R3 = max(R2,R3)
ffa004e0: ADD R3 += 0x20
ffa004e2: ASH R3 = ashift R1 by R3.L
ffa004e6: NEG R2 = -R2
ffa004e8: ASHIFT R1 >>>= R2
ffa004ea: LSHIFT R0 >>= R2
ffa004ec: OR R0 = R0 | R3
ffa004ee: RTS
ffa004f0: LINK 0x0
ffa004f4: PUSH [--SP] = (R7:4)
ffa004f6: MOVE R6 = R0
ffa004f8: BITCLR (R6,0x1f)
ffa004fa: LOAD R1 = 0x0
ffa004fc: LOAD R1.H = 0x3f80
ffa00500: CC = R6 <= R1
ffa00502: MOVE R5 = R0
ffa00504: ADD SP += -0x10
ffa00506: IF !CC JUMP 0xffa0068c
ffa00508: LOAD R2 = 0x4f3
ffa0050c: MOVE R1 = R2
ffa0050e: LOAD R1.H = 0x39b5
ffa00512: CC = R1 <= R6
ffa00514: IF !CC JUMP 0xffa00658
ffa00516: MOVE R0 = R6
ffa00518: CALL 0xffa028c8
ffa0051c: LOAD R2 = 0x0
ffa0051e: BITSET (R2,0x1e)
ffa00520: CC = R2 < R0
ffa00522: IF !CC JUMP 0xffa00664
ffa00524: SUB R0 = R2 - R0 (s)
ffa00528: ADD R0 = R0 + R2 (s)
ffa0052c: ASH R4 = R0 >>> 0x1
ffa00530: MOVE R0 = R4
ffa00532: CALL 0xffa0236c
ffa00536: NEG R0 = -R0 (s)
ffa0053a: ASH R0 = R0 << 0x1 (s)
ffa0053e: CALL 0xffa02894
ffa00542: LOAD R1 = 0xfdb
ffa00546: MOVE R6 = R0
ffa00548: MOVE R7 = R1
ffa0054a: LOAD R7.H = 0x3fc9
ffa0054e: LOAD P1.L = 0x343c
ffa00552: LOAD P1.H = 0xff80
ffa00556: LOAD R1 = [P1]
ffa00558: MAC|| A1 = R1.L * R4.L (fu)
ffa0055c: LOAD R3 = [P1 + 0x4]
ffa0055e: NOP
ffa00560: LOAD R2 = 0x80
ffa00564: MAC|| A1 += R2.L * R2.L 
ffa00568: STORE [SP + 0x30] = R3
ffa0056a: NOP
ffa0056c: LSH|| A1 = A1 >> 0x10
ffa00570: LOAD R3 = [P1 + 0xc]
ffa00572: NOP
ffa00574: MAC|| A1 += R1.H * R4.L (m),A0 = R1.H * R4.H 
ffa00578: STORE [SP + 0x2c] = R3
ffa0057a: NOP
ffa0057c: MAC|| A1 += R4.H * R1.L (m)
ffa00580: LOAD R3 = [P1 + 0x10]
ffa00582: NOP
ffa00584: MAC|| A1 += R2.L * R2.L (fu)
ffa00588: STORE [SP + 0x28] = R3
ffa0058a: NOP
ffa0058c: ASH|| A1 = A1 >>> 0xf
ffa00590: LOAD R3 = [SP + 0x30]
ffa00592: NOP
ffa00594: MOVE|| R1 = (A0 += A1)
ffa00598: LOAD R0 = [P1 + 0x8]
ffa0059a: NOP
ffa0059c: ADD R1 = R1 + R3 (s)
ffa005a0: MAC A1 = R1.L * R4.L (fu)
ffa005a4: MAC A1 += R2.L * R2.L 
ffa005a8: LSH A1 = A1 >> 0x10
ffa005ac: MAC A1 += R1.H * R4.L (m),A0 = R1.H * R4.H 
ffa005b0: MAC|| A1 += R4.H * R1.L (m)
ffa005b4: LOAD R1 = [SP + 0x2c]
ffa005b6: NOP
ffa005b8: MAC A1 += R2.L * R2.L (fu)
ffa005bc: ASH A1 = A1 >>> 0xf
ffa005c0: MOVE R3 = (A0 += A1)
ffa005c4: MAC A1 = R0.L * R4.L (fu)
ffa005c8: MAC A1 += R2.L * R2.L 
ffa005cc: LSH A1 = A1 >> 0x10
ffa005d0: MAC A1 += R0.H * R4.L (m),A0 = R0.H * R4.H 
ffa005d4: MAC A1 += R4.H * R0.L (m)
ffa005d8: MAC A1 += R2.L * R2.L (fu)
ffa005dc: ASH A1 = A1 >>> 0xf
ffa005e0: MOVE R0 = (A0 += A1)
ffa005e4: ADD R0 = R0 + R1 (s)
ffa005e8: ASH R1 = R3 >>> 0x1f
ffa005ec: MAC A1 = R0.L * R4.L (fu)
ffa005f0: MAC A1 += R2.L * R2.L 
ffa005f4: LSH A1 = A1 >> 0x10
ffa005f8: MAC A1 += R0.H * R4.L (m),A0 = R0.H * R4.H 
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
ffa0067c: MAC A1 += R1.L * R1.L (fu)
ffa00680: ASH A1 = A1 >>> 0xf
ffa00684: LOAD R7 = 0x0
ffa00686: MOVE R4 = (A0 += A1)
ffa0068a: JUMP.S 0xffa0054e
ffa0068c: ADD SP += 0x10
ffa0068e: LOAD P0 = [FP + 0x4]
ffa00690: POP (R7:4) = [SP++]
ffa00692: UNLINK
ffa00696: LOAD R0 = 0x0
ffa00698: JUMP (P0)
ffa0069c: LINK 0x4
ffa006a0: PUSH [--SP] = (R7:4,P5:5)
ffa006a2: MOVE R5 = R0
ffa006a4: BITCLR (R5,0x1f)
ffa006a6: ADD SP += -0x10
ffa006a8: ROT|| R6 = rot R1 by 0
ffa006ac: _STORE [SP + 0x34] = R0
ffa006ae: _NOP
ffa006b0: CC = R5 == 0x0
ffa006b2: ROT|| R1 = rot R5 by 0
ffa006b6: _STORE [SP + 0x30] = R1
ffa006b8: _NOP
ffa006ba: BITCLR (R6,0x1f)
ffa006bc: LOAD R0 = 0x0
ffa006be: IF CC JUMP 0xffa0087e
ffa006c0: CC = R6 == 0x0
ffa006c2: LOAD R0 = 0xfdb
ffa006c6: LOAD R0.H = 0x3fc9
ffa006ca: IF CC JUMP 0xffa0087e
ffa006cc: CC = R6 == R5
ffa006ce: LOAD R0 = 0xfdb
ffa006d2: LOAD R0.H = 0x3f49
ffa006d6: IF CC JUMP 0xffa0087e
ffa006d8: CC = R6 < R5
ffa006da: IF !CC JUMP 0xffa006e6
ffa006dc: MOVE R0 = R6
ffa006de: CALL 0xffa01814
ffa006e2: LOAD P5 = 0x2
ffa006e4: JUMP.S 0xffa006f0
ffa006e6: MOVE R1 = R6
ffa006e8: MOVE R0 = R5
ffa006ea: CALL 0xffa01814
ffa006ee: LOAD P5 = 0x0
ffa006f0: MOVE R4 = R0
ffa006f2: CALL 0xffa028c8
ffa006f6: LOAD R1 = 0x28bd
ffa006fa: LOAD R1.H = 0x224c
ffa006fe: CC = R1 < R0
ffa00700: MOVE R7 = R0
ffa00702: IF !CC JUMP 0xffa00772
ffa00704: ASH R1 = R0 >>> 0x1
ffa00708: LOAD R0 = -0x145f
ffa0070c: MAC A1 = R0.L * R1.L (fu)
ffa00710: LOAD R4.H = 0x80
ffa00714: MAC A1 += R4.H * R4.H 
ffa00718: LSH A1 = A1 >> 0x10
ffa0071c: LOAD R4.L = 0x6ed9
ffa00720: MAC A1 += R4.L * R1.L (m),A0 = R4.L * R1.H 
ffa00724: MAC A1 += R1.H * R0.L (m)
ffa00728: MAC A1 += R4.H * R4.H (fu)
ffa0072c: ASH A1 = A1 >>> 0xf
ffa00730: LOAD R3 = -0x1
ffa00732: LSHIFT R3 <<= 0x1d
ffa00734: LOAD R7 = -0xa2f
ffa00738: MOVE R0 = (A0 += A1)
ffa0073c: ADD R3 = R0 + R3 (s)
ffa00740: ASH R4 = R1 >>> 0x1
ffa00744: MOVE R2 = R7
ffa00746: LOAD R2.H = 0x376c
ffa0074a: ADD R2 = R4 + R2 (s)
ffa0074e: ASH R1 = R3 >>> 0x1f
ffa00752: CC = BITTST (R1,0x0)
ffa00754: ASH R7 = R2 >>> 0x1f
ffa00758: LSH|| R0 = R3 << 0x1f
ffa0075c: _STORE [SP + 0xc] = R7
ffa0075e: _NOP
ffa00760: ROT R1 = rot R3 by -0x1
ffa00764: CALL 0xffa01150
ffa00768: MOVE R7 = R0
ffa0076a: CALL 0xffa02894
ffa0076e: ADD P5 += 0x1
ffa00770: MOVE R4 = R0
ffa00772: ABS R1 = abs R7
ffa00776: LOAD R2 = 0xb505
ffa0077a: CC = R2 <= R1
ffa0077c: MOVE R0 = R4
ffa0077e: IF !CC JUMP 0xffa00860
ffa00780: MAC A1 = R7.L * R7.L (fu)
ffa00784: LOAD R2 = 0x80
ffa00788: MAC A1 += R2.L * R2.L 
ffa0078c: LSH A1 = A1 >> 0x10
ffa00790: MAC A1 += R7.H * R7.L (m),A0 = R7.H * R7.H 
ffa00794: MAC A1 += R7.H * R7.L (m)
ffa00798: MAC A1 += R2.L * R2.L (fu)
ffa0079c: ASH A1 = A1 >>> 0xf
ffa007a0: LOAD P1.L = 0x345c
ffa007a4: LOAD P1.H = 0xff80
ffa007a8: MOVE|| R1 = (A0 += A1)
ffa007ac: LOAD R3 = [P1]
ffa007ae: NOP
ffa007b0: MAC|| A1 = R3.L * R1.L (fu)
ffa007b4: LOAD R7 = [P1 + 0x4]
ffa007b6: NOP
ffa007b8: MAC|| A1 += R2.L * R2.L 
ffa007bc: STORE [SP + 0x24] = R7
ffa007be: NOP
ffa007c0: LSH|| A1 = A1 >> 0x10
ffa007c4: LOAD R7 = [P1 + 0xc]
ffa007c6: NOP
ffa007c8: MAC|| A1 += R3.H * R1.L (m),A0 = R3.H * R1.H 
ffa007cc: STORE [SP + 0x38] = R7
ffa007ce: NOP
ffa007d0: MAC|| A1 += R1.H * R3.L (m)
ffa007d4: LOAD R0 = [P1 + 0x8]
ffa007d6: NOP
ffa007d8: MAC|| A1 += R2.L * R2.L (fu)
ffa007dc: LOAD R7 = [SP + 0x24]
ffa007de: NOP
ffa007e0: ASH A1 = A1 >>> 0xf
ffa007e4: MOVE R3 = (A0 += A1)
ffa007e8: ADD R3 = R3 + R7 (s)
ffa007ec: MAC A1 = R3.L * R1.L (fu)
ffa007f0: MAC A1 += R2.L * R2.L 
ffa007f4: LSH A1 = A1 >> 0x10
ffa007f8: MAC A1 += R3.H * R1.L (m),A0 = R3.H * R1.H 
ffa007fc: MAC A1 += R1.H * R3.L (m)
ffa00800: MAC A1 += R2.L * R2.L (fu)
ffa00804: ASH A1 = A1 >>> 0xf
ffa00808: MOVE R3 = (A0 += A1)
ffa0080c: MAC A1 = R0.L * R1.L (fu)
ffa00810: MAC A1 += R2.L * R2.L 
ffa00814: LSH A1 = A1 >> 0x10
ffa00818: MAC A1 += R0.H * R1.L (m),A0 = R0.H * R1.H 
ffa0081c: MAC|| A1 += R1.H * R0.L (m)
ffa00820: LOAD R0 = [SP + 0x38]
ffa00822: NOP
ffa00824: MAC A1 += R2.L * R2.L (fu)
ffa00828: ASH A1 = A1 >>> 0xf
ffa0082c: MOVE R2 = (A0 += A1)
ffa00830: ADD R2 = R2 + R0 (s)
ffa00834: ASH R7 = R3 >>> 0x1f
ffa00838: ASH R0 = R2 >>> 0x1f
ffa0083c: LSH|| R1 = R3 >> 0x2
ffa00840: _STORE [SP + 0xc] = R0
ffa00842: _NOP
ffa00844: LSHIFT R7 <<= 0x1e
ffa00846: OR R1 = R7 | R1
ffa00848: LSH R0 = R3 << 0x1e
ffa0084c: CALL 0xffa01150
ffa00850: CALL 0xffa02894
ffa00854: MOVE R1 = R4
ffa00856: CALL 0xffa018f0
ffa0085a: MOVE R1 = R4
ffa0085c: CALL 0xffa01716
ffa00860: CC = P5 <= 0x0
ffa00862: IF CC JUMP 0xffa0087e
ffa00864: CC = P5 <= 0x1
ffa00866: MOVE R1 = R0
ffa00868: ADD P5 += -0x1
ffa0086a: LOAD P1.L = 0x3450
ffa0086e: LOAD P1.H = 0xff80
ffa00872: BITTGL (R1,0x1f)
ffa00874: ADD P1 = P1 + (P5 << 2)
ffa00876: IF !CC R0 = R1
ffa00878: LOAD R1 = [P1]
ffa0087a: CALL 0xffa01716
ffa0087e: LOAD R1 = [SP + 0x30]
ffa00880: CC = R1 < 0x0
ffa00882: IF !CC JUMP 0xffa00896
ffa00884: CC = R6 == 0x0
ffa00886: IF CC JUMP 0xffa00896
ffa00888: MOVE R1 = R0
ffa0088a: LOAD R0 = 0xfdb
ffa0088e: LOAD R0.H = 0x4049
ffa00892: CALL 0xffa01714
ffa00896: LOAD R1 = [SP + 0x34]
ffa00898: CC = R1 < 0x0
ffa0089a: IF !CC JUMP 0xffa008a4
ffa0089c: CC = R5 == 0x0
ffa0089e: MOVE R1 = R0
ffa008a0: BITTGL (R1,0x1f)
ffa008a2: IF !CC R0 = R1
ffa008a4: ADD SP += 0x10
ffa008a6: LOAD P0 = [FP + 0x4]
ffa008a8: POP (R7:4,P5:5) = [SP++]
ffa008aa: UNLINK
ffa008ae: JUMP (P0)
ffa008b0: LINK 0x0
ffa008b4: PUSH [--SP] = (R7:4,P5:5)
ffa008b6: MOVE R6 = R0
ffa008b8: LOAD R2 = 0x0
ffa008ba: BITCLR (R0,0x1f)
ffa008bc: LOAD R2.H = 0x3f80
ffa008c0: CC = R2 < R0
ffa008c2: ADD SP += -0x10
ffa008c4: IF CC JUMP 0xffa008cc
ffa008c6: MOVE R7 = R0
ffa008c8: LOAD P5 = 0x0
ffa008ca: JUMP.S 0xffa008d8
ffa008cc: MOVE R1 = R0
ffa008ce: MOVE R0 = R2
ffa008d0: CALL 0xffa01814
ffa008d4: MOVE R7 = R0
ffa008d6: LOAD P5 = 0x2
ffa008d8: MOVE R0 = R7
ffa008da: CALL 0xffa028c8
ffa008de: LOAD R1 = 0x28bd
ffa008e2: MOVE R4 = R0
ffa008e4: MOVE R0 = R1
ffa008e6: LOAD R0.H = 0x224c
ffa008ea: CC = R0 < R4
ffa008ec: IF !CC JUMP 0xffa0095c
ffa008ee: ASH R1 = R4 >>> 0x1
ffa008f2: LOAD R0 = -0x145f
ffa008f6: MAC A1 = R0.L * R1.L (fu)
ffa008fa: LOAD R5.H = 0x80
ffa008fe: MAC A1 += R5.H * R5.H 
ffa00902: LSH A1 = A1 >> 0x10
ffa00906: LOAD R7.H = 0x6ed9
ffa0090a: MAC A1 += R7.H * R1.L (m),A0 = R7.H * R1.H 
ffa0090e: MAC A1 += R1.H * R0.L (m)
ffa00912: MAC A1 += R5.H * R5.H (fu)
ffa00916: ASH A1 = A1 >>> 0xf
ffa0091a: LOAD R3 = -0x1
ffa0091c: LSHIFT R3 <<= 0x1d
ffa0091e: LOAD R7 = -0xa2f
ffa00922: MOVE R0 = (A0 += A1)
ffa00926: ADD R3 = R0 + R3 (s)
ffa0092a: ASH R4 = R1 >>> 0x1
ffa0092e: MOVE R2 = R7
ffa00930: LOAD R2.H = 0x376c
ffa00934: ADD R2 = R4 + R2 (s)
ffa00938: ASH R1 = R3 >>> 0x1f
ffa0093c: CC = BITTST (R1,0x0)
ffa0093e: ASH R7 = R2 >>> 0x1f
ffa00942: LSH|| R0 = R3 << 0x1f
ffa00946: _STORE [SP + 0xc] = R7
ffa00948: _NOP
ffa0094a: ROT R1 = rot R3 by -0x1
ffa0094e: CALL 0xffa01150
ffa00952: MOVE R4 = R0
ffa00954: CALL 0xffa02894
ffa00958: ADD P5 += 0x1
ffa0095a: MOVE R7 = R0
ffa0095c: ABS R0 = abs R4
ffa00960: LOAD R1 = 0xb505
ffa00964: CC = R1 <= R0
ffa00966: IF !CC JUMP 0xffa00a3a
ffa00968: MAC A1 = R4.L * R4.L (fu)
ffa0096c: LOAD R5.H = 0x80
ffa00970: MAC A1 += R5.H * R5.H 
ffa00974: LSH A1 = A1 >> 0x10
ffa00978: MAC A1 += R4.H * R4.L (m),A0 = R4.H * R4.H 
ffa0097c: MAC A1 += R4.H * R4.L (m)
ffa00980: MAC A1 += R5.H * R5.H (fu)
ffa00984: ASH A1 = A1 >>> 0xf
ffa00988: LOAD P1.L = 0x3478
ffa0098c: LOAD P1.H = 0xff80
ffa00990: MOVE|| R1 = (A0 += A1)
ffa00994: LOAD R3 = [P1]
ffa00996: NOP
ffa00998: MAC|| A1 = R3.L * R1.L (fu)
ffa0099c: LOAD R4 = [P1 + 0x4]
ffa0099e: NOP
ffa009a0: MAC|| A1 += R5.H * R5.H 
ffa009a4: LOAD R0 = [P1 + 0x8]
ffa009a6: NOP
ffa009a8: LSH|| A1 = A1 >> 0x10
ffa009ac: LOAD R2 = [P1 + 0xc]
ffa009ae: NOP
ffa009b0: MAC A1 += R3.H * R1.L (m),A0 = R3.H * R1.H 
ffa009b4: MAC A1 += R1.H * R3.L (m)
ffa009b8: MAC A1 += R5.H * R5.H (fu)
ffa009bc: ASH A1 = A1 >>> 0xf
ffa009c0: MOVE R3 = (A0 += A1)
ffa009c4: ADD R3 = R3 + R4 (s)
ffa009c8: MAC A1 = R3.L * R1.L (fu)
ffa009cc: MAC A1 += R5.H * R5.H 
ffa009d0: LSH A1 = A1 >> 0x10
ffa009d4: MAC A1 += R3.H * R1.L (m),A0 = R3.H * R1.H 
ffa009d8: MAC A1 += R1.H * R3.L (m)
ffa009dc: MAC A1 += R5.H * R5.H (fu)
ffa009e0: ASH A1 = A1 >>> 0xf
ffa009e4: MOVE R3 = (A0 += A1)
ffa009e8: MAC A1 = R0.L * R1.L (fu)
ffa009ec: MAC A1 += R5.H * R5.H 
ffa009f0: LSH A1 = A1 >> 0x10
ffa009f4: MAC A1 += R0.H * R1.L (m),A0 = R0.H * R1.H 
ffa009f8: MAC A1 += R1.H * R0.L (m)
ffa009fc: MAC A1 += R5.H * R5.H (fu)
ffa00a00: ASH A1 = A1 >>> 0xf
ffa00a04: MOVE R0 = (A0 += A1)
ffa00a08: ADD R2 = R0 + R2 (s)
ffa00a0c: ASH R0 = R3 >>> 0x1f
ffa00a10: LSHIFT R0 <<= 0x1e
ffa00a12: ASH R1 = R2 >>> 0x1f
ffa00a16: LSH|| R1 = R3 >> 0x2
ffa00a1a: _STORE [SP + 0xc] = R1
ffa00a1c: _NOP
ffa00a1e: OR R1 = R0 | R1
ffa00a20: LSH R0 = R3 << 0x1e
ffa00a24: CALL 0xffa01150
ffa00a28: CALL 0xffa02894
ffa00a2c: MOVE R1 = R7
ffa00a2e: CALL 0xffa018f0
ffa00a32: MOVE R1 = R7
ffa00a34: CALL 0xffa01716
ffa00a38: MOVE R7 = R0
ffa00a3a: CC = P5 <= 0x0
ffa00a3c: IF CC JUMP 0xffa00a60
ffa00a3e: CC = P5 <= 0x1
ffa00a40: ADD P5 += -0x1
ffa00a42: MOVE R0 = R7
ffa00a44: BITTGL (R0,0x1f)
ffa00a46: IF !CC R7 = R0
ffa00a48: LOAD P1.L = 0x346c
ffa00a4c: LOAD P1.H = 0xff80
ffa00a50: ADD P1 = P1 + (P5 << 2)
ffa00a52: ROT|| R0 = rot R7 by 0
ffa00a56: _LOAD R1 = [P1]
ffa00a58: _NOP
ffa00a5a: CALL 0xffa01716
ffa00a5e: MOVE R7 = R0
ffa00a60: ADD SP += 0x10
ffa00a62: ROT|| R0 = rot R7 by 0
ffa00a66: _LOAD P0 = [FP + 0x4]
ffa00a68: _NOP
ffa00a6a: CC = R6 < 0x0
ffa00a6c: BITTGL (R7,0x1f)
ffa00a6e: IF CC R0 = R7
ffa00a70: POP (R7:4,P5:5) = [SP++]
ffa00a72: UNLINK
ffa00a76: JUMP (P0)
ffa00a78: ABS R0 = abs R0 (v)
ffa00a7c: MOVE R1 = R0.L (Z)
ffa00a7e: LSH R2 = R0 >> 0x10
ffa00a82: CC = R1 == 0x0
ffa00a84: IF CC JUMP 0xffa00ac8
ffa00a86: CC = R2 == 0x0
ffa00a88: IF CC JUMP 0xffa00acc
ffa00a8a: CC = R1 == R2
ffa00a8c: IF CC JUMP 0xffa00ad0
ffa00a8e: PUSH [--SP] = R7
ffa00a90: CC = R1 < R2
ffa00a92: IF !CC JUMP 0xffa00a9a
ffa00a94: MOVE R0 = R1
ffa00a96: MOVE R1 = R2
ffa00a98: JUMP.S 0xffa00a9c
ffa00a9a: MOVE R0 = R2
ffa00a9c: MOVE R7 = R1
ffa00a9e: PUSH [--SP] = RETS
ffa00aa0: CALL 0xffa00f94
ffa00aa4: MULT R2 = R0.L * R0.L 
ffa00aa8: LSHIFT R2 >>= 0x12
ffa00aaa: LOAD R3 = 0x2000
ffa00aae: ADD R0 = R3 + R2
ffa00ab0: CALL 0xffa022ec
ffa00ab4: POP RETS = [SP++]
ffa00ab6: MULT R0 = R7.L * R0.L 
ffa00aba: LSHIFT R0 >>= 0xf
ffa00abc: LOAD R3 = 0x7fff
ffa00ac0: CC = BITTST (R0,0xf)
ffa00ac2: IF CC R0 = R3
ffa00ac4: LOAD R7 = [SP++]
ffa00ac6: RTS
ffa00ac8: MOVE R0 = R2
ffa00aca: RTS
ffa00acc: MOVE R0 = R1
ffa00ace: RTS
ffa00ad0: LOAD R2 = 0x5a82
ffa00ad4: LOAD R0 = 0x7fff
ffa00ad8: CC = R2 <= R1
ffa00ada: IF CC JUMP 0xffa00ae2
ffa00adc: MULT R0.L = R2.L * R1.L 
ffa00ae0: LSHIFT R0 <<= 0x1
ffa00ae2: RTS
ffa00ae4: LINK 0x0
ffa00ae8: MOVE R2 = R0
ffa00aea: MOVE R3 = R1
ffa00aec: PUSH [--SP] = (R7:4)
ffa00aee: MOVE R7 = R2
ffa00af0: BITCLR (R3,0x1f)
ffa00af2: BITCLR (R7,0x1f)
ffa00af4: CC = R3 == 0x0
ffa00af6: ADD SP += -0xc
ffa00af8: MOVE R0 = R7
ffa00afa: IF CC JUMP 0xffa00b7a
ffa00afc: CC = R7 == 0x0
ffa00afe: MOVE R0 = R3
ffa00b00: IF CC JUMP 0xffa00b7a
