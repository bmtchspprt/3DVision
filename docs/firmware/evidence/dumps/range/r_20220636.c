
/* WARNING: Control flow encountered unimplemented instructions */

undefined4
FUN_20220636(int *param_1,int param_2,int param_3,undefined4 param_4,int *param_5,int param_6,
            int param_7)

{
  short sVar1;
  char cVar2;
  undefined1 uVar3;
  int iVar4;
  undefined4 uVar5;
  uint uVar6;
  undefined4 uVar7;
  uint uVar8;
  short sVar9;
  int iVar10;
  int iVar11;
  int iVar12;
  int *piVar13;
  undefined4 *puVar14;
  short *psVar15;
  short *psVar16;
  bool bVar17;
  
  if (DAT_2021ea60 != '\0') {
    DAT_2021ea70 = 0;
    psVar15 = (short *)(param_3 + 0x34a54);
    if (0 < *psVar15) {
      iVar4 = FUN_202b5024(0,param_2,param_3);
      DAT_2021ea70 = (short)iVar4;
      DAT_2021ea72 = (short)((uint)iVar4 >> 0x10);
      if (iVar4 < *psVar15) {
        DAT_2021ea68 = 0;
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
    }
    DAT_2021ea60 = '\0';
  }
  iVar4 = DAT_2021ea64;
  DAT_2021ea78 = 0;
  if (param_6 == 7) {
    DAT_2021ea88 = 0xa3570a3;
    DAT_2021ea84 = *(int *)(param_2 + 0x68);
  }
  else if ((param_6 == 5) || (param_6 == 4)) {
    iVar12 = *(int *)(param_7 + 8) - *(int *)(param_2 + 0x18);
    iVar4 = *(int *)(param_7 + 0xc) - *(int *)(param_2 + 0x18);
    DAT_2021ea88 = iVar12 * (uint)(iVar12 < 0xa3570a3) + (uint)(iVar12 >= 0xa3570a3) * 0xa3570a3;
    DAT_2021ea84 = iVar4 * (uint)(0 < iVar4);
  }
  else {
    piVar13 = &DAT_2021ea64;
    iVar12 = FUN_ffa00fb4(DAT_2021ea64,3);
    if (((((iVar4 == iVar12 * 3) || (*(char *)(param_3 + 0x520) != '\0')) ||
         (iVar12 = (int)*(short *)(param_3 + 0x34c0c), iVar12 == 0)) ||
        (*(char *)(param_3 + 0x522) != '\0')) ||
       ((*(char *)(*(int *)(DAT_ff804840 + 0xbc) + 0x22) == '\x01' &&
        ((iVar11 = *(int *)(*(int *)(DAT_ff804840 + 8) + 0x3c), iVar11 == 0x100 || (iVar11 == 0x200)
         ))))) {
      *piVar13 = iVar4 + 1;
      piVar13[9] = *(int *)(param_2 + 0xc);
      *(undefined2 *)(piVar13 + 0xc) = 1;
      DAT_2021ea84 = *(int *)(param_2 + 0x14);
    }
    else {
      iVar11 = 0;
      DAT_2021ea84 = 0xa3d70a3;
      DAT_2021ea88 = 0;
      DAT_2021ea94 = 0;
      DAT_2021ea68 = 0;
      if (0 < iVar12) {
        piVar13 = (int *)(param_3 + 0x34c14);
        iVar10 = *piVar13;
        DAT_2021ea84 = (uint)(0xa3d70a3 < iVar10) * 0xa3d70a3 + iVar10 * (uint)(0xa3d70a3 >= iVar10)
        ;
        do {
          iVar12 = iVar12 + -1;
          if (iVar12 == 0) break;
          piVar13 = piVar13 + 6;
          iVar11 = iVar11 * (uint)(iVar10 < iVar11) + iVar10 * (uint)(iVar10 >= iVar11);
          iVar10 = *piVar13;
          DAT_2021ea84 = DAT_2021ea84 * (uint)(DAT_2021ea84 < iVar10) +
                         iVar10 * (uint)(DAT_2021ea84 >= iVar10);
        } while (iVar12 != 0);
        DAT_2021ea88 = iVar11 * (uint)(iVar10 < iVar11) + iVar10 * (uint)(iVar10 >= iVar11);
      }
      iVar12 = (int)(short)param_5[0x1d11];
      if (0 < iVar12) {
        iVar11 = *param_5;
        DAT_2021ea84 = DAT_2021ea84 * (uint)(DAT_2021ea84 < iVar11) +
                       iVar11 * (uint)(DAT_2021ea84 >= iVar11);
        piVar13 = param_5;
        do {
          iVar12 = iVar12 + -1;
          if (iVar12 == 0) break;
          piVar13 = piVar13 + 3;
          DAT_2021ea88 = DAT_2021ea88 * (uint)(iVar11 < DAT_2021ea88) +
                         iVar11 * (uint)(iVar11 >= DAT_2021ea88);
          iVar11 = *piVar13;
          DAT_2021ea84 = DAT_2021ea84 * (uint)(DAT_2021ea84 < iVar11) +
                         iVar11 * (uint)(DAT_2021ea84 >= iVar11);
        } while (iVar12 != 0);
        DAT_2021ea88 = DAT_2021ea88 * (uint)(iVar11 < DAT_2021ea88) +
                       iVar11 * (uint)(iVar11 >= DAT_2021ea88);
        DAT_2021ea68 = (short)param_5[0x1d11];
      }
      iVar11 = DAT_2021ea88 + 0x20c49b;
      iVar10 = DAT_2021ea84 + -0x20c49b;
      iVar12 = *(int *)(param_2 + 0x68);
      DAT_2021ea84 = iVar10 * (uint)(iVar12 < iVar10) + iVar12 * (uint)(iVar12 >= iVar10);
      DAT_2021ea88 = iVar11 * (uint)(iVar11 < 0xa3570a3) + (uint)(iVar11 >= 0xa3570a3) * 0xa3570a3;
      DAT_2021ea64 = iVar4 + 1;
    }
  }
  uVar5 = 0;
  if (DAT_2021ea84 < DAT_2021ea88) {
    DAT_2021ea98 = 1;
    if (param_6 == 7) {
      DAT_2021ea98 = 0;
    }
    else if (param_6 == 5) {
      DAT_2021ea98 = (uint)(*(char *)(*(int *)(DAT_ff804840 + 0xe8) + 4) == '\0');
    }
    uVar6 = DAT_2021ea98;
    if (DAT_2021ea98 != 0) {
      iVar12 = DAT_ff8000ec * 2;
      DAT_ff8000e8 = DAT_ff8000ec * 8 * DAT_ff8000f0;
      piVar13 = &DAT_ff8000e4;
      DAT_ff8000ec = 0;
      DAT_ff806ed4 = iVar12;
      iVar4 = FUN_ffa00fb4(DAT_ff8000e8,iVar12);
      *piVar13 = iVar12 + iVar4 * iVar12;
      piVar13[3] = 0;
    }
    DAT_ff806edc = 1;
    if (((short)DAT_2021ea94 != 0) && (uVar6 != 0)) {
      *(undefined4 *)(param_3 + 0x4ec24) = 0;
      *(undefined4 *)(param_3 + 0x4ec28) = 0;
    }
    DAT_2021ea70 = 0;
    while( true ) {
      psVar15 = (short *)(param_3 + 0x34a54);
      if ((int)*psVar15 <= (int)DAT_2021ea70) break;
      DAT_ff806ed8 = 1;
      iVar4 = FUN_202b5024((int)DAT_2021ea70,param_2,param_3);
      DAT_2021ea70 = (short)iVar4;
      if (*psVar15 <= iVar4) break;
      if (DAT_2021ea98 != 0) {
        DAT_ff8000ec = DAT_ff8000ec + 1;
      }
      if ((param_6 == 5) || (param_6 == 4)) {
        if (DAT_2021ea70 < *psVar15) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
          halt_unimplemented();
        }
        if (*psVar15 <= DAT_2021ea70) break;
      }
      if (*(short *)(param_3 + 0x34c0a) < DAT_2021ea70) {
        DAT_2021ea70 = *(short *)(param_3 + 0x34c0a);
      }
      *(short *)(param_3 + 0x34c08) = DAT_2021ea70;
      FUN_20210be6(param_2,param_3);
      uVar5 = FUN_ffa05c38(DAT_2021ea84,param_2,param_3);
      DAT_2021ea72 = (short)uVar5;
      DAT_2021ea74 = (short)((uint)uVar5 >> 0x10);
      uVar5 = FUN_ffa05c38(DAT_2021ea88,param_2,param_3);
      DAT_2021ea74 = (short)uVar5;
      uRam2021ea76 = (undefined2)((uint)uVar5 >> 0x10);
      if (DAT_2021ea98 != 0) {
        iVar4 = ((int)DAT_2021ea74 - (int)DAT_2021ea72) + 1;
        DAT_ff8000f0 = DAT_ff8000f0 * (uint)(iVar4 < DAT_ff8000f0) +
                       iVar4 * (uint)(iVar4 >= DAT_ff8000f0);
      }
      DAT_2021ea68 = DAT_2021ea72;
      if (DAT_2021ea72 <= DAT_2021ea74) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
      if (*(short *)(param_3 + 0x34c0a) <= *(short *)(param_3 + 0x34c08)) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
      DAT_2021ea70 = DAT_2021ea70 + 1;
    }
    cVar2 = *(char *)(*(int *)(DAT_ff804840 + 0xf0) + 2);
    if ((cVar2 == '\x01') || (cVar2 == '\x02')) {
      *(undefined1 *)(*(int *)(DAT_ff804840 + 0xf0) + 1) = 0xfa;
      while ((**(char **)(DAT_ff804840 + 0xf0) == '\0' &&
             ((*(char **)(DAT_ff804840 + 0xf0))[2] != '\0'))) {
        FUN_ffa06008(10000,0,1);
      }
      **(undefined1 **)(DAT_ff804840 + 0xf0) = 0;
      *(undefined1 *)(*(int *)(DAT_ff804840 + 0xf0) + 1) = 0xff;
    }
    if (param_6 == 3) {
      if (*(int *)(*(int *)(DAT_ff804840 + 0xf0) + 0xc) < 3) {
        *(undefined1 *)(param_3 + 0x4fc72) = 0;
      }
      iVar12 = DAT_ff804840;
      *(int *)(*(int *)(DAT_ff804840 + 0xf0) + 0xc) =
           *(int *)(*(int *)(DAT_ff804840 + 0xf0) + 0xc) + 1;
      iVar4 = *(int *)(iVar12 + 0xd8);
      uVar5 = FUN_ffa01716(0x459c4000,*(undefined4 *)(param_3 + 0x624c));
      FUN_ffa01814(uVar5,0x461c4000);
      uVar3 = FUN_ffa014dc();
      *(undefined1 *)(iVar4 + 0x32) = uVar3;
      uVar5 = FUN_ffa01716(*(undefined4 *)(param_3 + 0x17940),0x459c4000);
      uVar5 = FUN_ffa01716(uVar5,*(undefined4 *)(param_3 + 0x1d63c));
      iVar4 = *(int *)(iVar12 + 0xd8);
      uVar5 = FUN_ffa01716(uVar5,*(undefined4 *)(param_3 + 0x23338));
      FUN_ffa01814(uVar5,0x46ea6000);
      uVar3 = FUN_ffa014dc();
      *(undefined1 *)(iVar4 + 0x33) = uVar3;
      cVar2 = *(char *)(*(int *)(iVar12 + 0xf0) + 2);
      if (((((cVar2 == '\x01') || (cVar2 == '\x02')) &&
           (3 < *(int *)(*(int *)(iVar12 + 0xf0) + 0xc))) && (*(char *)(param_3 + 0x4fc72) == '\0'))
         || (cVar2 == '\0')) {
        FUN_2021ffe4(param_2,param_3);
      }
    }
    psVar16 = (short *)(param_3 + 0x34c08);
    DAT_2021ea70 = 0;
    while ((int)DAT_2021ea70 < (int)psVar16[-0xda]) {
      iVar12 = FUN_202b5024((int)DAT_2021ea70,param_2,param_3);
      iVar4 = (int)psVar16[-0xda];
      DAT_2021ea70 = (short)iVar12;
      if (iVar4 <= iVar12) break;
      if ((param_6 == 5) || (param_6 == 4)) {
        if (DAT_2021ea70 < iVar4) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
          halt_unimplemented();
        }
        if (iVar4 <= DAT_2021ea70) break;
      }
      sVar1 = psVar16[1];
      if (sVar1 < DAT_2021ea70) {
        DAT_2021ea70 = sVar1;
      }
      sVar9 = DAT_2021ea70;
      bVar17 = sVar1 <= DAT_2021ea70;
      *psVar16 = DAT_2021ea70;
      if (bVar17) {
        DAT_2021ea6a._0_2_ = *(short *)(param_3 + 0x34c0a);
        if ((int)(short)DAT_2021ea6a < (int)*psVar15) {
          iVar4 = FUN_202b5024((int)(short)DAT_2021ea6a,param_2,param_3);
          DAT_2021ea6a._0_2_ = (short)iVar4;
          if (iVar4 < *psVar15) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
            halt_unimplemented();
          }
        }
        break;
      }
      if ((((short)DAT_2021ea94 != 0) || ((char)psVar16[-0x1a374] != '\0')) && (DAT_2021ea98 != 0))
      {
        uVar6 = FUN_20212bae(param_2,param_3,param_4,param_5);
        DAT_2021ea78 = uVar6 | DAT_2021ea78;
        sVar9 = DAT_2021ea70;
      }
      DAT_2021ea70 = sVar9 + 1;
    }
    if (param_6 == 6) {
      iVar4 = 9;
      piVar13 = param_5 + 0xb17a;
      do {
        *param_1 = *piVar13;
        if (iVar4 == 0) break;
        iVar4 = iVar4 + -1;
        param_1 = param_1 + 1;
        piVar13 = piVar13 + 1;
      } while (iVar4 != 0);
      DAT_2021ea6a._0_2_ = 9;
    }
    if (param_6 == 3) {
      FUN_2022f986(param_2,param_3,param_4,param_5);
      bVar17 = *(short *)(param_3 + 0x34c0c) < 1;
      DAT_2021ea8c = 0;
      DAT_2021ea90 = 0;
      DAT_2021ea68 = 0;
      if (!bVar17) {
                    /* WARNING: Unimplemented instruction - Truncating control flow here */
        halt_unimplemented();
      }
      puVar14 = &DAT_2021ea8c;
      iVar4 = param_2;
      FUN_ffa0165c(0x3f800000,0);
      uVar5 = 0x3f800000;
      if (bVar17) {
        uVar5 = 0;
      }
      uVar5 = FUN_ffa01814(*puVar14,uVar5);
      *puVar14 = uVar5;
      uVar7 = FUN_ffa01688(*(ushort *)(iVar4 + 6) - 1);
      uVar7 = FUN_ffa018f0(uVar7,*(undefined4 *)(param_3 + 0x4f0));
      uVar5 = FUN_ffa018f0(0x40000000,uVar5);
      uVar5 = FUN_ffa01716(uVar5,uVar7);
      *(undefined4 *)(param_3 + 0x4f0) = uVar5;
      uVar7 = FUN_ffa01688(*(ushort *)(param_2 + 6) + 1);
      uVar8 = FUN_ffa01814(uVar5,uVar7);
      uVar6 = uVar8 >> 0x1f;
      if (-0x800000 < (int)uVar8) {
        uVar6 = 0;
      }
      if (uVar8 == 0x80000000) {
        uVar6 = 0;
      }
      if (uVar6 == 1) {
        uVar8 = 0;
      }
      *(uint *)(param_3 + 0x4f0) = uVar8;
    }
    iVar12 = DAT_ff804840;
    uVar5 = FUN_ffa01716(0x459c4000,*(undefined4 *)(param_3 + 0x4fbb4));
    iVar4 = *(int *)(iVar12 + 0xd8);
    FUN_ffa01814(uVar5,0x461c4000);
    uVar3 = FUN_ffa014dc();
    *(undefined1 *)(iVar4 + 0x3d) = uVar3;
    *(char *)(*(int *)(iVar12 + 0xd8) + 0x3e) = (char)DAT_2021ea64;
    uVar5 = DAT_2021ea8c;
  }
  return uVar5;
}


