(function (global) {
  "use strict";
  var root = global.LocatorAlgo = global.LocatorAlgo || {};
  var Defs = root.Defs;

  function noop() {}

  function createValueGrid() {
    var Value = new Array(130);
    var i, j, row;
    for (i = 0; i < 130; i++) {
      row = new Array(130);
      for (j = 0; j < 130; j++) {
        row[j] = false;
      }
      Value[i] = row;
    }
    return Value;
  }

  function Matrix(LX, LY) {
    this.Value = createValueGrid();
    this.is_round = false;
    var i, j;
    if (arguments.length === 0) {
      this.lenX = 128;
      this.lenY = 128;
      for (i = 0; i < this.lenY; i++) {
        for (j = 0; j < this.lenX; j++) {
          this.Value[i][j] = false;
        }
      }
      return;
    }
    this.lenX = LX;
    this.lenY = LY;
    if (LX < 1 || LY < 1) {
      this.lenX = 130;
      this.lenY = 130;
    }
    for (i = 0; i < this.lenY; i++) {
      for (j = 0; j < this.lenX; j++) {
        this.Value[i][j] = false;
      }
    }
  }

  Matrix.white = false;
  Matrix.black = true;
  Matrix.random = {
    Next: function (min, maxExclusive) {
      return min + Math.floor(Math.random() * (maxExclusive - min));
    }
  };

  Matrix.prototype.CopyFrom = function (M) {
    var i, j;
    this.lenX = M.lenX;
    this.lenY = M.lenY;
    for (i = 0; i < this.lenY; i++) {
      for (j = 0; j < this.lenX; j++) {
        this.Value[i][j] = M.Value[i][j];
      }
    }
  };

  Matrix.prototype.MakeRound = function () {
    this.is_round = true;
  };

  Matrix.prototype.CancleRound = function () {
    this.is_round = false;
  };

  Matrix.prototype.blacken = function (x, y) {
    this.Value[y][x] = true;
  };

  Matrix.prototype.whiten = function (x, y) {
    this.Value[y][x] = false;
  };

  Matrix.prototype.is_valid = function (x, y) {
    if (x > -1 && y > -1 && x < this.lenX) {
      return y < this.lenY;
    }
    return false;
  };

  Matrix.prototype.is_free = function (x, y) {
    if (x > -1 && y > -1 && x < this.lenX && y < this.lenY) {
      return !this.Value[y][x];
    }
    return false;
  };

  Matrix.prototype.blacken_all = function () {
    var i, j;
    for (i = 0; i < this.lenY; i++) {
      for (j = 0; j < this.lenX; j++) {
        this.Value[i][j] = true;
      }
    }
  };

  Matrix.prototype.whiten_all = function () {
    var i, j;
    for (i = 0; i < this.lenY; i++) {
      for (j = 0; j < this.lenX; j++) {
        this.Value[i][j] = false;
      }
    }
  };

  Matrix.prototype.print_matrix = function (LX, LY) {
    if (LX === undefined) LX = -1;
    if (LY === undefined) LY = -1;
    if (LX === -1 && LY === -1) {
      LX = this.lenX;
      LY = this.lenY;
    }
    noop("");
    var i, j;
    for (i = 0; i < this.lenY; i++) {
      for (j = 0; j < this.lenX; j++) {
        if (this.Value[i][j]) {
          noop("x");
        } else {
          noop(" ");
        }
      }
      noop("");
    }
  };

  Matrix.prototype.blacken_outside_circle = function () {
    var num, num2, i, j, k, l;
    if (this.lenX >= this.lenY) {
      num = this.lenX / this.lenY;
      num2 = (this.lenX - 1) / 2.0;
      for (i = 0; i < this.lenY; i++) {
        for (j = 0; j < this.lenX; j++) {
          if (Defs.alternative_len[(Math.abs((i + 0) * num - num2 - 0.0)) | 0][(Math.abs(j - num2)) | 0] > num2) {
            this.blacken(j, i);
          }
        }
      }
      return;
    }
    num = this.lenY / this.lenX;
    num2 = (this.lenY - 1) / 2.0;
    for (k = 0; k < this.lenY; k++) {
      for (l = 0; l < this.lenX; l++) {
        if (Defs.alternative_len[(Math.abs(k - num2)) | 0][(Math.abs((l + 0) * num - num2 - 0.0)) | 0] > num2) {
          this.blacken(l, k);
        }
      }
    }
  };

  Matrix.prototype.is_cycle_in_matrix = function (Px, Py, R) {
    if (R >= 0 && Px - R >= 0 && Py - R >= 0 && Px + R < this.lenX) {
      return Py + R < this.lenY;
    }
    return false;
  };

  Matrix.prototype.is_valid_cycle = function (Px, Py, R) {
    if (!this.is_cycle_in_matrix(Px, Py, R)) {
      return false;
    }
    var i, j, k, l, m;
    if (R > 9) {
      for (i = Py - R; i < Py + R + 1; i++) {
        for (j = Px - (Math.sqrt(R * R - ((Py - i) * (Py - i))) | 0) - 2; Defs._DIST(j, i, Px, Py) > R; j++) {
        }
        for (k = j; k < 2 * Px - j + 1; k++) {
          if (this.Value[i][k]) {
            return false;
          }
        }
      }
    } else {
      for (l = Py - R; l < Py + R + 1; l++) {
        for (m = Px - Defs.StartX[R][l - Py + R]; m < Px + Defs.StartX[R][l - Py + R] + 1; m++) {
          if (this.Value[l][m]) {
            return false;
          }
        }
      }
    }
    return true;
  };

  Matrix.prototype.old_blacken_cycle = function (Px, Py, R) {
    var i, j, k;
    for (i = Py - R; i < Py + R + 1; i++) {
      for (j = Px - (Math.sqrt(R * R - ((Py - i) * (Py - i))) | 0) - 2; Defs._DIST(j, i, Px, Py) > R; j++) {
      }
      for (k = j; k < 2 * Px - j + 1; k++) {
        if (this.is_valid(k, i)) {
          this.Value[i][k] = true;
        }
      }
    }
    return true;
  };

  Matrix.prototype.blacken_cycle = function (Px, Py, R) {
    if (R > 9) {
      return this.old_blacken_cycle(Px, Py, R);
    }
    var i, j, num;
    for (i = Py - R; i < Py + R + 1; i++) {
      num = Px + Defs.StartX[R][i - Py + R] + 1;
      for (j = Px - Defs.StartX[R][i - Py + R]; j < num; j++) {
        if (this.is_valid(j, i)) {
          this.Value[i][j] = true;
        }
      }
    }
    return true;
  };

  Matrix.prototype.blacken_cycle_if_valid = function (Px, Py, R) {
    if (!this.is_valid_cycle(Px, Py, R)) {
      return false;
    }
    return this.blacken_cycle(Px, Py, R);
  };

  Matrix.prototype.whiten_cycle = function (Px, Py, R) {
    if (!this.is_cycle_in_matrix(Px, Py, R)) {
      return false;
    }
    var i, j, k, l, m;
    if (R > 9) {
      for (i = Py - R; i < Py + R + 1; i++) {
        for (j = Px - (Math.sqrt(R * R - ((Py - i) * (Py - i))) | 0) - 2; Defs._DIST(j, i, Px, Py) > R; j++) {
        }
        for (k = j; k < 2 * Px - j + 1; k++) {
          this.Value[i][k] = false;
        }
      }
    } else {
      for (l = Py - R; l < Py + R + 1; l++) {
        for (m = Px - Defs.StartX[R][l - Py + R]; m < Px + Defs.StartX[R][l - Py + R] + 1; m++) {
          this.Value[l][m] = false;
        }
      }
    }
    return true;
  };

  Matrix.prototype.get_max_cycle = function (Px, Py) {
    if (!this.is_free(Px, Py)) {
      return -1;
    }
    var i;
    for (i = 1; this.is_valid_cycle(Px, Py, i); i++) {
    }
    return i - 1;
  };

  Matrix.prototype.alternative_get_max_cycle = function (Px, Py) {
    if (!this.is_free(Px, Py)) {
      return -1;
    }
    if (!this.is_free(Px, Py - 1) || !this.is_free(Px, Py + 1) || !this.is_free(Px - 1, Py) || !this.is_free(Px + 1, Py)) {
      return 0;
    }
    var num;
    num = 0;
    var num2;
    num2 = 4;
    while (this.is_valid_cycle(Px, Py, num2)) {
      num2 *= 2;
    }
    num2 = (num2 / 2) | 0;
    for (num = (num2 / 2) | 0; num > 0; num = (num / 2) | 0) {
      num2 = (!this.is_valid_cycle(Px, Py, num2)) ? (num2 - num) : (num2 + num);
    }
    if (!this.is_valid_cycle(Px, Py, num2)) {
      num2--;
    }
    return num2;
  };

  Matrix.prototype.blacken_max_cycle = function (Px, Py) {
    var num;
    num = this.get_max_cycle(Px, Py);
    if (num === -1) {
      return -1;
    }
    var i, j;
    for (i = Py - num; i < Py + num + 1; i++) {
      for (j = Px - num; j < Px + num + 1; j++) {
        if (Defs._DIST(j, i, Px, Py) <= num) {
          this.Value[i][j] = true;
        }
      }
    }
    return num;
  };

  Matrix.prototype.new_add_random_cycle = function (SizeX, SizeY, IsRound, Rezolution, Balls) {
    var BallOfFloat = root.BallOfFloat;
    var num;
    num = -1;
    var num2;
    num2 = Rezolution / Math.max(SizeX, SizeY);
    var num3;
    num3 = 0;
    var ballOfFloat;
    ballOfFloat = new BallOfFloat();
    var i, j, tempPx, tempPy, num4, flag, conv;
    while (true) {
      i = Matrix.random.Next(0, this.lenX);
      j = Matrix.random.Next(0, this.lenY);
      conv = this.ConvertMeasures(num2, SizeX, SizeY, i, j);
      tempPx = conv.tempPx;
      tempPy = conv.tempPy;
      num4 = this.new_get_max_cycle(tempPx, tempPy, SizeX, SizeY, IsRound, Balls);
      if (num4 > 0) {
        for (num = num4 + 1; num > num4; num = Matrix.random.Next(0, Defs.Rezolution) / num2) {
        }
        if (num === 0) {
          num = num4;
        }
        if (num > num4 || num < 0) {
          noop("error");
          noop(num4 + "," + num);
        }
        ballOfFloat.CenterX = tempPx;
        ballOfFloat.CenterY = tempPy;
        ballOfFloat.Radius = num;
        Balls.push(ballOfFloat);
        break;
      }
      num3++;
      if (num3 <= 1000) {
        continue;
      }
      flag = false;
      for (j = 0; j < this.lenY; j++) {
        for (i = 0; i < this.lenX; i++) {
          if (this.is_free(i, j)) {
            flag = true;
          }
        }
      }
      if (!flag) {
        break;
      }
    }
  };

  Matrix.prototype.blacken_rand_cycle = function () {
    var num;
    num = 0;
    var px, py, num2, flag;
    while (true) {
      px = Matrix.random.Next(0, this.lenX);
      py = Matrix.random.Next(0, this.lenY);
      num2 = this.get_max_cycle(px, py);
      if (num2 > -1) {
        this.blacken_cycle(px, py, Matrix.random.Next(0, num2 + 1));
        break;
      }
      num++;
      if (num <= 1000) {
        continue;
      }
      flag = false;
      for (py = 0; py < this.lenY; py++) {
        for (px = 0; px < this.lenX; px++) {
          if (this.is_free(px, py)) {
            flag = true;
          }
        }
      }
      if (!flag) {
        break;
      }
    }
  };

  Matrix.prototype.naive_get_max_free_cycle_in_matrix = function (out) {
    var num;
    num = -1;
    var num2;
    num2 = 0;
    var num3;
    num3 = 0;
    var i, j, num4;
    for (i = 0; i < this.lenX; i++) {
      for (j = 0; j < this.lenY; j++) {
        num4 = this.get_max_cycle(i, j);
        if (num4 > num) {
          num = num4;
          num2 = i;
          num3 = j;
        }
      }
    }
    out.R = num;
    out.Px = num2;
    out.Py = num3;
  };

  Matrix.prototype.new_get_max_free_cycle_in_matrix = function (SizeX, SizeY, IsRound, Rezolution, PrevBalls, out) {
    var num;
    num = Rezolution / Math.max(SizeX, SizeY);
    var num2;
    num2 = this.find_next_power_of_two() + 1;
    if (num2 > 130) {
      noop("problem, the matrix built is too large - " + this.lenX + "x" + this.lenY + "\n");
      out.Px = -1;
      out.Py = -1;
      out.R = -1;
      return;
    }
    Defs.Helper.lenX = num2;
    Defs.Helper.lenY = num2;
    Defs.Helper.blacken_all();
    var num4, tempPx, i, j, k, l, num3;
    if (IsRound) {
      num3 = SizeX * SizeX / 4;
      for (i = 0; i < this.lenY; i++) {
        num4 = (i + 0) / num - SizeY / 2;
        num4 *= num4;
        for (j = 0; j < this.lenX; j++) {
          tempPx = (j + 0) / num - SizeX / 2;
          if (tempPx * tempPx + num4 < num3) {
            Defs.Helper.whiten(j, i);
          }
        }
      }
    } else {
      for (k = 0; k < this.lenY; k++) {
        for (l = 0; l < this.lenX; l++) {
          Defs.Helper.whiten(l, k);
        }
      }
    }
    var num5;
    num5 = num2 - 1;
    var R = -1;
    var Px = 0;
    var Py = 0;
    var m, n, num6, num7, num8, num9, PrevBall, conv;
    while (num5 > 1) {
      for (m = 0; m < num2; m += num5) {
        num4 = (m + 0) / num - SizeY / 2;
        for (n = 0; n < num2; n += num5) {
          if (Defs.Helper.is_free(n, m)) {
            tempPx = (n + 0) / num - SizeX / 2;
            num6 = this.new_get_max_cycle(tempPx, num4, SizeX, SizeY, IsRound, PrevBalls);
            if (num6 > R) {
              R = num6;
              Px = tempPx;
              Py = num4;
            } else {
              Defs.Helper.blacken_cycle(n, m, (num * (R - num6)) | 0);
            }
            Defs.Helper.blacken(n, m);
          }
        }
      }
      num5 = (num5 / 2) | 0;
    }
    for (num7 = 0; num7 < num2; num7++) {
      for (num8 = 0; num8 < num2; num8++) {
        if (Defs.Helper.Value[num7][num8]) {
          continue;
        }
        conv = this.ConvertMeasures(num, SizeX, SizeY, num8, num7);
        tempPx = conv.tempPx;
        num4 = conv.tempPy;
        num6 = (IsRound ? (SizeX / 2 - this.Length(tempPx, num4)) : Math.min(Math.min(tempPx + SizeX / 2, SizeX / 2 - tempPx), Math.min(num4 + SizeY / 2, SizeY / 2 - num4)));
        for (var bi = 0; bi < PrevBalls.length; bi++) {
          PrevBall = PrevBalls[bi];
          if (!(PrevBall.Radius < 0)) {
            num9 = this.Length(tempPx - PrevBall.CenterX, num4 - PrevBall.CenterY) - PrevBall.Radius;
            if (num9 < num6) {
              num6 = num9;
            }
            if (num6 <= R) {
              break;
            }
          }
        }
        if (num6 > R) {
          R = num6;
          Px = tempPx;
          Py = num4;
        }
      }
    }
    out.Px = Px;
    out.Py = Py;
    out.R = R;
  };

  Matrix.prototype.new_get_max_cycle = function (Px, Py, SizeX, SizeY, IsRound, PrevBalls) {
    var num;
    num = (IsRound ? (SizeX / 2 - this.Length(Px, Py)) : Math.min(Math.min(Px + SizeX / 2, SizeX / 2 - Px), Math.min(Py + SizeY / 2, SizeY / 2 - Py)));
    var PrevBall, num2, num3, bi;
    for (bi = 0; bi < PrevBalls.length; bi++) {
      PrevBall = PrevBalls[bi];
      if (!(PrevBall.Radius < 0)) {
        num2 = num + PrevBall.Radius;
        num2 *= num2;
        num3 = (Px - PrevBall.CenterX) * (Px - PrevBall.CenterX) + (Py - PrevBall.CenterY) * (Py - PrevBall.CenterY);
        if (num3 < num2) {
          num = Math.sqrt(num3) - PrevBall.Radius;
        }
        if (num < 0) {
          break;
        }
      }
    }
    return num;
  };

  Matrix.prototype.find_next_power_of_two = function () {
    var num;
    num = 1;
    while (num < this.lenX || num < this.lenY) {
      num *= 2;
    }
    return num;
  };

  Matrix.prototype.ConvertMeasures = function (Ratio, SizeX, SizeY, i, j) {
    var tempPx, tempPy;
    if (Ratio <= 0) {
      tempPx = 0;
      tempPy = 0;
    } else {
      tempPx = (i + 0) / Ratio - SizeX / 2;
      tempPy = (j + 0) / Ratio - SizeY / 2;
    }
    return { tempPx: tempPx, tempPy: tempPy };
  };

  Matrix.prototype.ConvertBack = function (Ratio, SizeX, SizeY, Px, Py) {
    var i, j;
    if (Ratio <= 0) {
      i = 0;
      j = 0;
    } else {
      i = ((Px + SizeX / 2) * Ratio - 0) | 0;
      j = ((Py + SizeY / 2) * Ratio - 0) | 0;
    }
    return { i: i, j: j };
  };

  Matrix.prototype.Length = function (x, y) {
    return Math.sqrt(x * x + y * y);
  };

  root.Matrix = Matrix;

  // Defs.Helper must be a Matrix instance once Matrix exists.
  if (Defs) {
    Defs.Helper = new Matrix(130, 130);
  }
})(typeof self !== "undefined" ? self : window);
