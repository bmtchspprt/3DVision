/* FUN_2020caa4 @ 2020caa4 */

/* WARNING: Restarted to delay deadcode elimination for space: ram */

undefined4 FUN_2020caa4(uint param_1,int param_2)

{
  char cVar1;
  undefined1 *puVar2;
  undefined4 uVar3;
  int iVar4;
  byte bVar5;
  int iVar6;
  int iStack_30;
  
  puRam2020c844 = *(undefined4 **)(param_2 + 8);
  puRam2020c854 = *(undefined4 **)(param_2 + 0x38);
  iRam2020c848 = *(int *)(param_2 + 0x14);
  uRam2020c84c = *(undefined4 *)(param_2 + 0x20);
  puRam2020c850 = *(undefined1 **)(param_2 + 0x2c);
  uRam2020c858 = *(undefined4 *)(param_2 + 0x44);
  pcRam2020c85c = *(char **)(param_2 + 0x50);
  iRam2020c878 = *(int *)(param_2 + 0xa4);
  iRam2020c860 = *(int *)(param_2 + 0x5c);
  iRam2020c864 = *(int *)(param_2 + 0x68);
  iRam2020c868 = *(int *)(param_2 + 0x74);
  uRam2020c898 = *(undefined1 *)(iRam2020c860 + 8);
  piRam2020c86c = *(int **)(param_2 + 0x80);
  uRam2020c870 = *(undefined4 *)(param_2 + 0x8c);
  uRam2020c874 = *(undefined4 *)(param_2 + 0x98);
  piRam2020c880 = *(int **)(param_2 + 0xd8);
  iRam2020c888 = *(int *)(param_2 + 0xdc);
  cVar1 = *(char *)((int)puRam2020c844 + 0x37);
  cRam2020c89a = *(char *)(puRam2020c844 + 0xe);
  puRam2020c89c = (undefined4 *)(puRam2020c850 + 4);
  uRam2020c87c = *(undefined4 *)(param_2 + 0xb0);
  iRam2020c884 = *(int *)(param_2 + 0xe0);
  iRam2020c8a0 = piRam2020c880[1];
  uRam2020c984 = 0x2020c9ec;
  uRam2020c988 = 0x2020ca04;
  uRam2020c890 = *(undefined4 *)(param_2 + 0xec);
  puRam2020c980 = (undefined1 *)0x2020c9d4;
  pcRam2020c894 = *(char **)(param_2 + 0xe8);
  pcRam2020c97c = &bRam2020c9bc;
  bVar5 = (byte)param_1;
  iStack_30 = -0x7fdd68;
  iRam2020c88c = iRam2020c884;
  cRam2020c899 = cVar1;
  bRam2020c978 = bVar5;
  switch(param_1) {
  case 0:
    iVar6 = param_2;
    bRam2020c979 = bVar5;
    if (iRam2020c8a0 == 100000) {
      uRam2020c8a4 = *puRam2020c89c;
    }
    else {
      uVar3 = (*(code *)0xffa05ee4)(iRam2020c8a0);
      uRam2020c8a4 = func_0x202ffa74(uVar3,*puRam2020c89c);
    }
    if (bRamff800050 == 1) {
      bRamff800050 = bVar5;
      puRam2020c850[1] = 1;
      bRam2020c836 = bVar5;
    }
    if (*(int *)(*(int *)(iVar6 + 8) + 0x3c) == 0x10) {
      if ((cRam2020c899 == '\x02') || (cRam2020c899 == '\x03')) {
        cRam2020c899 = '\x01';
        *(undefined1 *)((int)puRam2020c844 + 0x37) = 1;
      }
      if (cRam2020c899 == '\x05') {
        cRam2020c899 = '\x04';
        *(undefined1 *)((int)puRam2020c844 + 0x37) = 4;
      }
    }
    if ((*pcRam2020c894 == '\x01') && (pcRam2020c894[1] == '\0')) {
      func_0x202b4b54(pcRam2020c97c,0xff802378);
    }
    else {
      (*(code *)&SUB_ffa05f92)(pcRam2020c97c,0xff802390,0x18);
      (*(code *)&SUB_ffa05f92)(pcRam2020c97c,(int)puRam2020c844 + 0xf,0x10);
      puVar2 = puRam2020c980;
      iVar4 = (byte)puRam2020c850[1] - 1;
      switch(iVar4) {
      case 0:
        if ((bRam2020c836 == 0) || (*(uint *)(*(int *)(iVar6 + 8) + 0x3c) < 0x21)) {
          cRam2020c990 = func_0x2020c53c(*piRam2020c880,puRam2020c980,1,0,uRam2020c898,cRam2020c899)
          ;
          func_0x202b4ffa(puRam2020c980,0xff802248);
        }
        else if (bRam2020c836 == 1) {
          cRam2020c990 = func_0x2020c53c(*(undefined4 *)(*(int *)(iVar6 + 0x100) + 0x7450),
                                         puRam2020c980,1,0,uRam2020c898,cRam2020c899);
          func_0x202b4ffa(puRam2020c980,0xff802254);
        }
        else {
          cRam2020c990 = func_0x2020c53c(*(undefined4 *)(*(int *)(iVar6 + 0x100) + 0x7454),
                                         puRam2020c980,1,0,uRam2020c898,cRam2020c899);
          func_0x202b4ffa(puRam2020c980,0xff802260);
        }
        break;
      case 1:
        if ((bRam2020c837 == 0) || (*(uint *)(*(int *)(iVar6 + 8) + 0x3c) < 0x21)) {
          cRam2020c990 = func_0x2020c53c(piRam2020c86c[2] - *piRam2020c880,puRam2020c980,iVar4,0,
                                         uRam2020c898,cRam2020c899);
          func_0x202b4ffa(puRam2020c980,0xff80226c);
        }
        else if (bRam2020c837 == 1) {
          cRam2020c990 = func_0x2020c53c(piRam2020c86c[2] -
                                         *(int *)(*(int *)(iVar6 + 0x100) + 0x7454),puRam2020c980,
                                         iVar4,0,uRam2020c898,cRam2020c899);
          func_0x202b4ffa(puRam2020c980,0xff802278);
        }
        else {
          cRam2020c990 = func_0x2020c53c(piRam2020c86c[2] -
                                         *(int *)(*(int *)(iVar6 + 0x100) + 0x7450),puRam2020c980,
                                         iVar4,0,uRam2020c898,cRam2020c899);
          func_0x202b4ffa(pcRam2020c97c,0xff802284);
        }
        break;
      case 2:
        if (**(char **)(iVar6 + 0x2c) == '\x05') {
          *puRam2020c980 = 0x2d;
          puRam2020c980[1] = 0x2d;
          puRam2020c980[2] = bVar5;
        }
        else {
          func_0x2020c66a(piRam2020c880[1],6,*(undefined1 *)(iRam2020c860 + 8),puRam2020c980);
        }
        func_0x202b4ffa(puRam2020c980,0xff802290);
        break;
      case 3:
        if (*(int *)(*(int *)(iVar6 + 0x2c) + 8) == 0) {
          *puRam2020c980 = 0x2d;
          puRam2020c980[1] = 0x2d;
          puRam2020c980[2] = bVar5;
        }
        else {
          func_0x2020063a(param_2);
          uRam2020c8a8 = (*(code *)0xffa01520)();
          func_0x2020c0c6(uRam2020c8a8,puRam2020c980,1);
          cRam2020c990 = func_0x202b4ad6(puRam2020c980,0xb);
          if (uRam2020c8a8 < (param_1 | 0x100000)) {
            func_0x202b4ffa(puRam2020c980,0xff8022c4);
            cRam2020c990 = cRam2020c990 + '\x02';
          }
          uVar3 = func_0x20200742(param_2);
          func_0x202b4ffa(puRam2020c980,uVar3);
        }
        func_0x202b4ffa(puRam2020c980,0xff8022c8);
        break;
      case 4:
        cRam2020c990 = func_0x2020c3f6(piRam2020c880[4],puRam2020c980,0,2,0x2e,0xff802298,0);
        func_0x202b4ffa(puRam2020c980,0xff80229c);
        break;
      case 5:
        if (*(char *)(puRam2020c844 + 0xe) == '\x01') {
          cRam2020c990 = func_0x2020c3f6(piRam2020c880[3],puRam2020c980,0,1,0x2e,0xff8022b4,0);
        }
        else {
          uVar3 = (*(code *)0xffa01688)(piRam2020c880[3]);
          uVar3 = (*(code *)&SUB_ffa018f0)(uVar3,0x3fe66666);
          (*(code *)0xffa01716)(uVar3,0x46fa0000);
          uVar3 = (*(code *)&SUB_ffa014dc)();
          cRam2020c990 = func_0x2020c3f6(uVar3,puVar2,0,1,0x2e,iStack_30 + 0x20,0);
        }
        func_0x202b4ffa(puRam2020c980,0xff8022bc);
        break;
      case 6:
        (*(code *)&SUB_ffa018f0)(piRam2020c880[5],0x447a0000);
        uVar3 = (*(code *)&SUB_ffa014dc)();
        cRam2020c990 = func_0x2020c3f6(uVar3,puRam2020c980,0,1,0x2e,0xff8022a8,0);
        func_0x202b4ffa(puRam2020c980,iStack_30 + 0x14);
      }
      func_0x2020c6c0(uRam2020c984,*piRam2020c880,*(undefined4 *)(iRam2020c848 + 0xc),
                      *(undefined4 *)(iRam2020c848 + 8),piRam2020c86c[2],puRam2020c850[1],
                      *puRam2020c850,uRam2020c87c);
    }
    break;
  case 1:
    bRam2020c979 = 0;
    bRam2020c9bc = *(char *)(*(int *)(param_2 + 0x2c) + 1) - 1;
    break;
  case 2:
    bRam2020c979 = 0;
    bRam2020c9bc = bRam2020c836;
    break;
  case 3:
    bRam2020c979 = 0;
    bRam2020c9bc = bRam2020c837;
    break;
  case 4:
    bRam2020c979 = 0;
    bRam2020c9bc = bRam2020c838;
    break;
  case 5:
    bRam2020c979 = 0;
    cRam2020c990 = func_0x2020c53c(*puRam2020c854,&bRam2020c9bc,1,0,uRam2020c898,cVar1);
    break;
  case 6:
    bRam2020c979 = 0;
    break;
  case 7:
    bRam2020c979 = 0;
    break;
  case 8:
    bRam2020c979 = 0;
    break;
  case 9:
    bRam2020c979 = 1;
    cRam2020c990 = func_0x2020c146(*(undefined1 *)((int)puRam2020c844 + 0xd),&bRam2020c9bc,2);
    break;
  case 10:
    bRam2020c979 = 0;
    bRam2020c9bc = *pcRam2020c85c - 1;
    if (*pcRam2020c85c == '\0') {
      bRam2020c9bc = 0;
    }
    break;
  case 0xb:
    bRam2020c979 = 1;
    cRam2020c990 = func_0x2020c3f6(*(undefined4 *)(iRam2020c884 + 4),&bRam2020c9bc,2,2,0x2e,
                                   0xff802298,0);
    break;
  case 0xc:
    bRam2020c979 = 1;
    cRam2020c990 = func_0x2020c3f6(*(undefined4 *)(pcRam2020c85c + 4),&bRam2020c9bc,2,2,0x2e,
                                   0xff802298,0);
    break;
  case 0xd:
    bRam2020c979 = 1;
    (*(code *)&SUB_ffa05f92)(&bRam2020c9bc,(int)puRam2020c844 + 0xf,0x10);
    pcRam2020c97c[0x10] = 0;
    if (*pcRam2020c97c == 10) {
      func_0x2020c146(*(undefined1 *)((int)puRam2020c844 + 0xd),puRam2020c980,2);
      func_0x202b4b54(pcRam2020c97c,0xff8022d0);
      (*(code *)&SUB_ffa05f92)(pcRam2020c97c + 5,puRam2020c980,4);
      (*(code *)&SUB_ffa05f92)((int)puRam2020c844 + 0xf,pcRam2020c97c,0x10);
    }
    cRam2020c990 = '\x10';
    break;
  case 0xe:
    bRam2020c979 = 0;
    bRam2020c9bc = *(byte *)(iRam2020c864 + 4);
    if ((bRam2020c9bc < 3) && (bRam2020c9bc != 0)) {
      bRam2020c9bc = bRam2020c9bc - 1;
    }
    else {
      bRam2020c9bc = 0;
    }
    break;
  case 0xf:
    bRam2020c979 = 0;
    bRam2020c9bc = 0;
    break;
  case 0x10:
    bRam2020c979 = 0;
    func_0x2020c0c6(0x62fcc,0x2020c8ac,7);
    func_0x2020c088(0x2020c8ac);
    func_0x202b4b54(pcRam2020c97c,0x2020c8ac);
    func_0x2020bf96(*(undefined1 *)(puRam2020c844 + 3),puRam2020c980);
    func_0x2020c0c6(0,0x2020c8ac,7);
    func_0x202b4b54(uRam2020c984,0x2020c8ac);
    break;
  case 0x11:
    func_0x202b4b54(&bRam2020c9bc,iRam2020c888 + 6);
    func_0x2020c0c6(*puRam2020c844,puRam2020c980,9);
    break;
  case 0x12:
    bRam2020c979 = 0;
    bRam2020c9bc = cVar1 - 1;
    if (2 < bRam2020c9bc) {
      bRam2020c9bc = cVar1 - 2;
    }
    break;
  case 0x13:
    if (puRam2020c844[0xf] == 0x10) {
      param_1 = 0x14;
    }
    bRam2020c979 = 0;
    bRam2020c9bc = 0;
    bRam2020c978 = (byte)param_1;
    break;
  case 0x14:
    bRam2020c979 = 0;
    bRam2020c9bc = 0;
    break;
  case 0x15:
    bRam2020c979 = 0;
    break;
  case 0x16:
    bRam2020c979 = 0;
    break;
  case 0x17:
    bRam2020c979 = 1;
    break;
  case 0x19:
    bRam2020c979 = 0;
    break;
  case 0x1a:
    bRam2020c979 = 1;
    func_0x202b4b54(&bRam2020c9bc,0xff8022d8);
    cRam2020c990 = '\x03';
    break;
  case 0x1b:
    break;
  case 0x1c:
    break;
  case 0x1d:
    bRam2020c979 = 1;
    cRam2020c990 = '\x03';
    func_0x2020bf96(*(undefined1 *)(puRam2020c844 + 3),&bRam2020c9bc);
    break;
  case 0x1e:
    bRam2020c979 = 0;
    func_0x2020c0c6(*puRam2020c844,&bRam2020c9bc,9);
    func_0x2020bf96(*(undefined1 *)(puRam2020c844 + 3),puRam2020c980);
    break;
  case 0x1f:
    bRam2020c979 = 0;
    if (((cVar1 == '\x01') || (cVar1 == '\x02')) || (cVar1 == '\x03')) {
      bRam2020c9bc = 0;
    }
    else {
      bRam2020c9bc = 1;
    }
    break;
  case 0x20:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 2;
    if (cVar1 == '\x04') {
      uRam2020c898 = 3;
      cRam2020c899 = '\x04';
    }
    cRam2020c990 = func_0x2020c53c(*(undefined4 *)(iRam2020c878 + 0x10),&bRam2020c9bc,1,0,
                                   uRam2020c898,cRam2020c899);
    break;
  case 0x21:
    bRam2020c979 = 0;
    bRam2020c9bc = *(char *)(iRam2020c878 + 1) - 1;
    break;
  case 0x22:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 3;
    if (cVar1 == '\x04') {
      cRam2020c899 = '\x04';
      uRam2020c898 = 4;
    }
    cRam2020c990 = func_0x2020c53c(*(undefined4 *)(iRam2020c878 + 0x14),&bRam2020c9bc,0,0,
                                   uRam2020c898,cRam2020c899);
    break;
  case 0x23:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 3;
    if (cVar1 == '\x04') {
      cRam2020c899 = '\x04';
      uRam2020c898 = 4;
    }
    cRam2020c990 = func_0x2020c53c(*(undefined4 *)(iRam2020c878 + 0x18),&bRam2020c9bc,0,0,
                                   uRam2020c898,cRam2020c899);
    break;
  case 0x24:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 2;
    if (cVar1 == '\x04') {
      uRam2020c898 = 3;
      cRam2020c899 = '\x04';
    }
    cRam2020c990 = func_0x2020c53c(piRam2020c86c[2],&bRam2020c9bc,1,0,uRam2020c898,cRam2020c899);
    break;
  case 0x25:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 3;
    if (cVar1 == '\x04') {
      cRam2020c899 = '\x04';
      uRam2020c898 = 4;
    }
    cRam2020c990 = func_0x2020c53c(*piRam2020c86c,&bRam2020c9bc,0,1,uRam2020c898,cRam2020c899);
    cRam2020c990 = cRam2020c990 + '\x01';
    break;
  case 0x26:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 3;
    if (cVar1 == '\x04') {
      cRam2020c899 = '\x04';
      uRam2020c898 = 4;
    }
    cRam2020c990 = func_0x2020c53c(piRam2020c86c[1],&bRam2020c9bc,0,1,uRam2020c898,cRam2020c899);
    cRam2020c990 = cRam2020c990 + '\x01';
    break;
  case 0x27:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 2;
    if (cVar1 == '\x04') {
      uRam2020c898 = 3;
      cRam2020c899 = '\x04';
    }
    cRam2020c990 = func_0x2020c53c(*(undefined4 *)(iRam2020c878 + 0x14),&bRam2020c9bc,1,0,
                                   uRam2020c898,cRam2020c899);
    break;
  case 0x28:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 2;
    if (cVar1 == '\x04') {
      uRam2020c898 = 3;
      cRam2020c899 = '\x04';
    }
    cRam2020c990 = func_0x2020c53c(piRam2020c86c[2],&bRam2020c9bc,1,0,uRam2020c898,cRam2020c899);
    break;
  case 0x29:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 2;
    if (cVar1 == '\x04') {
      uRam2020c898 = 3;
      cRam2020c899 = '\x04';
    }
    iVar6 = *piRam2020c86c;
    iVar4 = -iVar6;
    cRam2020c990 = func_0x2020c53c(iVar4 * (uint)(iVar6 < iVar4) + iVar6 * (uint)(iVar6 >= iVar4),
                                   &bRam2020c9bc,1,0,uRam2020c898,cRam2020c899);
    break;
  case 0x2a:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 2;
    if (cVar1 == '\x04') {
      uRam2020c898 = 3;
      cRam2020c899 = '\x04';
    }
    cRam2020c990 = func_0x2020c53c(*(undefined4 *)(iRam2020c848 + 0xc),&bRam2020c9bc,1,0,
                                   uRam2020c898,cRam2020c899);
    break;
  case 0x2b:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 2;
    if (cVar1 == '\x04') {
      uRam2020c898 = 3;
      cRam2020c899 = '\x04';
    }
    cRam2020c990 = func_0x2020c53c(*(undefined4 *)(iRam2020c848 + 8),&bRam2020c9bc,1,0,uRam2020c898,
                                   cRam2020c899);
    break;
  case 0x2c:
    bRam2020c979 = 1;
    cRam2020c990 = func_0x2020c146(*(undefined1 *)(iRam2020c868 + 0x42),&bRam2020c9bc,2);
    break;
  case 0x2d:
    bRam2020c979 = 0;
    bVar5 = *(byte *)(iRam2020c848 + 0x10);
    if (bVar5 < 2) {
      if (bVar5 == 1) {
        bRam2020c9bc = 1;
        break;
      }
    }
    else {
      if (bVar5 == 2) {
        bRam2020c9bc = 0;
        break;
      }
      if (bVar5 == 3) {
        bRam2020c9bc = 2;
        break;
      }
    }
    bRam2020c9bc = 1;
    break;
  case 0x2e:
    bRam2020c979 = 0;
    bRam2020c9bc = cRam2020c89a - 1;
    if (1 < bRam2020c9bc) {
      bRam2020c9bc = 1;
    }
    break;
  case 0x2f:
    bRam2020c979 = 0;
    bRam2020c9bc = 0;
    break;
  case 0x30:
    bRam2020c979 = 0;
    bRam2020c9bc = 0;
    break;
  case 0x31:
    bRam2020c979 = 0;
    break;
  case 0x32:
    bRam2020c979 = 1;
    cRam2020c899 = '\x01';
    uRam2020c898 = 2;
    if (cVar1 == '\x04') {
      uRam2020c898 = 3;
      cRam2020c899 = '\x04';
    }
    cRam2020c990 = func_0x2020c53c(0,&bRam2020c9bc,1,0,uRam2020c898,cRam2020c899);
    break;
  case 0x33:
    bRam2020c979 = 0;
    bRam2020c9bc = 0;
    break;
  case 0x34:
    bRam2020c979 = 0;
    break;
  case 0x36:
    func_0x20236986();
    return 0;
  }
  uVar3 = func_0x20236b20(0x2020c944);
  return uVar3;
}


