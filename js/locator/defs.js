(function (global) {
  "use strict";
  var root = global.LocatorAlgo = global.LocatorAlgo || {};

  function create2D(rows, cols, fill) {
    var a = new Array(rows);
    var i, j, row;
    for (i = 0; i < rows; i++) {
      row = new Array(cols);
      for (j = 0; j < cols; j++) {
        row[j] = fill;
      }
      a[i] = row;
    }
    return a;
  }

  function Defs() {}

  Defs.MAX_LEN = 130;
  Defs.PRACTICAL_MAX_LEN = 128;
  Defs.Shift = 0;
  Defs.SQRT2 = 1.414214;
  Defs.TwoPi = Math.PI * 2.0;
  Defs.use_alternative_len = 1;
  Defs.Rezolution = 55;
  Defs.alternative_len = create2D(130, 130, 0);
  // Wired to a Matrix(130,130) instance after Matrix is defined (see matrix.js).
  Defs.Helper = null;
  Defs.StartX = create2D(21, 21, 0);

  Defs.prototype.fill_alternative_len = function () {
    var i, j;
    for (i = 0; i < 130; i++) {
      for (j = 0; j < 130; j++) {
        Defs.alternative_len[i][j] = Math.sqrt(i * i + (j * j));
      }
    }
  };

  Defs.prototype.init_StartX = function () {
    this.fill_alternative_len();
    var i, j, k;
    for (i = 0; i < 10; i++) {
      for (j = 0; j < 2 * i + 1; j++) {
        for (k = -i; Defs._DIST(k, j, 0, i) > i; k++) {
        }
        Defs.StartX[i][j] = (-k) | 0;
      }
    }
  };

  Defs._DIST = function (x, y, i, j) {
    return Defs.Length(y - j, x - i);
  };

  Defs.Length = function (x, y) {
    if (x < 0) {
      x = -x;
    }
    if (y < 0) {
      y = -y;
    }
    if (x > 129 || y > 129) {
      return Math.sqrt(x * x + (y * y));
    }
    return Defs.alternative_len[y][x];
  };

  Defs.Dist = function (x1, y1, x2, y2) {
    return Defs.Length(x1 - x2, y1 - y2);
  };

  root.Defs = Defs;
})(typeof self !== "undefined" ? self : window);
