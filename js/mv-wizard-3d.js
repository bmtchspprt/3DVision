/**
 * Device Configuration Wizard vessel preview (Three.js).
 *
 * Ports SurfaceUC / Draw3DVessel / FillScannerShape:
 *   DiffuseMaterial Yellow @ wizard opacity 0.5 (no wireframe — facet seams are lighting only),
 *   Cylinder/Cone: ThetaDiv=20 unshared verts (flat); Dome: EllipsoidGeometry smooth hemi,
 *   3 DirectionalLights from SurfaceUCMain.xaml, TransformHelper model rotate,
 *   scanner Gray horn + Blue(0,51,127) head; size is 0.2 m radius / 0.2–0.3 m height converted to Distance.
 */
(function (global) {
  "use strict";

  var state = null;
  var SCALE = 0.18;
  var SEGS = 20;
  // WizardWindowDevice.Update3DDisplay → Show3DSiloNew(..., opacity: 0.5)
  var WIZARD_VESSEL_OPACITY = 0.5;
  var M_TO_FT = 0.3048;
  /* Draw a bit smaller than FillScannerShape meters so the unit reads on the roof without dominating. */
  var SCANNER_MESH_SCALE = 0.85;

  function displayToMeters(v, unit) {
    var u = String(unit || "m").toLowerCase();
    if (u === "ft" || u === "feet") return v * M_TO_FT;
    if (u === "in" || u === "inch") return v * 0.0254;
    if (u === "cm") return v / 100;
    if (u === "mm") return v / 1000;
    return v;
  }

  function metersToDisplay(meters, unit) {
    var u = String(unit || "m").toLowerCase();
    if (u === "ft" || u === "feet") return meters / M_TO_FT;
    if (u === "in" || u === "inch") return meters / 0.0254;
    if (u === "cm") return meters * 100;
    if (u === "mm") return meters * 1000;
    return meters;
  }

  /**
   * Same FillScannerShape size for every scanner on the vessel (count does not shrink).
   * width = 0.2 m; height = 0.2 m if totalH < 15 m else 0.3 m.
   * Shrink only when that height > 5% of vessel height: height = 4% of H, width = height/2.
   * Scene is in Distance unit, so convert the meter result (3D Vision stores the vessel in meters).
   */
  function scannerSizeDisplay(totalHeightDisplay, unit) {
    var totalH = displayToMeters(Number(totalHeightDisplay) || 0, unit);
    var width = 0.2;
    var height = totalH < 15.0 ? 0.2 : 0.3;
    if (height > totalH * 0.05) {
      height = totalH * 0.04;
      width = height / 2.0;
    }
    return {
      width: metersToDisplay(width, unit),
      height: metersToDisplay(height, unit),
    };
  }

  function disposeObject(obj) {
    if (!obj) return;
    obj.traverse(function (child) {
      if (child.geometry) child.geometry.dispose();
      if (child.material) {
        if (Array.isArray(child.material)) {
          child.material.forEach(function (m) {
            m.dispose();
          });
        } else {
          child.material.dispose();
        }
      }
    });
  }

  /**
   * Draw3DVessel: DiffuseMaterial(SolidColorBrush(Colors.Yellow) { Opacity }).
   * Cylinder/cone meshes use unshared verts → flat facets.
   * Domes use EllipsoidGeometry shared verts → smooth shading (no "grid lines").
   */
  function shellMat(opacity, highlight, smooth) {
    return new THREE.MeshLambertMaterial({
      color: highlight ? 0xff0000 : 0xffff00,
      transparent: true,
      opacity: opacity,
      side: THREE.DoubleSide,
      depthWrite: false,
      flatShading: !smooth,
    });
  }

  function makeAxisCone(baseR, tipR, baseX, baseY, baseZ, tipX, tipY, tipZ, mat, closeBase, closeTip, segs) {
    var positions = [];
    var indices = [];
    var i;
    var n = segs || SEGS;
    if (closeBase == null) closeBase = true;
    if (closeTip == null) closeTip = true;

    for (i = 0; i <= n; i++) {
      var a = (i / n) * Math.PI * 2;
      positions.push(baseX + baseR * Math.cos(a), baseY, baseZ + baseR * Math.sin(a));
    }
    var tipStart = positions.length / 3;
    if (tipR < 1e-6) {
      positions.push(tipX, tipY, tipZ);
    } else {
      for (i = 0; i <= n; i++) {
        var a2 = (i / n) * Math.PI * 2;
        positions.push(tipX + tipR * Math.cos(a2), tipY, tipZ + tipR * Math.sin(a2));
      }
    }

    if (tipR < 1e-6) {
      for (i = 0; i < n; i++) indices.push(i, i + 1, tipStart);
    } else {
      for (i = 0; i < n; i++) {
        indices.push(i, i + 1, tipStart + i + 1);
        indices.push(i, tipStart + i + 1, tipStart + i);
      }
    }

    if (closeBase) {
      var baseCenter = positions.length / 3;
      positions.push(baseX, baseY, baseZ);
      for (i = 0; i < n; i++) indices.push(baseCenter, i + 1, i);
    }
    if (closeTip && tipR >= 1e-6) {
      var tipCenter = positions.length / 3;
      positions.push(tipX, tipY, tipZ);
      for (i = 0; i < n; i++) indices.push(tipCenter, tipStart + i, tipStart + i + 1);
    }

    var geo = new THREE.BufferGeometry();
    geo.setAttribute("position", new THREE.Float32BufferAttribute(positions, 3));
    geo.setIndex(indices);
    // Match WPF cylinder/cone: unshared face verts → face normals.
    geo = geo.toNonIndexed();
    geo.computeVertexNormals();
    return new THREE.Mesh(geo, mat);
  }

  /**
   * FillDome / EllipsoidGeometry.GetMesh3D:
   *   DomeNumPoints(=ThetaDiv)=20, PhiDiv=20, hemi via Z>=0 / Z<=0 filter,
   *   XLength=ZLength=radius, YLength=height — shared verts → smooth.
   */
  function makeDome(joinY, radius, height, top, mat) {
    var thetaDiv = 20;
    var phiRings = 10; // half of PhiDiv=20 (equator→pole)
    var positions = [];
    var indices = [];
    var i;
    var j;
    var h = Math.max(height, 0.001);
    var r = Math.max(radius, 0.001);
    for (i = 0; i <= phiRings; i++) {
      var phi = top ? (i / phiRings) * (Math.PI / 2) : Math.PI / 2 + (i / phiRings) * (Math.PI / 2);
      var sp = Math.sin(phi);
      var cp = Math.cos(phi);
      for (j = 0; j <= thetaDiv; j++) {
        var theta = (j / thetaDiv) * Math.PI * 2;
        // WPF: x=X*sinθ*sinφ, z=Y*cosφ, y=-Z*cosθ*sinφ → Three Y-up
        positions.push(r * Math.sin(theta) * sp, h * cp, r * Math.cos(theta) * sp);
      }
    }
    for (i = 0; i < phiRings; i++) {
      for (j = 0; j < thetaDiv; j++) {
        var a = i * (thetaDiv + 1) + j;
        var b = a + thetaDiv + 1;
        indices.push(a, b, a + 1);
        indices.push(a + 1, b, b + 1);
      }
    }
    var geo = new THREE.BufferGeometry();
    geo.setAttribute("position", new THREE.Float32BufferAttribute(positions, 3));
    geo.setIndex(indices);
    geo.computeVertexNormals(); // shared verts → smooth like WPF auto-normals
    var mesh = new THREE.Mesh(geo, mat);
    // Anchor flat equator at joinY (WPF MinPointZ placement).
    if (top) mesh.position.y = joinY;
    else mesh.position.y = joinY;
    return mesh;
  }

  /**
   * FillScannerShape materials:
   *   CreateMaterialScannerBottom → Gray (horn)
   *   CreateMaterialScannerHead → RGB(0,51,127) (head)
   * Opaque so the yellow vessel (opacity 0.5) does not wash them out.
   */
  function buildScanner(apexY, apexX, apexZ, sz, showAxis, angleDeg, shaftWorld) {
    var group = new THREE.Group();
    var headW = sz.width * SCANNER_MESH_SCALE;
    var headH = sz.height * SCANNER_MESH_SCALE;
    var hornH = headH * 1.5;
    var w = headW * SCALE;
    var hHead = headH * SCALE;
    var hHorn = hornH * SCALE;

    var hornMat = new THREE.MeshLambertMaterial({
      color: 0x808080,
      transparent: false,
      opacity: 1,
      flatShading: true,
      side: THREE.DoubleSide,
      depthWrite: true,
    });
    var horn = makeAxisCone(w / 4, w, apexX, apexY, apexZ, apexX, apexY - hHorn, apexZ, hornMat, true, true, 16);
    horn.renderOrder = 10;
    group.add(horn);

    var headMat = new THREE.MeshLambertMaterial({
      color: 0x00337f,
      transparent: false,
      opacity: 1,
      flatShading: true,
      side: THREE.DoubleSide,
      depthWrite: true,
    });
    var headGeo = new THREE.CylinderGeometry(w, w, hHead, 16, 1, false).toNonIndexed();
    headGeo.computeVertexNormals();
    var head = new THREE.Mesh(headGeo, headMat);
    head.position.set(apexX, apexY + hHead / 2, apexZ);
    head.renderOrder = 10;
    group.add(head);

    if (showAxis) {
      // ShowServerDeviceArrow: red shaft + arrowhead along HorizAngle (180° → −X).
      var angDeg = Number(angleDeg);
      if (isNaN(angDeg)) angDeg = 180;
      var ang = (angDeg * Math.PI) / 180;
      var shaft = shaftWorld != null ? shaftWorld : Math.max(w * 4.5, 0.4);
      var tipLen = shaft * 0.2;
      var tipHalf = tipLen * 0.45;
      var ax = apexX;
      var ay = apexY + hHead * 0.5;
      var az = apexZ;
      var dx = Math.cos(ang);
      var dz = Math.sin(ang);
      var ex = ax + dx * shaft;
      var ez = az + dz * shaft;
      var bx = ax + dx * (shaft - tipLen);
      var bz = az + dz * (shaft - tipLen);
      var px = -dz * tipHalf;
      var pz = dx * tipHalf;
      group.add(
        new THREE.Line(
          new THREE.BufferGeometry().setFromPoints([
            new THREE.Vector3(ax, ay, az),
            new THREE.Vector3(bx, ay, bz),
          ]),
          new THREE.LineBasicMaterial({ color: 0xff0000 })
        )
      );
      group.add(
        new THREE.Line(
          new THREE.BufferGeometry().setFromPoints([
            new THREE.Vector3(bx + px, ay, bz + pz),
            new THREE.Vector3(ex, ay, ez),
            new THREE.Vector3(bx - px, ay, bz - pz),
            new THREE.Vector3(bx + px, ay, bz + pz),
          ]),
          new THREE.LineBasicMaterial({ color: 0xff0000 })
        )
      );
    }
    return group;
  }

  /** FillPoint: Orange inverted cone (ConeRbottom=0, ConeRtop=0.3) at vessel-top XY. */
  function buildFillPointMarker(x, yTop, z, sz, unit) {
    var h = sz.height;
    var w = metersToDisplay(0.3, unit) * SCALE;
    var hh = h * SCALE;
    var mat = new THREE.MeshLambertMaterial({
      color: 0xffa500,
      transparent: true,
      opacity: 0.8,
      flatShading: true,
      side: THREE.DoubleSide,
      depthWrite: false,
    });
    // Wide at top (surface), tip downward — reads as a circle from above.
    return makeAxisCone(w, 0, x, yTop, z, x, yTop - hh, z, mat, true, false, 20);
  }

  /** CreateCalibrationFeature / CalibPointsCylinder: ring + letter at Z. */
  function buildCalibRing(radius, y, color, label, margin) {
    var g = new THREE.Group();
    var r = radius + margin;
    var pts = [];
    var i;
    var n = 20;
    for (i = 0; i < n; i++) {
      var a = (i / (n - 1)) * Math.PI * 2;
      pts.push(new THREE.Vector3(r * Math.cos(a), y, r * Math.sin(a)));
    }
    g.add(
      new THREE.Line(
        new THREE.BufferGeometry().setFromPoints(pts),
        new THREE.LineBasicMaterial({ color: color, linewidth: 2 })
      )
    );
    // Text sprite for F / E
    var canvas = document.createElement("canvas");
    canvas.width = 64;
    canvas.height = 64;
    var ctx = canvas.getContext("2d");
    ctx.clearRect(0, 0, 64, 64);
    ctx.fillStyle = "#" + ("000000" + color.toString(16)).slice(-6);
    ctx.font = "bold 48px sans-serif";
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.fillText(label, 32, 34);
    var tex = new THREE.CanvasTexture(canvas);
    var spr = new THREE.Sprite(
      new THREE.SpriteMaterial({ map: tex, transparent: true, depthTest: false })
    );
    spr.scale.set(0.35, 0.35, 0.35);
    spr.position.set(r + margin, y, margin);
    g.add(spr);
    return g;
  }

  function topSurfaceY(joinY, tipY, tipR, baseR, x, z) {
    var r = Math.sqrt(x * x + z * z);
    if (baseR < 1e-6) return tipY;
    var t = Math.min(1, Math.max(0, r / baseR));
    // tip at tipY with tipR, base at joinY with baseR
    return tipY + (joinY - tipY) * t;
  }

  function buildVessel(params) {
    var group = new THREE.Group();
    var top = params.top || { shape: "cone", height: 1, diameter: 0 };
    var center = params.center || { shape: "cylinder", height: 16, diameter: 9 };
    var bottom = params.bottom || { shape: "cone", height: 1, diameter: 0, xPos: 0, yPos: 0 };
    var hi = params.highlight || null;
    var showAxis = !!params.showDeviceAxis;
    var devices = params.devices;
    if (!devices || !devices.length) {
      devices = [params.device || { x: 0, y: 0, z: 18, angle: 180 }];
    }
    var fillPoints = params.fillPoints || [];
    var calib = params.calibration || null;

    var cHm = Math.max(0.05, Number(center.height) || 16);
    var cDm = Math.max(0.05, Number(center.diameter) || 9);
    var tHm = Math.max(0, Number(top.height) || 0);
    var bHm = Math.max(0, Number(bottom.height) || 0);
    var tipXm = Number(bottom.xPos) || 0;
    var tipZm = Number(bottom.yPos) || 0;
    var botX = Number(bottom.x) || 0;
    var botY = Number(bottom.y) || 0;

    var cH = cHm * SCALE;
    var cR = (cDm / 2) * SCALE;
    if ((center.shape || "").toLowerCase() === "cube") {
      cR = (Math.max(Number(center.x) || cDm, Number(center.y) || cDm) / 2) * SCALE;
    }
    var tH = tHm * SCALE;
    var bH = bHm * SCALE;
    var tTipR = (Math.max(0, Number(top.diameter) || 0) / 2) * SCALE;
    var bTipR = (Math.max(0, Number(bottom.diameter) || 0) / 2) * SCALE;
    var tipX = tipXm * SCALE;
    var tipZ = tipZm * SCALE;

    var tShape = (top.shape || "flat").toLowerCase();
    var bShape = (bottom.shape || "cone").toLowerCase();
    var cShape = (center.shape || "cylinder").toLowerCase();
    var totalHm = tHm + cHm + bHm;
    var y = 0;
    // Wizard opacity 0.5 for all shell parts (Draw3DVessel + Update3DDisplay).
    var matT = shellMat(WIZARD_VESSEL_OPACITY, hi === "top", false);
    var matC = shellMat(WIZARD_VESSEL_OPACITY, hi === "center", false);
    var matB = shellMat(WIZARD_VESSEL_OPACITY, hi === "bottom", false);
    var matTDome = shellMat(WIZARD_VESSEL_OPACITY, hi === "top", true);
    var matBDome = shellMat(WIZARD_VESSEL_OPACITY, hi === "bottom", true);

    if (bShape === "cone" && bH > 0.001) {
      group.add(makeAxisCone(cR, bTipR, 0, y + bH, 0, tipX, y, tipZ, matB, false, true));
      y += bH;
    } else if (bShape === "cone2" && bH > 0.001) {
      var halfR = cR / 2;
      group.add(makeAxisCone(halfR, bTipR, halfR, y + bH, 0, halfR + tipX, y, tipZ, matB, false, true));
      group.add(makeAxisCone(halfR, bTipR, -halfR, y + bH, 0, -halfR + tipX, y, tipZ, matB, false, true));
      y += bH;
    } else if (bShape === "pyramid" && bH > 0.001) {
      group.add(makeAxisCone(cR, 0, 0, y + bH, 0, tipX, y, tipZ, matB, false, false, 4));
      y += bH;
    } else if (bShape === "pyramid2" && bH > 0.001) {
      var hx = cR / 2;
      group.add(makeAxisCone(hx, 0, hx, y + bH, 0, hx + tipX, y, tipZ, matB, false, false, 4));
      group.add(makeAxisCone(hx, 0, -hx, y + bH, 0, -hx + tipX, y, tipZ, matB, false, false, 4));
      y += bH;
    } else if (bShape === "inverted" && bH > 0.001) {
      var joinR = ((botY > 0 ? botY : cDm) / 2) * SCALE;
      var openR = (Math.max(0, botX) / 2) * SCALE;
      group.add(makeAxisCone(joinR, openR, 0, y + bH, 0, 0, y, 0, matB, false, true));
      y += bH;
    } else if (bShape === "dome" && bH > 0.001) {
      group.add(makeDome(y + bH, cR, bH, false, matBDome));
      y += bH;
    } else if (bShape === "flat") {
      var disc = new THREE.Mesh(new THREE.CircleGeometry(cR, SEGS), matB);
      disc.rotation.x = -Math.PI / 2;
      disc.position.y = y;
      group.add(disc);
    }

    var centerBottomY = y;

    if (cShape === "cube") {
      var sx = (Number(center.x) || cDm) * SCALE;
      var sz = (Number(center.y) || cDm) * SCALE;
      var boxGeo = new THREE.BoxGeometry(sx, cH, sz).toNonIndexed();
      boxGeo.computeVertexNormals();
      var box = new THREE.Mesh(boxGeo, matC);
      box.position.y = centerBottomY + cH / 2;
      group.add(box);
    } else {
      // ThetaDiv=20 wall; non-indexed face normals match CylinderGeometry.GetMesh3D (no Normals collection).
      var cylGeo = new THREE.CylinderGeometry(cR, cR, cH, SEGS, 1, false).toNonIndexed();
      cylGeo.computeVertexNormals();
      var cyl = new THREE.Mesh(cylGeo, matC);
      cyl.position.y = centerBottomY + cH / 2;
      group.add(cyl);
    }
    y = centerBottomY + cH;

    if (tShape === "cone" && tH > 0.001) {
      group.add(makeAxisCone(cR, tTipR, 0, y, 0, 0, y + tH, 0, matT, true, true));
      y += tH;
    } else if (tShape === "dome" && tH > 0.001) {
      group.add(makeDome(y, cR, tH, true, matTDome));
      y += tH;
    } else if (tShape === "pyramid" && tH > 0.001) {
      group.add(makeAxisCone(cR, 0, 0, y, 0, 0, y + tH, 0, matT, true, false, 4));
      y += tH;
    } else {
      var roof = new THREE.Mesh(new THREE.CircleGeometry(cR, SEGS), matT);
      roof.rotation.x = -Math.PI / 2;
      roof.position.y = y;
      group.add(roof);
    }

    var tipTopY = y;
    var joinTopY = tipTopY;
    if ((tShape === "cone" || tShape === "dome" || tShape === "pyramid") && tH > 0.001) {
      joinTopY = tipTopY - tH;
    }
    // Shaft length ≈ Center.X/5 (ShowServerDeviceArrow).
    var shaftLen = (cDm / 5) * SCALE;
    var scannerSz = scannerSizeDisplay(totalHm, params.distanceUnit);
    var di;
    for (di = 0; di < devices.length; di++) {
      var device = devices[di] || {};
      var devX = (Number(device.x) || 0) * SCALE;
      var devZ = (Number(device.y) || 0) * SCALE;
      var devYm = Number(device.z);
      if (isNaN(devYm)) devYm = tipTopY / SCALE;
      var apexY = Math.max(0, Math.min(tipTopY, devYm * SCALE));
      group.add(
        buildScanner(apexY, devX, devZ, scannerSz, showAxis, device.angle, shaftLen)
      );
    }

    // Fill stream points (always drawn when present — wizard ShowFillEmptyPoints(true)).
    var fi;
    for (fi = 0; fi < fillPoints.length; fi++) {
      var fp = fillPoints[fi];
      var fx = (Number(fp.x) || 0) * SCALE;
      var fz = (Number(fp.y) || 0) * SCALE;
      var fy =
        tipTopY !== joinTopY
          ? topSurfaceY(joinTopY, tipTopY, tTipR, cR, fx, fz)
          : tipTopY;
      group.add(buildFillPointMarker(fx, fy, fz, scannerSz, params.distanceUnit));
    }

    // Full/Empty rings — CreateCalibrationFeature (step 4 / ShowCalibration).
    if (calib && calib.show) {
      var fullFromBottom = Number(calib.fullLevel);
      var emptyFromBottom = Number(calib.emptyLevel);
      if (isNaN(fullFromBottom)) fullFromBottom = Math.max(0, totalHm - 0.5);
      if (isNaN(emptyFromBottom)) emptyFromBottom = 0;
      var margin = 0.3 * SCALE;
      group.add(buildCalibRing(cR, fullFromBottom * SCALE, 0xff0000, "F", margin));
      group.add(buildCalibRing(cR, emptyFromBottom * SCALE, 0xffa500, "E", margin));
    }

    group.position.y = -(y / 2);
    return group;
  }

  /** TransformHelper.RotateX / RotateY — rotate model around world axes. */
  function rotateModel(axis, deg) {
    if (!state || !state.pivot) return;
    var q = new THREE.Quaternion().setFromAxisAngle(axis, (deg * Math.PI) / 180);
    state.pivot.quaternion.premultiply(q);
  }

  /** SurfaceUCMain.RotateToOriginView — RotateX(5) then RotateY(5) from identity. */
  function applyOriginViewQuaternion(pivot) {
    if (!pivot) return;
    pivot.quaternion.identity();
    var qx = new THREE.Quaternion().setFromAxisAngle(new THREE.Vector3(1, 0, 0), (5 * Math.PI) / 180);
    var qy = new THREE.Quaternion().setFromAxisAngle(new THREE.Vector3(0, 1, 0), (5 * Math.PI) / 180);
    // Same order as TransformHelper: RotateX then RotateY on the view matrix.
    pivot.quaternion.premultiply(qx);
    pivot.quaternion.premultiply(qy);
  }

  function wirePointer(dom) {
    if (!dom || dom.__mvOrbit) return;
    dom.__mvOrbit = true;
    var dragging = false;
    var lastX = 0;
    var lastY = 0;
    dom.style.cursor = "grab";
    dom.addEventListener("pointerdown", function (e) {
      dragging = true;
      lastX = e.clientX;
      lastY = e.clientY;
      try {
        dom.setPointerCapture(e.pointerId);
      } catch (err) {}
      dom.style.cursor = "grabbing";
    });
    dom.addEventListener("pointermove", function (e) {
      if (!dragging || !state) return;
      var w = state.container.clientWidth || 480;
      var h = state.container.clientHeight || 520;
      // TransformHelper.MoveModel: 180 * delta / size, clamped to ±5° per tick
      var dx = (180 * (e.clientX - lastX)) / w;
      var dy = (180 * (e.clientY - lastY)) / h;
      var cap = 5;
      if (dx > cap) dx = cap;
      if (dx < -cap) dx = -cap;
      if (dy > cap) dy = cap;
      if (dy < -cap) dy = -cap;
      lastX = e.clientX;
      lastY = e.clientY;
      // Same order as TransformHelper: Rotate X (pitch) then Rotate Y (yaw)
      rotateModel(new THREE.Vector3(1, 0, 0), dy);
      rotateModel(new THREE.Vector3(0, 1, 0), dx);
    });
    function endDrag(e) {
      dragging = false;
      dom.style.cursor = "grab";
      try {
        dom.releasePointerCapture(e.pointerId);
      } catch (err) {}
    }
    dom.addEventListener("pointerup", endDrag);
    dom.addEventListener("pointercancel", endDrag);
  }

  function ensure(container) {
    if (!container || typeof THREE === "undefined") return null;
    if (state && state.container === container) return state;

    destroy();
    var w = Math.max(200, container.clientWidth || 480);
    var h = Math.max(200, container.clientHeight || 520);
    var scene = new THREE.Scene();
    // SurfaceUCMain.xaml viewport background #FFF0F3F5
    scene.background = new THREE.Color(0xf0f3f5);

    var viewH = 4.2;
    var aspect = w / h;
    // Fixed camera — model rotates (TransformHelper), not a spherical orbit.
    var camera = new THREE.OrthographicCamera(
      (-viewH * aspect) / 2,
      (viewH * aspect) / 2,
      viewH / 2,
      -viewH / 2,
      0.1,
      100
    );
    camera.position.set(0, 0, 10);
    camera.up.set(0, 1, 0);
    camera.lookAt(0, 0, 0);

    // Soft MSAA — WPF EdgeMode=Aliased only affects raster edges, it is not a wireframe overlay.
    var renderer = new THREE.WebGLRenderer({ antialias: true, alpha: false });
    renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
    renderer.setSize(w, h);
    container.innerHTML = "";
    container.appendChild(renderer.domElement);
    wirePointer(renderer.domElement);

    // SurfaceUCMain.xaml: three DirectionalLights only (no AmbientLight).
    // WPF Direction D → Three.js light from -D (rays travel toward D / target origin).
    // White dominates yellow DiffuseMaterial; Blue×Yellow≈0 so Blue is a weak cool fill only.
    var lightSteel = new THREE.DirectionalLight(0xb0c4de, 0.95);
    lightSteel.position.set(-1, -1, 1);
    scene.add(lightSteel);
    var lightBlue = new THREE.DirectionalLight(0x0000ff, 0.35);
    lightBlue.position.set(1, -1, 1);
    scene.add(lightBlue);
    var lightWhite = new THREE.DirectionalLight(0xffffff, 1.25);
    lightWhite.position.set(0, 1, 0.5);
    scene.add(lightWhite);

    var pivot = new THREE.Group();
    scene.add(pivot);
    // SurfaceUCMain ctor: InitTransformMatrix + RotateToOriginView (RotateX 5, RotateY 5).
    // Wizard OnLoaded → Show3DSiloNew → that default (no RotateFromTop until Device Position).
    applyOriginViewQuaternion(pivot);

    state = {
      container: container,
      scene: scene,
      camera: camera,
      renderer: renderer,
      pivot: pivot,
      vessel: null,
      viewH: 4.2,
      anim: 0,
      showDeviceAxis: false,
      zoomInFromTop: false,
      lastParams: null,
    };

    function frame() {
      if (!state) return;
      state.anim = requestAnimationFrame(frame);
      state.renderer.render(state.scene, state.camera);
    }
    frame();
    return state;
  }

  function applyOrthoFrustum() {
    if (!state || !state.container) return;
    var w = Math.max(200, state.container.clientWidth || 480);
    var h = Math.max(200, state.container.clientHeight || 520);
    var aspect = w / h;
    var vh = state.viewH || 4.2;
    state.camera.left = (-vh * aspect) / 2;
    state.camera.right = (vh * aspect) / 2;
    state.camera.top = vh / 2;
    state.camera.bottom = -vh / 2;
    state.camera.updateProjectionMatrix();
    state.renderer.setSize(w, h);
  }

  /**
   * SurfaceUCMain DrawShapes fits using geometry bounds in model space (before view matrix),
   * then CalculateProjectionMatrix(..., scaleFactor=0.8).
   * ZoomInFromTop: horizontal footprint only (WPF X,Y with Z-up → our X,Z with Y-up).
   * Measuring after pivot rotation was wrong and caused wild zoom jumps on 1↔2.
   */
  function fitViewToVessel() {
    if (!state || !state.vessel) return;
    var pivot = state.pivot;
    var savedQ = pivot.quaternion.clone();
    var savedP = pivot.position.clone();
    // Measure vessel in model space (identity view), same as WPF ptMinEntire/ptMaxEntire.
    pivot.quaternion.identity();
    pivot.position.set(0, 0, 0);
    pivot.updateMatrixWorld(true);
    var box = new THREE.Box3().setFromObject(state.vessel);
    var size = new THREE.Vector3();
    box.getSize(size);
    pivot.quaternion.copy(savedQ);
    pivot.position.copy(savedP);
    pivot.updateMatrixWorld(true);

    var span = state.zoomInFromTop
      ? Math.max(size.x, size.z, 0.01)
      : Math.max(size.x, size.y, size.z, 0.01);
    state._fitViewH = span / 0.8;
    state.viewH = state._fitViewH;
    applyOrthoFrustum();
  }

  /**
   * Apply wizard camera pose before/with geometry update (one frame — no paint-then-flip).
   * mode: "top" = RotateFromTop + ZoomInFromTop; "origin" = RotateToOriginView.
   */
  function applyWizardViewMode(mode) {
    if (!state) return;
    if (mode === "top") {
      state.zoomInFromTop = true;
      state.pivot.quaternion.identity();
      rotateModel(new THREE.Vector3(1, 0, 0), 90);
    } else {
      state.zoomInFromTop = false;
      applyOriginViewQuaternion(state.pivot);
    }
    state._fitViewH = null;
  }

  function update(params, opts) {
    if (!state) return;
    opts = opts || {};
    params = params || {};
    if (params.showDeviceAxis != null) state.showDeviceAxis = !!params.showDeviceAxis;
    params.showDeviceAxis = state.showDeviceAxis;
    state.lastParams = params;

    if (opts.viewMode === "top" || opts.viewMode === "origin") {
      applyWizardViewMode(opts.viewMode);
    }

    var prevViewH = state.viewH;
    var prevFit = state._fitViewH;
    if (state.vessel) {
      state.pivot.remove(state.vessel);
      disposeObject(state.vessel);
      state.vessel = null;
    }
    state.vessel = buildVessel(params);
    state.pivot.add(state.vessel);

    if (opts.viewMode === "top" || opts.viewMode === "origin") {
      fitViewToVessel();
    } else if (opts.preserveView) {
      state._fitViewH = prevFit;
      state.viewH = prevViewH;
      applyOrthoFrustum();
    } else {
      fitViewToVessel();
    }
  }

  function setShowDeviceAxis(on) {
    if (!state) return;
    state.showDeviceAxis = !!on;
    if (state.lastParams) {
      state.lastParams.showDeviceAxis = state.showDeviceAxis;
      update(state.lastParams, { preserveView: true });
    }
  }

  function resize() {
    applyOrthoFrustum();
  }

  /**
   * Slider matches SurfaceUC: Value 25 = projection baseline (scaleFactor 0.8).
   * Each tick ±1 → ZoomInRel/ZoomOutRel with mZoomScaleFactor 1.2.
   */
  function setZoom(t) {
    if (!state) return;
    var steps = (Number(t) || 25) - 25;
    var base = state._fitViewH || state.viewH || 4.2;
    state.viewH = base / Math.pow(1.2, steps);
    applyOrthoFrustum();
  }

  /** D-pad: SurfaceUC2V OnRotate* → RotateY(±5) / RotateX(±5). */
  function nudge(dx, dy) {
    if (!state) return;
    // dx > 0 = right button → RotateY(+5); dy > 0 = up → RotateX(-5) in real (OnRotateTop)
    if (dx) rotateModel(new THREE.Vector3(0, 1, 0), dx > 0 ? 5 : -5);
    if (dy) rotateModel(new THREE.Vector3(1, 0, 0), dy > 0 ? -5 : 5);
  }

  /**
   * SurfaceUCMain.RotateFromTop — first entry to Device Position (ScannerPosition):
   * InitTransformMatrix + RotateX(90), with ZoomInFromTop fit to model-space footprint.
   */
  function rotateFromTop() {
    if (!state) return;
    applyWizardViewMode("top");
    fitViewToVessel();
  }

  /** SurfaceUCMain.ResetViewToOrigin / RotateToOriginView — Init + RotateX(5)/RotateY(5). */
  function resetViewToOrigin() {
    if (!state) return;
    applyWizardViewMode("origin");
    fitViewToVessel();
  }

  /** D-pad home / vessel-step default — same as ResetViewToOrigin. */
  function resetView() {
    resetViewToOrigin();
  }

  function destroy() {
    if (!state) return;
    cancelAnimationFrame(state.anim);
    if (state.vessel) disposeObject(state.vessel);
    if (state.renderer) {
      state.renderer.dispose();
      if (state.renderer.domElement && state.renderer.domElement.parentNode) {
        state.renderer.domElement.parentNode.removeChild(state.renderer.domElement);
      }
    }
    state = null;
  }

  global.MvWizard3D = {
    mount: ensure,
    update: update,
    resize: resize,
    setZoom: setZoom,
    nudge: nudge,
    resetView: resetView,
    resetViewToOrigin: resetViewToOrigin,
    rotateFromTop: rotateFromTop,
    setShowDeviceAxis: setShowDeviceAxis,
    destroy: destroy,
  };
})(window);
