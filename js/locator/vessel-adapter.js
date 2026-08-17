/* LocatorPlacement.VesselAdapter
 * Thin vessel/device model in meters + AutoCalculateZFromVesselBottom
 * (matching formulas used in mv-dialogs.js / Display3DHelper).
 */
(function (global) {
  "use strict";
  var NS = global.LocatorPlacement = global.LocatorPlacement || {};
  var ShapeCenter = NS.ShapeCenterType || { Cylinder: "Cylinder", Cube: "Cube" };
  var ShapeTB = NS.ShapeTopBottomType || { Flat: "Flat", Cone: "Cone", Dome: "Dome", Pyramid: "Pyramid" };

  function normShape(s, fallback) {
    if (s == null || s === "") return fallback;
    if (typeof s === "number") {
      if (fallback === ShapeCenter.Cylinder || fallback === "Cylinder") {
        return s === 1 ? ShapeCenter.Cube : ShapeCenter.Cylinder;
      }
      var map = { 0: ShapeTB.Flat, 1: ShapeTB.Cone, 2: ShapeTB.Dome, 3: ShapeTB.Pyramid };
      return map[s] != null ? map[s] : fallback;
    }
    var t = String(s).toLowerCase();
    if (t === "cylinder") return ShapeCenter.Cylinder;
    if (t === "cube") return ShapeCenter.Cube;
    if (t === "flat") return ShapeTB.Flat;
    if (t === "cone") return ShapeTB.Cone;
    if (t === "dome") return ShapeTB.Dome;
    if (t === "pyramid") return ShapeTB.Pyramid;
    return s;
  }

  /**
   * Build vessel model from thin options (all lengths in meters).
   * @param {object} opts
   * @returns {object} vessel with meter aliases used by error estimation
   */
  function createVessel(opts) {
    opts = opts || {};
    var topShape = normShape(opts.topShape, ShapeTB.Cone);
    var centerShape = normShape(opts.centerShape, ShapeCenter.Cylinder);
    var bottomShape = normShape(opts.bottomShape, ShapeTB.Flat);
    var topH = opts.topH || 0;
    var topD = opts.topD != null ? opts.topD : 0;
    var topX = opts.topX != null ? opts.topX : topD;
    var topY = opts.topY != null ? opts.topY : topD;
    var centerH = opts.centerH || 0;
    var centerD = opts.centerD != null ? opts.centerD : 0;
    var centerX = opts.centerX != null ? opts.centerX : centerD;
    var centerY = opts.centerY != null ? opts.centerY : centerD;
    var bottomH = opts.bottomH || 0;
    var bottomD = opts.bottomD != null ? opts.bottomD : 0;
    var bottomX = opts.bottomX != null ? opts.bottomX : bottomD;
    var bottomY = opts.bottomY != null ? opts.bottomY : bottomD;
    var isCube = centerShape === ShapeCenter.Cube || centerShape === "Cube";
    var totalHeight = opts.totalHeight != null ? opts.totalHeight : (topH + centerH + bottomH);

    var vessel = {
      TopShapeType: topShape,
      TopShapeHeight: topH,
      TopShapeHeightMeter: topH,
      TopShapeDiameter: topD,
      TopShapeDiameterMeter: topD,
      TopShapeX: topX,
      TopShapeXMeter: topX,
      TopShapeY: topY,
      TopShapeYMeter: topY,
      CenterShapeType: centerShape,
      CenterShapeHeight: centerH,
      CenterShapeHeightMeter: centerH,
      CenterShapeDiameter: centerD,
      CenterShapeDiameterMeter: centerD,
      CenterShapeX: centerX,
      CenterShapeXMeter: centerX,
      CenterShapeY: centerY,
      CenterShapeYMeter: centerY,
      BottomShapeType: bottomShape,
      BottomShapeHeight: bottomH,
      BottomShapeHeightMeter: bottomH,
      BottomShapeDiameter: bottomD,
      BottomShapeDiameterMeter: bottomD,
      BottomShapeX: bottomX,
      BottomShapeXMeter: bottomX,
      BottomShapeY: bottomY,
      BottomShapeYMeter: bottomY,
      TotalHeight: totalHeight,
      TotalHeightMeter: totalHeight,
      isCube: isCube,
      fillPoints: opts.fillPoints || [],
      scanners: opts.scanners || [],
      emptyPoints: opts.emptyPoints || []
    };

    vessel.AutoCalculateZFromVesselBottom = function (vx, vy) {
      return autoCalculateZFromVesselBottom(vessel, vx, vy);
    };
    vessel.VesselTotalHeight = function () {
      return vessel.TotalHeightMeter;
    };
    return vessel;
  }

  /**
   * Z of roof/surface above vessel bottom at (x,y), matching mv-dialogs autoCalculateZFromVesselBottom.
   */
  function autoCalculateZFromVesselBottom(vessel, x, y) {
    if (arguments.length === 3 && typeof vessel === "object" && typeof x === "object") {
      /* Vessel.AutoCalculateZFromVesselBottom(vessel, x, y) static-style */
      y = arguments[2];
      x = arguments[1];
    }
    var total = vessel.TotalHeightMeter != null ? vessel.TotalHeightMeter : vessel.TotalHeight;
    var cenShape = vessel.CenterShapeType;
    var topShape = vessel.TopShapeType;
    var topH = vessel.TopShapeHeightMeter != null ? vessel.TopShapeHeightMeter : vessel.TopShapeHeight;
    if (isNaN(topH) || topShape === ShapeTB.Flat || topShape === "Flat" || topShape === 0) topH = 0;
    var bch = (vessel.BottomShapeHeightMeter || 0) + (vessel.CenterShapeHeightMeter || 0);
    var diam = vessel.CenterShapeDiameterMeter != null ? vessel.CenterShapeDiameterMeter : vessel.CenterShapeDiameter;
    var isCube = cenShape === ShapeCenter.Cube || cenShape === "Cube";

    if (isCube) {
      var diamX = vessel.CenterShapeXMeter || diam;
      var diamY = vessel.CenterShapeYMeter || diam;
      var topDX = vessel.TopShapeXMeter || 0;
      var topDY = vessel.TopShapeYMeter || 0;
      var nx = x / (diamX / 2);
      var ny = y / (diamY / 2);
      var w1 = -topDX / diamX;
      var u1 = -topDY / diamY;
      var w3 = topDX / diamX;
      var u3 = topDY / diamY;
      if (nx < w1) nx = (nx - w1) / (-1 - w1);
      else if (nx > w3) nx = (nx - w3) / (1 - w3);
      else nx = 0;
      if (ny < u1) ny = (ny - u1) / (-1 - u1);
      else if (ny > u3) ny = (ny - u3) / (1 - u3);
      else ny = 0;
      return bch + topH * (1 - Math.max(nx, ny));
    }

    if (topShape === ShapeTB.Flat || topShape === "Flat" || topH <= 0) return total;
    if (topShape === ShapeTB.Dome || topShape === "Dome") {
      var dd = (4 * (x * x + y * y)) / (diam * diam);
      if (dd > 1) dd = 1;
      return bch + topH * Math.sqrt(Math.max(0, 1 - dd));
    }
    if (topShape === ShapeTB.Cone || topShape === "Cone" || topShape === ShapeTB.Pyramid || topShape === "Pyramid") {
      var topDiam = vessel.TopShapeDiameterMeter != null ? vessel.TopShapeDiameterMeter : vessel.TopShapeDiameter;
      if (topShape === ShapeTB.Pyramid || topShape === "Pyramid") {
        topDiam = vessel.TopShapeXMeter != null ? vessel.TopShapeXMeter : vessel.TopShapeX;
      }
      if (isNaN(topDiam) || topDiam == null) topDiam = 0;
      var d = (4 * (x * x + y * y)) / (diam * diam);
      if (topDiam < diam) {
        if (d > 1) return bch;
        var w = (diam * topH) / (diam - topDiam);
        var zr = Math.sqrt(Math.max(0, d));
        return zr > topDiam / diam ? bch + (1 - zr) * w : bch + topH;
      }
      return total;
    }
    return total;
  }

  function calculateTopConeBaseTan(vessel) {
    var top = vessel.TopShapeType;
    if (top === ShapeTB.Cone || top === "Cone") {
      return vessel.TopShapeHeight / (vessel.CenterShapeDiameter / 2.0 - vessel.TopShapeDiameter / 2.0);
    }
    if (top === ShapeTB.Dome || top === "Dome") {
      var num = Math.sqrt(vessel.TopShapeHeight * (vessel.CenterShapeDiameter - vessel.TopShapeHeight));
      return vessel.TopShapeHeight / num;
    }
    if (top === ShapeTB.Flat || top === "Flat") return 0.0;
    if (top === ShapeTB.Pyramid || top === "Pyramid") {
      return vessel.TopShapeHeight / (vessel.CenterShapeX / 2.0 - vessel.TopShapeX / 2.0);
    }
    return 0.0;
  }

  function getClosestScannerToLocation(device, x0, y0) {
    if (!device.ScannerDevicePoints) return null;
    var result = null;
    var num = Number.MAX_VALUE;
    var i;
    for (i = 0; i < device.ScannerDevicePoints.length; i++) {
      var dp = device.ScannerDevicePoints[i];
      var num2 = Math.pow(dp.X - x0, 2.0) + Math.pow(dp.Y - y0, 2.0);
      if (num2 < num) {
        result = dp;
        num = num2;
      }
    }
    return result;
  }

  /**
   * Build Device-like object expected by ErrorEstimationCal / ExhaustiveSearch.
   */
  function createDevice(vesselOrOpts, opts) {
    var vessel = vesselOrOpts;
    if (!vessel || !vessel.CenterShapeType) {
      vessel = createVessel(vesselOrOpts);
      opts = opts || {};
    } else {
      opts = opts || {};
    }
    var fillPts = (opts.fillPoints || vessel.fillPoints || []).map(function (p) {
      return { X: p.x != null ? p.x : p.X, Y: p.y != null ? p.y : p.Y, Z: p.z != null ? p.z : (p.Z || 0), XDisplay: 0, YDisplay: 0 };
    });
    if (fillPts.length === 0) {
      fillPts.push({ X: 0, Y: 0, Z: 0, XDisplay: 0, YDisplay: 0 });
    }
    var emptyPts = (opts.emptyPoints || vessel.emptyPoints || []).map(function (p) {
      return { X: p.x != null ? p.x : p.X, Y: p.y != null ? p.y : p.Y, Z: p.z != null ? p.z : (p.Z || 0) };
    });
    var scannersIn = opts.scanners || vessel.scanners || [];
    var scanners = [];
    var scannerDevicePoints = [];
    var i;
    for (i = 0; i < Math.max(1, scannersIn.length); i++) {
      var s = scannersIn[i] || { x: 0, y: 0, z: 0, zOffset: 0 };
      var x = s.x != null ? s.x : (s.X || 0);
      var y = s.y != null ? s.y : (s.Y || 0);
      var zOff = s.zOffset != null ? s.zOffset : (s.ScannerZOffsetFromVesselTop || 0);
      var z = s.z != null ? s.z : (s.Z != null ? s.Z : autoCalculateZFromVesselBottom(vessel, x, y) + zOff);
      scanners.push({
        ScannerPositionX: x,
        ScannerPositionY: y,
        ScannerPositionZ: z,
        ScannerZOffsetFromVesselTop: zOff
      });
      scannerDevicePoints.push({
        X: x,
        Y: y,
        Z: z,
        ScannerZOffsetFromVesselTop: zOff,
        maxZ: 0,
        minZ: 0
      });
    }
    var deviceDiameter = vessel.CenterShapeDiameterMeter || vessel.CenterShapeDiameter ||
      Math.max(vessel.CenterShapeXMeter || 0, vessel.CenterShapeYMeter || 0);

    var device = {
      VesselInWork: vessel,
      FillPoints: fillPts,
      EmptyPoints: emptyPts,
      Scanners: scanners,
      ScannerDevicePoints: scannerDevicePoints,
      UnitsCoef: opts.unitsCoef != null ? opts.unitsCoef : 1.0,
      DeviceDiameter: deviceDiameter,
      ZFromRealFloor: opts.zFromRealFloor || 0,
      CalculateTopConeBaseTan: function () {
        return calculateTopConeBaseTan(vessel);
      },
      GetClosestScannerToLocation: function (x0, y0) {
        return getClosestScannerToLocation(device, x0, y0);
      }
    };
    return device;
  }

  /** Ensure device has exactly N scanners (pad/truncate). */
  function setNumScanners(device, numScanners) {
    while (device.Scanners.length > numScanners) {
      device.Scanners.pop();
      device.ScannerDevicePoints.pop();
    }
    while (device.Scanners.length < numScanners) {
      device.Scanners.push({
        ScannerPositionX: 0,
        ScannerPositionY: 0,
        ScannerPositionZ: 0,
        ScannerZOffsetFromVesselTop: 0
      });
      device.ScannerDevicePoints.push({
        X: 0, Y: 0, Z: 0, ScannerZOffsetFromVesselTop: 0, maxZ: 0, minZ: 0
      });
    }
  }

  /** True when every scanner sits on the same XY (search failed / never moved). */
  function scannersAreStacked(scanners) {
    if (!scanners || scanners.length < 2) return false;
    var x0 = Number(scanners[0].x) || 0;
    var y0 = Number(scanners[0].y) || 0;
    var i;
    for (i = 1; i < scanners.length; i++) {
      var dx = (Number(scanners[i].x) || 0) - x0;
      var dy = (Number(scanners[i].y) || 0) - y0;
      if (dx * dx + dy * dy > 0.01) return false;
    }
    return true;
  }

  NS.createVessel = createVessel;
  NS.autoCalculateZFromVesselBottom = autoCalculateZFromVesselBottom;
  NS.AutoCalculateZFromVesselBottom = autoCalculateZFromVesselBottom;
  NS.createDevice = createDevice;
  NS.setNumScanners = setNumScanners;
  NS.scannersAreStacked = scannersAreStacked;
  NS.calculateTopConeBaseTan = calculateTopConeBaseTan;
  NS.getClosestScannerToLocation = getClosestScannerToLocation;

  /* Static-style for ErrorEstimationCalculation near-walls path */
  NS.Vessel = NS.Vessel || {};
  NS.Vessel.AutoCalculateZFromVesselBottom = function (vessel, x, y) {
    return autoCalculateZFromVesselBottom(vessel, x, y);
  };
})(typeof self !== "undefined" ? self : (typeof globalThis !== "undefined" ? globalThis : this));
