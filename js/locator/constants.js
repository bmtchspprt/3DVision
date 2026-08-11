(function (global) {
  "use strict";
  var root = global.LocatorAlgo = global.LocatorAlgo || {};

  root.Constants = {
    ExhaustiveSearchResolution: 31,
    ExhaustiveSearchResolutionRough2Scanners: 15,
    ExhaustiveSearchResolutionRough: 13,
    ExhaustiveSearchResolutionInternalLoop: 6,
    NumberOfBadBallsAccurate: 50,
    NumberOfBadBallsFast: 12,
    BallsMatrix: 111,
    ScannerAngle: 25,
    ScannerAngleWide: 40,
    MaterialAngle: 30,
    SymmetryLimiter: 0.1,
    numRanges: 10,
    maxErrorStage1: 3.5,
    maxErrorStage2: 4.5,
    ErrorEstimationOrangeLineFactor: 2,
    ErrorEstimMaxHeightBelowHighestFillingPoint: 0.5
  };
})(typeof self !== "undefined" ? self : window);
