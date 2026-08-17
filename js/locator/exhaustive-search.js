/* LocatorPlacement.ExhaustiveSearch
 * Port of ExhaustiveSearchExe MatrixExhaustiveSearch flow (1–3 scanners).
 * Uses LocatorPlacement.ErrorEstimationCal + geometry ValidateScannersLocation.
 */
(function (global) {
  "use strict";
  var NS = global.LocatorPlacement = global.LocatorPlacement || {};

  function createBoolGrid(nx, ny, fill) {
    var g = new Array(nx);
    var i, j;
    for (i = 0; i < nx; i++) {
      g[i] = new Array(ny);
      for (j = 0; j < ny; j++) g[i][j] = !!fill;
    }
    return g;
  }

  function ErrorEstimBestResult() {
    this.indexXBestResult = -1;
    this.indexYBestResult = -1;
    this.BestScannerPositionX = 0;
    this.BestScannerPositionY = 0;
    this.BestScannerPositionZ = 0;
    this.ScannerGeom = null;
    this.DevicePoint = null;
  }

  function ExhaustiveSearchExe(options) {
    options = options || {};
    var D = NS.DEFAULTS || {};
    var C = (global.LocatorAlgo && global.LocatorAlgo.Constants) || {};
    this.ExhaustiveSearchResolutionRough = D.ExhaustiveSearchResolutionRoughConfig || C.ExhaustiveSearchResolutionRough || 13;
    this.ExhaustiveSearchResolutionRough2Scanners = D.ExhaustiveSearchResolutionRough2ScannersConfig || C.ExhaustiveSearchResolutionRough2Scanners || 15;
    this.ExhaustiveSearchResolutionInternalLoop = D.ExhaustiveSearchResolutionInternalLoop || C.ExhaustiveSearchResolutionInternalLoop || 6;
    this.ExhaustiveSearchResolution = D.ExhaustiveSearchResolution || C.ExhaustiveSearchResolution || 31;
    this.NumberOfBadBallsAccurate = D.NumberOfBadBallsAccurate || C.NumberOfBadBallsAccurate || 50;
    this.NumberOfBadBallsFast = D.NumberOfBadBallsFast || C.NumberOfBadBallsFast || 12;
    this.allExhaustiveSearchSteps = true;
    this.exhaustiveSearchStopByUser = false;
    this.calculateAllRows = false;
    this.calculatePerformance = false;
    this.deviceInWork = null;
    this.errorEstimationCal = null;
    this.fuzzyManager = null;
    this.algoParameter = null;
    this.errorEstimMaxHeightMeter = 0;
    this.onProgress = null;
    this.shouldCancel = null;
  }

  ExhaustiveSearchExe.prototype._defaults = function () {
    return NS.DEFAULTS || {};
  };

  ExhaustiveSearchExe.prototype.NumDivExhaustiveSearch = function (numScanners) {
    if (numScanners === 2) return this.ExhaustiveSearchResolutionRough2Scanners;
    if (numScanners >= 3) return this.ExhaustiveSearchResolutionRough;
    return this.ExhaustiveSearchResolution;
  };

  ExhaustiveSearchExe.prototype.PrepareNumberOfBadBalls = function (accurate) {
    var n = accurate ? this.NumberOfBadBallsAccurate : this.NumberOfBadBallsFast;
    this.errorEstimationCal.NumberOfBadBallsAccurate = n;
  };

  ExhaustiveSearchExe.prototype._autoZ = function (x, y) {
    var v = this.deviceInWork.VesselInWork;
    if (NS.autoCalculateZFromVesselBottom) {
      return NS.autoCalculateZFromVesselBottom(v, x, y);
    }
    if (v.AutoCalculateZFromVesselBottom) {
      return v.AutoCalculateZFromVesselBottom(x, y);
    }
    return v.TotalHeightMeter || v.TotalHeight || 0;
  };

  ExhaustiveSearchExe.prototype.MatrixExhaustiveSearchDimensions = function (p) {
    var vesselInWork = p.deviceInWork.VesselInWork;
    var num, num2, widthVesselCenter;
    if (vesselInWork.CenterShapeType === "Cylinder" || vesselInWork.CenterShapeType === (NS.ShapeCenterType && NS.ShapeCenterType.Cylinder)) {
      num = vesselInWork.CenterShapeDiameter;
      num2 = num;
      widthVesselCenter = num;
    } else {
      num = vesselInWork.CenterShapeX;
      num2 = vesselInWork.CenterShapeY;
      widthVesselCenter = Math.sqrt(num * num2);
    }
    p.widthVesselCenter = widthVesselCenter;
    p.widthXVesselCenter = num;
    p.widthYVesselCenter = num2;
    p.widthX = num;
    p.widthY = num2;
    p.meshSizeXHalf = p.widthX / p.numDivX;
    p.meshSizeYHalf = p.widthY / p.numDivY;
    this.MatrixExhaustiveSearchDimensionsStartEnd(p);
  };

  ExhaustiveSearchExe.prototype.MatrixExhaustiveSearchDimensionsStartEnd = function (p) {
    p.measXStart = (0.0 - p.widthX) / 2.0 + p.meshSizeXHalf / 2.0;
    p.measYStart = (0.0 - p.widthY) / 2.0 + p.meshSizeYHalf / 2.0;
    p.measXEnd = p.widthX / 2.0 - p.meshSizeXHalf / 2.0;
    p.measYEnd = p.widthY / 2.0 - p.meshSizeYHalf / 2.0;
  };

  ExhaustiveSearchExe.prototype.ValidateScannersLocationColor = function (
    isCylinderSilo, unitsCoeff, width, widthX, widthY, height, siloRadius, algoPrm, x, y, listFill
  ) {
    var outObj = {};
    NS.DeviceGeometry.ValidateScannersLocation(
      isCylinderSilo, unitsCoeff, width, widthX, widthY, height, siloRadius, algoPrm, x, y, listFill, outObj
    );
    if (!outObj.validInsideSilo) return NS.eColorGradient.NotValidOutOfGeometry;
    if (!outObj.validDistanceCenter) return NS.eColorGradient.NotValid;
    if (!outObj.validFillInPointsDistance) return NS.eColorGradient.NotValid;
    if (!outObj.atLeastOnScannerIsLegal && !outObj.restScannersIsLegal) return NS.eColorGradient.NotValid;
    return NS.eColorGradient.Good;
  };

  ExhaustiveSearchExe.prototype.MatrixExhaustiveValidateScannersLocation = function (
    matrixNodeForCalculation, centerAnd4Vertices, listFill, centerPointShiftX, centerPointShiftY, p
  ) {
    var algoParameter = this.algoParameter || new NS.AlgoParameter();
    algoParameter.SetSize(p.widthXVesselCenter, p.widthYVesselCenter, p.height, 1.0);
    var num = 0;
    var unitsCoeff = 1.0;
    var height = p.height;
    var siloRadius = p.siloRadius;
    var isCylinderSilo = p.isCylinderSilo;
    var widthVesselCenter = p.widthVesselCenter;
    var widthXVesselCenter = p.widthXVesselCenter;
    var widthYVesselCenter = p.widthYVesselCenter;
    var meshSizeXHalf = p.meshSizeXHalf;
    var meshSizeYHalf = p.meshSizeYHalf;
    var num2 = -1;
    var num3 = -1;
    var num4, num5, num6, num7, eColorGradient2, flag;
    for (num4 = p.measXStart; num4 <= p.measXEnd; num4 += meshSizeXHalf) {
      num2++;
      num3 = -1;
      num5 = num4 + centerPointShiftX;
      for (num6 = p.measYStart; num6 <= p.measYEnd; num6 += meshSizeYHalf) {
        num3++;
        num7 = num6 + centerPointShiftY;
        eColorGradient2 = this.ValidateScannersLocationColor(
          isCylinderSilo, unitsCoeff, widthVesselCenter, widthXVesselCenter, widthYVesselCenter,
          height, siloRadius, algoParameter, num5, num7, listFill
        );
        flag = true;
        if (eColorGradient2 === NS.eColorGradient.Good || eColorGradient2 === NS.eColorGradient.Best) {
          flag = false;
        }
        if (centerAnd4Vertices && flag) {
          /* optional 4-vertex recheck omitted when centerAnd4Vertices is false (default) */
        }
        if (flag) {
          matrixNodeForCalculation[num2][num3] = false;
          continue;
        }
        matrixNodeForCalculation[num2][num3] = true;
        num++;
      }
    }
    return num;
  };

  ExhaustiveSearchExe.prototype.IsRemovedBySameCell = function (
    iXScanner1, iYScanner1, iXScanner2, iYScanner2, iXScanner3, iYScanner3, dict
  ) {
    var num = iXScanner1 * 1000 + iYScanner1;
    var num2 = iXScanner2 * 1000 + iYScanner2;
    var num3 = iXScanner3 * 1000 + iYScanner3;
    if (iXScanner3 > 0 && (num === num2 || num === num3 || num2 === num3)) return true;
    if (iXScanner2 > 0 && num === num2) return true;
    var num4 = Math.min(Math.min(num, num2), num3);
    var num5 = Math.max(Math.max(num, num2), num3);
    var num6 = num;
    if (num2 !== num4 && num2 !== num5) num6 = num2;
    if (num3 !== num4 && num3 !== num5) num6 = num3;
    var key = num4 + "," + num6 + "," + num5;
    if (dict[key]) return true;
    dict[key] = true;
    return false;
  };

  ExhaustiveSearchExe.prototype.MatrixExhaustiveSearchFillCurrentScanner = function (best, x, y) {
    best.ScannerGeom.ScannerPositionX = x;
    best.ScannerGeom.ScannerPositionY = y;
    best.DevicePoint.X = x;
    best.DevicePoint.Y = y;
    best.DevicePoint.ScannerZOffsetFromVesselTop = best.ScannerGeom.ScannerZOffsetFromVesselTop;
  };

  ExhaustiveSearchExe.prototype._cancelled = function () {
    if (this.exhaustiveSearchStopByUser) return true;
    if (this.shouldCancel && this.shouldCancel()) return true;
    return false;
  };

  ExhaustiveSearchExe.prototype._reportProgress = function (current, total, maxError) {
    if (!this.onProgress) return;
    var now = Date.now();
    var est = this._progressEstTotal || total || 1;
    var cur = current;
    if (total > est) est = total;
    if (cur > est) est = cur;
    // Tight loops can post thousands of times and freeze the page. Cap ~8/sec.
    if (this._lastProgressAt && now - this._lastProgressAt < 120 && cur < est) return;
    this._lastProgressAt = now;
    this.onProgress({ current: cur, total: est, maxError: maxError });
  };

  ExhaustiveSearchExe.prototype.MatrixExhaustiveSearchSingleScanners = function (
    matrixNodeForCalculation, minDistanceBetweenScannersPower2, sbGeneralExceptionByAlgorithm,
    errorEstimBestResult, multiScanners, dictRemoveMatrixIndexSameCombination, numScanners,
    iXScanner2, iYScanner2, iXScanner3, iYScanner3,
    xScanner2, yScanner2, zScanner2, xScanner3, yScanner3, zScanner3,
    centerPointShiftX, centerPointShiftY, p, state
  ) {
    var result = false;
    var errorEstimMaxHeightMeter = this.errorEstimMaxHeightMeter;
    var meshSizeXHalf = p.meshSizeXHalf;
    var meshSizeYHalf = p.meshSizeYHalf;
    var num = -1;
    var num2 = -1;
    var num3 = 0.0;
    var num4, num5, num6, num7;
    for (num4 = p.measXStart; num4 <= p.measXEnd; num4 += meshSizeXHalf) {
      num++;
      num2 = -1;
      num5 = num4 + centerPointShiftX;
      for (num6 = p.measYStart; num6 <= p.measYEnd; num6 += meshSizeYHalf) {
        num2++;
        num7 = num6 + centerPointShiftY;
        num3 = this._autoZ(num5, num7);
        if (
          num < 0 ||
          num2 < 0 ||
          !matrixNodeForCalculation[num] ||
          matrixNodeForCalculation[num][num2] == null
        ) {
          continue;
        }
        if (!matrixNodeForCalculation[num][num2]) continue;
        if (this._cancelled()) return false;
        if (multiScanners) {
          if (this.IsRemovedBySameCell(num, num2, iXScanner2, iYScanner2, iXScanner3, iYScanner3, dictRemoveMatrixIndexSameCombination)) {
            break;
          }
          var num8;
          if (iXScanner3 > -1) {
            num8 = Math.pow(xScanner3 - num5, 2.0) + Math.pow(yScanner3 - num7, 2.0);
            if (num8 < minDistanceBetweenScannersPower2) break;
          }
          num8 = Math.pow(xScanner2 - num5, 2.0) + Math.pow(yScanner2 - num7, 2.0);
          if (num8 < minDistanceBetweenScannersPower2) break;
        }
        state.numCumulativeCalc++;
        this.MatrixExhaustiveSearchFillCurrentScanner(errorEstimBestResult, num5, num7);
        var device = this.deviceInWork;
        device.Scanners[0].ScannerPositionX = num5;
        device.Scanners[0].ScannerPositionY = num7;
        device.Scanners[0].ScannerPositionZ = num3;
        device.ScannerDevicePoints[0].X = num5;
        device.ScannerDevicePoints[0].Y = num7;
        device.ScannerDevicePoints[0].Z = num3;
        if (numScanners >= 2) {
          device.Scanners[1].ScannerPositionX = xScanner2;
          device.Scanners[1].ScannerPositionY = yScanner2;
          device.Scanners[1].ScannerPositionZ = zScanner2;
          device.ScannerDevicePoints[1].X = xScanner2;
          device.ScannerDevicePoints[1].Y = yScanner2;
          device.ScannerDevicePoints[1].Z = zScanner2;
        }
        if (numScanners >= 3) {
          device.Scanners[2].ScannerPositionX = xScanner3;
          device.Scanners[2].ScannerPositionY = yScanner3;
          device.Scanners[2].ScannerPositionZ = zScanner3;
          device.ScannerDevicePoints[2].X = xScanner3;
          device.ScannerDevicePoints[2].Y = yScanner3;
          device.ScannerDevicePoints[2].Z = zScanner3;
        }
        this.errorEstimationCal.PrepareNewCalculationInsideCalculationLoop();
        var flag = this.errorEstimationCal.CalculateErrorEstimation(
          sbGeneralExceptionByAlgorithm, this.calculatePerformance, errorEstimMaxHeightMeter,
          null, p.calculateAllRows, state.maxErrorIndex, state.maxErrorTotal
        );
        var num10 = NS.ErrorEstimationCal.MaxError(this.errorEstimationCal.SearchRadiusList);
        if (!flag) {
          if (num10 < state.maxErrorTotal) {
            result = true;
            errorEstimBestResult.indexXBestResult = num;
            errorEstimBestResult.indexYBestResult = num2;
            errorEstimBestResult.BestScannerPositionX = num5;
            errorEstimBestResult.BestScannerPositionY = num7;
            errorEstimBestResult.BestScannerPositionZ = num3;
            state.maxErrorTotal = num10;
            state.maxErrorIndex = NS.ErrorEstimationCal.MaxErrorIndex(this.errorEstimationCal.SearchRadiusList);
          }
        }
        if (multiScanners) {
          this._reportProgress(
            state.numCumulativeCalc,
            this._progressEstTotal || Math.max(state.numCalc, state.numCumulativeCalc),
            state.maxErrorTotal
          );
        }
      }
      if (!multiScanners) {
        this._reportProgress(state.numCumulativeCalc, state.numCalc, state.maxErrorTotal);
      }
    }
    return result;
  };

  ExhaustiveSearchExe.prototype.MatrixExhaustiveSearchAllScanners = function (
    matrixNodeForCalculations, minDistanceBetweenScannersPower2, sbGeneralExceptionByAlgorithm,
    listErrorEstimBestResult, listCenterPointShiftX, listCenterPointShiftY, p, state
  ) {
    state.numCumulativeCalc = 0;
    var num = -1, num2 = -1, num3 = -1, iYScanner = -1;
    var xScanner = 0, yScanner = 0, zScanner = 0;
    var xScanner2 = 0, yScanner2 = 0, zScanner2 = 0;
    var errorEstimBestResult = listErrorEstimBestResult[0];
    var errorEstimBestResult2 = null;
    var errorEstimBestResult3 = null;
    var matrixNodeForCalculation = matrixNodeForCalculations[0];
    var array = null;
    var array2 = null;
    var multiScanners = listErrorEstimBestResult.length > 1;
    var dict = {};
    var centerPointShiftX = listCenterPointShiftX[0];
    var centerPointShiftY = listCenterPointShiftY[0];
    var num4 = 0, num5 = 0, num6 = 0, num7 = 0;
    var num8 = 0;
    var meshSizeXHalf = p.meshSizeXHalf;
    var meshSizeYHalf = p.meshSizeYHalf;
    var num9 = (p.widthX / meshSizeXHalf) * (p.widthY / meshSizeYHalf);
    var count = listErrorEstimBestResult.length;
    var nDiv = Math.max(1, p.numDivX || 1);
    if (count <= 1) this._progressEstTotal = nDiv * nDiv;
    else if (count === 2) this._progressEstTotal = nDiv * nDiv * nDiv * nDiv;
    else this._progressEstTotal = nDiv * nDiv * nDiv * nDiv * nDiv * nDiv;
    this._lastProgressAt = 0;
    this._reportProgress(0, this._progressEstTotal, state.maxErrorTotal);
    if (count === 2 || count === 3) {
      errorEstimBestResult2 = listErrorEstimBestResult[1];
      array = matrixNodeForCalculations[1];
      num4 = listCenterPointShiftX[1];
      num5 = listCenterPointShiftY[1];
      if (count === 3) {
        num6 = listCenterPointShiftX[2];
        num7 = listCenterPointShiftY[2];
        errorEstimBestResult3 = listErrorEstimBestResult[2];
        array2 = matrixNodeForCalculations[2];
      }
    }
    var self = this;
    if (count === 1) {
      this.MatrixExhaustiveSearchSingleScanners(
        matrixNodeForCalculation, minDistanceBetweenScannersPower2, sbGeneralExceptionByAlgorithm,
        errorEstimBestResult, multiScanners, dict, count,
        -1, -1, -1, -1, 0, 0, 0, 0, 0, 0,
        centerPointShiftX, centerPointShiftY, p, state
      );
    } else if (count === 2) {
      state.maxErrorIndex = -1;
      num = -1;
      for (var num12 = p.measXStart; num12 <= p.measXEnd; num12 += meshSizeXHalf) {
        num++;
        num2 = -1;
        xScanner = num12 + num4;
        state.maxErrorIndex = -1;
        for (var num13 = p.measYStart; num13 <= p.measYEnd; num13 += meshSizeYHalf) {
          num2++;
          yScanner = num13 + num5;
          zScanner = this._autoZ(xScanner, yScanner);
          num8++;
          if (
            array &&
            array[num] &&
            array[num][num2]
          ) {
            this.MatrixExhaustiveSearchFillCurrentScanner(errorEstimBestResult2, xScanner, yScanner);
            if (this.MatrixExhaustiveSearchSingleScanners(
              matrixNodeForCalculation, minDistanceBetweenScannersPower2, sbGeneralExceptionByAlgorithm,
              errorEstimBestResult, multiScanners, dict, count,
              num, num2, -1, -1, xScanner, yScanner, zScanner, 0, 0, 0,
              centerPointShiftX, centerPointShiftY, p, state
            )) {
              errorEstimBestResult2.indexXBestResult = num;
              errorEstimBestResult2.indexYBestResult = num2;
              errorEstimBestResult2.BestScannerPositionX = xScanner;
              errorEstimBestResult2.BestScannerPositionY = yScanner;
              errorEstimBestResult2.BestScannerPositionZ = zScanner;
            }
          }
        }
        this._reportProgress(
          state.numCumulativeCalc || num8,
          this._progressEstTotal || num9,
          state.maxErrorTotal
        );
        if (this._cancelled()) return;
      }
    } else if (count === 3) {
      num9 *= num9;
      num3 = -1;
      for (var num10 = p.measXStart; num10 <= p.measXEnd; num10 += meshSizeXHalf) {
        num3++;
        iYScanner = -1;
        xScanner2 = num10 + num6;
        for (var num11 = p.measYStart; num11 <= p.measYEnd; num11 += meshSizeYHalf) {
          iYScanner++;
          yScanner2 = num11 + num7;
          zScanner2 = this._autoZ(xScanner2, yScanner2);
          num = -1;
          num8++;
          state.maxErrorIndex = -1;
          if (!array2 || !array2[num3] || !array2[num3][iYScanner]) continue;
          var flag = false;
          for (num12 = p.measXStart; num12 <= p.measXEnd; num12 += meshSizeXHalf) {
            if (flag) break;
            num++;
            num2 = -1;
            xScanner = num12 + num4;
            for (num13 = p.measYStart; num13 <= p.measYEnd; num13 += meshSizeYHalf) {
              if (flag) break;
              num2++;
              yScanner = num13 + num5;
              zScanner = this._autoZ(xScanner, yScanner);
              num8++;
              if (!array || !array[num] || !array[num][num2]) continue;
              this.MatrixExhaustiveSearchFillCurrentScanner(errorEstimBestResult2, xScanner, yScanner);
              var num14 = Math.pow(xScanner2 - xScanner, 2.0) + Math.pow(yScanner2 - yScanner, 2.0);
              if (num14 < minDistanceBetweenScannersPower2) {
                flag = true;
                break;
              }
              if (this.MatrixExhaustiveSearchSingleScanners(
                matrixNodeForCalculation, minDistanceBetweenScannersPower2, sbGeneralExceptionByAlgorithm,
                errorEstimBestResult, multiScanners, dict, count,
                num, num2, num3, iYScanner, xScanner, yScanner, zScanner, xScanner2, yScanner2, zScanner2,
                centerPointShiftX, centerPointShiftY, p, state
              )) {
                errorEstimBestResult2.indexXBestResult = num;
                errorEstimBestResult2.indexYBestResult = num2;
                errorEstimBestResult2.BestScannerPositionX = xScanner;
                errorEstimBestResult2.BestScannerPositionY = yScanner;
                errorEstimBestResult2.BestScannerPositionZ = zScanner;
                if (errorEstimBestResult3) {
                  errorEstimBestResult3.indexXBestResult = num3;
                  errorEstimBestResult3.indexYBestResult = iYScanner;
                  errorEstimBestResult3.BestScannerPositionX = xScanner2;
                  errorEstimBestResult3.BestScannerPositionY = yScanner2;
                  errorEstimBestResult3.BestScannerPositionZ = zScanner2;
                }
              }
            }
            this._reportProgress(
              state.numCumulativeCalc || num8,
              this._progressEstTotal || num9,
              state.maxErrorTotal
            );
          }
          if (this._cancelled()) return;
        }
      }
    }
  };

  ExhaustiveSearchExe.prototype.MatrixExhaustiveSearch = function (p) {
    var ErrorEstimationCal = NS.ErrorEstimationCal;
    this.errorEstimationCal.ClearSearchRadiusList();
    var device = p.deviceInWork;
    var vesselInWork = device.VesselInWork;
    var totalHeight = vesselInWork.TotalHeight;
    var fillPoints = device.FillPoints;
    var num2 = p.widthVesselCenter / 2.0;
    var minDistanceBetweenScannersPower = Math.pow(1.0 * num2 / 2.0, 2.0);
    var isCylinderSilo = vesselInWork.CenterShapeType === "Cylinder" ||
      vesselInWork.CenterShapeType === (NS.ShapeCenterType && NS.ShapeCenterType.Cylinder);
    var centerAnd4Vertices = false;
    var sbGeneralExceptionByAlgorithm = [];
    p.siloRadius = num2;
    p.height = totalHeight;
    p.isCylinderSilo = isCylinderSilo;
    this.MatrixExhaustiveSearchDimensionsStartEnd(p);

    var list3 = [];
    var list4 = [];
    var list5 = [];
    var item = createBoolGrid(p.numDivX, p.numDivY, false);
    var i;
    for (i = 0; i < device.Scanners.length; i++) {
      list5.push(item);
      list3.push(0.0);
      list4.push(0.0);
    }
    var num3 = this.MatrixExhaustiveValidateScannersLocation(list5[0], centerAnd4Vertices, fillPoints, 0.0, 0.0, p);

    var list6 = [];
    for (i = 0; i < device.Scanners.length; i++) {
      var best = new ErrorEstimBestResult();
      best.ScannerGeom = device.Scanners[i];
      best.DevicePoint = device.ScannerDevicePoints[i];
      list6.push(best);
    }

    var state = {
      numCalc: num3,
      numCumulativeCalc: 0,
      maxErrorTotal: Number.MAX_VALUE,
      maxErrorIndex: -1
    };

    this.errorEstimationCal.SearchRadiusList.length = 0;
    this.PrepareNumberOfBadBalls(true);
    this.errorEstimationCal.CalculateErrorEstimation(
      sbGeneralExceptionByAlgorithm, p.calculatePerformance, this.errorEstimMaxHeightMeter,
      null, true, state.maxErrorIndex, state.maxErrorTotal
    );
    /* Seed timing only — search starts from MaxValue like C# */
    this.errorEstimationCal.SearchRadiusList.length = 0;
    this.PrepareNumberOfBadBalls(false);
    state.maxErrorTotal = Number.MAX_VALUE;
    state.maxErrorIndex = -1;

    this.MatrixExhaustiveSearchAllScanners(
      list5, minDistanceBetweenScannersPower, sbGeneralExceptionByAlgorithm,
      list6, list3, list4, p, state
    );

    /* Apply rough best to device */
    var roughBest = [];
    for (i = 0; i < list6.length; i++) {
      var br = list6[i];
      roughBest.push({ X: br.BestScannerPositionX, Y: br.BestScannerPositionY, Z: br.BestScannerPositionZ });
      device.Scanners[i].ScannerPositionX = br.BestScannerPositionX;
      device.Scanners[i].ScannerPositionY = br.BestScannerPositionY;
      device.Scanners[i].ScannerPositionZ = br.BestScannerPositionZ;
      device.ScannerDevicePoints[i].X = br.BestScannerPositionX;
      device.ScannerDevicePoints[i].Y = br.BestScannerPositionY;
      device.ScannerDevicePoints[i].Z = br.BestScannerPositionZ;
    }
    var roughMaxError = state.maxErrorTotal;

    /* Fine pass when multi-scanner and allSteps */
    if (this.allExhaustiveSearchSteps && device.Scanners.length > 1 && !this._cancelled()) {
      var meshSizeXHalf = p.meshSizeXHalf;
      var meshSizeYHalf = p.meshSizeYHalf;
      var num6scale = (this._defaults().FinePassCellScale != null) ? this._defaults().FinePassCellScale : 1.5;
      p.numDivX = this.ExhaustiveSearchResolutionInternalLoop;
      p.numDivY = this.ExhaustiveSearchResolutionInternalLoop;
      p.widthX = meshSizeXHalf * num6scale;
      p.widthY = meshSizeYHalf * num6scale;
      p.meshSizeXHalf = p.widthX / p.numDivX;
      p.meshSizeYHalf = p.widthY / p.numDivY;
      list3 = [];
      list4 = [];
      list5 = [];
      for (i = 0; i < device.Scanners.length; i++) {
        list3.push(device.Scanners[i].ScannerPositionX);
        list4.push(device.Scanners[i].ScannerPositionY);
        list6[i].BestScannerPositionX = device.Scanners[i].ScannerPositionX;
        list6[i].BestScannerPositionY = device.Scanners[i].ScannerPositionY;
        list6[i].BestScannerPositionZ = device.Scanners[i].ScannerPositionZ;
        list5.push(createBoolGrid(p.numDivX, p.numDivY, false));
      }
      this.MatrixExhaustiveSearchDimensionsStartEnd(p);
      for (i = 0; i < device.Scanners.length; i++) {
        this.MatrixExhaustiveValidateScannersLocation(
          list5[i], false, fillPoints, list3[i], list4[i], p
        );
      }
      state.maxErrorTotal = Number.MAX_VALUE;
      state.maxErrorIndex = -1;
      this.errorEstimationCal.SearchRadiusList.length = 0;
      this.PrepareNumberOfBadBalls(true);
      this.errorEstimationCal.PrepareNewCalculationInsideCalculationLoop();
      this.errorEstimationCal.CalculateErrorEstimation(
        sbGeneralExceptionByAlgorithm, p.calculatePerformance, this.errorEstimMaxHeightMeter,
        null, true, state.maxErrorIndex, state.maxErrorTotal
      );
      this.errorEstimationCal.SearchRadiusList.length = 0;
      this.PrepareNumberOfBadBalls(false);
      this.errorEstimationCal.PrepareNewCalculationInsideCalculationLoop();
      this.MatrixExhaustiveSearchAllScanners(
        list5, minDistanceBetweenScannersPower, sbGeneralExceptionByAlgorithm,
        list6, list3, list4, p, state
      );
      if (roughMaxError < state.maxErrorTotal) {
        for (i = 0; i < roughBest.length; i++) {
          device.ScannerDevicePoints[i].X = roughBest[i].X;
          device.ScannerDevicePoints[i].Y = roughBest[i].Y;
          device.ScannerDevicePoints[i].Z = roughBest[i].Z;
          device.Scanners[i].ScannerPositionX = roughBest[i].X;
          device.Scanners[i].ScannerPositionY = roughBest[i].Y;
          device.Scanners[i].ScannerPositionZ = roughBest[i].Z;
        }
        state.maxErrorTotal = roughMaxError;
      } else {
        for (i = 0; i < list6.length; i++) {
          device.ScannerDevicePoints[i].X = list6[i].BestScannerPositionX;
          device.ScannerDevicePoints[i].Y = list6[i].BestScannerPositionY;
          device.ScannerDevicePoints[i].Z = list6[i].BestScannerPositionZ;
          device.Scanners[i].ScannerPositionX = list6[i].BestScannerPositionX;
          device.Scanners[i].ScannerPositionY = list6[i].BestScannerPositionY;
          device.Scanners[i].ScannerPositionZ = list6[i].BestScannerPositionZ;
        }
      }
    }

    this.PrepareNumberOfBadBalls(true);
    this.errorEstimationCal.PrepareNewCalculationInsideCalculationLoop();
    this.errorEstimationCal.CalculateErrorEstimation(
      sbGeneralExceptionByAlgorithm, false, this.errorEstimMaxHeightMeter,
      null, true, -1, Number.MAX_VALUE
    );
    var maxError = ErrorEstimationCal.MaxError(this.errorEstimationCal.SearchRadiusList);
    return { maxError: maxError, bestResults: list6, numCalc: state.numCumulativeCalc };
  };

  /**
   * @param {object} opts
   * @param {object} opts.vessel - thin vessel or full device VesselInWork
   * @param {number} opts.numScanners
   * @param {boolean} [opts.allSteps=true]
   * @param {function} [opts.onProgress]
   * @param {function} [opts.shouldCancel]
   * @param {object} [opts.fuzzyTableMap] - { TypeName: xmlString }
   * @param {object} [opts.device] - prebuilt device
   * @returns {{ scanners:[{x,y,z}], maxError:number }}
   */
  function runExhaustiveSearch(opts) {
    opts = opts || {};
    var numScanners = opts.numScanners || 1;
    var device = opts.device;
    if (!device) {
      device = NS.createDevice(opts.vessel, {
        fillPoints: opts.fillPoints || (opts.vessel && opts.vessel.fillPoints),
        emptyPoints: opts.emptyPoints || (opts.vessel && opts.vessel.emptyPoints),
        scanners: opts.scanners
      });
    }
    NS.setNumScanners(device, numScanners);

    var D = NS.DEFAULTS || {};
    var C = (global.LocatorAlgo && global.LocatorAlgo.Constants) || {};
    var fuzzy = opts.fuzzyManager || new NS.FuzzyManager();
    fuzzy.setDeviceInWork(device);
    var tableMap = opts.fuzzyTableMap || NS.FuzzyManager.FuzzyTableXmlByType || {};
    try {
      fuzzy.LoadFromGeometry(tableMap);
    } catch (e) {
      /* fall back to baked SFCenterSECenter */
      fuzzy.LoadFuzzyTableFile(fuzzy.fuzzyData, NS.eFuzzyType.SFCenterSECenter, tableMap);
    }

    var eec = new NS.ErrorEstimationCal();
    eec.DeviceInWork = device;
    eec.FuzzyManager = fuzzy;
    eec.Vessel = device.VesselInWork;
    eec.UnitsCoef = device.UnitsCoef || 1.0;
    eec.MatrizSize = D.BallsMatix || C.BallsMatrix || 111;
    eec.NumberOfBadBallsAccurate = D.NumberOfBadBallsAccurate || 50;
    eec.NumRanges = D.NumRanges || C.numRanges || 10;
    eec.MaterialAngleRadians = ((D.MaterialAngleDeg || C.MaterialAngle || 30) * Math.PI) / 180.0;
    eec.ScannerOpenningHalfAngle = ((D.ScannerAngleDeg || C.ScannerAngle || 25) * Math.PI) / 180.0;
    eec.ScannerOpenningHalfAngleWide = ((D.ScannerAngleWideDeg || C.ScannerAngleWide || 40) * Math.PI) / 180.0;
    var wx = device.VesselInWork.CenterShapeDiameter || device.VesselInWork.CenterShapeX;
    var wy = device.VesselInWork.CenterShapeDiameter || device.VesselInWork.CenterShapeY;
    if (device.VesselInWork.CenterShapeType === "Cube" || device.VesselInWork.isCube) {
      wx = device.VesselInWork.CenterShapeX;
      wy = device.VesselInWork.CenterShapeY;
    }
    eec.TotalVesselWidthX = wx;
    eec.TotalVesselWidthY = wy;
    eec.ListScannerLocationBalls = [];

    var exe = new ExhaustiveSearchExe();
    exe.deviceInWork = device;
    exe.errorEstimationCal = eec;
    exe.fuzzyManager = fuzzy;
    exe.algoParameter = new NS.AlgoParameter();
    exe.allExhaustiveSearchSteps = opts.allSteps !== false;
    exe.onProgress = opts.onProgress || null;
    exe.shouldCancel = opts.shouldCancel || null;
    exe.calculateAllRows = opts.calculateAllRows === true;
    var below = D.ErrorEstimMaxHeightBelowHighestFillingPoint != null
      ? D.ErrorEstimMaxHeightBelowHighestFillingPoint
      : (C.ErrorEstimMaxHeightBelowHighestFillingPoint || 0.5);
    exe.errorEstimMaxHeightMeter = (device.VesselInWork.TotalHeightMeter || device.VesselInWork.TotalHeight) - below;

    var p = {
      numDivX: exe.NumDivExhaustiveSearch(numScanners),
      numDivY: 0,
      centerX: 0,
      centerY: 0,
      deviceInWork: device,
      calculateAllRows: exe.calculateAllRows,
      calculatePerformance: false
    };
    p.numDivY = p.numDivX;
    exe.MatrixExhaustiveSearchDimensions(p);
    var result = exe.MatrixExhaustiveSearch(p);

    var scanners = [];
    for (var si = 0; si < device.Scanners.length; si++) {
      scanners.push({
        x: device.Scanners[si].ScannerPositionX,
        y: device.Scanners[si].ScannerPositionY,
        z: device.Scanners[si].ScannerPositionZ
      });
    }
    if (NS.scannersAreStacked(scanners) && NS.geometricRecommendedScanners) {
      var diam =
        (device.VesselInWork &&
          (device.VesselInWork.CenterShapeDiameterMeter ||
            device.VesselInWork.CenterShapeDiameter)) ||
        9;
      scanners = NS.geometricRecommendedScanners(scanners.length, diam, function (x, y) {
        return NS.autoCalculateZFromVesselBottom
          ? NS.autoCalculateZFromVesselBottom(device.VesselInWork, x, y)
          : 0;
      });
      for (si = 0; si < scanners.length; si++) {
        device.Scanners[si].ScannerPositionX = scanners[si].x;
        device.Scanners[si].ScannerPositionY = scanners[si].y;
        device.Scanners[si].ScannerPositionZ = scanners[si].z;
      }
    }
    return { scanners: scanners, maxError: result.maxError, numCalc: result.numCalc };
  }

  NS.ExhaustiveSearchExe = ExhaustiveSearchExe;
  NS.ErrorEstimBestResult = ErrorEstimBestResult;
  NS.runExhaustiveSearch = runExhaustiveSearch;
})(typeof self !== "undefined" ? self : (typeof globalThis !== "undefined" ? globalThis : this));
