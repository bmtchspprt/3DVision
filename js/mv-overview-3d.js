/**
 * MultiVision Overview 3D pane (Three.js).
 *
 * Port of the Demo Mode display path (not a live ConicSynth host):
 *   CreateSurfacePoints → Surface3D grid → PseudoColor top
 *   + fillBoundsWithColorMaterial solid body (walls welded to heat rim)
 *   + VisualVisionPanelView3DNew shell (Yellow @ 0.2)
 *
 * Demo Coke proportions: center H=16 m, diameter=9 m (radius 4.5).
 * Level placement uses vessel avg/max/min (meters from bottom), same as MaterialMatrix.
 */
(function (global) {
  "use strict";

  var state = null;

  // Demo Coke / Lime Stone center-shape geometry (meters).
  var DEMO_CENTER_H = 16;
  var DEMO_RADIUS_M = 4.5;
  // Scene scale so the vessel fits the Overview pane camera.
  var SCENE_SCALE = 0.2;
  var SILO_HEIGHT = DEMO_CENTER_H * SCENE_SCALE; // 3.2
  var SILO_RADIUS = DEMO_RADIUS_M * SCENE_SCALE; // 0.9

  /**
   * SurfaceTextureHeler.PseudoColor — exact 4-band ramp (blue→cyan→green→yellow→red).
   */
  function pseudoColor(k) {
    k = Math.max(0, Math.min(1, k));
    var r;
    var g;
    var b;
    if (k < 0.25) {
      r = 0;
      g = 4 * k;
      b = 1;
    } else if (k < 0.5) {
      r = 0;
      g = 1;
      b = 1 - 4 * (k - 0.25);
    } else if (k < 0.75) {
      r = 4 * (k - 0.5);
      g = 1;
      b = 0;
    } else {
      r = 1;
      g = 1 - 4 * (k - 0.75);
      b = 0;
    }
    return { r: r, g: g, b: b };
  }

  function hash2(ix, iy) {
    var n = Math.sin(ix * 127.1 + iy * 311.7) * 43758.5453;
    return n - Math.floor(n);
  }

  function smoothNoise(x, y) {
    var x0 = Math.floor(x);
    var y0 = Math.floor(y);
    var fx = x - x0;
    var fy = y - y0;
    fx = fx * fx * (3 - 2 * fx);
    fy = fy * fy * (3 - 2 * fy);
    var a = hash2(x0, y0);
    var b = hash2(x0 + 1, y0);
    var c = hash2(x0, y0 + 1);
    var d = hash2(x0 + 1, y0 + 1);
    return a + (b - a) * fx + (c - a) * fy + (a - b - c + d) * fx * fy;
  }

  function fbm(x, y) {
    var v = 0;
    var amp = 0.55;
    var freq = 1.2;
    for (var i = 0; i < 4; i++) {
      v += amp * smoothNoise(x * freq, y * freq);
      amp *= 0.5;
      freq *= 2.05;
    }
    return v;
  }

  /**
   * Build a unit-disk height field in meters-from-bottom / DEMO_CENTER_H
   * (same role as MaterialMatrix levels before CreateSurfacePoints).
   * Relief is driven by vessel min/max span, not a fake fill percentage.
   */
  function buildHeightField(seed, avgM, maxM, minM) {
    var n = 50; // VisualMappingConfig.TdMatrixSize default
    var heights = [];
    var minH = Infinity;
    var maxH = -Infinity;
    var avg = isFinite(avgM) ? avgM : DEMO_CENTER_H * 0.75;
    var mx = isFinite(maxM) ? maxM : avg + 1.1;
    var mn = isFinite(minM) ? minM : avg - 1.1;
    if (mx <= mn) {
      mx = avg + 1.0;
      mn = avg - 1.0;
    }
    // Fraction of center height (MaterialMatrix / height).
    var base = Math.max(0.08, Math.min(0.96, avg / DEMO_CENTER_H));
    var spanFrac = Math.max(0.02, (mx - mn) / DEMO_CENTER_H);
    var amp = spanFrac * 0.55;
    var i;
    var j;

    for (j = 0; j <= n; j++) {
      heights[j] = [];
      for (i = 0; i <= n; i++) {
        var u = i / n;
        var v = j / n;
        var x = (u - 0.5) * 2;
        var z = (v - 0.5) * 2;
        var r2 = x * x + z * z;
        var h = base;
        if (r2 <= 1) {
          // Deterministic topography standing in for Voronoi/HTM surface shape.
          var mound =
            0.55 * Math.exp(-((x + 0.35) * (x + 0.35) + (z - 0.15) * (z - 0.15)) / 0.22) -
            0.32 * Math.exp(-(x * x + (z + 0.1) * (z + 0.1)) / 0.2) +
            0.28 * Math.exp(-((x - 0.25) * (x - 0.25) + (z + 0.35) * (z + 0.35)) / 0.3) +
            0.4 * Math.exp(-(x * x + z * z) / 0.35);
          h = base + amp * (mound + (fbm(x * 2.2 + seed, z * 2.2 + seed * 1.7) - 0.45) * 0.75);
          h = Math.max(base - amp * 0.45, Math.min(base + amp * 1.15, h));
        } else {
          // Outside silo (ColorMatrix NOT_EXIST): unused by polar mesh; keep rim-safe base.
          h = base;
        }
        heights[j][i] = h;
        if (r2 <= 1) {
          if (h < minH) minH = h;
          if (h > maxH) maxH = h;
        }
      }
    }
    if (!isFinite(minH) || minH === maxH) {
      minH = base - amp * 0.3;
      maxH = base + amp * 0.5;
    }
    return {
      n: n,
      heights: heights,
      minH: minH,
      maxH: maxH,
      base: base,
      avgM: avg,
      maxM: mx,
      minM: mn,
    };
  }

  function sampleHeightField(field, nx, nz) {
    var n = field.n;
    var rr = Math.sqrt(nx * nx + nz * nz);
    if (rr > 1) {
      nx /= rr;
      nz /= rr;
    }
    var u = ((nx + 1) / 2) * n;
    var v = ((nz + 1) / 2) * n;
    var i0 = Math.max(0, Math.min(n - 1, Math.floor(u)));
    var j0 = Math.max(0, Math.min(n - 1, Math.floor(v)));
    var i1 = Math.min(n, i0 + 1);
    var j1 = Math.min(n, j0 + 1);
    var fu = u - i0;
    var fv = v - j0;
    var h00 = field.heights[j0][i0];
    var h10 = field.heights[j0][i1];
    var h01 = field.heights[j1][i0];
    var h11 = field.heights[j1][i1];
    return h00 * (1 - fu) * (1 - fv) + h10 * fu * (1 - fv) + h01 * (1 - fu) * fv + h11 * fu * fv;
  }

  /**
   * Solid material mesh — port of Surface3D.GetMesh3DList(surfaceWithMaterial)
   * + fillBoundsWithColorMaterial side/bottom weld:
   * heat-mapped top shares rim vertices with opaque blue walls down to floor.
   */
  function createMaterialSolid(field, siloRadius, siloHeight) {
    var positions = [];
    var colors = [];
    var indices = [];
    // Saturated blue used for fillBounds auxiliary / solid body (Overview look).
    var blueDeep = { r: 0.0, g: 0.16, b: 0.7 };
    var span = field.maxH - field.minH || 0.01;
    // Fit flush to shell (slight inset only to avoid z-fight with yellow walls).
    var rMat = siloRadius * 0.992;
    var rings = 48;
    var segs = 96;
    var i;
    var r;

    function pushV(x, y, z, col) {
      positions.push(x, y, z);
      colors.push(col.r, col.g, col.b);
      return positions.length / 3 - 1;
    }

    function shadeBlue(nx, nz) {
      var lit = 0.88 + 0.14 * (nx * 0.2 + nz * 0.9);
      lit = Math.max(0.82, Math.min(1.0, lit));
      return {
        r: blueDeep.r * lit,
        g: blueDeep.g * lit,
        b: Math.min(1, blueDeep.b * lit + 0.02),
      };
    }

    function heatCol(hNorm) {
      return pseudoColor((hNorm - field.minH) / span);
    }

    // --- Heat-mapped top (Surface3D grid → PseudoColor by Z) ---
    var top = [];
    var centerH = sampleHeightField(field, 0, 0);
    var centerIdx = pushV(0, centerH * siloHeight, 0, heatCol(centerH));
    top[0] = [];
    for (i = 0; i < segs; i++) {
      top[0][i] = centerIdx;
    }

    for (r = 1; r <= rings; r++) {
      top[r] = [];
      var rad = r / rings;
      for (i = 0; i < segs; i++) {
        var ang = (i / segs) * Math.PI * 2;
        var nx = Math.cos(ang) * rad;
        var nz = Math.sin(ang) * rad;
        var hNorm = sampleHeightField(field, nx, nz);
        top[r][i] = pushV(nx * rMat, hNorm * siloHeight, nz * rMat, heatCol(hNorm));
      }
    }

    for (i = 0; i < segs; i++) {
      indices.push(centerIdx, top[1][i], top[1][(i + 1) % segs]);
    }
    for (r = 1; r < rings; r++) {
      for (i = 0; i < segs; i++) {
        var j1 = (i + 1) % segs;
        indices.push(top[r][i], top[r + 1][i], top[r][j1]);
        indices.push(top[r][j1], top[r + 1][i], top[r + 1][j1]);
      }
    }

    // --- Walls welded to heat rim (fillBoundsWithColorMaterial) ---
    // Same XYZ as heat rim (top[rings]); separate verts so sides stay solid blue.
    var floorRim = [];
    var wallTop = [];
    for (i = 0; i < segs; i++) {
      var ang2 = (i / segs) * Math.PI * 2;
      var nx2 = Math.cos(ang2);
      var nz2 = Math.sin(ang2);
      var hRim = sampleHeightField(field, nx2, nz2) * siloHeight;
      wallTop.push(pushV(nx2 * rMat, hRim, nz2 * rMat, shadeBlue(nx2, nz2)));
      floorRim.push(pushV(nx2 * rMat, 0.001, nz2 * rMat, shadeBlue(nx2, nz2)));
    }
    for (i = 0; i < segs; i++) {
      var k1 = (i + 1) % segs;
      indices.push(wallTop[i], floorRim[i], wallTop[k1]);
      indices.push(wallTop[k1], floorRim[i], floorRim[k1]);
    }

    // --- Bottom disk (floor at zLimitFillBounds ≈ vessel bottom) ---
    var bottomCenter = pushV(0, 0, 0, blueDeep);
    for (i = 0; i < segs; i++) {
      indices.push(bottomCenter, floorRim[(i + 1) % segs], floorRim[i]);
    }

    var geo = new THREE.BufferGeometry();
    geo.setAttribute("position", new THREE.Float32BufferAttribute(positions, 3));
    geo.setAttribute("color", new THREE.Float32BufferAttribute(colors, 3));
    geo.setIndex(indices);
    geo.computeVertexNormals();

    var mat = new THREE.MeshBasicMaterial({
      vertexColors: true,
      side: THREE.DoubleSide,
      transparent: false,
      depthWrite: true,
      fog: false,
    });
    var mesh = new THREE.Mesh(geo, mat);
    mesh.renderOrder = 2;
    mesh.userData.surfaceTopY = field.maxH * siloHeight;
    mesh.userData.surfaceAvgY = field.base * siloHeight;
    return mesh;
  }

  function createSurfaceMesh(field, siloRadius, siloHeight) {
    return createMaterialSolid(field, siloRadius, siloHeight);
  }

  function createVesselWallLines(siloRadius, siloHeight, count) {
    var positions = [];
    var i;
    for (i = 0; i < count; i++) {
      var a = (i / count) * Math.PI * 2;
      var x = Math.cos(a) * siloRadius;
      var z = Math.sin(a) * siloRadius;
      positions.push(x, 0, z, x, siloHeight, z);
    }
    var geo = new THREE.BufferGeometry();
    geo.setAttribute("position", new THREE.Float32BufferAttribute(positions, 3));
    var lines = new THREE.LineSegments(
      geo,
      new THREE.LineBasicMaterial({
        color: 0xc8b84a,
        transparent: true,
        opacity: 0.28,
        depthWrite: false,
        depthTest: true,
      })
    );
    lines.renderOrder = 3;
    return lines;
  }

  /**
   * Vessel shell — VisualVisionPanelView3DNew: Yellow @ opacity 0.2,
   * split at material level (DrawCenterShapeCylinder lower/upper halves).
   */
  function createSiloShell(siloRadius, siloHeight, materialTopY) {
    var group = new THREE.Group();
    var yellow = 0xe8d44a;
    var topY = Math.max(0.05, Math.min(siloHeight - 0.05, Number(materialTopY) || siloHeight * 0.75));
    var emptyH = Math.max(0.08, siloHeight - topY);
    var filledH = Math.max(0.05, topY);

    function makeWall(height, yCenter, opacity) {
      var geo = new THREE.CylinderGeometry(siloRadius, siloRadius, height, 64, 1, true);
      geo.translate(0, yCenter, 0);
      var mat = new THREE.MeshPhongMaterial({
        color: yellow,
        transparent: true,
        opacity: opacity,
        side: THREE.DoubleSide,
        depthWrite: false,
        flatShading: false,
        shininess: 28,
      });
      var mesh = new THREE.Mesh(geo, mat);
      mesh.renderOrder = 4;
      return mesh;
    }

    // Lower half (around filled region): very light so blue solid stays readable.
    group.add(makeWall(filledH, filledH / 2, 0.08));
    // Upper empty headspace: Yellow 0.2 as in Draw3DVessel.
    group.add(makeWall(emptyH, topY + emptyH / 2, 0.2));
    group.add(createVesselWallLines(siloRadius * 1.004, siloHeight, 24));

    var roofH = siloRadius * 0.22;
    var roofGeo = new THREE.ConeGeometry(siloRadius * 1.002, roofH, 48, 1, true);
    roofGeo.translate(0, siloHeight + roofH / 2, 0);
    var roof = new THREE.Mesh(
      roofGeo,
      new THREE.MeshPhongMaterial({
        color: yellow,
        transparent: true,
        opacity: 0.28,
        side: THREE.DoubleSide,
        depthWrite: false,
        shininess: 30,
      })
    );
    roof.renderOrder = 4;
    group.add(roof);

    var mount = new THREE.Mesh(
      new THREE.ConeGeometry(0.05, 0.07, 10),
      new THREE.MeshPhongMaterial({ color: 0x555555, flatShading: true })
    );
    mount.position.set(0, siloHeight + roofH + 0.02, 0);
    group.add(mount);
    var cap = new THREE.Mesh(
      new THREE.SphereGeometry(0.048, 12, 10),
      new THREE.MeshPhongMaterial({ color: 0x2a7fff, shininess: 70 })
    );
    cap.position.set(0, siloHeight + roofH + 0.07, 0);
    group.add(cap);

    return group;
  }

  function createInsetMaterialMesh(field, half, levelMin, levelMax) {
    var positions = [];
    var colors = [];
    var indices = [];
    var blueDeep = { r: 0.0, g: 0.15, b: 0.68 };
    var span = field.maxH - field.minH || 0.01;
    var levelSpan = Math.max(0.05, levelMax - levelMin);
    var n = 48;
    var floorY = 0;
    var i;
    var j;

    function hToY(hNorm) {
      var t = (hNorm - field.minH) / span;
      return floorY + Math.max(0, Math.min(1, t)) * levelSpan;
    }

    function sampleSquare(u, v) {
      var nx = u * 2 - 1;
      var nz = v * 2 - 1;
      var rr = Math.sqrt(nx * nx + nz * nz);
      if (rr > 1) {
        nx /= rr;
        nz /= rr;
      }
      return sampleHeightField(field, nx, nz);
    }

    function pushV(x, y, z, col) {
      positions.push(x, y, z);
      colors.push(col.r, col.g, col.b);
      return positions.length / 3 - 1;
    }

    function shadeBlue(x, z) {
      var lit = 0.84 + 0.18 * ((x / half) * 0.2 + (z / half) * 0.85);
      lit = Math.max(0.78, Math.min(1.0, lit));
      return {
        r: blueDeep.r * lit,
        g: blueDeep.g * lit,
        b: Math.min(1, blueDeep.b * lit + 0.04),
      };
    }

    function heatCol(hNorm) {
      return pseudoColor((hNorm - field.minH) / span);
    }

    var top = [];
    for (j = 0; j <= n; j++) {
      top[j] = [];
      for (i = 0; i <= n; i++) {
        var u = i / n;
        var v = j / n;
        var x = (u - 0.5) * 2 * half;
        var z = (v - 0.5) * 2 * half;
        var hNorm = sampleSquare(u, v);
        top[j][i] = pushV(x, hToY(hNorm), z, heatCol(hNorm));
      }
    }
    for (j = 0; j < n; j++) {
      for (i = 0; i < n; i++) {
        indices.push(top[j][i], top[j + 1][i], top[j][i + 1]);
        indices.push(top[j][i + 1], top[j + 1][i], top[j + 1][i + 1]);
      }
    }

    function addWall(x0, z0, x1, z1, segments) {
      var s;
      for (s = 0; s < segments; s++) {
        var t0 = s / segments;
        var t1 = (s + 1) / segments;
        var ax = x0 + (x1 - x0) * t0;
        var az = z0 + (z1 - z0) * t0;
        var bx = x0 + (x1 - x0) * t1;
        var bz = z0 + (z1 - z0) * t1;
        var ua = (ax / half + 1) / 2;
        var va = (az / half + 1) / 2;
        var ub = (bx / half + 1) / 2;
        var vb = (bz / half + 1) / 2;
        var ha = hToY(sampleSquare(ua, va));
        var hb = hToY(sampleSquare(ub, vb));
        var cA = shadeBlue(ax, az);
        var cB = shadeBlue(bx, bz);
        var i0 = pushV(ax, ha, az, cA);
        var i1 = pushV(bx, hb, bz, cB);
        var i2 = pushV(ax, floorY, az, cA);
        var i3 = pushV(bx, floorY, bz, cB);
        indices.push(i0, i2, i1);
        indices.push(i1, i2, i3);
      }
    }
    var segs = 32;
    addWall(-half, -half, half, -half, segs);
    addWall(half, -half, half, half, segs);
    addWall(half, half, -half, half, segs);
    addWall(-half, half, -half, -half, segs);

    var b0 = pushV(-half, floorY, -half, blueDeep);
    var b1 = pushV(half, floorY, -half, blueDeep);
    var b2 = pushV(half, floorY, half, blueDeep);
    var b3 = pushV(-half, floorY, half, blueDeep);
    indices.push(b0, b1, b2);
    indices.push(b0, b2, b3);

    var geo = new THREE.BufferGeometry();
    geo.setAttribute("position", new THREE.Float32BufferAttribute(positions, 3));
    geo.setAttribute("color", new THREE.Float32BufferAttribute(colors, 3));
    geo.setIndex(indices);
    geo.computeVertexNormals();

    return new THREE.Mesh(
      geo,
      new THREE.MeshBasicMaterial({
        vertexColors: true,
        side: THREE.DoubleSide,
        transparent: false,
        depthWrite: true,
      })
    );
  }

  function createInsetBoundsBox(half, levelSpan) {
    var h = Math.max(0.2, levelSpan);
    var geo = new THREE.BoxGeometry(half * 2, h, half * 2);
    geo.translate(0, h / 2, 0);
    var edges = new THREE.EdgesGeometry(geo);
    return new THREE.LineSegments(
      edges,
      new THREE.LineBasicMaterial({ color: 0x888888, transparent: true, opacity: 0.55 })
    );
  }

  function paintInsetAxisLabels(canvas, levelMin, levelMax) {
    var ctx = canvas.getContext("2d");
    if (!ctx) return;
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.fillStyle = "#444";
    ctx.font = "10px Segoe UI, sans-serif";
    ctx.textAlign = "left";
    ctx.fillText(levelMax.toFixed(2), 4, 12);
    ctx.fillText(levelMin.toFixed(2), 4, canvas.height - 4);
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

  function seedFromId(id) {
    var s = 0;
    var str = String(id || "vessel");
    for (var i = 0; i < str.length; i++) {
      s = (s * 31 + str.charCodeAt(i)) | 0;
    }
    return (Math.abs(s) % 1000) / 100;
  }

  function mountOverview3D(mainEl, miniEl, options) {
    if (!global.THREE) {
      console.error("Three.js not loaded");
      return null;
    }
    disposeOverview3D();

    options = options || {};
    var vesselId = options.vesselId || "default";
    var avgM = Number(options.avg);
    var maxM = Number(options.max);
    var minM = Number(options.min);
    var fillPct = Math.max(5, Math.min(95, Number(options.fill) || 50));
    if (!isFinite(avgM)) {
      avgM = (fillPct / 100) * DEMO_CENTER_H;
    }
    if (!isFinite(maxM)) maxM = avgM + 1.1;
    if (!isFinite(minM)) minM = avgM - 1.1;

    var siloRadius = SILO_RADIUS;
    var siloHeight = SILO_HEIGHT;
    var field = buildHeightField(seedFromId(vesselId), avgM, maxM, minM);

    var scene = new THREE.Scene();
    scene.background = new THREE.Color(0xececec);

    var camera = new THREE.PerspectiveCamera(36, 1, 0.1, 100);
    // Frame the taller Demo-aspect cylinder (H/D ≈ 1.78).
    var spherical = new THREE.Spherical(5.4, 1.02, 0.72);
    var target = new THREE.Vector3(0, siloHeight * 0.42, 0);

    function updateCamera() {
      camera.position.setFromSpherical(spherical);
      camera.position.add(target);
      camera.lookAt(target);
    }
    updateCamera();

    var renderer = new THREE.WebGLRenderer({ antialias: true, alpha: false });
    renderer.setPixelRatio(Math.min(window.devicePixelRatio || 1, 2));
    mainEl.innerHTML = "";
    mainEl.appendChild(renderer.domElement);

    var ambient = new THREE.AmbientLight(0xffffff, 0.55);
    scene.add(ambient);
    var hemi = new THREE.HemisphereLight(0xf0f4f8, 0x5a6a7c, 0.35);
    scene.add(hemi);
    var dir = new THREE.DirectionalLight(0xffffff, 0.45);
    dir.position.set(2.2, 4.5, 3.2);
    scene.add(dir);
    var fill = new THREE.DirectionalLight(0xd0d8e4, 0.28);
    fill.position.set(-2.5, 1.5, -1.5);
    scene.add(fill);

    var root = new THREE.Group();
    // VesselDetails3D.UpdateByConnectionStatus → ClearDisplay when not connected:
    // empty shell only (no material surface / inset fill).
    var connected = options.connected !== false;
    var materialMesh = null;
    var surfaceTopY = siloHeight * 0.75;
    if (connected) {
      materialMesh = createSurfaceMesh(field, siloRadius, siloHeight);
      surfaceTopY =
        (materialMesh.userData && materialMesh.userData.surfaceTopY) || field.maxH * siloHeight;
      root.add(materialMesh);
    }
    root.add(createSiloShell(siloRadius, siloHeight, surfaceTopY + 0.01));
    scene.add(root);

    var miniRenderer = null;
    var miniCamera = null;
    var miniScene = null;
    if (miniEl) {
      miniEl.innerHTML = "";
      if (connected) {
        var levelMax = maxM;
        var levelMin = minM;
        if (!isFinite(levelMax) || !isFinite(levelMin) || levelMax <= levelMin) {
          levelMax = field.maxM;
          levelMin = field.minM;
        }
        var levelSpan = Math.max(0.2, levelMax - levelMin);
        var half = 0.9;

        miniScene = new THREE.Scene();
        miniScene.background = new THREE.Color(0xf7f7f7);
        miniCamera = new THREE.PerspectiveCamera(30, 100 / 90, 0.05, 40);
        var camDist = Math.max(2.8, levelSpan * 2.2 + 1.6);
        miniCamera.position.set(camDist * 0.55, levelSpan * 0.85 + 0.35, camDist * 0.95);
        miniCamera.lookAt(0, levelSpan * 0.38, 0);
        miniRenderer = new THREE.WebGLRenderer({ antialias: true, alpha: false });
        miniRenderer.setPixelRatio(1);
        miniRenderer.setClearColor(0xf7f7f7, 1);
        miniRenderer.domElement.style.cssText = "display:block;width:100%;height:100%;";
        miniEl.appendChild(miniRenderer.domElement);

        var miniRoot = new THREE.Group();
        miniRoot.add(createInsetMaterialMesh(field, half, levelMin, levelMax));
        miniRoot.add(createInsetBoundsBox(half, levelSpan));
        miniScene.add(miniRoot);

        var labelCanvas = document.createElement("canvas");
        labelCanvas.width = 108;
        labelCanvas.height = 98;
        paintInsetAxisLabels(labelCanvas, levelMin, levelMax);
        labelCanvas.style.cssText =
          "position:absolute;left:0;top:0;width:100%;height:100%;pointer-events:none;z-index:2;";
        miniEl.style.position = "absolute";
        miniEl.appendChild(labelCanvas);
      }
    }

    var dragging = false;
    var lastX = 0;
    var lastY = 0;

    function onPointerDown(e) {
      dragging = true;
      lastX = e.clientX;
      lastY = e.clientY;
      mainEl.setPointerCapture && mainEl.setPointerCapture(e.pointerId);
    }
    function onPointerMove(e) {
      if (!dragging) return;
      var dx = e.clientX - lastX;
      var dy = e.clientY - lastY;
      lastX = e.clientX;
      lastY = e.clientY;
      spherical.theta -= dx * 0.01;
      spherical.phi = Math.max(0.2, Math.min(Math.PI - 0.2, spherical.phi + dy * 0.01));
      updateCamera();
    }
    function onPointerUp() {
      dragging = false;
    }
    function onWheel(e) {
      e.preventDefault();
      spherical.radius = Math.max(3.2, Math.min(11, spherical.radius + e.deltaY * 0.01));
      syncZoomSlider();
      updateCamera();
    }

    mainEl.addEventListener("pointerdown", onPointerDown);
    mainEl.addEventListener("pointermove", onPointerMove);
    mainEl.addEventListener("pointerup", onPointerUp);
    mainEl.addEventListener("pointerleave", onPointerUp);
    mainEl.addEventListener("wheel", onWheel, { passive: false });

    var zoomSlider = document.getElementById("mvZoomSlider");
    function syncZoomSlider() {
      if (!zoomSlider) return;
      var t = (11 - spherical.radius) / (11 - 3.2);
      zoomSlider.value = String(Math.round(Math.max(0, Math.min(100, t * 100))));
    }
    function applyZoomSlider() {
      if (!zoomSlider) return;
      var t = Number(zoomSlider.value) / 100;
      spherical.radius = 11 - t * (11 - 3.2);
      updateCamera();
    }
    syncZoomSlider();
    if (zoomSlider) {
      zoomSlider.addEventListener("input", applyZoomSlider);
    }

    function resize() {
      var w = mainEl.clientWidth || 400;
      var h = mainEl.clientHeight || 300;
      camera.aspect = w / h;
      camera.updateProjectionMatrix();
      renderer.setSize(w, h, false);
      if (miniRenderer && miniEl) {
        var mw = miniEl.clientWidth || 108;
        var mh = miniEl.clientHeight || 98;
        miniCamera.aspect = mw / mh;
        miniCamera.updateProjectionMatrix();
        miniRenderer.setSize(mw, mh, false);
      }
    }

    var raf = 0;
    function frame() {
      raf = requestAnimationFrame(frame);
      if (state) {
        state.raf = raf;
      }
      renderer.render(scene, camera);
      if (miniRenderer && miniScene && miniCamera) {
        miniRenderer.render(miniScene, miniCamera);
      }
    }

    resize();
    frame();
    window.addEventListener("resize", resize);

    state = {
      mainEl: mainEl,
      miniEl: miniEl,
      renderer: renderer,
      miniRenderer: miniRenderer,
      scene: scene,
      miniScene: miniScene,
      root: root,
      spherical: spherical,
      target: target,
      updateCamera: updateCamera,
      syncZoomSlider: syncZoomSlider,
      applyZoomSlider: applyZoomSlider,
      zoomSlider: zoomSlider,
      raf: raf,
      resize: resize,
      onPointerDown: onPointerDown,
      onPointerMove: onPointerMove,
      onPointerUp: onPointerUp,
      onWheel: onWheel,
    };

    return {
      rotate: function (dTheta, dPhi) {
        spherical.theta += dTheta;
        spherical.phi = Math.max(0.2, Math.min(Math.PI - 0.2, spherical.phi + dPhi));
        updateCamera();
      },
      zoom: function (delta) {
        spherical.radius = Math.max(3.2, Math.min(11, spherical.radius + delta));
        syncZoomSlider();
        updateCamera();
      },
      reset: function () {
        spherical.set(5.4, 1.02, 0.72);
        syncZoomSlider();
        updateCamera();
      },
      resize: resize,
    };
  }

  function disposeOverview3D() {
    if (!state) return;
    cancelAnimationFrame(state.raf);
    window.removeEventListener("resize", state.resize);
    if (state.mainEl) {
      state.mainEl.removeEventListener("pointerdown", state.onPointerDown);
      state.mainEl.removeEventListener("pointermove", state.onPointerMove);
      state.mainEl.removeEventListener("pointerup", state.onPointerUp);
      state.mainEl.removeEventListener("pointerleave", state.onPointerUp);
      state.mainEl.removeEventListener("wheel", state.onWheel);
    }
    if (state.zoomSlider && state.applyZoomSlider) {
      state.zoomSlider.removeEventListener("input", state.applyZoomSlider);
    }
    disposeObject(state.root);
    disposeObject(state.miniScene);
    if (state.renderer) {
      state.renderer.dispose();
      if (state.renderer.domElement && state.renderer.domElement.parentNode) {
        state.renderer.domElement.parentNode.removeChild(state.renderer.domElement);
      }
    }
    if (state.miniRenderer) {
      state.miniRenderer.dispose();
      if (state.miniRenderer.domElement && state.miniRenderer.domElement.parentNode) {
        state.miniRenderer.domElement.parentNode.removeChild(state.miniRenderer.domElement);
      }
    }
    if (state.mainEl) state.mainEl.innerHTML = "";
    if (state.miniEl) state.miniEl.innerHTML = "";
    state = null;
  }

  global.mountOverview3D = mountOverview3D;
  global.disposeOverview3D = disposeOverview3D;
})(window);
