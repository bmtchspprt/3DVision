/* LocatorPlacement.ErrorEstimationCal
 * Port of ErrorEstimationCal.cs — CalculateErrorEstimation + helpers (fast path via LocatorAlgo).
 * Requires: LocatorPlacement.ErrorEstimationCalculation, geometry DeviceCalc/AlgoCalc,
 *           LocatorAlgo.AlgoErrorEstimation.CalcErrorEstimationFast, LocatorAlgo.Balls (or plain balls).
 */
(function (root) {
  'use strict';
  var NS = root.LocatorPlacement = root.LocatorPlacement || {};
  var EEC = null;
  var LA = null;

  function Balls(x, y, r) {
    if (LA && LA.Balls) {
      return new LA.Balls(x, y, r);
    }
    return { x: x, y: y, r: r, xOffset: 0, yOffset: 0, isGoodBal: false, numTouchBalls: 0, angleAuxliary: 0 };
  }

  function cloneDevicePoint(dp, unitsCoef) {
    return {
      X: dp.X / unitsCoef,
      Y: dp.Y / unitsCoef,
      Z: dp.Z / unitsCoef,
      ScannerZOffsetFromVesselTop: (dp.ScannerZOffsetFromVesselTop || 0) / unitsCoef,
      maxZ: (dp.maxZ || 0) / unitsCoef,
      minZ: (dp.minZ || 0) / unitsCoef
    };
  }

  function ErrorEstimationCal() {
    this.deviceInWork = null;
    this.fuzzyManager = null;
    this.vessel = null;
    this.listScannerLocationBalls = null;
    this.searchRadiusList = [];
    this.searchRadiusListAllFillingPoints = null;
    this.matrizSize = (NS.DEFAULTS && NS.DEFAULTS.BallsMatix) || 111;
    this.numberOfBadBallsAccurate = (NS.DEFAULTS && NS.DEFAULTS.NumberOfBadBallsAccurate) || 50;
    this.numRanges = (NS.DEFAULTS && NS.DEFAULTS.NumRanges) || 10;
    this.totalVesselWidthX = 0;
    this.totalVesselWidthY = 0;
    this.unitsCoef = 1.0;
    this.materialAngleRadians = Math.PI / 6.0;
    this.scannerOpenningHalfAngle = 25.0 * Math.PI / 180.0;
    this.scannerOpenningWideHalfAngle = 40.0 * Math.PI / 180.0;
    this.isDebugRun = false;
    this.NumSecondsForErrorEstimationCalculation = -1.0;
    this.numCalculationRowsExecuted = 0;
    this.listFuzzyLogicSymmetry = null;
    this.listFuzzyLogicCone = null;
    this.deltaRangeCalculation = 0.0;
    this.materialPickToActialPickFrom = 0.0;
    this.isFastErrorEstimationAlgorithm = true;
  }

  ErrorEstimationCal.ErrorEstimationUseVesselSizePenalty = true;
  ErrorEstimationCal.ErrorEstimLowFreqMove2HighFreqCoeff = 1.0;
  ErrorEstimationCal.ErrorEstimationLowFrequencyFrom = 0.8;

  ErrorEstimationCal.prototype._ensureDeps = function () {
    EEC = NS.ErrorEstimationCalculation;
    LA = root.LocatorAlgo || {};
    if (!EEC) throw new Error('LocatorPlacement.ErrorEstimationCalculation required');
  };

  Object.defineProperty(ErrorEstimationCal.prototype, 'DeviceInWork', {
    get: function () { return this.deviceInWork; },
    set: function (v) { this.deviceInWork = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'FuzzyManager', {
    get: function () { return this.fuzzyManager; },
    set: function (v) { this.fuzzyManager = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'Vessel', {
    get: function () { return this.vessel; },
    set: function (v) { this.vessel = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'SearchRadiusList', {
    get: function () { return this.searchRadiusList; },
    set: function (v) { this.searchRadiusList = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'MatrizSize', {
    set: function (v) { this.matrizSize = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'NumberOfBadBallsAccurate', {
    set: function (v) { this.numberOfBadBallsAccurate = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'NumRanges', {
    set: function (v) { this.numRanges = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'MaterialAngleRadians', {
    set: function (v) { this.materialAngleRadians = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'ScannerOpenningHalfAngle', {
    set: function (v) { this.scannerOpenningHalfAngle = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'ScannerOpenningHalfAngleWide', {
    set: function (v) { this.scannerOpenningWideHalfAngle = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'UnitsCoef', {
    set: function (v) { this.unitsCoef = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'TotalVesselWidthX', {
    set: function (v) { this.totalVesselWidthX = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'TotalVesselWidthY', {
    set: function (v) { this.totalVesselWidthY = v; }
  });
  Object.defineProperty(ErrorEstimationCal.prototype, 'ListScannerLocationBalls', {
    get: function () { return this.listScannerLocationBalls; },
    set: function (v) { this.listScannerLocationBalls = v; }
  });

  ErrorEstimationCal.GetListGoodBalls = function (sr) {
    var array = [];
    var i;
    for (i = 0; i < sr.GoodBalls.length; i++) {
      var g = sr.GoodBalls[i];
      array.push(Balls(g.x, g.y, g.r));
    }
    return array;
  };

  ErrorEstimationCal.GetListGoodBallsTopShape = function (sr) {
    if (!sr.GoodBallsTopShape) return null;
    var array = [];
    var i;
    for (i = 0; i < sr.GoodBallsTopShape.length; i++) {
      var g = sr.GoodBallsTopShape[i];
      array.push(Balls(g.x, g.y, g.r));
    }
    return array;
  };

  ErrorEstimationCal.GetListGoodBallsBottomShape = function (sr) {
    if (!sr.GoodBallsBottomShape) return null;
    var array = [];
    var i;
    for (i = 0; i < sr.GoodBallsBottomShape.length; i++) {
      var g = sr.GoodBallsBottomShape[i];
      array.push(Balls(g.x, g.y, g.r));
    }
    return array;
  };

  ErrorEstimationCal.GetListGoodBallsMultiplySymmetry = function (ball, x0, y0, newListBalls) {
    var x1 = ball.x;
    var y1 = ball.y;
    var num = Math.sqrt(Math.pow(x1 - x0, 2.0) + Math.pow(y1 - y0, 2.0));
    var num2 = (x1 !== 0) ? Math.atan(ball.y / ball.x) : 0.0;
    var i;
    for (i = 0; i <= 7; i++) {
      num2 += Math.PI / 4.0;
      x1 = num * Math.cos(num2);
      y1 = num * Math.sin(num2);
      newListBalls.push(Balls(x1 + x0, y1 + y0, ball.r));
    }
  };

  ErrorEstimationCal.GetListGoodBallsSymmetry = function (goodBalsSymmetry, deviceInWork, fillingPoint) {
    var list = [];
    var x = fillingPoint.X;
    var y = fillingPoint.Y;
    var i;
    for (i = 0; i < goodBalsSymmetry.length; i++) {
      ErrorEstimationCal.GetListGoodBallsMultiplySymmetry(goodBalsSymmetry[i], x, y, list);
    }
    return list;
  };

  ErrorEstimationCal.CalAngleBetween2Lines = function (x0, y0, x1, y1, x2, y2) {
    var num = Math.sqrt(Math.pow(x1 - x0, 2.0) + Math.pow(y1 - y0, 2.0));
    var num2 = Math.sqrt(Math.pow(x2 - x0, 2.0) + Math.pow(y2 - y0, 2.0));
    var x3 = Math.sqrt(Math.pow(x1 - x2, 2.0) + Math.pow(y1 - y2, 2.0));
    var num3 = Math.pow(num, 2.0) + Math.pow(num2, 2.0) - Math.pow(x3, 2.0);
    var num4 = 2.0 * num * num2;
    if (Math.abs(num3 / num4) > 1.0) {
      return 0.0;
    }
    return Math.acos(num3 / num4);
  };

  ErrorEstimationCal.ErrorEstimForMaxErrorCalc = function (sr) {
    return sr.ErrorEstimationVolumePercentSumFinalAlmostFull;
  };

  ErrorEstimationCal.GetMaxError = function (listRadius, outObj) {
    outObj.maxErrorIndex = 0;
    if (!listRadius) return NaN;
    var num = 0.0;
    var num2 = 0;
    var i;
    for (i = 0; i < listRadius.length; i++) {
      var num3 = ErrorEstimationCal.ErrorEstimForMaxErrorCalc(listRadius[i]);
      if (num < num3) {
        num = num3;
        outObj.maxErrorIndex = num2;
      }
      num2++;
    }
    return num;
  };

  ErrorEstimationCal.MaxError = function (listRadius) {
    var outObj = { maxErrorIndex: 0 };
    var maxError = ErrorEstimationCal.GetMaxError(listRadius, outObj);
    return Math.min(maxError, 100.0);
  };

  ErrorEstimationCal.MaxErrorIndex = function (listRadius) {
    var outObj = { maxErrorIndex: 0 };
    ErrorEstimationCal.GetMaxError(listRadius, outObj);
    return outObj.maxErrorIndex;
  };

  ErrorEstimationCal.ReCreateGoodBalls = function (list, device, unitsCoef) {
    list.length = 0;
    var scanners = device.Scanners;
    var i;
    for (i = 0; i < scanners.length; i++) {
      list.push(Balls(scanners[i].ScannerPositionX / unitsCoef, scanners[i].ScannerPositionY / unitsCoef, 0));
    }
  };

  ErrorEstimationCal.prototype.ReCreateGoodBalls = function () {
    if (!this.listScannerLocationBalls) this.listScannerLocationBalls = [];
    ErrorEstimationCal.ReCreateGoodBalls(this.listScannerLocationBalls, this.deviceInWork, this.unitsCoef);
  };

  ErrorEstimationCal.prototype.PrepareNewCalculationInsideCalculationLoop = function () {
    this.searchRadiusList = [];
    this.searchRadiusListAllFillingPoints = [];
    this.ReCreateGoodBalls();
  };

  ErrorEstimationCal.prototype.ClearSearchRadiusList = function () {
    this.searchRadiusList.length = 0;
  };

  ErrorEstimationCal.prototype.PrepareNewCalculationAndResetAllData = function () {
    if (!this.listScannerLocationBalls) return;
    var i;
    for (i = 0; i < this.listScannerLocationBalls.length; i++) {
      this.listScannerLocationBalls[i].r = 0;
      this.listScannerLocationBalls[i].x = 0;
      this.listScannerLocationBalls[i].y = 0;
    }
  };

  ErrorEstimationCal.prototype.GenarateAlgoTable = function (listBalls, sr, radiusX, radiusY, fillingPoint) {
    this._ensureDeps();
    var list = [];
    var filling_x = fillingPoint.X;
    var filling_y = fillingPoint.Y;
    var isRectange = true;
    var rx = radiusX;
    var ry = radiusY;
    if (this.deviceInWork.VesselInWork.CenterShapeType === 'Cylinder' ||
        this.deviceInWork.VesselInWork.CenterShapeType === NS.ShapeCenterType.Cylinder) {
      ry = 0.0;
      isRectange = false;
    }
    if (!this._algoErrorEstimationInst) {
      if (!LA.AlgoErrorEstimation) {
        throw new Error('LocatorAlgo.AlgoErrorEstimation required');
      }
      this._algoErrorEstimationInst = new LA.AlgoErrorEstimation();
    }
    var algoInst = this._algoErrorEstimationInst;
    if (this.isFastErrorEstimationAlgorithm) {
      if (rx > 0.0 && rx < 1.0) rx = 1.0;
      if (ry > 0.0 && ry < 1.0) ry = 1.0;
      algoInst.CalcErrorEstimationFast(
        isRectange, this.matrizSize, rx, ry, this.numberOfBadBallsAccurate,
        listBalls, list, filling_x, filling_y
      );
    } else {
      algoInst.CalcErrorEstimation(
        this.matrizSize, rx, ry, this.numberOfBadBallsAccurate,
        listBalls, list, filling_x, filling_y
      );
    }
    return list;
  };

  ErrorEstimationCal.prototype.GenerateAlgoTable = function (sr, symmetry, radiusX, radiusY, fillingPoint) {
    var listBalls;
    if (symmetry) {
      listBalls = ErrorEstimationCal.GetListGoodBallsSymmetry(sr.GoodBalls, this.deviceInWork, fillingPoint);
    } else {
      listBalls = ErrorEstimationCal.GetListGoodBalls(sr);
    }
    return this.GenarateAlgoTable(listBalls, sr, radiusX, radiusY, fillingPoint);
  };

  ErrorEstimationCal.prototype.BadBallsPostCalculationLists = function (listBalls, listBadBalls) {
    var num = Math.max(this.totalVesselWidthX, this.totalVesselWidthY) * 0.04;
    var val = 5;
    var num2 = Math.min(listBadBalls.length, val);
    var i, bi;
    for (i = 0; i < num2; i++) {
      var balls = listBadBalls[i];
      balls.numTouchBalls = 0;
      var list = [];
      for (bi = 0; bi < listBalls.length; bi++) {
        var balls2 = listBalls[bi];
        var num3 = Math.sqrt(Math.pow(balls2.x - balls.x, 2.0) + Math.pow(balls2.y - balls.y, 2.0));
        if (Math.abs(num3 - balls2.r - balls.r) < num) {
          list.push(balls2);
          balls.numTouchBalls++;
        }
      }
      if (balls.numTouchBalls === 2) {
        balls.angleAuxliary = ErrorEstimationCal.CalAngleBetween2Lines(
          balls.x, balls.y, list[0].x, list[0].y, list[1].x, list[1].y
        );
      }
    }
  };

  ErrorEstimationCal.prototype.BadBallsPostCalculation = function (sr, isSymmetry, fillingPoint) {
    var listBalls, listBadBalls;
    if (isSymmetry) {
      listBalls = ErrorEstimationCal.GetListGoodBallsSymmetry(sr.GoodBalls, this.deviceInWork, fillingPoint);
      listBadBalls = sr.BadBallsSymmetry;
    } else {
      listBalls = ErrorEstimationCal.GetListGoodBalls(sr);
      listBadBalls = sr.BadBallsNoSymmetry;
    }
    this.BadBallsPostCalculationLists(listBalls, listBadBalls);
  };

  ErrorEstimationCal.prototype.PostAllBadBallsCalculatedList = function (listBalls, fillingPoint) {
    if (!listBalls) return;
    var i;
    for (i = 0; i < listBalls.length; i++) {
      listBalls[i].xOffset = fillingPoint.X;
      listBalls[i].yOffset = fillingPoint.Y;
    }
  };

  ErrorEstimationCal.prototype.PostAllBadBallsCalculated = function (sr, fillingPoint) {
    this.PostAllBadBallsCalculatedList(sr.BadBallsNoSymmetry, fillingPoint);
    this.PostAllBadBallsCalculatedList(sr.BadBallsSymmetry, fillingPoint);
    this.PostAllBadBallsCalculatedList(sr.BadBallsTopShapeNoSymmetry, fillingPoint);
    this.PostAllBadBallsCalculatedList(sr.BadBallsTopShapeSymmetry, fillingPoint);
    this.PostAllBadBallsCalculatedList(sr.BadBallsBottomShapeNoSymmetry, fillingPoint);
    this.PostAllBadBallsCalculatedList(sr.BadBallsBottomShapeSymmetry, fillingPoint);
  };

  ErrorEstimationCal.prototype.CalculateSingleEstimation = function (
    sr, fuzzyLogicValSymmetry, fuzzyLogicValCone, heightInShapeType,
    calculateConeTopShape, calculateConeBottomShape,
    RadiusTopX, RadiusTopY, RadiusBottomX, RadiusBottomY,
    heightFromFloor, distanceMaxMaterialPickToActialPick, fillingPoint
  ) {
    this._ensureDeps();
    var topConeBaseHeightFromFloor =
      this.deviceInWork.VesselInWork.CenterShapeHeightMeter +
      this.deviceInWork.VesselInWork.BottomShapeHeightMeter;

    if (sr.BadBallsNoSymmetry == null || sr.BadBallsSymmetry == null) {
      var radiusX = this.totalVesselWidthX / 2.0;
      var radiusY = this.totalVesselWidthY / 2.0;
      var flag = fuzzyLogicValSymmetry > 0.0;
      var badBallsNoSymmetry = this.GenerateAlgoTable(sr, false, radiusX, radiusY, fillingPoint);
      sr.BadBallsNoSymmetry = badBallsNoSymmetry;
      this.BadBallsPostCalculation(sr, false, fillingPoint);
      if (flag) {
        badBallsNoSymmetry = this.GenerateAlgoTable(sr, true, radiusX, radiusY, fillingPoint);
        sr.BadBallsSymmetry = badBallsNoSymmetry;
        this.BadBallsPostCalculation(sr, true, fillingPoint);
      }
      if (calculateConeTopShape && sr.GoodBallsTopShape != null && heightInShapeType === 0 /* top */) {
        badBallsNoSymmetry = this.GenarateAlgoTable(
          ErrorEstimationCal.GetListGoodBallsTopShape(sr), sr, RadiusTopX, RadiusTopY, fillingPoint);
        sr.BadBallsTopShapeNoSymmetry = badBallsNoSymmetry;
        if (flag) {
          badBallsNoSymmetry = this.GenarateAlgoTable(
            ErrorEstimationCal.GetListGoodBallsSymmetry(sr.GoodBallsTopShape, this.deviceInWork, fillingPoint),
            sr, RadiusTopX, RadiusTopY, fillingPoint);
          sr.BadBallsTopShapeSymmetry = badBallsNoSymmetry;
        }
      }
      if (sr.GoodBallsBottomShape != null && heightInShapeType === 2 /* bottom */ && RadiusBottomX > 0.0) {
        badBallsNoSymmetry = this.GenarateAlgoTable(
          ErrorEstimationCal.GetListGoodBallsBottomShape(sr), sr, RadiusBottomX, RadiusBottomY, fillingPoint);
        sr.BadBallsBottomShapeNoSymmetry = badBallsNoSymmetry;
        if (flag) {
          badBallsNoSymmetry = this.GenarateAlgoTable(
            ErrorEstimationCal.GetListGoodBallsSymmetry(sr.GoodBallsBottomShape, this.deviceInWork, fillingPoint),
            sr, RadiusBottomX, RadiusBottomY, fillingPoint);
          sr.BadBallsBottomShapeSymmetry = badBallsNoSymmetry;
        }
      }
    }
    this.PostAllBadBallsCalculated(sr, fillingPoint);

    var count = this.listScannerLocationBalls.length;
    var materialAngle = this.materialAngleRadians;
    var num2 = NS.DeviceCalc.CalculateVolume(this.deviceInWork);
    num2 /= Math.pow(this.unitsCoef, 3.0);
    var list = null;
    var list2 = null;
    if (calculateConeTopShape) {
      list = sr.BadBallsTopShapeNoSymmetry;
      list2 = sr.BadBallsTopShapeSymmetry;
    } else if (calculateConeBottomShape) {
      list = sr.BadBallsBottomShapeNoSymmetry;
      list2 = sr.BadBallsBottomShapeSymmetry;
    } else {
      list = sr.BadBallsNoSymmetry;
      list2 = sr.BadBallsSymmetry;
    }
    var calculateNearWalls = false;
    EEC.CalculateErrorEstimationVolumeAll(
      calculateNearWalls, sr, list2, num2, materialAngle, topConeBaseHeightFromFloor,
      this.deviceInWork.VesselInWork.TotalHeightMeter, distanceMaxMaterialPickToActialPick,
      heightFromFloor, true, this.vessel);
    EEC.CalculateErrorEstimationVolumeAll(
      calculateNearWalls, sr, list, num2, materialAngle, topConeBaseHeightFromFloor,
      this.deviceInWork.VesselInWork.TotalHeightMeter, distanceMaxMaterialPickToActialPick,
      heightFromFloor, false, this.vessel);
    if (calculateConeTopShape) {
      calculateNearWalls = true;
      EEC.CalculateErrorEstimationVolumeAll(
        calculateNearWalls, sr, sr.BadBallsSymmetry, num2, materialAngle, topConeBaseHeightFromFloor,
        this.deviceInWork.VesselInWork.TotalHeightMeter, distanceMaxMaterialPickToActialPick,
        heightFromFloor, true, this.vessel);
      sr.ErrorEstimationVolumeSumSymmetry = Math.max(0, sr.ErrorEstimationVolumeSumSymmetryNearWalls);
      EEC.CalculateErrorEstimationVolumeAll(
        calculateNearWalls, sr, sr.BadBallsNoSymmetry, num2, materialAngle, topConeBaseHeightFromFloor,
        this.deviceInWork.VesselInWork.TotalHeightMeter, distanceMaxMaterialPickToActialPick,
        heightFromFloor, false, this.vessel);
      sr.ErrorEstimationVolumeSumNoSymmetry = Math.max(0, sr.ErrorEstimationVolumeSumNoSymmetryNearWalls);
    }
    sr.ErrorEstimationVolumePercentSumSymmetry = 100.0 * sr.ErrorEstimationVolumeSumSymmetry / num2;
    sr.ErrorEstimationVolumePercentSumNoSymmetry = 100.0 * sr.ErrorEstimationVolumeSumNoSymmetry / num2;
    var num5 = -Number.MAX_VALUE;
    var num6 = Number.MAX_VALUE;
    var regrationSpan = 1.0;
    if (this.deviceInWork.ScannerDevicePoints.length > 1) {
      var centerShapeDiameterForCalculation = NS.AlgoCalc.GetCenterShapeDiameterForCalculation(this.deviceInWork.VesselInWork);
      var si;
      for (si = 0; si < this.deviceInWork.ScannerDevicePoints.length; si++) {
        var scannerDevicePoint = this.deviceInWork.ScannerDevicePoints[si];
        var val = NS.DeviceGeometry.Distance(scannerDevicePoint.X, scannerDevicePoint.Y, fillingPoint.X, fillingPoint.Y);
        num5 = Math.max(num5, val);
        num6 = Math.min(num6, val);
      }
      regrationSpan = (!(num5 <= num6)) ? (centerShapeDiameterForCalculation / (num5 - num6)) : 1000000.0;
    }
    EEC.ErrorEstimationVolumeSumFinal(sr, fuzzyLogicValSymmetry, fuzzyLogicValCone, count, num2, regrationSpan);
  };

  ErrorEstimationCal.prototype.ClaculateAllEstimations = function (
    calculateConeTopShape, calculateConeBottomShape, RadiusTopX, RadiusTopY, RadiusBottomX, RadiusBottomY,
    heightFromFloor, index, distanceMaxMaterialPickToActialPick, fillingPoint, heightInShapeType
  ) {
    var sr = this.searchRadiusList[index];
    var sym = this.listFuzzyLogicSymmetry[index];
    var cone = this.listFuzzyLogicCone[index];
    if (!sr || !sym || !cone) {
      return ErrorEstimationCal.ErrorEstimForMaxErrorCalc(sr || {});
    }
    this.CalculateSingleEstimation(
      sr, sym.FuzzyLogicVal, cone.FuzzyLogicVal,
      heightInShapeType, calculateConeTopShape, calculateConeBottomShape,
      RadiusTopX, RadiusTopY, RadiusBottomX, RadiusBottomY,
      heightFromFloor, distanceMaxMaterialPickToActialPick, fillingPoint
    );
    return ErrorEstimationCal.ErrorEstimForMaxErrorCalc(sr);
  };

  ErrorEstimationCal.prototype.CalculateDistanceMaxMaterialPickToActialPick = function (index) {
    return this.materialPickToActialPickFrom + this.deltaRangeCalculation * index;
  };

  ErrorEstimationCal.prototype.CalculteFrequencyAngleInCalculation = function (
    ball, isCubeCenterShape, widthX, widthY, heightFromFloor, dp
  ) {
    var num = 0.0;
    var num2 = 0.0;
    var num3 = 0.0;
    var vesselInWork = this.deviceInWork.VesselInWork;
    var flag = false;
    if (!isCubeCenterShape && (vesselInWork.TopShapeType === 'Cone' || vesselInWork.TopShapeType === 1)) {
      flag = true;
      num = Math.atan(2.0 * vesselInWork.TopShapeHeightMeter / (vesselInWork.CenterShapeDiameterMeter - vesselInWork.TopShapeDiameter));
    } else if (isCubeCenterShape && (vesselInWork.TopShapeType === 'Pyramid' || vesselInWork.TopShapeType === 3)) {
      flag = true;
      num = Math.atan(2.0 * vesselInWork.TopShapeHeightMeter / (vesselInWork.CenterShapeXMeter - vesselInWork.TopShapeXMeter));
      num2 = Math.atan(2.0 * vesselInWork.TopShapeHeightMeter / (vesselInWork.CenterShapeYMeter - vesselInWork.TopShapeYMeter));
    }
    var num4 = Math.sqrt(Math.pow(dp.X, 2.0) + Math.pow(dp.Y, 2.0));
    var flag2 = false;
    if (flag) {
      if (isCubeCenterShape) {
        var num5 = Math.abs(dp.X);
        var num6 = Math.abs(dp.Y);
        var flag3 = false;
        var flag4 = false;
        if (num5 > vesselInWork.TopShapeXMeter / 2.0) {
          if (num6 <= vesselInWork.TopShapeYMeter / 2.0) {
            flag3 = true;
          } else if (vesselInWork.TopShapeY > 0.0 && vesselInWork.TopShapeX > 0.0) {
            var num7 = (vesselInWork.CenterShapeYMeter - vesselInWork.TopShapeY) / (vesselInWork.CenterShapeXMeter - vesselInWork.TopShapeX);
            var num8 = num6 / num5;
            if (num8 < num7) flag3 = true;
            else flag4 = true;
          }
        } else if (num6 >= vesselInWork.TopShapeYMeter / 2.0) {
          flag4 = true;
        }
        if ((flag3 && num > Math.PI / 2.0 - this.scannerOpenningWideHalfAngle) ||
            (flag4 && num2 > Math.PI / 2.0 - this.scannerOpenningWideHalfAngle)) {
          flag2 = true;
        }
      } else if (num4 > vesselInWork.TopShapeDiameterMeter / 2.0 && num > Math.PI / 2.0 - this.scannerOpenningWideHalfAngle) {
        flag2 = true;
      }
    }
    if (flag2) {
      return this.scannerOpenningHalfAngle;
    }
    var num9;
    if (isCubeCenterShape) {
      var val = widthX / 2.0 - Math.abs(ball.x);
      var val2 = widthY / 2.0 - Math.abs(ball.y);
      num9 = Math.min(val, val2);
    } else {
      num9 = widthX / 2.0 - Math.sqrt(Math.pow(ball.x, 2.0) + Math.pow(ball.y, 2.0));
    }
    var num10 = dp.Z - heightFromFloor;
    num3 = (!(num10 < EEC.OrangeLineFactor * num9)) ? this.scannerOpenningHalfAngle : this.scannerOpenningWideHalfAngle;
    return num3;
  };

  ErrorEstimationCal.prototype.CalculateErrorEstimationRangeOfRows = function (
    errorEstimationMaxHeigh, numRanges, from, to, scannerDevicePointsAux,
    calculateAllRows, maxErrorWorst, mergeWorstResultsInFillingPoints, isFirstCalculation
  ) {
    this._ensureDeps();
    var num = numRanges;
    var totalHeightMeter = this.deviceInWork.VesselInWork.TotalHeightMeter;
    var centerShapeX = this.deviceInWork.VesselInWork.CenterShapeX;
    var num2 = centerShapeX;
    var topShapeHeightMeter = this.deviceInWork.VesselInWork.TopShapeHeightMeter;
    var num3 = this.deviceInWork.VesselInWork.TopShapeDiameterMeter;
    var num4 = 0.0;
    var bottomShapeHeightMeter = this.deviceInWork.VesselInWork.BottomShapeHeightMeter;
    var num5 = this.deviceInWork.VesselInWork.BottomShapeDiameterMeter;
    var num6 = 0.0;
    var centerShapeHeightMeter = this.deviceInWork.VesselInWork.CenterShapeHeightMeter;
    var num7 = centerShapeX / 2.0;
    var num8 = 0.0;
    var flag = this.deviceInWork.VesselInWork.CenterShapeType === 'Cube' ||
      this.deviceInWork.VesselInWork.CenterShapeType === NS.ShapeCenterType.Cube;
    if (flag) {
      num2 = this.deviceInWork.VesselInWork.CenterShapeY;
      num8 = num2 / 2.0;
    }
    if (this.deviceInWork.VesselInWork.TopShapeType === 'Pyramid' || this.deviceInWork.VesselInWork.TopShapeType === 3) {
      num3 = this.deviceInWork.VesselInWork.TopShapeXMeter;
      num4 = this.deviceInWork.VesselInWork.TopShapeYMeter;
    }
    if (this.deviceInWork.VesselInWork.BottomShapeType === 'Pyramid' || this.deviceInWork.VesselInWork.BottomShapeType === 3) {
      num5 = this.deviceInWork.VesselInWork.BottomShapeXMeter;
      num6 = this.deviceInWork.VesselInWork.BottomShapeYMeter;
    }
    this.materialPickToActialPickFrom = totalHeightMeter - errorEstimationMaxHeigh;
    var num9 = totalHeightMeter - this.materialPickToActialPickFrom;
    this.deltaRangeCalculation = num9 / num;
    var zFromRealFloor = this.deviceInWork.ZFromRealFloor || 0;
    var result = false;
    var count = this.deviceInWork.ScannerDevicePoints.length;
    if (this.searchRadiusListAllFillingPoints == null) {
      this.searchRadiusListAllFillingPoints = [];
    }
    var num10 = 0;
    if (isFirstCalculation) {
      this.searchRadiusListAllFillingPoints.length = 0;
    }
    var num11 = -1;
    var num12 = Math.max(centerShapeX, centerShapeX);
    var num13 = num12;
    var num14 = (this.vessel && this.vessel.VesselTotalHeight)
      ? this.vessel.VesselTotalHeight()
      : totalHeightMeter;
    var xPen = 2.0 * num14 / num13 - 2.0;
    xPen = 2.5 - Math.pow(xPen, 4.0);
    if (xPen < 0.0) xPen = 0.0;
    if (!ErrorEstimationCal.ErrorEstimationUseVesselSizePenalty) {
      xPen = 0.0;
    }

    var fillPoints = this.deviceInWork.FillPoints;
    var fpIdx;
    for (fpIdx = 0; fpIdx < fillPoints.length; fpIdx++) {
      num11++;
      num10++;
      var fillPoint2 = fillPoints[fpIdx];
      var fillPoint = {
        XDisplay: fillPoint2.XDisplay, YDisplay: fillPoint2.YDisplay,
        X: fillPoint2.X, Y: fillPoint2.Y, Z: fillPoint2.Z
      };
      var list = [];
      var i;
      for (i = 0; i < numRanges + 1; i++) {
        var distanceMaxMaterialPickToActialPick = this.CalculateDistanceMaxMaterialPickToActialPick(i);
        list.push(EEC.PenaltyNotSeeingMaterialPickCalculation(
          fillPoint.X, fillPoint.Y, num11, this.materialAngleRadians, this.scannerOpenningHalfAngle,
          this.deviceInWork, distanceMaxMaterialPickToActialPick, flag, centerShapeX, num2, num9
        ));
      }
      this.searchRadiusList.length = 0;
      if (!isFirstCalculation) {
        if (this.searchRadiusListAllFillingPoints.length > num11) {
          var list2 = this.searchRadiusListAllFillingPoints[num11];
          for (var j = this.searchRadiusList.length; j < from; j++) {
            this.searchRadiusList.push(list2[j]);
          }
        } else {
          for (j = this.searchRadiusList.length; j < from; j++) {
            this.searchRadiusList.push(EEC.createSearchRadius());
          }
        }
      } else {
        for (j = this.searchRadiusList.length; j < from; j++) {
          this.searchRadiusList.push(EEC.createSearchRadius());
        }
      }
      var flag2 = false;
      for (j = from; j < to + 1; j++) {
        if (flag2) break;
        this.numCalculationRowsExecuted++;
        var flag3 = false;
        var flag4 = false;
        var num15 = this.CalculateDistanceMaxMaterialPickToActialPick(j);
        var searchRadius;
        if (this.searchRadiusList.length > j) {
          searchRadius = this.searchRadiusList[j];
        } else {
          searchRadius = EEC.createSearchRadius();
          this.searchRadiusList.push(searchRadius);
        }
        searchRadius.FrequencyAngleInCalculation = 0.0;
        searchRadius.HeightSliceIndex = j;
        searchRadius.ErrorEstimationFromFillingPointID = num10;
        searchRadius.IsDebugRun = this.isDebugRun;
        searchRadius.NumScanners = count;
        searchRadius.HeightFromFloor = (totalHeightMeter - num15 + zFromRealFloor) * this.unitsCoef;
        searchRadius.HeightPercent = ((totalHeightMeter - num15) / num9) * 100;
        searchRadius.GoodBalls = [];
        distanceMaxMaterialPickToActialPick = num15;
        var num16 = 0;
        var topType = this.deviceInWork.VesselInWork.TopShapeType;
        if (topType === 'Cone' || topType === 'Pyramid' || topType === 'Dome' || topType === 1 || topType === 2 || topType === 3) {
          searchRadius.GoodBallsTopShape = [];
        }
        var botType = this.deviceInWork.VesselInWork.BottomShapeType;
        if (botType === 'Cone' || botType === 'Pyramid' || botType === 'Dome' || botType === 1 || botType === 2 || botType === 3) {
          searchRadius.GoodBallsBottomShape = [];
        }
        var radiusTopX = 0.0, radiusTopY = 0.0, radiusBottomX = 0.0, radiusBottomY = 0.0;
        if (searchRadius.GoodBallsTopShape != null) {
          var num17 = topShapeHeightMeter - distanceMaxMaterialPickToActialPick;
          if (num17 > 0.0) {
            flag3 = true;
            searchRadius.VesselHeightType = 0; /* Top */
            var num18 = topShapeHeightMeter / (num7 - num3 / 2.0);
            radiusTopX = num7 - num17 / num18;
            var num19 = topShapeHeightMeter / (num8 - num4 / 2.0);
            radiusTopY = num8 - num17 / num19;
          }
        }
        var num20 = totalHeightMeter - distanceMaxMaterialPickToActialPick;
        if (searchRadius.GoodBallsBottomShape != null) {
          var num21 = this.deviceInWork.VesselInWork.BottomShapeHeightMeter / (num7 - num5 / 2.0);
          radiusBottomX = num20 / num21 + num5 / 2.0;
          var num23 = this.deviceInWork.VesselInWork.BottomShapeHeightMeter / (num8 - num6 / 2.0);
          radiusBottomY = num20 / num23 + num6 / 2.0;
          if (totalHeightMeter - distanceMaxMaterialPickToActialPick < bottomShapeHeightMeter) {
            searchRadius.VesselHeightType = 2; /* Bottom */
            flag4 = true;
          }
        }
        var heightFromFloor = searchRadius.HeightFromFloor;
        var heightInShapeType = 1; /* center */
        if (num20 > centerShapeHeightMeter + bottomShapeHeightMeter) {
          heightInShapeType = 0; /* top */
        } else if (num20 < bottomShapeHeightMeter) {
          heightInShapeType = 2; /* bottom */
        }
        var outRad = { radNew: 0.0 };
        var bi;
        for (bi = 0; bi < this.listScannerLocationBalls.length; bi++) {
          var listScannerLocationBall = this.listScannerLocationBalls[bi];
          var devicePoint = scannerDevicePointsAux[num16];
          num16++;
          var num25 = this.CalculteFrequencyAngleInCalculation(
            listScannerLocationBall, flag, centerShapeX, num2, heightFromFloor, devicePoint);
          if (searchRadius.FrequencyAngleInCalculation === 0.0 || num25 < searchRadius.FrequencyAngleInCalculation) {
            searchRadius.FrequencyAngleInCalculation = num25;
          }
          var point = EEC.RadiusCalculation(
            true, searchRadius, listScannerLocationBall.x, listScannerLocationBall.y,
            devicePoint.ScannerZOffsetFromVesselTop, fillPoint.X, fillPoint.Y, totalHeightMeter,
            this.materialAngleRadians, num25, this.deviceInWork, distanceMaxMaterialPickToActialPick,
            this.listFuzzyLogicCone[j], outRad
          );
          var balls = Balls(point.X, point.Y, outRad.radNew);
          balls.isGoodBal = true;
          searchRadius.GoodBalls.push(balls);
          if (flag3) {
            searchRadius.GoodBallsTopShape.push(Balls(point.X, point.Y, outRad.radNew));
          }
          if (flag4) {
            searchRadius.GoodBallsBottomShape.push(Balls(point.X, point.Y, outRad.radNew));
          }
        }
        var num27 = this.ClaculateAllEstimations(
          flag3, flag4, radiusTopX, radiusTopY, radiusBottomX, radiusBottomY,
          heightFromFloor, j, distanceMaxMaterialPickToActialPick, fillPoint, heightInShapeType
        );
        var num28 = NS.DeviceCalc.CalculateVolume(this.deviceInWork);
        var num29 = list[j];
        searchRadius.PenaltyForNotSeeingMaterialPick = 100.0 * num29 / num28;
        searchRadius.PenaltyVesselSize = xPen;
        searchRadius.ErrorEstimationVolumeSumFinal += num29;
        searchRadius.ErrorEstimationVolumeSumFinal += (xPen / 100.0 * num28);
        searchRadius.ErrorEstimationVolumePercentSumFinal = 100.0 * searchRadius.ErrorEstimationVolumeSumFinal / num28;
        searchRadius.ErrorEstimationVolumePercentSumFinalAlmostFull = searchRadius.ErrorEstimationVolumePercentSumFinal;
        num27 = ErrorEstimationCal.ErrorEstimForMaxErrorCalc(searchRadius);
        if (num27 > maxErrorWorst) {
          result = true;
          flag2 = true;
        }
      }
      var list3 = this.searchRadiusList.slice();
      if (this.searchRadiusListAllFillingPoints.length <= num11) {
        this.searchRadiusListAllFillingPoints.push(list3);
      } else {
        this.searchRadiusListAllFillingPoints[num11] = list3;
      }
    }

    if (mergeWorstResultsInFillingPoints && this.deviceInWork.FillPoints.length > 1) {
      var list4 = [];
      for (j = 0; j < this.searchRadiusListAllFillingPoints.length; j++) {
        if (j === 0) {
          list4 = this.searchRadiusListAllFillingPoints[j].slice();
          continue;
        }
        list2 = this.searchRadiusListAllFillingPoints[j];
        var k;
        for (k = 0; k < list2.length; k++) {
          if (list4.length > k) {
            if (list4[k].ErrorEstimationVolumePercentSumFinalAlmostFull < list2[k].ErrorEstimationVolumePercentSumFinalAlmostFull) {
              list4[k] = list2[k];
            }
          }
        }
      }
      this.searchRadiusList.length = 0;
      for (k = 0; k < list4.length; k++) this.searchRadiusList.push(list4[k]);
    }
    return result;
  };

  /**
   * Top-level entry (matches ErrorEstimationCal.CalculateErrorEstimation).
   * @returns {boolean} early-exit exceeded maxErrorWorst
   */
  ErrorEstimationCal.prototype.CalculateErrorEstimation = function (
    sbGeneralExceptionByAlgorithm, calculatePerformance, errorEstimationMaxHeigh,
    listAlgoData, calculateAllRows, maxErrorIndex, maxErrorWorst
  ) {
    this._ensureDeps();
    if (calculateAllRows === undefined) calculateAllRows = true;
    if (maxErrorIndex === undefined) maxErrorIndex = -1;
    if (maxErrorWorst === undefined) maxErrorWorst = Number.MAX_VALUE;
    var flag = false;
    try {
      var totalHeightMeter = this.deviceInWork.VesselInWork.TotalHeightMeter;
      this.listFuzzyLogicSymmetry = (this.fuzzyManager.FuzzyLogicValuesSymmetry || []).slice();
      this.listFuzzyLogicCone = (this.fuzzyManager.FuzzyLogicValuesCone || []).slice();
      var list = [];
      this.ReCreateGoodBalls();
      this.materialPickToActialPickFrom = totalHeightMeter - errorEstimationMaxHeigh;
      var num2 = totalHeightMeter - this.materialPickToActialPickFrom;
      this.deltaRangeCalculation = num2 / this.numRanges;
      var si;
      for (si = 0; si < this.deviceInWork.ScannerDevicePoints.length; si++) {
        list.push(cloneDevicePoint(this.deviceInWork.ScannerDevicePoints[si], this.unitsCoef));
      }
      if (calculateAllRows) {
        this.CalculateErrorEstimationRangeOfRows(
          errorEstimationMaxHeigh, this.numRanges, 0, this.numRanges, list,
          calculateAllRows, maxErrorWorst, true, true
        );
      } else {
        var mergeWorstResultsInFillingPoints = true;
        flag = this.CalculateErrorEstimationRangeOfRows(
          errorEstimationMaxHeigh, this.numRanges, 0, maxErrorIndex, list,
          calculateAllRows, maxErrorWorst, mergeWorstResultsInFillingPoints, true
        );
        if (!flag) {
          flag = this.CalculateErrorEstimationRangeOfRows(
            errorEstimationMaxHeigh, this.numRanges, maxErrorIndex + 1, this.numRanges, list,
            calculateAllRows, maxErrorWorst, mergeWorstResultsInFillingPoints, false
          );
        }
      }
    } catch (ex) {
      if (sbGeneralExceptionByAlgorithm) sbGeneralExceptionByAlgorithm.push(String(ex));
    }
    return flag;
  };

  NS.ErrorEstimationCal = ErrorEstimationCal;
  NS.Balls = Balls;
})(typeof self !== 'undefined' ? self : (typeof globalThis !== 'undefined' ? globalThis : this));
