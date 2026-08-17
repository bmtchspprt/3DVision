/* FUN_20204630 @ 20204630 */

void FUN_20204630(int param_1,int param_2)

{
  undefined4 uVar1;
  undefined4 unaff_R4;
  int iVar2;
  int in_P3;
  int iVar3;
  int *unaff_P5;
  int unaff_FP;
  char cVar4;
  
  do {
    (*(code *)0xffa05f2e)(param_2 + param_1 + 0x5a26,0,0x28e);
    while( true ) {
      (*(code *)0xffa06008)(1,0,1);
      *(int *)(unaff_FP + -4) = *(int *)(unaff_FP + -4) + 1;
      if ((int)*(short *)(*(int *)(*(int *)(unaff_FP + 8) + 0xf8) + in_P3) <=
          *(int *)(unaff_FP + -4)) {
        return;
      }
      cVar4 = *unaff_P5 + 0x292U < 0x100000;
      if (!(bool)cVar4) {
        return;
      }
      uVar1 = (*(code *)0xffa06a04)(*unaff_P5,0x292,*(undefined4 *)(unaff_FP + -0x10));
      *(undefined4 *)(unaff_FP + -8) = uVar1;
      (*(code *)0xffa06008)(10000,0,1);
      *unaff_P5 = *unaff_P5 + 0x292;
      (*(code *)&SUB_ffa05f92)
                (*(int *)(*(int *)(unaff_FP + 8) + 0xf8) + *(int *)(unaff_FP + -4) * 0x5cfc + 0x6270
                 ,*(undefined4 *)(unaff_FP + -0x10),4);
      *(undefined4 *)(unaff_FP + -0x18) = 0x202046ac;
      (*(code *)&SUB_ffa05f92)(unaff_FP + 0xc,*(undefined4 *)(unaff_FP + -0x18),2);
      uVar1 = (*(code *)0xffa01688)((int)*(short *)(unaff_FP + 0xc));
      *(undefined4 *)(unaff_FP + -0x14) = uVar1;
      *(undefined4 *)(unaff_FP + -0xc) = uVar1;
      iVar3 = *(int *)(unaff_FP + 8);
      iVar2 = *(int *)(unaff_FP + -4) * 0x5cfc;
      uVar1 = (*(code *)&SUB_ffa01814)
                        (*(undefined4 *)(*(int *)(iVar3 + 0xf8) + iVar2 + 0x6270),0x47000000);
      uVar1 = (*(code *)&SUB_ffa018f0)(uVar1,*(undefined4 *)(unaff_FP + -0x14));
      *(undefined4 *)(unaff_FP + -0x14) = uVar1;
      *(undefined4 *)(unaff_FP + -0xc) = uVar1;
      (*(code *)0xffa0165c)(uVar1,0x44898000);
      cVar4 = cVar4 == '\0';
      if (((bool)cVar4) ||
         ((*(code *)0xffa0165c)(0x44610000,*(undefined4 *)(unaff_FP + -0x14)), cVar4 == '\0')) {
        *(undefined4 *)(*(int *)(iVar3 + 0xf8) + iVar2 + 0x6270) = unaff_R4;
      }
      else {
        uVar1 = (*(code *)&SUB_ffa01814)(0x447a0000,*(undefined4 *)(unaff_FP + -0x14));
        iVar2 = *(int *)(iVar3 + 0xf8) + 0x578 + iVar2;
        uVar1 = (*(code *)&SUB_ffa018f0)(uVar1,*(undefined4 *)(iVar2 + 0x5cf8));
        *(undefined4 *)(iVar2 + 0x5cf8) = uVar1;
      }
      (*(code *)&SUB_ffa05f92)(unaff_FP + 0x10,*(undefined4 *)(unaff_FP + -0x10),4);
      cVar4 = *(int *)(unaff_FP + 0x10) == -1;
      if ((bool)cVar4) break;
      iVar3 = *(int *)(unaff_FP + 8);
      iVar2 = *(int *)(unaff_FP + -4) * 0x5cfc;
      (*(code *)0xffa01630)(0,*(undefined4 *)(*(int *)(iVar3 + 0xf8) + iVar2 + 0x6270));
      if (cVar4 != '\0') break;
      (*(code *)&SUB_ffa05f92)
                (*(int *)(iVar3 + 0xf8) + iVar2 + 0x5f9e,*(undefined4 *)(unaff_FP + -0x18),0x28e);
    }
    *(undefined4 *)
     (*(int *)(*(int *)(unaff_FP + 8) + 0xf8) + *(int *)(unaff_FP + -4) * 0x5cfc + 0x6270) =
         0x3f800000;
    param_2 = *(int *)(*(int *)(unaff_FP + 8) + 0xf8) + 0x578;
    param_1 = *(int *)(unaff_FP + -4) * 0x5cfc;
  } while( true );
}


