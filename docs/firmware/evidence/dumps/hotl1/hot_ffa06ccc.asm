ffa06ccc: ADD R0 = R0 + R1
ffa06cce: CC = R2 <= R0
ffa06cd0: LINK 0x0
ffa06cd4: IF !CC JUMP 0xffa06ce4
ffa06cd6: LOAD P1 = -0x1
ffa06cd8: LSETUP (0xffa06cdc,0xffa06ce0) LC0 = P1
ffa06cdc: SUB R0 = R0 - R2
ffa06cde: CC = R2 <= R0
ffa06ce0: IF !CC JUMP 0xffa06ce4
ffa06ce2: JUMP.S 0xffa06cd8
ffa06ce4: CC = R0 < 0x0
ffa06ce6: IF !CC JUMP 0xffa06cf6
ffa06ce8: LOAD P1 = -0x1
ffa06cea: LSETUP (0xffa06cee,0xffa06cf2) LC0 = P1
ffa06cee: ADD R0 = R2 + R0
ffa06cf0: CC = R0 < 0x0
ffa06cf2: IF !CC JUMP 0xffa06cf6
ffa06cf4: JUMP.S 0xffa06cea
ffa06cf6: UNLINK
ffa06cfa: RTS
