===== ffa10000
ffa10000: LINK 0x0
ffa10004: PUSH [--SP] = (R7:7,P5:4)
ffa10006: MOVE P5 = R0
ffa10008: LOAD R1 = 0x5
ffa1000a: ADD SP += -0xc
ffa1000c: BITSET (R1,0x1e)
ffa1000e: LOAD R2 = 0x0
ffa10010: CALL 0xffa10684
ffa10014: CC = R0 == 0x0
ffa10016: LOAD R7 = 0x0
ffa10018: IF !CC JUMP 0xffa10092
ffa1001a: NOP
ffa1001c: NOP
ffa1001e: NOP
ffa10020: LOAD R1 = [P5 + 0x18]
ffa10022: CC = R1 == 0x1
ffa10024: IF !CC JUMP 0xffa1008e
ffa10026: NOP
ffa10028: LOAD P1 = 0x5c
ffa1002c: ADD P1 = P5 + P1
ffa1002e: SUB|| R1 = R1 - R1 (ns)
ffa10032: _LOAD P4 = [P1]
ffa10034: _NOP
ffa10036: LOAD R0 = [P1]
ffa10038: CC = R0 == 0x0
ffa1003a: IF CC JUMP 0xffa100d0
ffa1003c: NOP
ffa1003e: NOP
ffa10040: NOP
ffa10042: LOAD R0 = [P4 + 0x4]
ffa10044: CC = R0 == 0x0
ffa10046: IF CC JUMP 0xffa10052
ffa10048: CALL 0xffa079ac
ffa1004c: CC = R0 == 0x0
ffa1004e: IF !CC JUMP 0xffa10058
ffa10050: STORE [P4 + 0x4] = R7
ffa10052: MOVE P1 = P4
ffa10054: ADD P1 += 0x14
ffa10056: JUMP.S 0xffa1002e
ffa10058: CC = R0 == 0x0
ffa1005a: IF !CC JUMP 0xffa1008e
ffa1005c: NOP
ffa1005e: LOAD P1 = 0x58
ffa10062: ADD P1 = P5 + P1
ffa10064: SUB|| R1 = R1 - R1 (ns)
ffa10068: _LOAD P4 = [P1]
ffa1006a: _NOP
ffa1006c: LOAD R0 = [P1]
ffa1006e: CC = R0 == 0x0
ffa10070: IF CC JUMP 0xffa100cc
ffa10072: NOP
ffa10074: NOP
ffa10076: NOP
ffa10078: LOAD R0 = [P4 + 0x4]
ffa1007a: CC = R0 == 0x0
ffa1007c: IF CC JUMP 0xffa10088
ffa1007e: CALL 0xffa079ac
ffa10082: CC = R0 == 0x0
ffa10084: IF !CC JUMP 0xffa1008e
ffa10086: STORE [P4 + 0x4] = R7
ffa10088: MOVE P1 = P4
ffa1008a: ADD P1 += 0x14
ffa1008c: JUMP.S 0xffa10064
ffa1008e: CC = R0 == 0x0
ffa10090: IF CC JUMP 0xffa1009e
ffa10092: ADD SP += 0xc
ffa10094: LOAD P0 = [FP + 0x4]
ffa10096: POP (R7:7,P5:4) = [SP++]
ffa10098: UNLINK
ffa1009c: JUMP (P0)
ffa1009e: LOAD P1 = [P5]
ffa100a0: LOAD R0 = [P5 + 0x8]
ffa100a2: LOAD P1 = [P1 + 0x4]
ffa100a4: CALL (P1)
ffa100a6: CC = R0 == 0x0
ffa100a8: IF !CC JUMP 0xffa10092 (bp)
ffa100aa: LOAD P1 = [P5 + 0x4]
ffa100ac: LOAD R0 = [P1 + 0x4]
ffa100ae: CALL 0xffa08cea
ffa100b2: STORE B [P5 + 0x14] = R7
ffa100b6: CALL 0xffa08d0c
ffa100ba: ADD SP += 0xc
ffa100bc: SUB|| R0 = R0 - R0 (ns)
ffa100c0: _LOAD P0 = [FP + 0x4]
ffa100c2: _NOP
ffa100c4: POP (R7:7,P5:4) = [SP++]
ffa100c6: UNLINK
ffa100ca: JUMP (P0)
ffa100cc: LOAD R0 = 0x0
ffa100ce: JUMP.S 0xffa1008e
ffa100d0: LOAD R0 = 0x0
ffa100d2: JUMP.S 0xffa10058
ffa100d4: LINK 0x1c
ffa100d8: PUSH [--SP] = (R7:4,P5:3)
ffa100da: ADD SP += -0x1c
ffa100dc: LOAD R3 = 0x3
ffa100de: STORE W [SP + 0x3e] = R3
ffa100e2: LOAD R6 = 0x3
ffa100e4: LOAD R4 = 0x7
ffa100e6: LOAD R5 = 0x6
ffa100e8: STORE [FP + -0x8] = R2
ffa100ea: LOAD R7 = 0x3
ffa100ec: LOAD P0.L = 0x3bdc
ffa100f0: LOAD P0.H = 0xff80
ffa100f4: LOAD R3 = 0x4
ffa100f6: STORE W [SP + 0x46] = R6
ffa100fa: STORE W [SP + 0x44] = R4
ffa100fe: STORE W [SP + 0x3c] = R5
ffa10102: ROT|| R4 = rot R1 by 0
ffa10106: _STORE [FP + 0xc] = R0
ffa10108: _NOP
ffa1010a: SUB|| R6 = R6 - R6 (ns)
ffa1010e: _STORE [FP + -0x4] = R0
ffa10110: _NOP
ffa10112: STORE [FP + -0x14] = P0
ffa10114: STORE W [SP + 0x3a] = R7
ffa10118: STORE W [SP + 0x38] = R3
ffa1011c: LOAD P4 = 0x0
ffa1011e: LOAD P1 = [FP + -0x8]
ffa10120: LOAD R5 = 0x5
ffa10122: LOAD R0 = 0x9
ffa10124: CC = R1 < R0 (IU)
ffa10126: IF !CC JUMP 0xffa103e2
ffa10128: LOAD R0 = 0x8
ffa1012a: CC = R4 == R0
ffa1012c: STORE [FP + 0x10] = P1
ffa1012e: ROT|| R7 = rot R4 by 0
ffa10132: _LOAD P5 = [FP + -0x8]
ffa10134: _NOP
ffa10136: IF !CC JUMP 0xffa10146
ffa10138: NOP
ffa1013a: NOP
ffa1013c: NOP
ffa1013e: LOAD P5 = [P1 + 0x4]
ffa10140: LOAD R7 = [P1]
ffa10142: ADD P1 += 0x8
ffa10144: STORE [FP + 0x10] = P1
ffa10146: LOAD P1 = [FP + 0xc]
ffa10148: MOVE R1 = FP
ffa1014a: LOAD R0 = [P1 + 0x18]
ffa1014c: CC = R0 == 0x1
ffa1014e: IF !CC JUMP 0xffa102d6
ffa10150: CC = P4 == 0x0
ffa10152: IF CC JUMP 0xffa102c2
ffa10154: CC = R7 == R5
ffa10156: IF CC JUMP 0xffa1016c
ffa10158: NOP
ffa1015a: NOP
ffa1015c: NOP
ffa1015e: LOAD R0 = B [P4 + 0x8] (Z)
ffa10162: CC = R0 == 0x0
ffa10164: IF CC JUMP 0xffa101c8
ffa10166: LOAD R0 = 0x6
ffa10168: CC = R7 == R0
ffa1016a: IF CC JUMP 0xffa101c8
ffa1016c: LOAD R0 = B [P1 + 0x15] (Z)
ffa10170: CC = R0 == 0x0
ffa10172: IF CC JUMP 0xffa1018c
ffa10174: SUB|| R2 = R2 - R2 (ns)
ffa10178: _LOAD R0 = [P4 + 0x4]
ffa1017a: _NOP
ffa1017c: LOAD R1 = [SP + 0x3c]
ffa1017e: CALL 0xffa07cd0
ffa10182: CC = R0 == 0x0
ffa10184: IF !CC JUMP 0xffa102b6
ffa10186: NOP
ffa10188: NOP
ffa1018a: NOP
ffa1018c: SUB|| R2 = R2 - R2 (ns)
ffa10190: _LOAD R0 = [P4 + 0x4]
ffa10192: _NOP
ffa10194: LOAD R1 = [FP + -0x10]
ffa10196: CALL 0xffa07cd0
ffa1019a: CC = R0 == 0x0
ffa1019c: IF !CC JUMP 0xffa102aa
ffa1019e: CC = R7 == R5
ffa101a0: IF CC JUMP 0xffa1028a
ffa101a2: NOP
ffa101a4: SUB|| R2 = R2 - R2 (ns)
ffa101a8: _LOAD P1 = [FP + 0xc]
ffa101aa: _NOP
ffa101ac: STORE B [P4 + 0x8] = R0
ffa101b0: LOAD R0 = [P1 + 0xc]
ffa101b2: CC = R0 == 0x3
ffa101b4: IF CC JUMP 0xffa101bc
ffa101b6: CC = R0 == R5
ffa101b8: IF !CC JUMP 0xffa10272
ffa101ba: NOP
ffa101bc: LOAD P1 = [FP + 0xc]
ffa101be: LOAD R2 = 0x1
ffa101c0: LOAD R0 = B [P1 + 0x15] (Z)
ffa101c4: CC = R0 == 0x0
ffa101c6: IF !CC JUMP 0xffa1025a
ffa101c8: CC = R7 == R5
ffa101ca: IF CC JUMP 0xffa101d2
ffa101cc: LOAD R0 = 0x6
ffa101ce: CC = R7 == R0
ffa101d0: IF !CC JUMP 0xffa10232
ffa101d2: MOVE R3 = FP
ffa101d4: LOAD R2 = [FP + 0x14]
ffa101d6: ADD R3 += 0x8
ffa101d8: STORE [SP + 0xc] = R2
ffa101da: STORE [SP + 0x10] = R3
ffa101dc: LOAD R1 = [P5]
ffa101de: LOAD R2 = [P5 + 0x4]
ffa101e0: LOAD R0 = [FP + -0x4]
ffa101e2: CALL 0xffa0b8c0
ffa101e6: CC = R0 == 0x0
ffa101e8: IF !CC JUMP 0xffa10226
ffa101ea: CC = R7 == R5
ffa101ec: IF !CC JUMP 0xffa10202
ffa101ee: NOP
ffa101f0: NOP
ffa101f2: NOP
ffa101f4: LOAD R7 = [P5]
ffa101f6: CC = R7 == 0x1
ffa101f8: LOAD P5 = [P5 + 0x4]
ffa101fa: IF !CC JUMP 0xffa1021a
ffa101fc: STORE [P4 + 0xc] = P5
ffa101fe: LOAD R0 = [FP + 0x8]
ffa10200: STORE [P4 + 0x10] = R0
ffa10202: MOVE R1 = R7
ffa10204: ADD R1 += -0x1
ffa10206: CC = R1 < 0x7 (IU)
ffa10208: LOAD R0 = 0x0
ffa1020a: IF !CC JUMP 0xffa10318
ffa1020c: MOVE P1 = R1
ffa1020e: LOAD P0 = [FP + -0x14]
ffa10210: LOAD R7 = 0x7
ffa10212: MOVE R1 = P5
ffa10214: ADD P1 = P0 + (P1 << 2)
ffa10216: LOAD P1 = [P1]
ffa10218: JUMP (P1)
ffa1021a: CC = R7 == 0x2
ffa1021c: IF !CC JUMP 0xffa10202
ffa1021e: STORE [P4 + 0xc] = P5
ffa10220: LOAD R0 = [FP + 0x8]
ffa10222: STORE [P4 + 0x10] = R0
ffa10224: JUMP.S 0xffa10202
ffa10226: ADD SP += 0x1c
ffa10228: LOAD P0 = [FP + 0x4]
ffa1022a: POP (R7:4,P5:3) = [SP++]
ffa1022c: UNLINK
ffa10230: JUMP (P0)
ffa10232: MOVE R3 = FP
ffa10234: ROT|| R1 = rot R7 by 0
ffa10238: _LOAD R0 = [FP + 0x14]
ffa1023a: _NOP
ffa1023c: ADD R3 += 0x8
ffa1023e: STORE [SP + 0xc] = R0
ffa10240: STORE [SP + 0x10] = R3
ffa10242: MOVE R2 = P5
ffa10244: LOAD R0 = [FP + -0x4]
ffa10246: CALL 0xffa0b8c0
ffa1024a: CC = R0 == 0x0
ffa1024c: IF CC JUMP 0xffa101ea (bp)
ffa1024e: ADD SP += 0x1c
ffa10250: LOAD P0 = [FP + 0x4]
ffa10252: POP (R7:4,P5:3) = [SP++]
ffa10254: UNLINK
ffa10258: JUMP (P0)
ffa1025a: LOAD R0 = [P4 + 0x4]
ffa1025c: LOAD R1 = [SP + 0x3c]
ffa1025e: CALL 0xffa07cd0
ffa10262: CC = R0 == 0x0
ffa10264: IF CC JUMP 0xffa101c8 (bp)
ffa10266: ADD SP += 0x1c
ffa10268: LOAD P0 = [FP + 0x4]
ffa1026a: POP (R7:4,P5:3) = [SP++]
ffa1026c: UNLINK
ffa10270: JUMP (P0)
ffa10272: LOAD R0 = [P4 + 0x4]
ffa10274: LOAD R1 = [SP + 0x38]
ffa10276: CALL 0xffa07cd0
ffa1027a: CC = R0 == 0x0
ffa1027c: IF CC JUMP 0xffa101bc (bp)
ffa1027e: ADD SP += 0x1c
ffa10280: LOAD P0 = [FP + 0x4]
ffa10282: POP (R7:4,P5:3) = [SP++]
ffa10284: UNLINK
ffa10288: JUMP (P0)
ffa1028a: LOAD R0 = 0x1
ffa1028c: STORE B [P4 + 0x8] = R0
ffa10290: LOAD R2 = 0x1
ffa10292: LOAD R0 = [P4 + 0x4]
ffa10294: LOAD R1 = [SP + 0x38]
ffa10296: CALL 0xffa07cd0
ffa1029a: CC = R0 == 0x0
ffa1029c: IF CC JUMP 0xffa101bc (bp)
ffa1029e: ADD SP += 0x1c
ffa102a0: LOAD P0 = [FP + 0x4]
ffa102a2: POP (R7:4,P5:3) = [SP++]
ffa102a4: UNLINK
ffa102a8: JUMP (P0)
ffa102aa: ADD SP += 0x1c
ffa102ac: LOAD P0 = [FP + 0x4]
ffa102ae: POP (R7:4,P5:3) = [SP++]
ffa102b0: UNLINK
ffa102b4: JUMP (P0)
ffa102b6: ADD SP += 0x1c
ffa102b8: LOAD P0 = [FP + 0x4]
ffa102ba: POP (R7:4,P5:3) = [SP++]
ffa102bc: UNLINK
ffa102c0: JUMP (P0)
ffa102c2: LOAD R0 = [FP + 0x14]
ffa102c4: CC = R0 == 0x1
ffa102c6: IF !CC JUMP 0xffa102d0
ffa102c8: LOAD P4 = [P1 + 0x58]
ffa102cc: JUMP.S 0xffa10154
ffa102d0: LOAD P4 = [P1 + 0x5c]
ffa102d4: JUMP.S 0xffa10154
ffa102d6: STORE [FP + -0xc] = P5
ffa102d8: ADD R1 += 0x8
ffa102da: LOAD R3 = [FP + 0x14]
ffa102dc: ROT|| R1 = rot R7 by 0
ffa102e0: _STORE [SP + 0x10] = R1
ffa102e2: _NOP
ffa102e4: STORE [SP + 0xc] = R3
ffa102e6: LOAD R0 = [FP + -0x4]
ffa102e8: LOAD R2 = [FP + -0xc]
ffa102ea: CALL 0xffa0b8c0
ffa102ee: CC = R0 == 0x0
ffa102f0: IF !CC JUMP 0xffa103d6
ffa102f2: LOAD P0 = [FP + 0xc]
ffa102f4: LOAD R1 = [FP + 0x14]
ffa102f6: CC = R1 == 0x2
ffa102f8: ROT|| R1 = rot R7 by 0
ffa102fc: _LOAD R0 = [P0 + 0x8]
ffa102fe: _NOP
ffa10300: LOAD P1 = [P0]
ffa10302: IF !CC JUMP 0xffa10312
ffa10304: ROT|| R1 = rot R7 by 0
ffa10308: _LOAD P1 = [P1 + 0xc]
ffa1030a: _NOP
ffa1030c: LOAD R2 = [FP + -0xc]
ffa1030e: CALL (P1)
ffa10310: JUMP.S 0xffa10318
ffa10312: LOAD P1 = [P1 + 0x8]
ffa10314: LOAD R2 = [FP + -0xc]
ffa10316: CALL (P1)
ffa10318: CC = R0 == 0x0
ffa1031a: IF !CC JUMP 0xffa103ca
ffa1031c: NOP
ffa1031e: NOP
ffa10320: LOAD P1 = [FP + 0xc]
ffa10322: LOAD R1 = [P1 + 0x18]
ffa10324: CC = R1 == 0x1
ffa10326: IF !CC JUMP 0xffa10330
ffa10328: NOP
ffa1032a: NOP
ffa1032c: NOP
ffa1032e: LOAD P4 = [P4 + 0x14]
ffa10330: CC = R7 == 0x3
ffa10332: IF CC JUMP 0xffa1037a
ffa10334: LOAD R0 = 0x7
ffa10336: CC = R7 == R0
ffa10338: IF CC JUMP 0xffa1037a
ffa1033a: LOAD R0 = B [P1 + 0x16] (Z)
ffa1033e: CC = R0 == 0x1
ffa10340: IF !CC JUMP 0xffa1037a
ffa10342: CC = R7 == 0x1
ffa10344: IF !CC JUMP 0xffa103b0
ffa10346: NOP
ffa10348: NOP
ffa1034a: NOP
ffa1034c: LOAD R0 = [P5 + 0x18]
ffa1034e: CC = R6 <= R0 (IU)
ffa10350: IF !CC JUMP 0xffa1035c
ffa10352: ROT|| R6 = rot R0 by 0
ffa10356: _LOAD P3 = [FP + 0x8]
ffa10358: _NOP
ffa1035a: ADD P3 += 0x24
ffa1035c: CC = R1 == 0x1
ffa1035e: IF !CC JUMP 0xffa10366
ffa10360: CC = P4 == 0x0
ffa10362: IF CC JUMP 0xffa1039c
ffa10364: NOP
ffa10366: LOAD P1 = -0x1
ffa10368: LSETUP (0xffa1036c,0xffa10376) LC0 = P1
ffa1036c: NOP
ffa1036e: NOP
ffa10370: NOP
ffa10372: LOAD R0 = [P3]
ffa10374: CC = R0 == 0x0
ffa10376: IF !CC JUMP 0xffa1037a
ffa10378: JUMP.S 0xffa10368
ffa1037a: LOAD R0 = 0x8
ffa1037c: CC = R4 == R0
ffa1037e: IF !CC JUMP 0xffa1038a
ffa10380: NOP
ffa10382: LOAD P0 = [FP + 0x10]
ffa10384: LOAD P1 = [FP + 0x10]
ffa10386: LOAD R1 = [P0]
ffa10388: JUMP.S 0xffa10122
ffa1038a: ADD SP += 0x1c
ffa1038c: SUB|| R0 = R0 - R0 (ns)
ffa10390: _LOAD P0 = [FP + 0x4]
ffa10392: _NOP
ffa10394: POP (R7:4,P5:3) = [SP++]
ffa10396: UNLINK
ffa1039a: JUMP (P0)
ffa1039c: LOAD P1 = -0x1
ffa1039e: LSETUP (0xffa103a2,0xffa103ac) LC0 = P1
ffa103a2: NOP
ffa103a4: NOP
ffa103a6: NOP
ffa103a8: LOAD R0 = [P3]
ffa103aa: CC = R0 == 0x0
ffa103ac: IF !CC JUMP 0xffa1037a
ffa103ae: JUMP.S 0xffa1039e
ffa103b0: CC = R7 == 0x2
ffa103b2: IF !CC JUMP 0xffa1035c
ffa103b4: NOP
ffa103b6: NOP
ffa103b8: LOAD P1 = [FP + 0x8]
ffa103ba: LOAD R0 = [P5 + 0x1c]
ffa103bc: LOAD R2 = [P5 + 0x24]
ffa103be: MULT R0 *= R2
ffa103c0: CC = R6 <= R0 (IU)
ffa103c2: IF CC R6 = R0
ffa103c4: ADD P1 += 0x30
ffa103c6: IF CC P3 = P1
ffa103c8: JUMP.S 0xffa1035c
ffa103ca: ADD SP += 0x1c
ffa103cc: LOAD P0 = [FP + 0x4]
ffa103ce: POP (R7:4,P5:3) = [SP++]
ffa103d0: UNLINK
ffa103d4: JUMP (P0)
ffa103d6: ADD SP += 0x1c
ffa103d8: LOAD P0 = [FP + 0x4]
ffa103da: POP (R7:4,P5:3) = [SP++]
ffa103dc: UNLINK
ffa103e0: JUMP (P0)
ffa103e2: ADD SP += 0x1c
ffa103e4: SUB|| R0 = R0 - R0 (ns)
ffa103e8: _LOAD P0 = [FP + 0x4]
ffa103ea: _NOP
ffa103ec: POP (R7:4,P5:3) = [SP++]
ffa103ee: UNLINK
ffa103f2: JUMP (P0)
ffa103f4: LOAD R0 = [P4 + 0x4]
ffa103f6: CALL 0xffa083e4
ffa103fa: LOAD R7 = 0x1
ffa103fc: JUMP.S 0xffa10318
ffa103fe: LOAD R0 = [P4 + 0x4]
===== ffa11800
ffa11800: JUMP (P0)
ffa11808: LSH|| R6 = R6 >> 0x4
ffa1180c: _LOAD R0 = [P5 + 0x34]
ffa1180e: _NOP
ffa11810: CALL 0xffa08cea
ffa11814: PACK|| R1 = pack(R6.L,R1.L)
ffa11818: _LOAD P1 = [P5]
ffa1181a: _NOP
ffa1181c: LOAD R6 = 0x2
ffa1181e: LOAD R1.L = 0x801
ffa11822: LOAD R3 = 0x501
ffa11826: LOAD R2 = W [P1] (X)
ffa11828: LOAD R5 = W [P1] (Z)
ffa1182a: DEPOSIT R6 = deposit(R5,R6)
ffa1182e: STORE W [P1] = R6.L
ffa11830: LOAD P1 = [P5]
ffa11832: LOAD P0 = -0x1
ffa11834: LOAD R6 = W [P1] (Z)
ffa11836: DEPOSIT R1 = deposit(R6,R1)
ffa1183a: STORE W [P1] = R1.L
ffa1183c: LOAD P1 = [P5]
ffa1183e: LOAD R1 = W [P1] (X)
ffa11840: BITSET (R1,0xe)
ffa11842: STORE W [P1] = R1.L
ffa11844: LOAD P1 = [P5 + 0x10]
ffa11846: LOAD R1 = W [P1] (X)
ffa11848: LSETUP (0xffa1184c,0xffa1185a) LC0 = P0
ffa1184c: LOAD P1 = [P5 + 0x4]
ffa1184e: NOP
ffa11850: NOP
ffa11852: LOAD R1 = W [P1] (X)
ffa11854: EXTRACT R1 = extract(R1,R3.L) (z)
ffa11858: CC = R1 == 0x0
ffa1185a: IF !CC JUMP 0xffa1185e
ffa1185c: JUMP.S 0xffa11848
ffa1185e: LOAD P1 = [P5 + 0x10]
ffa11860: LOAD R1 = W [P1] (X)
ffa11862: LOAD P1 = [P5]
ffa11864: STORE W [P1] = R2.L
ffa11866: CALL 0xffa08d0c
ffa1186a: ADD SP += 0xc
ffa1186c: SUB|| R0 = R0 - R0 (ns)
ffa11870: _LOAD P0 = [FP + 0x4]
ffa11872: _NOP
ffa11874: POP (R7:4,P5:5) = [SP++]
ffa11876: UNLINK
ffa1187a: JUMP (P0)
ffa1187c: LOAD R0 = [P5 + 0x34]
ffa1187e: CALL 0xffa08cea
ffa11882: CC = R6 == 0x0
ffa11884: LOAD P1 = [P5]
ffa11886: IF CC JUMP 0xffa11896
ffa11888: NOP
ffa1188a: NOP
ffa1188c: NOP
ffa1188e: LOAD R1 = W [P1] (X)
ffa11890: BITCLR (R1,0xe)
ffa11892: STORE W [P1] = R1.L
ffa11894: JUMP.S 0xffa1189c
ffa11896: LOAD R1 = W [P1] (X)
ffa11898: BITSET (R1,0xe)
ffa1189a: STORE W [P1] = R1.L
ffa1189c: CALL 0xffa08d0c
ffa118a0: ADD SP += 0xc
ffa118a2: SUB|| R0 = R0 - R0 (ns)
ffa118a6: _LOAD P0 = [FP + 0x4]
ffa118a8: _NOP
ffa118aa: POP (R7:4,P5:5) = [SP++]
ffa118ac: UNLINK
ffa118b0: JUMP (P0)
ffa118b4: STORE [P5 + 0x6c] = R6
ffa118b8: ADD SP += 0xc
ffa118ba: LOAD P0 = [FP + 0x4]
ffa118bc: POP (R7:4,P5:5) = [SP++]
ffa118be: UNLINK
ffa118c2: JUMP (P0)
ffa118c4: LINK 0x0
ffa118c8: PUSH [--SP] = (R7:6,P5:5)
ffa118ca: LOAD R1 = 0x5
ffa118cc: ADD SP += -0xc
ffa118ce: BITSET (R1,0x1e)
ffa118d0: LOAD R2 = 0x0
ffa118d2: MOVE R7 = R0
ffa118d4: CALL 0xffa114b8
ffa118d8: CC = R0 == 0x0
ffa118da: MOVE P5 = R7
ffa118dc: LOAD R6 = 0x0
ffa118de: IF CC JUMP 0xffa118ec
ffa118e0: ADD SP += 0xc
ffa118e2: LOAD P0 = [FP + 0x4]
ffa118e4: POP (R7:6,P5:5) = [SP++]
ffa118e6: UNLINK
ffa118ea: JUMP (P0)
ffa118ec: LOAD R0 = [P5 + 0x48]
ffa118f0: CALL 0xffa08c20
ffa118f4: LOAD R1 = 0x0
ffa118f6: LOAD R0 = [P5 + 0x48]
ffa118fa: CALL 0xffa08ba4
ffa118fe: MOVE R2 = R7
ffa11900: LOAD R0 = [P5 + 0x4c]
ffa11904: LOAD R1.L = 0x10e4
ffa11908: LOAD R1.H = 0xffa1
ffa1190c: CALL 0xffa08eb8
ffa11910: CC = R0 == 0x0
ffa11912: IF CC JUMP 0xffa11924
ffa11914: ADD SP += 0xc
ffa11916: LOAD P0 = [FP + 0x4]
ffa11918: POP (R7:6,P5:5) = [SP++]
ffa1191a: LOAD R0 = 0x12
ffa1191c: UNLINK
ffa11920: BITSET (R0,0x1e)
ffa11922: JUMP (P0)
ffa11924: LOAD R1 = 0x15
ffa11926: MOVE R0 = R7
ffa11928: BITSET (R1,0x1e)
ffa1192a: LOAD R2 = 0x0
ffa1192c: CALL 0xffa114b8
ffa11930: STORE [P5 + 0x20] = R6
ffa11932: ADD SP += 0xc
ffa11934: LOAD P0 = [FP + 0x4]
ffa11936: POP (R7:6,P5:5) = [SP++]
ffa11938: UNLINK
ffa1193c: JUMP (P0)
ffa11940: MOVE P1 = R0
ffa11942: LOAD R1 = 0x3
ffa11944: LOAD P0 = [P1]
ffa11946: LOAD R0 = [P1]
ffa11948: CC = R0 == 0x0
ffa1194a: IF CC JUMP 0xffa119dc
ffa1194c: NOP
ffa1194e: NOP
ffa11950: NOP
ffa11952: LOAD R0 = W [P0 + 0x2c] (X)
ffa11956: LSHIFT R0 >>= 0x2
ffa11958: AND R0 = R0 & R1
ffa1195a: MOVE R2 = R0.L (Z)
ffa1195c: CC = R2 == 0x0
ffa1195e: MOVE R0 = R2
ffa11960: IF CC JUMP 0xffa119dc
ffa11962: LOAD R0 = [P1 + 0x1c]
ffa11964: CC = R0 < 0x2 (IU)
ffa11966: IF CC JUMP 0xffa11974
ffa11968: CC = R0 == 0x2
ffa1196a: IF CC JUMP 0xffa11a1c
ffa1196c: LOAD R1 = 0x4
ffa1196e: CC = R0 == R1
ffa11970: IF !CC JUMP 0xffa11974
ffa11972: LOAD P0 = [P1 + 0x28]
ffa11974: CC = R2 == 0x1
ffa11976: LOAD P2 = [P1]
ffa11978: IF !CC JUMP 0xffa11988
ffa1197a: NOP
ffa1197c: NOP
ffa1197e: NOP
ffa11980: LOAD R0 = W [P2 + 0x88] (Z)
ffa11984: JUMP.S 0xffa1198c
ffa11988: LOAD R0 = W [P2 + 0x8c] (Z)
ffa1198c: CC = P0 == 0x0
ffa1198e: IF CC JUMP 0xffa119be
ffa11990: NOP
ffa11992: LOAD P2 = [P1]
ffa11994: LOAD R3 = 0xfe
ffa11998: LOAD R1 = W [P2 + 0x14] (X)
ffa1199a: CC = BITTST (R1,0x0)
ffa1199c: IF !CC JUMP 0xffa119be
ffa1199e: NOP
ffa119a0: NOP
ffa119a2: NOP
ffa119a4: LOAD R1 = [P0 + 0x18]
ffa119a6: CC = R3 < R1 (IU)
ffa119a8: IF !CC JUMP 0xffa119be
ffa119aa: LOAD R3 = [P0 + 0x28]
ffa119ac: SUB R1 = R1 - R3
ffa119ae: CC = R1 < 0x2 (IU)
ffa119b0: IF !CC JUMP 0xffa119be
ffa119b2: NOP
ffa119b4: NOP
ffa119b6: LOAD P2 = [P1]
ffa119b8: LOAD R1 = W [P2 + 0x14] (X)
ffa119ba: BITSET (R1,0x4)
ffa119bc: STORE W [P2 + 0x14] = R1
ffa119be: LOAD P2 = [P1]
ffa119c0: LOAD R1 = B [P1 + 0x24] (Z)
ffa119c4: CC = P0 == 0x0
ffa119c6: STORE W [P2 + 0x28] = R1
ffa119ca: IF CC JUMP 0xffa119da
ffa119cc: NOP
ffa119ce: NOP
ffa119d0: NOP
ffa119d2: LOAD R1 = [P0 + 0x28]
ffa119d4: LOAD R3 = [P0 + 0x18]
ffa119d6: CC = R1 == R3
ffa119d8: IF !CC JUMP 0xffa119de
ffa119da: LOAD R0 = 0x1
ffa119dc: RTS
ffa119de: CC = R2 == 0x1
ffa119e0: IF CC JUMP 0xffa11a04
ffa119e2: CC = R2 == 0x3
ffa119e4: IF !CC JUMP 0xffa11a18
ffa119e6: SUB R1 = R3 - R1
ffa119e8: CC = R1 < 0x2 (IU)
ffa119ea: IF CC JUMP 0xffa11a04
ffa119ec: LSH|| R1.L = R0.L >> 0x8
ffa119f0: LOAD P1 = [P0 + 0x28]
ffa119f2: NOP
ffa119f4: LOAD P2 = [P0 + 0x14]
ffa119f6: ADD P2 = P2 + P1
ffa119f8: LSH|| R0.L = R1.L << 0x0
ffa119fc: STORE B [P2] = R0
ffa119fe: NOP
ffa11a00: ADD P1 += 0x1
ffa11a02: STORE [P0 + 0x28] = P1
ffa11a04: LOAD P1 = [P0 + 0x28]
ffa11a06: LOAD P2 = [P0 + 0x14]
ffa11a08: ADD P2 = P2 + P1
ffa11a0a: SUB|| R0 = R0 - R0 (ns)
ffa11a0e: _STORE B [P2] = R0
ffa11a10: _NOP
ffa11a12: ADD P1 += 0x1
ffa11a14: STORE [P0 + 0x28] = P1
ffa11a16: RTS
ffa11a18: LOAD R0 = 0x0
ffa11a1a: RTS
ffa11a1c: LOAD R0 = [P1 + 0x28]
ffa11a1e: CC = R0 == 0x0
ffa11a20: LOAD P0 = [P1 + 0x28]
ffa11a22: IF CC JUMP 0xffa119dc
ffa11a24: JUMP.S 0xffa11974
ffa11a26: MOVE P2 = R0
ffa11a28: PUSH [--SP] = (P5:4)
ffa11a2a: LOAD R1 = 0x4
ffa11a2c: LOAD P1 = [P2]
ffa11a2e: LOAD R0 = [P2]
ffa11a30: CC = R0 == 0x0
ffa11a32: IF CC JUMP 0xffa11a42
ffa11a34: NOP
ffa11a36: NOP
ffa11a38: NOP
ffa11a3a: LOAD R0 = W [P1 + 0x2c] (X)
ffa11a3e: CC = BITTST (R0,0x0)
ffa11a40: IF !CC JUMP 0xffa11a48
ffa11a42: POP (P5:4) = [SP++]
ffa11a44: LOAD R0 = 0x0
ffa11a46: RTS
ffa11a48: LOAD R0 = [P2 + 0x1c]
ffa11a4a: CC = R0 < 0x2 (IU)
ffa11a4c: IF CC JUMP 0xffa11a58
ffa11a4e: CC = R0 == 0x2
ffa11a50: IF CC JUMP 0xffa11afe
ffa11a52: CC = R0 == R1
ffa11a54: IF !CC JUMP 0xffa11a58
ffa11a56: LOAD P0 = [P2 + 0x28]
ffa11a58: CC = P0 == 0x0
ffa11a5a: IF CC JUMP 0xffa11a6a
ffa11a5c: NOP
ffa11a5e: NOP
ffa11a60: NOP
ffa11a62: LOAD R0 = [P0 + 0x28]
ffa11a64: LOAD R1 = [P0 + 0x18]
ffa11a66: CC = R0 == R1
ffa11a68: IF !CC JUMP 0xffa11a74
ffa11a6a: POP (P5:4) = [SP++]
ffa11a6c: LOAD R0 = 0x3
ffa11a6e: LOAD R0.H = 0x4011
ffa11a72: RTS
ffa11a74: LOAD P1 = [P2]
ffa11a76: LOAD R0 = 0x3
ffa11a78: LOAD R1 = W [P1 + 0x2c] (X)
ffa11a7c: AND R0 = R1 & R0
ffa11a7e: CC = R0 == 0x0
ffa11a80: IF CC JUMP 0xffa11ace
ffa11a82: CC = R0 == 0x1
ffa11a84: IF !CC JUMP 0xffa11a98
ffa11a86: LOAD P1 = [P0 + 0x28]
ffa11a88: LOAD P5 = [P0 + 0x14]
ffa11a8a: ADD P5 = P5 + P1
ffa11a8c: LOAD R0 = B [P5] (Z)
ffa11a8e: ADD P1 += 0x1
ffa11a90: STORE [P0 + 0x28] = P1
ffa11a92: LOAD P1 = [P2]
ffa11a94: STORE W [P1 + 0x80] = R0
ffa11a98: LOAD P1 = [P2]
ffa11a9a: LOAD R0 = B [P2 + 0x24] (Z)
ffa11a9e: LOAD R1 = 0xfe
ffa11aa2: STORE W [P1 + 0x28] = R0
ffa11aa6: LOAD P1 = [P2]
ffa11aa8: LOAD R0 = W [P1 + 0x14] (X)
ffa11aaa: CC = BITTST (R0,0x0)
ffa11aac: IF !CC JUMP 0xffa11ac8
ffa11aae: LOAD R0 = [P0 + 0x18]
ffa11ab0: CC = R1 < R0 (IU)
ffa11ab2: IF !CC JUMP 0xffa11ac8
ffa11ab4: LOAD R1 = [P0 + 0x28]
ffa11ab6: SUB R0 = R0 - R1
ffa11ab8: CC = R0 == 0x0
ffa11aba: IF !CC JUMP 0xffa11ac8
ffa11abc: NOP
ffa11abe: NOP
ffa11ac0: LOAD P1 = [P2]
ffa11ac2: LOAD R0 = W [P1 + 0x14] (X)
ffa11ac4: BITSET (R0,0x4)
ffa11ac6: STORE W [P1 + 0x14] = R0
ffa11ac8: POP (P5:4) = [SP++]
ffa11aca: LOAD R0 = 0x0
ffa11acc: RTS
ffa11ace: LOAD P1 = [P2]
ffa11ad0: LOAD R0 = W [P1 + 0x28] (X)
ffa11ad4: CC = BITTST (R0,0x2)
ffa11ad6: IF !CC JUMP 0xffa11a86
ffa11ad8: LOAD R0 = [P0 + 0x28]
ffa11ada: LOAD R1 = [P0 + 0x18]
ffa11adc: SUB R0 = R0 - R1
ffa11ade: CC = R0 < 0x2 (IU)
ffa11ae0: IF CC JUMP 0xffa11a86
ffa11ae2: LOAD P1 = [P0 + 0x14]
ffa11ae4: LOAD P4 = [P0 + 0x28]
ffa11ae6: LOAD P5 = [P2]
ffa11ae8: ADD P1 = P1 + P4
ffa11aea: LOAD R1 = B [P1++] (Z)
ffa11aec: LOAD R0 = B [P1] (Z)
ffa11aee: LSHIFT R0 <<= 0x8
ffa11af0: ADD R0 = R1 + R0
ffa11af2: STORE W [P5 + 0x84] = R0
ffa11af6: LOAD R0 = [P0 + 0x28]
ffa11af8: ADD R0 += 0x2
ffa11afa: STORE [P0 + 0x28] = R0
ffa11afc: JUMP.S 0xffa11a98
ffa11afe: LOAD P0 = [P2 + 0x2c]
ffa11b00: JUMP.S 0xffa11a58
ffa11b02: MOVE P1 = R0
ffa11b04: LOAD R1 = 0x3
ffa11b06: LOAD R2 = -0x4
ffa11b08: LOAD R0 = 0x0
ffa11b0a: LOAD P0 = [P1]
ffa11b0c: LOAD R3 = W [P0 + 0x28] (X)
ffa11b10: OR R1 = R3 | R1
ffa11b12: STORE W [P0 + 0x28] = R1
ffa11b16: LOAD P1 = [P1]
ffa11b18: LOAD R1 = W [P1 + 0x28] (X)
ffa11b1c: AND R1 = R1 & R2
ffa11b1e: STORE W [P1 + 0x28] = R1
ffa11b22: RTS
ffa11b24: MOVE P1 = R1
ffa11b26: LINK 0x0
ffa11b2a: PUSH [--SP] = (R7:4,P5:4)
ffa11b2c: ADD SP += -0xc
ffa11b2e: ROT|| R7 = rot R2 by 0
ffa11b32: _LOAD P2 = [SP + 0x38]
ffa11b34: _NOP
ffa11b36: ADD P4 = P1 + P1
ffa11b38: MOVE P0 = P1
ffa11b3a: ADD P0 = (P0 + P4) << 2
ffa11b3c: ADD P1 = (P1 + P0) << 2
ffa11b3e: LOAD P5.L = 0x2078
ffa11b42: LOAD P5.H = 0xff80
ffa11b46: ADD P5 = P5 + P1
ffa11b48: STORE [P2] = P5
ffa11b4a: LOAD R0 = [FP + 0x1c]
ffa11b4c: CALL 0xffa08cea
ffa11b50: LOAD R4 = [P5 + 0xc]
ffa11b52: MOVE CC = R4
ffa11b54: LOAD R6 = [FP + 0x1c]
ffa11b56: LOAD R5 = [FP + 0x24]
ffa11b58: IF CC JUMP 0xffa11b5c
ffa11b5a: STORE [P5 + 0xc] = R7
ffa11b5c: CALL 0xffa08d0c
ffa11b60: MOVE CC = R4
ffa11b62: IF !CC JUMP 0xffa11b78
ffa11b64: ADD SP += 0xc
ffa11b66: LOAD P0 = [FP + 0x4]
ffa11b68: POP (R7:4,P5:4) = [SP++]
ffa11b6a: LOAD R0 = 0x2
ffa11b6c: UNLINK
ffa11b70: BITSET (R0,0x1e)
ffa11b72: JUMP (P0)
ffa11b78: SUB|| R3 = R3 - R3 (ns)
ffa11b7c: _LOAD R2 = [FP + 0x28]
ffa11b7e: _NOP
ffa11b80: LOAD R7 = 0x64
ffa11b84: LSH|| R3.L = R7.L << 0x0
ffa11b88: STORE [P5 + 0x1c] = R3
ffa11b8a: NOP
ffa11b8c: SUB|| R1 = R1 - R1 (ns)
ffa11b90: _STORE [P5 + 0x8] = R6
ffa11b92: _NOP
ffa11b94: STORE [P5 + 0x14] = R2
ffa11b96: MOVE R0 = P5
ffa11b98: LOAD R3.H = 0x32
ffa11b9c: LOAD R4 = 0x1
ffa11b9e: LOAD R2 = 0xc
ffa11ba0: LOAD R6 = 0x3
ffa11ba2: STORE [P5 + 0x10] = R5
ffa11ba4: STORE [P5 + 0x20] = R3
ffa11ba6: STORE B [P5 + 0x26] = R4
ffa11baa: STORE B [P5 + 0x27] = R4
ffa11bae: STORE B [P5 + 0x24] = R2
ffa11bb2: STORE B [P5 + 0x25] = R6
ffa11bb6: ADD R0 += 0x28
ffa11bb8: CALL 0xffa07280
ffa11bbc: ADD SP += 0xc
ffa11bbe: SUB|| R0 = R0 - R0 (ns)
ffa11bc2: _LOAD P0 = [FP + 0x4]
ffa11bc4: _NOP
ffa11bc6: POP (R7:4,P5:4) = [SP++]
ffa11bc8: UNLINK
ffa11bcc: JUMP (P0)
ffa11bce: MOVE P1 = R0
ffa11bd0: LINK 0x1c
ffa11bd4: STORE [SP + 0x18] = R7
ffa11bd6: LOAD R7 = [P1 + 0x14]
ffa11bd8: CC = R7 == 0x0
ffa11bda: LOAD P0 = [P1 + 0x14]
ffa11bdc: IF CC JUMP 0xffa11bfc
ffa11bde: LOAD R0 = [P1 + 0x10]
ffa11be0: CC = R0 == 0x0
ffa11be2: LOAD R3 = [P1 + 0xc]
ffa11be4: IF CC JUMP 0xffa11c0c
ffa11be6: ROT|| R2 = rot R7 by 0
ffa11bea: _STORE [SP + 0x14] = R2
ffa11bec: _NOP
ffa11bee: STORE [SP + 0xc] = R3
ffa11bf0: SUB|| R1 = R1 - R1 (ns)
ffa11bf4: _STORE [SP + 0x10] = R1
ffa11bf6: _NOP
ffa11bf8: CALL 0xffa07394
ffa11bfc: SUB|| R0 = R0 - R0 (ns)
===== ffa12a00
ffa12a00: LOAD R0 = [P5 + 0x14]
ffa12a02: CALL 0xffa016d4
ffa12a06: MOVE R7 = R0
ffa12a08: MOVE R0 = R6
ffa12a0a: CALL 0xffa016d4
ffa12a0e: LOAD R1 = 0x0
ffa12a10: LOAD R1.H = 0x4180
ffa12a14: CALL 0xffa018f0
ffa12a18: MOVE R1 = R0
ffa12a1a: MOVE R0 = R7
ffa12a1c: CALL 0xffa01814
ffa12a20: LOAD R1 = 0x0
ffa12a22: LOAD R1.H = 0x3f00
ffa12a26: CALL 0xffa01716
ffa12a2a: CALL 0xffa01520
ffa12a2e: LSH|| R2 = R0 >> 0x8
ffa12a32: _LOAD P1 = [P5]
ffa12a34: _NOP
ffa12a36: MOVE R1 = R0.B (Z)
ffa12a38: LOAD R0 = W [P1 + 0xc] (X)
ffa12a3a: BITSET (R0,0x7)
ffa12a3c: STORE W [P1 + 0xc] = R0
ffa12a3e: LOAD P1 = [P5]
ffa12a40: STORE W [P1] = R1.L
ffa12a42: LOAD P1 = [P5]
ffa12a44: STORE W [P1 + 0x4] = R2
ffa12a46: LOAD P1 = [P5]
ffa12a48: LOAD R0 = W [P1 + 0xc] (X)
ffa12a4a: BITCLR (R0,0x7)
ffa12a4c: STORE W [P1 + 0xc] = R0
ffa12a4e: ADD SP += 0xc
ffa12a50: LOAD P0 = [FP + 0x4]
ffa12a52: POP (R7:6,P5:5) = [SP++]
ffa12a54: UNLINK
ffa12a58: JUMP (P0)
ffa12a5a: LOAD R0 = 0x1
ffa12a5c: BITSET (R0,0x1e)
ffa12a5e: NOP
ffa12a60: NOP
ffa12a62: RTS
ffa12a64: LINK 0x0
ffa12a68: PUSH [--SP] = (R7:7,P5:4)
ffa12a6a: MOVE R7 = R2
ffa12a6c: CC = R7 == 0x0
ffa12a6e: MOVE P4 = R0
ffa12a70: ADD SP += -0xc
ffa12a72: IF CC JUMP 0xffa12a9a
ffa12a74: MOVE P5 = R7
ffa12a76: LOAD P0 = -0x1
ffa12a78: LSETUP (0xffa12a7c,0xffa12a96) LC0 = P0
ffa12a7c: NOP
ffa12a7e: NOP
ffa12a80: LOAD R0 = [P5 + 0x2c]
ffa12a82: CC = R0 == 0x0
ffa12a84: LOAD R2 = [P5 + 0x14]
ffa12a86: LOAD P1 = [P5 + 0x2c]
ffa12a88: LOAD R0 = [P5 + 0x18]
ffa12a8a: LOAD R1 = [P5 + 0x1c]
ffa12a8c: MULT R0 *= R1
ffa12a8e: STORE [P5 + 0x8] = R0
ffa12a90: STORE [P5] = P1
ffa12a92: STORE [P5 + 0x4] = R2
ffa12a94: IF CC JUMP 0xffa12a9a
ffa12a96: MOVE P5 = P1
ffa12a98: JUMP.S 0xffa12a78
ffa12a9a: LOAD R0 = 0x0
ffa12a9c: STORE [P5] = R0
ffa12a9e: LOAD R0 = [P4 + 0x58]
ffa12aa2: CALL 0xffa08cea
ffa12aa6: LOAD R1 = [P4 + 0x48]
ffa12aaa: CC = R1 == 0x0
ffa12aac: IF CC JUMP 0xffa12ad0
ffa12aae: LOAD P1 = [P4 + 0x4c]
ffa12ab2: STORE [P4 + 0x4c] = P5
ffa12ab6: STORE [P1] = R7
ffa12ab8: CALL 0xffa08d0c
ffa12abc: ADD SP += 0xc
ffa12abe: SUB|| R0 = R0 - R0 (ns)
ffa12ac2: _LOAD P0 = [FP + 0x4]
ffa12ac4: _NOP
ffa12ac6: POP (R7:7,P5:4) = [SP++]
ffa12ac8: UNLINK
ffa12acc: JUMP (P0)
ffa12ad0: LOAD P1 = 0x48
ffa12ad4: ADD P1 = P4 + P1
ffa12ad6: JUMP.S 0xffa12ab2
ffa12ad8: LINK 0x0
ffa12adc: PUSH [--SP] = (R7:7,P5:4)
ffa12ade: MOVE R7 = R2
ffa12ae0: CC = R7 == 0x0
ffa12ae2: MOVE P4 = R0
ffa12ae4: ADD SP += -0xc
ffa12ae6: IF CC JUMP 0xffa12b0e
ffa12ae8: MOVE P5 = R7
ffa12aea: LOAD P0 = -0x1
ffa12aec: LSETUP (0xffa12af0,0xffa12b0a) LC0 = P0
ffa12af0: NOP
ffa12af2: NOP
ffa12af4: LOAD R0 = [P5 + 0x2c]
ffa12af6: CC = R0 == 0x0
ffa12af8: LOAD R2 = [P5 + 0x14]
ffa12afa: LOAD P1 = [P5 + 0x2c]
ffa12afc: LOAD R1 = [P5 + 0x18]
ffa12afe: LOAD R0 = [P5 + 0x1c]
ffa12b00: MULT R0 *= R1
ffa12b02: STORE [P5 + 0x8] = R0
ffa12b04: STORE [P5] = P1
ffa12b06: STORE [P5 + 0x4] = R2
ffa12b08: IF CC JUMP 0xffa12b0e
ffa12b0a: MOVE P5 = P1
ffa12b0c: JUMP.S 0xffa12aec
ffa12b0e: LOAD R0 = 0x0
ffa12b10: STORE [P5] = R0
ffa12b12: LOAD R0 = [P4 + 0x58]
ffa12b16: CALL 0xffa08cea
ffa12b1a: LOAD R1 = [P4 + 0x50]
ffa12b1e: CC = R1 == 0x0
ffa12b20: IF CC JUMP 0xffa12b4c
ffa12b22: LOAD P1 = [P4 + 0x54]
ffa12b26: STORE [P4 + 0x54] = P5
ffa12b2a: STORE [P1] = R7
ffa12b2c: CALL 0xffa08d0c
ffa12b30: SUB|| R0 = R0 - R0 (ns)
ffa12b34: _LOAD P1 = [P4]
ffa12b36: _NOP
ffa12b38: LOAD R1 = W [P1 + 0x4] (X)
ffa12b3a: BITSET (R1,0x1)
ffa12b3c: STORE W [P1 + 0x4] = R1
ffa12b3e: ADD SP += 0xc
ffa12b40: LOAD P0 = [FP + 0x4]
ffa12b42: POP (R7:7,P5:4) = [SP++]
ffa12b44: UNLINK
ffa12b48: JUMP (P0)
ffa12b4c: LOAD P1 = 0x50
ffa12b50: ADD P1 = P4 + P1
ffa12b52: JUMP.S 0xffa12b26
ffa12b54: LINK 0x0
ffa12b58: PUSH [--SP] = (P5:3)
ffa12b5a: MOVE P4 = R1
ffa12b5c: MOVE P3 = R0
ffa12b5e: ADD SP += -0xc
ffa12b60: LOAD R0 = 0x1
ffa12b62: MOVE P5 = R2
ffa12b64: STORE [P4 + 0x24] = R0
ffa12b66: LOAD R0 = [P4 + 0x18]
ffa12b68: LOAD R1 = [P4 + 0x8]
ffa12b6a: SUB R0 = R0 - R1
ffa12b6c: STORE [P4 + 0x28] = R0
ffa12b6e: LOAD R0 = [P3 + 0x58]
ffa12b72: CALL 0xffa08cea
ffa12b76: LOAD R1 = [P4]
ffa12b78: CC = R1 == 0x0
ffa12b7a: STORE [P5] = R1
ffa12b7c: IF CC JUMP 0xffa12bec
ffa12b7e: CALL 0xffa08d0c
ffa12b82: LOAD R2 = [P4 + 0x20]
ffa12b84: CC = R2 == 0x0
ffa12b86: IF CC JUMP 0xffa12b96
ffa12b88: LOAD P1 = [P3 + 0x64]
ffa12b8c: LOAD R1 = 0x1
ffa12b8e: BITSET (R1,0x1e)
ffa12b90: LOAD R0 = [P3 + 0x5c]
ffa12b94: CALL (P1)
ffa12b96: SUB|| R2 = R2 - R2 (ns)
ffa12b9a: _LOAD R0 = [P3 + 0xc]
ffa12b9c: _NOP
ffa12b9e: CC = R0 == 0x3
ffa12ba0: IF CC JUMP 0xffa12bae
ffa12ba2: ADD SP += 0xc
ffa12ba4: LOAD P0 = [FP + 0x4]
ffa12ba6: POP (P5:3) = [SP++]
ffa12ba8: UNLINK
ffa12bac: JUMP (P0)
ffa12bae: LOAD R0 = [P4 + 0x14]
ffa12bb0: STORE [P4 + 0x4] = R0
ffa12bb2: LOAD R0 = [P4 + 0x1c]
ffa12bb4: LOAD R1 = [P4 + 0x18]
ffa12bb6: MULT R0 *= R1
ffa12bb8: STORE [P4 + 0x8] = R0
ffa12bba: STORE [P4 + 0x24] = R2
ffa12bbc: STORE [P4 + 0x28] = R2
ffa12bbe: LOAD R0 = [P3 + 0x58]
ffa12bc2: CALL 0xffa08cea
ffa12bc6: LOAD R1 = [P5]
ffa12bc8: CC = R1 == 0x0
ffa12bca: IF CC JUMP 0xffa12be6
ffa12bcc: NOP
ffa12bce: NOP
ffa12bd0: LOAD P1 = [SP + 0x2c]
ffa12bd2: LOAD P1 = [P1]
ffa12bd4: STORE [P1] = P4
ffa12bd6: CALL 0xffa08d0c
ffa12bda: ADD SP += 0xc
ffa12bdc: LOAD P0 = [FP + 0x4]
ffa12bde: POP (P5:3) = [SP++]
ffa12be0: UNLINK
ffa12be4: JUMP (P0)
ffa12be6: STORE [P5] = P4
ffa12be8: LOAD P1 = [SP + 0x2c]
ffa12bea: JUMP.S 0xffa12bd4
ffa12bec: LOAD P1 = [SP + 0x2c]
ffa12bee: STORE [P1] = R1
ffa12bf0: JUMP.S 0xffa12b7e
ffa12bf4: LINK 0x0
ffa12bf8: PUSH [--SP] = (R7:6,P5:5)
ffa12bfa: MOVE R7 = R0
ffa12bfc: MOVE P5 = R7
ffa12bfe: ADD SP += -0x10
ffa12c00: LOAD R1 = 0x1
ffa12c02: LOAD P1 = [P5]
ffa12c04: LOAD R6 = W [P1 + 0x14] (X)
ffa12c06: CC = BITTST (R6,0x0)
ffa12c08: IF !CC JUMP 0xffa12c48
ffa12c0a: NOP
ffa12c0c: NOP
ffa12c0e: LOAD P1 = [P5]
ffa12c10: LOAD R3 = W [P1] (X)
ffa12c12: LOAD P0 = [P5 + 0x48]
ffa12c16: LOAD R1 = [P5 + 0x48]
ffa12c1a: CC = R1 == 0x0
ffa12c1c: IF CC JUMP 0xffa12c46
ffa12c1e: NOP
ffa12c20: NOP
ffa12c22: NOP
ffa12c24: LOAD P1 = [P0 + 0x4]
ffa12c26: STORE B [P1++] = R3
ffa12c28: STORE [P0 + 0x4] = P1
ffa12c2a: LOAD R2 = [P0 + 0x8]
ffa12c2c: ADD R2 += -0x1
ffa12c2e: STORE [P0 + 0x8] = R2
ffa12c30: CC = R2 == 0x0
ffa12c32: IF CC JUMP 0xffa12d68
ffa12c34: LOAD R2 = [P5 + 0x40]
ffa12c38: CC = R2 == 0x0
ffa12c3a: IF CC JUMP 0xffa12c46
ffa12c3c: LOAD R2 = [P5 + 0x44]
ffa12c40: MOVE R3 = R3.B (Z)
ffa12c42: CC = R2 == R3
ffa12c44: IF CC JUMP 0xffa12d68
ffa12c46: LOAD R1 = 0x0
ffa12c48: CC = BITTST (R6,0x5)
ffa12c4a: IF !CC JUMP 0xffa12c98
ffa12c4c: NOP
ffa12c4e: LOAD P1 = [P5]
ffa12c50: LOAD R2 = 0x50
ffa12c54: ADD|| R2 = R7 + R2 (ns)
ffa12c58: _LOAD R0 = W [P1 + 0x4] (X)
ffa12c5a: _NOP
ffa12c5c: CC = BITTST (R0,0x1)
ffa12c5e: IF !CC JUMP 0xffa12c98
ffa12c60: LOAD P1 = [P5 + 0x50]
ffa12c64: LOAD R1 = [P5 + 0x50]
ffa12c68: CC = R1 == 0x0
ffa12c6a: IF CC JUMP 0xffa12d5c
ffa12c6c: NOP
ffa12c6e: NOP
ffa12c70: NOP
ffa12c72: LOAD R0 = [P1 + 0x8]
ffa12c74: CC = R0 == 0x0
ffa12c76: IF CC JUMP 0xffa12d44
ffa12c78: CC = R1 == 0x0
ffa12c7a: LOAD P0 = [P5]
ffa12c7c: IF CC JUMP 0xffa12d3c
ffa12c7e: NOP
ffa12c80: NOP
ffa12c82: NOP
ffa12c84: LOAD P2 = [P1 + 0x4]
ffa12c86: LOAD R0 = B [P2] (Z)
ffa12c88: STORE W [P0] = R0.L
ffa12c8a: LOAD R0 = [P1 + 0x4]
ffa12c8c: ADD R0 += 0x1
ffa12c8e: STORE [P1 + 0x4] = R0
ffa12c90: LOAD R0 = [P1 + 0x8]
ffa12c92: ADD R0 += -0x1
ffa12c94: STORE [P1 + 0x8] = R0
ffa12c96: LOAD R1 = 0x0
ffa12c98: ROT|| R0 = rot R1 by 0
ffa12c9c: _LOAD R2 = [P5 + 0x20]
ffa12c9e: _NOP
ffa12ca0: CC = R2 == 0x1
ffa12ca2: IF !CC JUMP 0xffa12cce
ffa12ca4: LOAD R1 = 0x1e
ffa12ca6: AND R1 = R6 & R1
ffa12ca8: CC = R1 == 0x0
ffa12caa: IF CC JUMP 0xffa12cce
ffa12cac: CC = BITTST (R6,0x1)
ffa12cae: IF CC JUMP 0xffa12d28
ffa12cb0: CC = BITTST (R6,0x2)
ffa12cb2: IF CC JUMP 0xffa12d14
ffa12cb4: CC = BITTST (R6,0x3)
ffa12cb6: IF CC JUMP 0xffa12d00
ffa12cb8: CC = BITTST (R6,0x4)
ffa12cba: IF CC JUMP 0xffa12cdc
ffa12cbc: ADD SP += 0x10
ffa12cbe: SUB|| R0 = R0 - R0 (ns)
ffa12cc2: _LOAD P0 = [FP + 0x4]
ffa12cc4: _NOP
ffa12cc6: POP (R7:6,P5:5) = [SP++]
ffa12cc8: UNLINK
ffa12ccc: JUMP (P0)
ffa12cce: ADD SP += 0x10
ffa12cd0: LOAD P0 = [FP + 0x4]
ffa12cd2: POP (R7:6,P5:5) = [SP++]
ffa12cd4: UNLINK
ffa12cd8: JUMP (P0)
ffa12cdc: LOAD P1 = [P5 + 0x64]
ffa12ce0: LOAD R0 = [P5 + 0x5c]
ffa12ce4: LOAD R2 = 0x0
ffa12ce6: LOAD R1 = 0x1
ffa12ce8: LOAD R1.H = 0x4012
ffa12cec: CALL (P1)
ffa12cee: ADD SP += 0x10
ffa12cf0: SUB|| R0 = R0 - R0 (ns)
ffa12cf4: _LOAD P0 = [FP + 0x4]
ffa12cf6: _NOP
ffa12cf8: POP (R7:6,P5:5) = [SP++]
ffa12cfa: UNLINK
ffa12cfe: JUMP (P0)
ffa12d00: LOAD P1 = [P5 + 0x64]
ffa12d04: LOAD R0 = [P5 + 0x5c]
ffa12d08: LOAD R2 = 0x0
ffa12d0a: LOAD R1 = 0x2
ffa12d0c: LOAD R1.H = 0x4012
ffa12d10: CALL (P1)
ffa12d12: JUMP.S 0xffa12cb8
ffa12d14: LOAD P1 = [P5 + 0x64]
ffa12d18: LOAD R0 = [P5 + 0x5c]
ffa12d1c: LOAD R2 = 0x0
ffa12d1e: LOAD R1 = 0x3
ffa12d20: LOAD R1.H = 0x4012
ffa12d24: CALL (P1)
ffa12d26: JUMP.S 0xffa12cb4
ffa12d28: LOAD P1 = [P5 + 0x64]
ffa12d2c: LOAD R0 = [P5 + 0x5c]
ffa12d30: LOAD R2 = 0x0
ffa12d32: LOAD R1 = 0x4
ffa12d34: LOAD R1.H = 0x4012
ffa12d38: CALL (P1)
ffa12d3a: JUMP.S 0xffa12cb0
ffa12d3c: LOAD R0 = W [P0 + 0x4] (X)
ffa12d3e: BITCLR (R0,0x1)
ffa12d40: STORE W [P0 + 0x4] = R0
ffa12d42: JUMP.S 0xffa12c96
ffa12d44: MOVE R0 = R7
ffa12d46: LOAD P1 = 0x54
ffa12d4a: ADD P1 = P5 + P1
ffa12d4c: STORE [SP + 0xc] = P1
ffa12d4e: CALL 0xffa12b54
ffa12d52: LOAD P1 = [P5 + 0x50]
ffa12d56: LOAD R1 = [P5 + 0x50]
ffa12d5a: JUMP.S 0xffa12c78
ffa12d5c: LOAD P1 = [P5]
ffa12d5e: LOAD R0 = W [P1 + 0x4] (X)
ffa12d60: BITCLR (R0,0x1)
ffa12d62: STORE W [P1 + 0x4] = R0
ffa12d64: JUMP.S 0xffa12c96
ffa12d68: LOAD P1 = 0x4c
ffa12d6c: ADD P1 = P5 + P1
ffa12d6e: LOAD R2 = 0x48
ffa12d72: ADD|| R2 = R7 + R2 (ns)
ffa12d76: _STORE [SP + 0xc] = P1
ffa12d78: _NOP
ffa12d7a: CALL 0xffa12b54
ffa12d7e: JUMP.S 0xffa12c46
ffa12d80: LINK 0x28
ffa12d84: PUSH [--SP] = (R7:6,P5:5)
ffa12d86: ADD SP += -0x14
ffa12d88: LOAD I0.L = 0x3d78
ffa12d8c: LOAD I0.H = 0xff80
ffa12d90: ROT|| R6 = rot R0 by 0
ffa12d94: _LOAD R1 = [I0++]
ffa12d96: _NOP
ffa12d98: MNOP||
ffa12d9c: _STORE [SP + 0x20] = R1
ffa12d9e: _LOAD R2 = [I0++]
ffa12da0: MOVE P1 = FP
ffa12da2: ADD P1 += -0x28
ffa12da4: MNOP||
ffa12da8: _STORE [P1 + 0x4] = R2
ffa12daa: _LOAD R0 = [I0++]
ffa12dac: MNOP||
ffa12db0: _STORE [P1 + 0x8] = R0
ffa12db2: _LOAD R0 = [I0++]
ffa12db4: MNOP||
ffa12db8: _STORE [P1 + 0xc] = R0
ffa12dba: _LOAD R0 = [I0++]
ffa12dbc: MNOP||
ffa12dc0: _STORE [P1 + 0x10] = R0
ffa12dc2: _LOAD R1 = [I0++]
ffa12dc4: MOVE P5 = R6
ffa12dc6: MNOP||
ffa12dca: _STORE [P1 + 0x14] = R1
ffa12dcc: _LOAD R0 = [I0++]
ffa12dce: MNOP||
ffa12dd2: _STORE [P1 + 0x18] = R0
ffa12dd4: _LOAD R1 = [I0++]
ffa12dd6: MNOP||
ffa12dda: _STORE [P1 + 0x1c] = R1
ffa12ddc: _LOAD R0 = [I0++]
ffa12dde: MNOP||
ffa12de2: _STORE [P1 + 0x20] = R0
ffa12de4: _LOAD R1 = [I0]
ffa12de6: STORE [P1 + 0x24] = R1
ffa12de8: LOAD R0 = [P5 + 0x34]
ffa12dea: CALL 0xffa0acc0
ffa12dee: MOVE R7 = R0
ffa12df0: CC = R7 == 0x0
ffa12df2: IF CC JUMP 0xffa12e08
ffa12df4: ADD SP += 0x14
ffa12df6: LOAD P0 = [FP + 0x4]
ffa12df8: POP (R7:6,P5:5) = [SP++]
ffa12dfa: UNLINK
ffa12dfe: LOAD R0 = 0x1
