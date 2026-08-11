/* LocatorPlacement.SearchRadius + CalcParams
 * Port of APM.Locator.ViewModel.SearchRadius fields used by error estimation.
 */
(function (global) {
  "use strict";
  var NS = global.LocatorPlacement = global.LocatorPlacement || {};

  var eVesselHeightType = { Top: 0, Center: 1, Bottom: 2 };

  function createCalcParams() {
    return {
      L_Param: 0,
      K_Param: 0,
      DistanceMaxMaterialPickToActialPick: 0,
      S_Param: 0
    };
  }

  function SearchRadius() {
    this.calcParams = createCalcParams();
    this.CalcParams = this.calcParams;
    this.BadBallsNoSymmetry = null;
    this.BadBallsSymmetry = null;
    this.BadBallsTopShapeNoSymmetry = null;
    this.BadBallsTopShapeSymmetry = null;
    this.BadBallsBottomShapeNoSymmetry = null;
    this.BadBallsBottomShapeSymmetry = null;
    this.GoodBalls = null;
    this.GoodBallsTopShape = null;
    this.GoodBallsBottomShape = null;
    this.HeightSliceIndex = 0;
    this.HeightFromFloor = 0;
    this.HeightFromFloorWithUnits = 0;
    this.HeightPercent = 0;
    this.FrequencyAngleInCalculation = 0;
    this.ErrorEstimationVolumeSumNoSymmetry = NaN;
    this.ErrorEstimationVolumePercentSumNoSymmetry = NaN;
    this.ErrorEstimationVolumeSumSymmetry = NaN;
    this.ErrorEstimationVolumePercentSumSymmetry = NaN;
    this.ErrorEstimationVolumeSumSymmetryNearWalls = NaN;
    this.ErrorEstimationVolumeSumNoSymmetryNearWalls = NaN;
    this.PenaltyForNotSeeingMaterialPick = 0;
    this.PenaltyVesselSize = 0;
    this.ErrorEstimationVolumeSumFinal = NaN;
    this.ErrorEstimationVolumePercentSumFinal = NaN;
    this.ErrorEstimationVolumePercentSumFinalAlmostFull = NaN;
    this.VesselHeightType = eVesselHeightType.Center;
    this.ErrorEstimationFromFillingPointID = 0;
    this.AlgoCalcTime = -1;
    this.NumScanners = 0;
    this.IsDebugRun = false;
  }

  function createSearchRadius() {
    return new SearchRadius();
  }

  NS.eVesselHeightType = eVesselHeightType;
  NS.SearchRadius = SearchRadius;
  NS.createSearchRadius = createSearchRadius;
  NS.createCalcParams = createCalcParams;

  if (NS.ErrorEstimationCalculation) {
    NS.ErrorEstimationCalculation.createSearchRadius = createSearchRadius;
    NS.ErrorEstimationCalculation.createCalcParams = createCalcParams;
    NS.ErrorEstimationCalculation.eVesselHeightType = eVesselHeightType;
  }
})(typeof self !== "undefined" ? self : (typeof globalThis !== "undefined" ? globalThis : this));
