/* LocatorPlacement.AlgoParameter + ValidateScannersLocation + DeviceCalc volume helpers
 * Port of AlgoParameter.cs MultiScanner defaults/RuleMs* and DeviceGeometry.ValidateScannersLocation.
 */
(function (root) {
  'use strict';
  var NS = root.LocatorPlacement = root.LocatorPlacement || {};
  var PI = Math.PI;

  var ShapeCenterType = { Cylinder: 'Cylinder', Cube: 'Cube' };
  var ShapeTopBottomType = { Flat: 'Flat', Cone: 'Cone', Dome: 'Dome', Pyramid: 'Pyramid' };
  var eColorGradient = {
    NotValid: 0,
    NotValidOutOfGeometry: 1,
    Good: 2,
    Best: 3
  };

  function AlgoParameter() {
    this.VesselInWork = null;
    this.MsMinDistFromFillPointMin = 2.5;
    this.MsMinDistFromFillPointMax1 = 0.66;
    this.MsMinDistFromFillPointMax2 = 10.0;
    this.MsMinDistFromFillPointMin1Narrow = 0.5;
    this.MsMinDistFromFillPointMin2Narrow = 6.0;
    this.MsMinDistSiloWallOneScanner1 = 0.7;
    this.MsMinDistSiloWallOneScanner2 = 6.0;
    this.MsMinDistSiloWallRestScanner1 = 0.7;
    this.MsMinDistSiloWallRestScanner2 = 6.0;
    this.MsMinDistSiloWallOneScanner1Narrow = 0.5;
    this.MsMinDistSiloWallOneScanner2Narrow = 4.0;
    this.MsMinDistSiloWallRestScanner1Narrow = 0.5;
    this.MsMinDistSiloWallRestScanner2Narrow = 4.0;
    this.MsIllegalCiloCenter = 0.5;
    this.MsIllegalCiloCenterNarrow = 0.2;
    this.ShowAlgoMsMinDistFromFillPoint = true;
    this.ShowAlgoMsMinDistFromCenter = true;
    this.ShowAlgoMsSiloWallsOneScanner = true;
    this.ShowAlgoMsSiloWallsRestScanners = true;
    this.ShowAlgoGeometry = true;
    this._widthX = 0;
    this._widthY = 0;
    this._height = 0;
    this._unitsCoeff = 1.0;
  }

  function MsMinDistance(msMinDistFromWall1, msMinDistFromWall2, unitsCoeff, width) {
    return Math.max(msMinDistFromWall1 * unitsCoeff, width / msMinDistFromWall2);
  }

  AlgoParameter.RuleSmallMVLLimits = function (unitsCoeff, width, outObj) {
    outObj.minBandRadius = Math.min(Math.max(0.75 * unitsCoeff, width / 10.0), 2.5 * unitsCoeff);
    outObj.maxBandRadius = outObj.minBandRadius + outObj.minBandRadius / 3.0;
    if (outObj.maxBandRadius > width / 2.0) {
      outObj.maxBandRadius = width / 2.0;
    }
  };

  AlgoParameter.prototype.SetSize = function (widthX, widthY, height, unitsCoeff) {
    this._widthX = widthX;
    this._widthY = widthY;
    this._height = height;
    this._unitsCoeff = unitsCoeff;
  };

  AlgoParameter.prototype.RuleMsMinDistanceFromWallsRestScanners = function () {
    if (this._widthX > 4.0 * this._unitsCoeff) {
      return MsMinDistance(this.MsMinDistSiloWallRestScanner1, this.MsMinDistSiloWallRestScanner2, this._unitsCoeff, this._widthX);
    }
    return MsMinDistance(this.MsMinDistSiloWallRestScanner1Narrow, this.MsMinDistSiloWallRestScanner2Narrow, this._unitsCoeff, this._widthX);
  };

  AlgoParameter.prototype.RuleMsMinDistanceFromWallsRestScannersX = function () {
    return this.RuleMsMinDistanceFromWallsRestScanners();
  };

  AlgoParameter.prototype.RuleMsMinDistanceFromWallsRestScannersY = function () {
    return MsMinDistance(this.MsMinDistSiloWallRestScanner1, this.MsMinDistSiloWallRestScanner2, this._unitsCoeff, this._widthY);
  };

  AlgoParameter.prototype.RuleMsMinDistanceFromWallsOneScanner = function () {
    if (this._widthX > 4.0 * this._unitsCoeff) {
      return MsMinDistance(this.MsMinDistSiloWallOneScanner1, this.MsMinDistSiloWallOneScanner2, this._unitsCoeff, this._widthX);
    }
    return MsMinDistance(this.MsMinDistSiloWallOneScanner1Narrow, this.MsMinDistSiloWallOneScanner2Narrow, this._unitsCoeff, this._widthX);
  };

  AlgoParameter.prototype.RuleMsMinDistanceFromWallsOneScannerX = function () {
    return this.RuleMsMinDistanceFromWallsOneScanner();
  };

  AlgoParameter.prototype.RuleMsMinDistanceFromWallsOneScannerY = function () {
    return MsMinDistance(this.MsMinDistSiloWallOneScanner1, this.MsMinDistSiloWallOneScanner2, this._unitsCoeff, this._widthY);
  };

  AlgoParameter.prototype.RuleMSMaxDistanceFromFillPoint = function () {
    var val = MsMinDistance(this.MsMinDistFromFillPointMax1, this.MsMinDistFromFillPointMax2, this._unitsCoeff, this._widthX);
    return Math.min(val, this.MsMinDistFromFillPointMin * this._unitsCoeff);
  };

  AlgoParameter.prototype.RuleMSMaxDistanceFromFillPointX = function () {
    return this.RuleMSMaxDistanceFromFillPoint();
  };

  AlgoParameter.prototype.RuleMSMaxDistanceFromFillPointY = function () {
    var val = MsMinDistance(this.MsMinDistFromFillPointMax1, this.MsMinDistFromFillPointMax2, this._unitsCoeff, this._widthY);
    return Math.min(val, this.MsMinDistFromFillPointMin);
  };

  function Distance2(x1, y1, x2, y2) {
    return Math.sqrt(Math.pow(x1 - x2, 2.0) + Math.pow(y1 - y2, 2.0));
  }

  function Distance3(x1, y1, z1, x2, y2, z2) {
    return Math.sqrt(Math.pow(x1 - x2, 2.0) + Math.pow(y1 - y2, 2.0) + Math.pow(z1 - z2, 2.0));
  }

  /* Static ValidateScannersLocation — returns flags on outObj */
  function ValidateScannersLocation(
    isCylinderSilo, unitsCoeff, width, widthX, widthY, height, siloRadius, algoPrm,
    x, y, listFill, outObj
  ) {
    var num = 0.0;
    var num2 = 0.0;
    outObj.atLeastOnScannerIsLegal = false;
    outObj.restScannersIsLegal = false;
    outObj.validDistanceCenter = true;
    outObj.validInsideSilo = true;
    outObj.validFillInPointsDistance = true;
    if (isCylinderSilo) {
      num2 = Distance2(x, y, 0.0, 0.0);
      if (num2 > siloRadius) {
        outObj.validInsideSilo = false;
      }
      if (!outObj.validDistanceCenter || !outObj.validInsideSilo) {
        return;
      }
    }
    if (isCylinderSilo) {
      num = Math.abs(siloRadius - num2);
      if (num > algoPrm.RuleMsMinDistanceFromWallsOneScanner()) {
        outObj.atLeastOnScannerIsLegal = true;
      }
      if (num > algoPrm.RuleMsMinDistanceFromWallsRestScanners()) {
        outObj.restScannersIsLegal = true;
      }
    } else {
      var val = Math.abs(widthX / 2.0 + x);
      var val2 = Math.abs(widthX / 2.0 - x);
      var val3 = Math.abs(widthY / 2.0 - y);
      var val4 = Math.abs(widthY / 2.0 + y);
      var num3 = Math.min(val, val2);
      var num4 = Math.min(val3, val4);
      if (num3 > algoPrm.RuleMsMinDistanceFromWallsOneScannerX() && num4 > algoPrm.RuleMsMinDistanceFromWallsOneScannerY()) {
        outObj.atLeastOnScannerIsLegal = true;
      }
      if (num3 > algoPrm.RuleMsMinDistanceFromWallsRestScannersX() && num4 > algoPrm.RuleMsMinDistanceFromWallsRestScannersY()) {
        outObj.restScannersIsLegal = true;
      }
    }
    var fi;
    for (fi = 0; fi < listFill.length; fi++) {
      var item = listFill[fi];
      var num5 = Distance3(x, y, height, item.X, item.Y, height);
      if (isCylinderSilo) {
        if (num5 < algoPrm.RuleMSMaxDistanceFromFillPoint()) {
          outObj.validFillInPointsDistance = false;
          return;
        }
      } else if (num5 < algoPrm.RuleMSMaxDistanceFromFillPointX() && num5 < algoPrm.RuleMSMaxDistanceFromFillPointY()) {
        outObj.validFillInPointsDistance = false;
        return;
      }
    }
    if (outObj.atLeastOnScannerIsLegal && outObj.atLeastOnScannerIsLegal && !isCylinderSilo) {
      /* empty branch preserved from source */
    }
  }

  /* DeviceCalc volume helpers (needed by ErrorEstimationCal) */
  var DeviceCalc = {
    CalculateVolumeCylinder: function (radius, height) {
      return Math.PI * Math.pow(radius, 2.0) * height;
    },
    CalculateVolumeCube: function (widthX, widthY, height) {
      return widthX * widthY * height;
    },
    CalculateVolumeCone: function (radiusBase, radiusTop, height) {
      if (Math.abs(radiusBase - radiusTop) < 0.0001) {
        return DeviceCalc.CalculateVolumeCylinder(radiusBase, height);
      }
      var num = height / (radiusBase - radiusTop);
      var num2 = radiusBase * num;
      var num3 = Math.PI * Math.pow(radiusBase, 2.0) * num2 / 3.0;
      var num4 = Math.PI * Math.pow(radiusTop, 2.0) * (num2 - height) / 3.0;
      return num3 - num4;
    },
    CalcDomeVolume: function (dDistance, dDiameter, height) {
      if (dDistance <= 0.0) return 0.0;
      var num = (dDiameter * dDiameter / 4.0 + height * height) / (2.0 * height);
      var num2 = Math.sqrt(num * num - Math.pow(num - dDistance, 2.0));
      var num3 = Math.PI / 6.0 * dDistance * (3.0 * num2 * num2 + dDistance * dDistance);
      if (isNaN(num3)) return 0.0;
      return num3;
    },
    CalculateVolumeDome: function (centerDiameter, height) {
      if (height === 0.0) return 0.0;
      return DeviceCalc.CalcDomeVolume(height, centerDiameter, height) - 0.0;
    },
    CalculateVolumePyramid: function (widthBaseX, widthBaseY, widthX, widthY, height) {
      return height / 6.0 * (widthBaseX * widthBaseY + (widthBaseX + widthX) * (widthBaseY + widthY) + widthX * widthY);
    },
    CalculateVolume: function (device) {
      var num = 0.0;
      var v = device.VesselInWork;
      var cst = v.CenterShapeType;
      if (cst === ShapeCenterType.Cylinder || cst === 'Cylinder') {
        num += DeviceCalc.CalculateVolumeCylinder(v.CenterShapeDiameter / 2.0, v.CenterShapeHeight);
      } else if (cst === ShapeCenterType.Cube || cst === 'Cube') {
        num += DeviceCalc.CalculateVolumeCube(v.CenterShapeX, v.CenterShapeY, v.CenterShapeHeight);
      }
      var top = v.TopShapeType;
      if (top === ShapeTopBottomType.Cone || top === 'Cone') {
        num += DeviceCalc.CalculateVolumeCone(v.CenterShapeDiameter / 2.0, v.TopShapeDiameter / 2.0, v.TopShapeHeight);
      } else if (top === ShapeTopBottomType.Dome || top === 'Dome') {
        num += DeviceCalc.CalculateVolumeDome(v.CenterShapeDiameter, v.TopShapeHeight);
      } else if (top === ShapeTopBottomType.Pyramid || top === 'Pyramid') {
        num += DeviceCalc.CalculateVolumePyramid(v.CenterShapeX, v.CenterShapeY, v.TopShapeX, v.TopShapeY, v.TopShapeHeight);
      }
      var bot = v.BottomShapeType;
      if (bot === ShapeTopBottomType.Cone || bot === 'Cone') {
        num += DeviceCalc.CalculateVolumeCone(v.CenterShapeDiameter / 2.0, v.BottomShapeDiameter / 2.0, v.BottomShapeHeight);
      } else if (bot === ShapeTopBottomType.Dome || bot === 'Dome') {
        num += DeviceCalc.CalculateVolumeDome(v.CenterShapeDiameter, v.BottomShapeHeight);
      } else if (bot === ShapeTopBottomType.Pyramid || bot === 'Pyramid') {
        num += DeviceCalc.CalculateVolumePyramid(v.CenterShapeX, v.CenterShapeY, v.BottomShapeX, v.BottomShapeY, v.BottomShapeHeight);
      }
      return num;
    }
  };

  function GetCenterShapeDiameterForCalculation(vessel) {
    if (vessel.CenterShapeType === ShapeCenterType.Cube || vessel.CenterShapeType === 'Cube') {
      return (vessel.CenterShapeX + vessel.CenterShapeY) / 2.0;
    }
    return vessel.CenterShapeDiameterMeter != null ? vessel.CenterShapeDiameterMeter : vessel.CenterShapeDiameter;
  }

  NS.ShapeCenterType = ShapeCenterType;
  NS.ShapeTopBottomType = ShapeTopBottomType;
  NS.eColorGradient = eColorGradient;
  NS.AlgoParameter = AlgoParameter;
  NS.DeviceGeometry = {
    Distance: Distance2,
    Distance3: Distance3,
    ValidateScannersLocation: ValidateScannersLocation
  };
  NS.DeviceCalc = DeviceCalc;
  NS.AlgoCalc = { GetCenterShapeDiameterForCalculation: GetCenterShapeDiameterForCalculation };

  /* Baked config defaults from app.config / code field initializers */
  NS.DEFAULTS = {
    BallsMatix: 111,
    NumberOfBadBallsAccurate: 50,
    NumberOfBadBallsFast: 12,
    NumRanges: 10,
    IsFastErrorEstimationAlgorithm: true,
    ExhaustiveSearchResolution: 31,
    ExhaustiveSearchResolutionRough: 8,
    ExhaustiveSearchResolutionRoughConfig: 13,
    ExhaustiveSearchResolutionRough2Scanners: 10,
    ExhaustiveSearchResolutionRough2ScannersConfig: 15,
    ExhaustiveSearchResolutionInternalLoop: 6,
    ScannerAngleDeg: 25.0,
    ScannerAngleWideDeg: 40.0,
    MaterialAngleDeg: 30.0,
    SymmetryLimiter: 0.1,
    OrangeLineFactor: 2.0,
    ErrorEstimMaxHeightBelowHighestFillingPoint: 0.5,
    ErrorEstimationUseVesselSizePenalty: true,
    ErrorEstimationLowFrequencyFrom: 0.8,
    ErrorEstimLowFreqMove2HighFreqCoeff: 1.0,
    maxErrorStage1: 3.5,
    maxErrorStage2: 4.5,
    maxErrorStage3: 6.0,
    maxErrorDisplayToUserStage3: 6.0,
    FinePassCellScale: 1.5
  };
})(typeof self !== 'undefined' ? self : (typeof globalThis !== 'undefined' ? globalThis : this));
