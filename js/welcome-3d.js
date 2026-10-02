/**
 * Welcome-card 3D vessel, drawn the way 3DVision's SurfaceUCMain draws it:
 * - OrthographicCamera, Background #F0F3F5 (SurfaceUCMain.xaml)
 * - DirectionalLights only: LightSteelBlue (1,1,-1), Blue (-1,1,-1), White (0,-1,-0.5)
 * - Projection: Rotate X -90, then Scale(1/hx, 1/hy, 1/hz) of the model box (TransformHelper)
 * - Material body: DiffuseMaterial Colors.Blue; top surface: SurfaceTextureHeler.PseudoColor
 * - Vessel shell: DiffuseMaterial Colors.Yellow @ 0.2 (VisualVisionPanelView3DNew)
 * - Calibration: 20-point rings, Red "F" / Orange "E", LineWidth 3 (CreateCalibrationFeature)
 * - Walls: black border, LightGray division lines, Arial 10 black Z labels (Wall3D)
 * Renders once to a 2D canvas; no animation loop.
 */
(function (global) {
  "use strict";

  // Demo vessel, meters (z up, like the software's Point3D)
  var RADIUS = 5.5;
  var R = RADIUS;
  var Z_BOTTOM_CONE = 2;
  var Z_CYL_TOP = 16;
  var Z_TOP = 18;
  var LEVEL_MIN = 12.39;
  var LEVEL_MAX = 14.92;
  var WALL_DIV_XY = 4;
  var WALL_DIV_Z = 6;

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
    return [r, g, b];
  }

  function gauss(x, y, cx, cy, s) {
    var dx = x - cx;
    var dy = y - cy;
    return Math.exp(-(dx * dx + dy * dy) / (2 * s * s));
  }

  // Material shape like the software's mapping help image: a pile toward the back, a draw-down hole front-right.
  function rawHeight(x, y) {
    return (
      1.15 * gauss(x, y, -0.6, 1.6, 1.5) -
      0.95 * gauss(x, y, 1.9, -1.4, 1.25) +
      0.35 * gauss(x, y, -2.4, -1.6, 1.1) +
      0.12 * Math.sin(x * 1.3) * Math.cos(y * 1.1)
    );
  }

  function buildSurfaceSampler() {
    var lo = Infinity;
    var hi = -Infinity;
    var i;
    var j;
    for (i = 0; i <= 40; i++) {
      for (j = 0; j <= 40; j++) {
        var x = -R + (2 * R * i) / 40;
        var y = -R + (2 * R * j) / 40;
        if (x * x + y * y > R * R) continue;
        var h = rawHeight(x, y);
        lo = Math.min(lo, h);
        hi = Math.max(hi, h);
      }
    }
    return function (x, y) {
      var t = (rawHeight(x, y) - lo) / (hi - lo || 1);
      return LEVEL_MIN + t * (LEVEL_MAX - LEVEL_MIN);
    };
  }

  // Model (x, y, z-up) → three.js (x, z, -y): TransformHelper's Rotate X -90.
  function v3(x, y, z) {
    return new THREE.Vector3(x, z, -y);
  }

  function lambert(color, opacity) {
    var transparent = opacity < 1;
    return new THREE.MeshLambertMaterial({
      color: color,
      transparent: transparent,
      opacity: opacity,
      side: THREE.DoubleSide,
      depthWrite: !transparent,
    });
  }

  function meshFrom(positions, indices, material, colors) {
    var geo = new THREE.BufferGeometry();
    geo.setAttribute("position", new THREE.Float32BufferAttribute(positions, 3));
    if (colors) geo.setAttribute("color", new THREE.Float32BufferAttribute(colors, 3));
    geo.setIndex(indices);
    geo.computeVertexNormals();
    return new THREE.Mesh(geo, material);
  }

  function buildMaterial(sample) {
    // Just inside the shell so the 0.2-opacity yellow doesn't z-fight the blue.
    var R = RADIUS * 0.985;
    var rings = 26;
    var segs = 72;
    var pos = [];
    var col = [];
    var idx = [];
    var i;
    var j;
    function push(p, c) {
      pos.push(p.x, p.y, p.z);
      col.push(c[0], c[1], c[2]);
      return pos.length / 3 - 1;
    }
    var grid = [];
    for (i = 0; i <= rings; i++) {
      grid[i] = [];
      var rr = (R * i) / rings;
      for (j = 0; j < (i === 0 ? 1 : segs); j++) {
        var a = (j / segs) * Math.PI * 2;
        var x = rr * Math.cos(a);
        var y = rr * Math.sin(a);
        var z = sample(x, y);
        grid[i][j] = push(v3(x, y, z), pseudoColor((z - LEVEL_MIN) / (LEVEL_MAX - LEVEL_MIN)));
      }
    }
    for (j = 0; j < segs; j++) {
      idx.push(grid[0][0], grid[1][j], grid[1][(j + 1) % segs]);
    }
    for (i = 1; i < rings; i++) {
      for (j = 0; j < segs; j++) {
        var k = (j + 1) % segs;
        idx.push(grid[i][j], grid[i + 1][j], grid[i][k]);
        idx.push(grid[i][k], grid[i + 1][j], grid[i + 1][k]);
      }
    }
    var top = meshFrom(pos, idx, new THREE.MeshLambertMaterial({ color: 0xffffff, vertexColors: true, side: THREE.DoubleSide }), col);

    // fillBoundsWithColorMaterial: vessel material (Colors.Blue) from the surface rim down through the hopper.
    var wpos = [];
    var widx = [];
    for (j = 0; j <= segs; j++) {
      var a2 = (j / segs) * Math.PI * 2;
      var cx = R * Math.cos(a2);
      var cy = R * Math.sin(a2);
      var p1 = v3(cx, cy, sample(cx, cy));
      var p2 = v3(cx, cy, Z_BOTTOM_CONE);
      wpos.push(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
      if (j < segs) {
        var b = j * 2;
        widx.push(b, b + 1, b + 2, b + 2, b + 1, b + 3);
      }
    }
    var wall = meshFrom(wpos, widx, lambert(0x0000ff, 1));

    var hopperGeo = new THREE.ConeGeometry(R, Z_BOTTOM_CONE, segs, 1, true);
    hopperGeo.rotateX(Math.PI);
    hopperGeo.translate(0, Z_BOTTOM_CONE / 2, 0);
    var hopper = new THREE.Mesh(hopperGeo, lambert(0x0000ff, 1));

    var g = new THREE.Group();
    g.add(top, wall, hopper);
    return g;
  }

  function buildShell() {
    var yellow = lambert(0xffff00, 0.2);
    var g = new THREE.Group();
    var cyl = new THREE.CylinderGeometry(R, R, Z_CYL_TOP - Z_BOTTOM_CONE, 72, 1, true);
    cyl.translate(0, (Z_CYL_TOP + Z_BOTTOM_CONE) / 2, 0);
    g.add(new THREE.Mesh(cyl, yellow));
    var roof = new THREE.ConeGeometry(R, Z_TOP - Z_CYL_TOP, 72, 1, true);
    roof.translate(0, (Z_TOP + Z_CYL_TOP) / 2, 0);
    g.add(new THREE.Mesh(roof, yellow));
    var hop = new THREE.ConeGeometry(R, Z_BOTTOM_CONE, 72, 1, true);
    hop.rotateX(Math.PI);
    hop.translate(0, Z_BOTTOM_CONE / 2, 0);
    g.add(new THREE.Mesh(hop, yellow));
    g.children.forEach(function (m) {
      m.renderOrder = 2;
    });
    return g;
  }

  function mountWelcome3D(el) {
    if (!el || !global.THREE || el.dataset.mounted) return;
    el.dataset.mounted = "1";
    var cssW = 300;
    var cssH = 370;
    var dpr = Math.min(global.devicePixelRatio || 1, 2) * 1.5;

    var scene = new THREE.Scene();
    // SurfaceUCMain.xaml lights. three.js points a DirectionalLight from position → origin, so position = -Direction.
    function light(color, dx, dy, dz) {
      var l = new THREE.DirectionalLight(color, 1);
      l.position.set(-dx, -dy, -dz);
      scene.add(l);
    }
    light(0xb0c4de, 1, 1, -1);
    light(0x0000ff, -1, 1, -1);
    light(0xffffff, 0, -1, -0.5);

    var model = new THREE.Group();
    var sample = buildSurfaceSampler();
    model.add(buildMaterial(sample));
    model.add(buildShell());
    model.position.set(0, -Z_TOP / 2, 0);

    // SurfaceUCMain widens the box to one cube (min/max over all axes), so the scale is uniform.
    var proj = new THREE.Group();
    proj.scale.setScalar(2 / Math.max(2 * R, Z_TOP));
    proj.add(model);

    // Save4Image order: RotateY, then RotateX.
    var view = new THREE.Group();
    view.rotation.set(THREE.MathUtils.degToRad(16), THREE.MathUtils.degToRad(-32), 0, "XYZ");
    view.add(proj);
    scene.add(view);
    scene.updateMatrixWorld(true);

    function world(x, y, z) {
      return v3(x, y, z).applyMatrix4(model.matrixWorld);
    }

    var corners = [];
    [-R, R].forEach(function (x) {
      [-R, R].forEach(function (y) {
        [0, Z_TOP].forEach(function (z) {
          corners.push(world(x, y, z));
        });
      });
    });
    var minX = Infinity;
    var maxX = -Infinity;
    var minY = Infinity;
    var maxY = -Infinity;
    corners.forEach(function (p) {
      minX = Math.min(minX, p.x);
      maxX = Math.max(maxX, p.x);
      minY = Math.min(minY, p.y);
      maxY = Math.max(maxY, p.y);
    });
    var padL = 0.34;
    var pad = 0.08;
    minX -= padL;
    maxX += pad;
    minY -= pad;
    maxY += pad;
    var w = maxX - minX;
    var h = maxY - minY;
    var aspect = cssW / cssH;
    if (w / h > aspect) {
      var nh = w / aspect;
      minY -= (nh - h) / 2;
      maxY += (nh - h) / 2;
    } else {
      var nw = h * aspect;
      minX -= (nw - w) / 2;
      maxX += (nw - w) / 2;
    }
    var camera = new THREE.OrthographicCamera(minX, maxX, maxY, minY, 0.1, 100);
    camera.position.set(0, 0, 50);
    camera.lookAt(0, 0, 0);
    camera.updateMatrixWorld(true);
    camera.updateProjectionMatrix();

    var renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true, preserveDrawingBuffer: true });
    renderer.setPixelRatio(dpr);
    renderer.setSize(cssW, cssH, false);
    renderer.setClearColor(0x000000, 0);
    renderer.render(scene, camera);

    var out = document.createElement("canvas");
    out.width = Math.round(cssW * dpr);
    out.height = Math.round(cssH * dpr);
    out.setAttribute("aria-hidden", "true");
    var ctx = out.getContext("2d");
    ctx.scale(dpr, dpr);

    function screen(x, y, z) {
      var p = world(x, y, z).project(camera);
      return [((p.x + 1) / 2) * cssW, ((1 - p.y) / 2) * cssH];
    }
    function line(a, b) {
      ctx.beginPath();
      ctx.moveTo(a[0], a[1]);
      ctx.lineTo(b[0], b[1]);
      ctx.stroke();
    }

    ctx.fillStyle = "#f0f3f5";
    ctx.fillRect(0, 0, cssW, cssH);

    // Wall3D: floor (XY at zMin), YZ at xMin, XZ at yMax. Black border, LightGray divisions.
    var i;
    var zs = [];
    for (i = 0; i <= WALL_DIV_Z; i++) zs.push((Z_TOP * i) / WALL_DIV_Z);
    var xs = [];
    for (i = 0; i <= WALL_DIV_XY; i++) xs.push(-R + (2 * R * i) / WALL_DIV_XY);
    ctx.lineWidth = 1;
    ctx.strokeStyle = "#d3d3d3";
    xs.slice(1, -1).forEach(function (v) {
      line(screen(v, -R, 0), screen(v, R, 0));
      line(screen(-R, v, 0), screen(R, v, 0));
      line(screen(-R, v, 0), screen(-R, v, Z_TOP));
      line(screen(v, R, 0), screen(v, R, Z_TOP));
    });
    zs.slice(1, -1).forEach(function (z) {
      line(screen(-R, -R, z), screen(-R, R, z));
      line(screen(-R, R, z), screen(R, R, z));
    });
    ctx.strokeStyle = "#000";
    [
      [[-R, -R, 0], [R, -R, 0]],
      [[R, -R, 0], [R, R, 0]],
      [[R, R, 0], [-R, R, 0]],
      [[-R, R, 0], [-R, -R, 0]],
      [[-R, -R, 0], [-R, -R, Z_TOP]],
      [[-R, R, 0], [-R, R, Z_TOP]],
      [[R, R, 0], [R, R, Z_TOP]],
      [[-R, -R, Z_TOP], [-R, R, Z_TOP]],
      [[-R, R, Z_TOP], [R, R, Z_TOP]],
    ].forEach(function (seg) {
      line(screen.apply(null, seg[0]), screen.apply(null, seg[1]));
    });
    // Wall3D uses Arial 10; the panel shows this canvas at ~0.8x.
    ctx.font = "12px Arial";
    ctx.fillStyle = "#000";
    ctx.textAlign = "right";
    ctx.textBaseline = "middle";
    var tick = 2 * R * 0.05;
    zs.forEach(function (z) {
      var a = screen(-R, -R, z);
      var b = screen(-R - tick, -R, z);
      line(a, b);
      ctx.fillText(z.toFixed(2), b[0] - 3, b[1]);
    });

    ctx.drawImage(renderer.domElement, 0, 0, cssW, cssH);

    // Full / Empty calibration rings
    function ring(z, color, label) {
      var pts = [];
      for (i = 0; i < 20; i++) {
        var a = ((i * 360) / 19) * (Math.PI / 180);
        pts.push(screen(R * 1.02 * Math.cos(a), R * 1.02 * Math.sin(a), z));
      }
      ctx.strokeStyle = color;
      ctx.lineWidth = 2;
      ctx.beginPath();
      pts.forEach(function (p, n) {
        if (n === 0) ctx.moveTo(p[0], p[1]);
        else ctx.lineTo(p[0], p[1]);
      });
      ctx.stroke();
      var right = pts.reduce(function (m, p) {
        return p[0] > m[0] ? p : m;
      }, pts[0]);
      ctx.fillStyle = color;
      ctx.font = "bold 11px Arial";
      ctx.textAlign = "left";
      ctx.fillText(label, right[0] + 4, right[1]);
    }
    ring(Z_CYL_TOP, "#ff0000", "F");
    ring(0, "#ffa500", "E");

    el.appendChild(out);
    renderer.dispose();
    scene.traverse(function (o) {
      if (o.geometry) o.geometry.dispose();
      if (o.material) o.material.dispose();
    });
  }

  global.mountWelcome3D = mountWelcome3D;
})(window);
