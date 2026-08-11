/* LocatorPlacement.ErrorEstimationCalculation
 * Port of APM.Locator.ViewModel.ErrorEstimationCalculation (+ SearchRadius / CalcParams).
 * MATH-CRITICAL — preserve formulas, constants, and evaluation order exactly.
 * Assumes LocatorAlgo.Balls exists (or plain {x,y,r,xOffset,yOffset,...} objects).
 */
(function (root) {
  'use strict';
  var NS = root.LocatorPlacement = root.LocatorPlacement || {};

  var PI = Math.PI;
  var degrees_5_InRadian = PI / 36.0;
  var degrees_15_InRadian = PI / 12.0;
  var degrees_26_InRadian = PI * 13.0 / 90.0;
  var degrees_30_InRadian = PI / 6.0;
  var degrees_45_InRadian = PI / 4.0;
  var degrees_52_InRadian = PI * 13.0 / 45.0;
  var degrees_60_InRadian = PI / 3.0;
  var BALLNOTINCONE = -1.0;
  var RANDOM_LIST_SIZE = 300;

  /* .NET Framework System.Random (subtractive generator) — seed 0 for penalty list fidelity */
  function DotNetRandom(seed) {
    var MBIG = 2147483647;
    var MSEED = 161803398;
    var SeedArray = new Array(56);
    var inext = 0;
    var inextp = 0;
    var subtraction = (seed === -2147483648) ? MBIG : Math.abs(seed | 0);
    var mj = MSEED - subtraction;
    SeedArray[55] = mj;
    var mk = 1;
    var i, ii, k;
    for (i = 1; i < 55; i++) {
      ii = (21 * i) % 55;
      SeedArray[ii] = mk;
      mk = mj - mk;
      if (mk < 0) mk += MBIG;
      mj = SeedArray[ii];
    }
    for (k = 1; k < 5; k++) {
      for (i = 1; i < 56; i++) {
        SeedArray[i] -= SeedArray[1 + (i + 30) % 55];
        if (SeedArray[i] < 0) SeedArray[i] += MBIG;
      }
    }
    inext = 0;
    inextp = 21;
    this.next = function () {
      var locINext = inext;
      var locINextp = inextp;
      if (++locINext >= 56) locINext = 1;
      if (++locINextp >= 56) locINextp = 1;
      var retVal = SeedArray[locINext] - SeedArray[locINextp];
      if (retVal === MBIG) retVal--;
      if (retVal < 0) retVal += MBIG;
      SeedArray[locINext] = retVal;
      inext = locINext;
      inextp = locINextp;
      return retVal;
    };
    this.nextDouble = function () {
      return this.next() * (1.0 / MBIG);
    };
  }

  var randomPenalty = new DotNetRandom(0);
  var penaltyNotSeeingMaterialRandomVals = null;

  function createCalcParams() {
    return {
      L_Param: 0,
      K_Param: 0,
      DistanceMaxMaterialPickToActialPick: 0,
      S_Param: 0
    };
  }

  function createSearchRadius() {
    return {
      calcParams: createCalcParams(),
      CalcParams: null, /* alias set below */
      BadBallsNoSymmetry: null,
      BadBallsSymmetry: null,
      BadBallsTopShapeNoSymmetry: null,
      BadBallsTopShapeSymmetry: null,
      BadBallsBottomShapeNoSymmetry: null,
      BadBallsBottomShapeSymmetry: null,
      GoodBalls: null,
      GoodBallsTopShape: null,
      GoodBallsBottomShape: null,
      HeightSliceIndex: 0,
      HeightFromFloor: 0,
      HeightFromFloorWithUnits: 0,
      HeightPercent: 0,
      FrequencyAngleInCalculation: 0,
      ErrorEstimationVolumeSumNoSymmetry: NaN,
      ErrorEstimationVolumePercentSumNoSymmetry: NaN,
      ErrorEstimationVolumeSumSymmetry: NaN,
      ErrorEstimationVolumePercentSumSymmetry: NaN,
      ErrorEstimationVolumeSumSymmetryNearWalls: NaN,
      ErrorEstimationVolumeSumNoSymmetryNearWalls: NaN,
      PenaltyForNotSeeingMaterialPick: 0,
      PenaltyVesselSize: 0,
      ErrorEstimationVolumeSumFinal: NaN,
      ErrorEstimationVolumePercentSumFinal: NaN,
      ErrorEstimationVolumePercentSumFinalAlmostFull: NaN,
      VesselHeightType: 1, /* Center */
      ErrorEstimationFromFillingPointID: 0,
      AlgoCalcTime: -1,
      NumScanners: 0,
      IsDebugRun: false
    };
  }

  var eBeamType = { Low: 0, Mid: 1, High: 2 };
  var eVesselHeightType = { Top: 0, Center: 1, Bottom: 2 };

  var EEC = {
    eBeamType: eBeamType,
    eVesselHeightType: eVesselHeightType,
    SymmetryLimiter: 0.1,
    OrangeLineFactor: 2.0,
    createSearchRadius: createSearchRadius,
    createCalcParams: createCalcParams,

    GetRandomNumber: function (random, minimum, maximum) {
      return random.nextDouble() * (maximum - minimum) + minimum;
    },

    GeneratePenaltyNotSeeingMaterialRandomVals: function () {
      penaltyNotSeeingMaterialRandomVals = [];
      while (true) {
        var randomNumber = EEC.GetRandomNumber(randomPenalty, -1.0, 1.0);
        var randomNumber2 = EEC.GetRandomNumber(randomPenalty, -1.0, 1.0);
        if (randomNumber * randomNumber + randomNumber2 * randomNumber2 < 1.0) {
          penaltyNotSeeingMaterialRandomVals.push({ X: randomNumber, Y: randomNumber2 });
          if (penaltyNotSeeingMaterialRandomVals.length >= RANDOM_LIST_SIZE) {
            break;
          }
        }
      }
    },

    /* Overload: 11 args = blend Low/Mid; 13 args = single beamType */
    PenaltyNotSeeingMaterialPickCalculation: function () {
      if (arguments.length === 11) {
        var fillPointX = arguments[0];
        var fillPointY = arguments[1];
        var fillPointIndex = arguments[2];
        var materialAngle = arguments[3];
        var scannerAngle = arguments[4];
        var device = arguments[5];
        var distanceMaxMaterialPickToActialPick = arguments[6];
        var isCubeCenterShape = arguments[7];
        var widthX = arguments[8];
        var widthY = arguments[9];
        var fullRangeHeight = arguments[10];
        if (penaltyNotSeeingMaterialRandomVals === null) {
          EEC.GeneratePenaltyNotSeeingMaterialRandomVals();
        }
        var closestScannerToLocation = device.GetClosestScannerToLocation
          ? device.GetClosestScannerToLocation(fillPointX, fillPointY)
          : NS._getClosestScannerToLocation(device, fillPointX, fillPointY);
        var num = EEC.PenaltyNotSeeingMaterialPickCalculationBeam(
          eBeamType.Low, fillPointX, fillPointY, fillPointIndex, closestScannerToLocation,
          materialAngle, scannerAngle, device, distanceMaxMaterialPickToActialPick,
          isCubeCenterShape, widthX, widthY, fullRangeHeight);
        var num2 = EEC.PenaltyNotSeeingMaterialPickCalculationBeam(
          eBeamType.Mid, fillPointX, fillPointY, fillPointIndex, closestScannerToLocation,
          materialAngle, scannerAngle, device, distanceMaxMaterialPickToActialPick,
          isCubeCenterShape, widthX, widthY, fullRangeHeight);
        var num3 = EEC.CalculateOrangeLineFuzzy(
          fillPointX, fillPointY, closestScannerToLocation, distanceMaxMaterialPickToActialPick,
          isCubeCenterShape, widthX, widthY);
        return num3 * num + (1.0 - num3) * num2;
      }
      return EEC.PenaltyNotSeeingMaterialPickCalculationBeam.apply(EEC, arguments);
    },

    PenaltyNotSeeingMaterialPickCalculationBeam: function (
      beamType, fillPointX, fillPointY, fillPointIndex, scannerDP, materialAngle, scannerAngle,
      device, distanceMaxMaterialPickToActialPick, isCubeCenterShape, widthX, widthY, fullRangeHeight
    ) {
      if (beamType === eBeamType.High) {
        return 0.0;
      }
      var scannerZOffsetFromVesselTop = scannerDP.ScannerZOffsetFromVesselTop;
      var x = scannerDP.X;
      var y = scannerDP.Y;
      var num = Math.tan(materialAngle);
      var num2 = Math.tan(scannerAngle);
      var num3 = EEC.CalculateCL_Parameter(device, x, y);
      var num4 = 0.0;
      var num5 = distanceMaxMaterialPickToActialPick - num3 + scannerZOffsetFromVesselTop;
      if (num5 < 0.0) {
        num5 = 0.0;
      }
      var num6 = Math.sqrt(Math.pow(x - fillPointX, 2.0) + Math.pow(y - fillPointY, 2.0));
      num4 = (num5 === 0.0) ? degrees_60_InRadian : (!(num5 * num2 >= num6) ? Math.atan(num6 / num5) : num2);
      var num7 = 0.0;
      var num8 = 0.0;
      var num9 = 0.0;
      switch (beamType) {
        case eBeamType.Low:
          num8 = degrees_45_InRadian;
          num9 = degrees_52_InRadian;
          break;
        case eBeamType.Mid:
          num8 = num2;
          num9 = num2 + degrees_5_InRadian;
          break;
      }
      num7 = (num4 < num8) ? 0.0 : (!(num4 <= num9) ? 1.0 : ((num4 - num8) / (num9 - num8)));
      if (penaltyNotSeeingMaterialRandomVals === null) {
        EEC.GeneratePenaltyNotSeeingMaterialRandomVals();
      }
      var count = penaltyNotSeeingMaterialRandomVals.length;
      var x2 = scannerDP.X;
      var y2 = scannerDP.Y;
      var num10 = 0;
      var i;
      for (i = 0; i < count; i++) {
        var num11 = penaltyNotSeeingMaterialRandomVals[i].X * num6 + fillPointX;
        var num12 = penaltyNotSeeingMaterialRandomVals[i].Y * num6 + fillPointY;
        if (isCubeCenterShape) {
          if (!(num11 < (0.0 - widthX) / 2.0) && !(num11 > widthX / 2.0) && !(num12 < (0.0 - widthY) / 2.0) && !(num12 > widthY / 2.0)) {
            num10++;
          }
        } else if (num11 * num11 + num12 * num12 < widthX / 2.0 * (widthX / 2.0)) {
          num10++;
        }
      }
      var num13 = num10 / count;
      var num14 = Math.PI * num6 * num6 * num6 * num;
      var result = Math.PI * Math.pow(num6, 3.0) * num * num7 * num13;
      var num15 = Math.min(num6 * num, fullRangeHeight - distanceMaxMaterialPickToActialPick);
      var num16 = Math.PI * Math.pow(num6, 2.0) * num15 * num7 * num13;
      return result;
    },

    CalculateOrangeLineFuzzy: function (fillPointX, fillPointY, scannerDP, distanceMaxMaterialPickToActialPick, isCubeCenterShape, widthX, widthY) {
      var num;
      if (isCubeCenterShape) {
        var val = Math.abs(widthX / 2.0 - Math.abs(scannerDP.X));
        var val2 = Math.abs(widthY / 2.0 - Math.abs(scannerDP.Y));
        num = Math.min(val, val2);
      } else {
        num = widthX / 2.0 - Math.sqrt(scannerDP.X * scannerDP.X + scannerDP.Y * scannerDP.Y);
      }
      var num2 = EEC.OrangeLineFactor * num;
      var num3 = Math.sqrt(
        Math.pow(fillPointX - scannerDP.X, 2.0) +
        Math.pow(fillPointY - scannerDP.Y, 2.0) +
        Math.pow(distanceMaxMaterialPickToActialPick, 2.0)
      );
      var num4 = 1.0;
      if (num3 < num2) {
        return 0.0;
      }
      if (num3 > num2 + num4) {
        return 1.0;
      }
      return (num3 - num2) / num4;
    },

    /* Returns { X, Y }; radNew via outObj.radNew */
    RadiusCalculation: function (
      isMoveScannerPosition, sr, xScanner, yScanner, zScannerDelta, fillPointX, fillPointY,
      vesselHeight, materialAngle, scannerAngle, device, distanceMaxMaterialPickToActialPick,
      fuzzyLogicValueCone, outObj
    ) {
      var flag = false;
      var num = Math.tan(materialAngle);
      var num2 = Math.tan(scannerAngle);
      var num3 = EEC.CalculateCL_Parameter(device, xScanner, yScanner);
      var num4 = distanceMaxMaterialPickToActialPick - num3 + zScannerDelta;
      var num5 = Math.sqrt(Math.pow(xScanner - fillPointX, 2.0) + Math.pow(yScanner - fillPointY, 2.0));
      var num6 = num4 + num5 * num;
      if (num6 < 0.0) {
        flag = true;
      }
      if (num4 < 0.0) {
        num4 = 0.0;
      }
      var num7 = num4 * num2;
      var num8 = 1.0 / num2 - num;
      var num9 = (num4 + num5 * num) / num8;
      var num11;
      if (num4 * num2 <= num5) {
        var num10 = (num5 - num4 * num2) / (num2 + 1.0 / num);
        num11 = (num10 + num4) * num;
      } else {
        num11 = num4 / num8;
      }
      var cp = sr.calcParams || sr.CalcParams;
      cp.S_Param = num11;
      cp.L_Param = num4;
      cp.K_Param = num11 * num;
      cp.DistanceMaxMaterialPickToActialPick = distanceMaxMaterialPickToActialPick;
      var fuzzyVal = (fuzzyLogicValueCone && fuzzyLogicValueCone.FuzzyLogicVal !== undefined)
        ? fuzzyLogicValueCone.FuzzyLogicVal
        : fuzzyLogicValueCone;
      var num12 = 0.5 * (num11 + num9) * fuzzyVal + num7 * (1.0 - fuzzyVal);
      var num13 = 0.0;
      var num14 = Math.sqrt(Math.pow(xScanner - fillPointX, 2.0) + Math.pow(yScanner - fillPointY, 2.0));
      outObj.radNew = num12;
      var result = { X: xScanner, Y: yScanner };
      if (!isMoveScannerPosition) {
        return result;
      }
      var flag2 = false;
      if (num14 > 0.0001) {
        num13 = 1.0 + Math.abs(fuzzyVal * 0.5 * (num9 - num11) / num14);
        result.X = fillPointX + (xScanner - fillPointX) * num13;
        result.Y = fillPointY + (yScanner - fillPointY) * num13;
        flag2 = true;
      }
      if (flag) {
        outObj.radNew = 0.0;
        result.X = fillPointX + (xScanner - fillPointX) * num13;
        result.Y = fillPointY + (yScanner - fillPointY) * num13;
        flag2 = true;
      }
      if (flag2) {
        EEC.RadiusCalculation(
          false, sr, xScanner, yScanner, zScannerDelta, fillPointX, fillPointY, vesselHeight,
          materialAngle, scannerAngle, device, distanceMaxMaterialPickToActialPick,
          fuzzyLogicValueCone, outObj
        );
      }
      return result;
    },

    CalculateCL_Parameter: function (device, xScanner, yScanner) {
      var top = device.VesselInWork.TopShapeType;
      if (top === 'Cone' || top === 1 /* Cone */) {
        return EEC.CalculateCL_ParameterCone(device, xScanner, yScanner);
      }
      if (top === 'Pyramid' || top === 3) {
        return EEC.CalculateCL_ParameterPyramid(device, xScanner, yScanner);
      }
      if (top === 'Dome' || top === 2) {
        return EEC.CalculateCL_ParameterDome(device, xScanner, yScanner);
      }
      return 0.0;
    },

    CalculateCL_ParameterCone: function (device, xScanner, yScanner) {
      var num = Math.sqrt(Math.pow(xScanner, 2.0) + Math.pow(yScanner, 2.0));
      var num2 = device.VesselInWork.TopShapeDiameterMeter / 2.0;
      if (num > num2) {
        var tan = device.CalculateTopConeBaseTan
          ? device.CalculateTopConeBaseTan()
          : NS._calculateTopConeBaseTan(device);
        return (num - num2) * tan;
      }
      return 0.0;
    },

    CalculateCL_ParameterPyramid: function (device, xScanner, yScanner) {
      var v = device.VesselInWork;
      var num = v.CenterShapeXMeter / 2.0;
      var num2 = v.CenterShapeYMeter / 2.0;
      var num3 = Math.abs(xScanner);
      var num4 = Math.abs(yScanner);
      var num5 = v.TopShapeXMeter / 2.0;
      var num6 = v.TopShapeYMeter / 2.0;
      var num7 = (num2 - num6) / (num - num5);
      if (num3 < num5 && num4 < num6) {
        return 0.0;
      }
      var num9 = v.TopShapeHeightMeter / (num - num5);
      var num10 = v.TopShapeHeightMeter / (num2 - num6);
      if (num4 - num6 >= num7 * (num3 - num5)) {
        return (num4 - num6) * num10;
      }
      return (num3 - num5) * num9;
    },

    CalculateCL_ParameterDome: function (device, xScanner, yScanner) {
      var x = Math.sqrt(Math.pow(xScanner, 2.0) + Math.pow(yScanner, 2.0));
      var centerShapeDiameterMeter = device.VesselInWork.CenterShapeDiameterMeter;
      var topShapeHeightMeter = device.VesselInWork.TopShapeHeightMeter;
      var num2 = (Math.pow(centerShapeDiameterMeter / 2.0, 2.0) + Math.pow(topShapeHeightMeter, 2.0)) / (2.0 * topShapeHeightMeter);
      return num2 - Math.sqrt(Math.pow(num2, 2.0) - Math.pow(x, 2.0));
    },

    CalculateErrorEstimationVolumeAll: function (
      calculateNearWalls, sr, badBallsCenter, volueCenterShape, materialAngle,
      TopConeBaseHeightFromFloor, SiloHeight, distanceMaxMaterialPickToActialPick,
      heightFromFloor, isSymmetryAlgorithm, vessel
    ) {
      var num = 0.0;
      if (badBallsCenter != null) {
        var bi;
        for (bi = 0; bi < badBallsCenter.length; bi++) {
          var item = badBallsCenter[bi];
          var outV = { Verror1: 0 };
          var num2 = EEC.CalculateErrorEstimationVolumeSingleBall(item, materialAngle, outV);
          if (calculateNearWalls) {
            if (heightFromFloor > TopConeBaseHeightFromFloor && !isSymmetryAlgorithm) {
              var num3 = EEC.CalculateErrorEstimationVolumeSingleBallNearWalls(
                vessel, item, materialAngle, heightFromFloor, TopConeBaseHeightFromFloor);
              num = (num3 === -1.0) ? (num + num2) : (num + num3);
            } else {
              num += num2;
            }
          } else {
            num += num2;
          }
        }
      }
      if (!calculateNearWalls) {
        if (isSymmetryAlgorithm) {
          sr.ErrorEstimationVolumeSumSymmetry = num;
          sr.ErrorEstimationVolumePercentSumSymmetry = 100.0 * sr.ErrorEstimationVolumeSumSymmetry / volueCenterShape;
        } else {
          sr.ErrorEstimationVolumeSumNoSymmetry = num;
          sr.ErrorEstimationVolumePercentSumNoSymmetry = 100.0 * sr.ErrorEstimationVolumeSumNoSymmetry / volueCenterShape;
        }
      } else if (isSymmetryAlgorithm) {
        sr.ErrorEstimationVolumeSumSymmetryNearWalls = num;
      } else {
        sr.ErrorEstimationVolumeSumNoSymmetryNearWalls = num;
      }
    },

    CalculateErrorEstimationVolumeSingleBallNearWalls: function (vessel, ball, materialAngle, BallLevel, TopConeBaseHeightFromFloor) {
      var num = 5;
      var num2 = 10;
      var xOffset = ball.xOffset;
      var yOffset = ball.yOffset;
      var num3 = ball.r;
      var num4 = Math.sqrt(Math.pow(ball.x - xOffset, 2.0) + Math.pow(ball.y - yOffset, 2.0));
      var num5 = num4 - num3;
      var num6 = num4 + num3;
      var num7 = BallLevel - num5 * Math.tan(materialAngle);
      if (num7 < TopConeBaseHeightFromFloor || num5 < 0.0) {
        return -1.0;
      }
      var num8 = (num6 - num5) / num2;
      var num9 = 2.0 * Math.atan(num3 / num4);
      var num10 = num9 / num;
      var num11 = 0.0;
      var i, j;
      var autoZ = (vessel && typeof vessel.AutoCalculateZFromVesselBottom === "function")
        ? function (vx, vy) { return vessel.AutoCalculateZFromVesselBottom(vx, vy); }
        : function (vx, vy) {
          return (NS.autoCalculateZFromVesselBottom
            ? NS.autoCalculateZFromVesselBottom(vessel, vx, vy)
            : 0);
        };
      for (i = 0; i < num2; i++) {
        var num12 = num5 + i * num8;
        var num13 = num12 + num8 / 2.0;
        var num14 = num13 / num4 * (ball.x - xOffset) + xOffset;
        var num15 = num13 / num4 * (ball.y - yOffset) + yOffset;
        for (j = 0; j < num; j++) {
          var num16 = j * num10;
          var num17 = num7 - autoZ(num14, num15);
          var num18;
          if (num17 > 0.0) {
            num18 = (num13 - num5) * Math.tan(materialAngle) - num17;
            if (num18 < 0.0) {
              num18 = 0.0;
            }
          } else {
            num18 = (num13 - num5) * Math.tan(materialAngle);
          }
          var num19 = (Math.pow(num12 + num8, 2.0) - num12 * num12) * num10 / 2.0;
          num11 += num19 * num18;
        }
      }
      return num11;
    },

    CalculateErrorEstimationVolumeSingleBall: function (ball, materialAngle, outObj) {
      var num = 0.0;
      outObj.Verror1 = 0.0;
      var num2 = 0.0;
      var xOffset = ball.xOffset;
      var yOffset = ball.yOffset;
      var num3 = ball.r;
      var num4 = Math.sqrt(Math.pow(ball.x - xOffset, 2.0) + Math.pow(ball.y - yOffset, 2.0));
      var num5 = num4 - num3;
      var num6 = num4 + num3;
      var num7 = 2.0 * Math.atan(num3 / num4);
      var num8 = num6 * Math.tan(materialAngle);
      var num9 = num5 * Math.tan(materialAngle);
      var num10 = num8 * Math.pow(num6, 2.0) * num7 / 2.0 * (2.0 / 3.0);
      var num11 = num9 * Math.pow(num6, 2.0) * num7 / 2.0;
      var num12 = num9 * Math.pow(num5, 2.0) * num7 / 2.0 * (1.0 / 3.0);
      outObj.Verror1 = num10 - num11 + num12;
      num2 = Math.PI * Math.pow(num3, 3.0) * Math.tan(materialAngle) / 3.0;
      if (num4 >= num3) {
        return outObj.Verror1;
      }
      return num2;
    },

    CalculateErrorEstimationVolumeConeSingleBall: function (
      ball, materialAngle, TopConeBaseHeight, SiloHeight, distanceMaxMaterialPickToActialPick,
      xsiTopBaseConeAngle, tanAlpha1
    ) {
      var num = 0.0;
      var num2 = ball.r;
      var xOffset = ball.xOffset;
      var yOffset = ball.yOffset;
      var num3 = Math.sqrt(Math.pow(ball.x, 2.0) + Math.pow(ball.y, 2.0));
      var num4 = Math.sqrt(Math.pow(ball.x - xOffset, 2.0) + Math.pow(ball.y - yOffset, 2.0));
      var num5 = Math.tan(xsiTopBaseConeAngle);
      var num6 = 2.0 * num2 * tanAlpha1;
      var num7 = (num4 + num2) * tanAlpha1;
      var num8 = Math.max(0.0, SiloHeight - (distanceMaxMaterialPickToActialPick + num7));
      var num9 = Math.min(num6, Math.max(0.0, TopConeBaseHeight - num8));
      var num10 = 2.0 * Math.atan(num2 / num4);
      var num11 = num4 + num2;
      var num12 = num11 - (num6 - num9) / num5;
      var num13 = num11 * num5;
      var num14 = num12 * num5;
      var num15 = num13 * Math.pow(num11, 2.0) * num10 / 2.0 * (2.0 / 3.0);
      var num16 = num14 * Math.pow(num11, 2.0) * num10 / 2.0;
      var num17 = num14 * Math.pow(num12, 2.0) * num10 / 2.0 * (1.0 / 3.0);
      num = num15 - num16 + num17;
      return Math.max(num, 0.0);
    },

    ErrorEstimationVolumeSumFinal: function (sr, fuzzyLogicValueSymmetry, fuzzyLogicValCone, numGoodBalls, volueCenterShape, RegrationSpan) {
      if (!isNaN(sr.ErrorEstimationVolumeSumSymmetry)) {
        if (!isNaN(sr.ErrorEstimationVolumeSumNoSymmetry)) {
          sr.ErrorEstimationVolumeSumSymmetry = Math.max(
            sr.ErrorEstimationVolumeSumNoSymmetry * EEC.SymmetryLimiter,
            sr.ErrorEstimationVolumeSumSymmetry
          );
        }
        sr.ErrorEstimationVolumePercentSumSymmetry = 100.0 * sr.ErrorEstimationVolumeSumSymmetry / volueCenterShape;
        sr.ErrorEstimationVolumeSumFinal =
          sr.ErrorEstimationVolumeSumSymmetry * fuzzyLogicValueSymmetry +
          sr.ErrorEstimationVolumeSumNoSymmetry * (1.0 - fuzzyLogicValueSymmetry);
        sr.ErrorEstimationVolumePercentSumFinal = 100.0 * sr.ErrorEstimationVolumeSumFinal / volueCenterShape;
        if (numGoodBalls > 1) {
          var val = fuzzyLogicValCone * RegrationSpan * 2.0 / numGoodBalls;
          val = Math.min(6.0, val);
          var num = val + (1.0 - fuzzyLogicValCone) * sr.ErrorEstimationVolumePercentSumFinal;
          if (num > sr.ErrorEstimationVolumePercentSumFinal) {
            num = sr.ErrorEstimationVolumePercentSumFinal;
          }
          sr.ErrorEstimationVolumePercentSumFinalAlmostFull = num;
        } else {
          sr.ErrorEstimationVolumePercentSumFinalAlmostFull = sr.ErrorEstimationVolumePercentSumFinal;
        }
      } else {
        sr.ErrorEstimationVolumeSumFinal = sr.ErrorEstimationVolumeSumNoSymmetry;
        sr.ErrorEstimationVolumePercentSumFinal = 100.0 * sr.ErrorEstimationVolumeSumFinal / volueCenterShape;
        sr.ErrorEstimationVolumePercentSumFinalAlmostFull = sr.ErrorEstimationVolumePercentSumFinal;
      }
    }
  };

  /* Fix SearchRadius CalcParams alias */
  var _origCreate = createSearchRadius;
  EEC.createSearchRadius = function () {
    var sr = _origCreate();
    sr.CalcParams = sr.calcParams;
    return sr;
  };

  NS.ErrorEstimationCalculation = EEC;
  NS._getClosestScannerToLocation = function (device, x0, y0) {
    var pts = device.ScannerDevicePoints;
    if (!pts) return null;
    var result = null;
    var num = Number.MAX_VALUE;
    var i;
    for (i = 0; i < pts.length; i++) {
      var num2 = Math.pow(pts[i].X - x0, 2.0) + Math.pow(pts[i].Y - y0, 2.0);
      if (num2 < num) {
        result = pts[i];
        num = num2;
      }
    }
    return result;
  };
  NS._calculateTopConeBaseTan = function (device) {
    var vessel = device.VesselInWork;
    var top = vessel.TopShapeType;
    if (top === 'Cone' || top === 1) {
      return vessel.TopShapeHeight / (vessel.CenterShapeDiameter / 2.0 - vessel.TopShapeDiameter / 2.0);
    }
    if (top === 'Dome' || top === 2) {
      var num = Math.sqrt(vessel.TopShapeHeight * (vessel.CenterShapeDiameter - vessel.TopShapeHeight));
      return vessel.TopShapeHeight / num;
    }
    if (top === 'Flat' || top === 0) return 0.0;
    if (top === 'Pyramid' || top === 3) {
      return vessel.TopShapeHeight / (vessel.CenterShapeX / 2.0 - vessel.TopShapeX / 2.0);
    }
    return 0.0;
  };

  NS.DotNetRandom = DotNetRandom;
})(typeof self !== 'undefined' ? self : (typeof globalThis !== 'undefined' ? globalThis : this));
