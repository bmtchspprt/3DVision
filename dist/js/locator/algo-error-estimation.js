(function (global) {
  "use strict";
  var root = global.LocatorAlgo = global.LocatorAlgo || {};
  var Defs = root.Defs;
  var Matrix = root.Matrix;
  var Balls = root.Balls;
  var BallOfFloat = root.BallOfFloat;

  function noop() {}

  function AlgoErrorEstimation() {
    this.Matrix = null;
    this.TotalRadius = 100;
    this.TotalRadius2 = 0;
    this.RadiusX = 0;
    this.RadiusY = 0;
    this.NumberOfBadBalls = 50;
    this.martix_size = 0;
  }

  AlgoErrorEstimation.prototype.CalcErrorEstimation = function (martixSize, RadiusX, RadiusY, numberOfBadBalls, GoodBalls, BadBalls, Filling_x, Filling_y) {
    this.martix_size = martixSize;
    if (this.Matrix === null || this.Matrix.length !== martixSize * martixSize) {
      this.Matrix = new Array(martixSize * martixSize);
      var zi;
      for (zi = 0; zi < this.Matrix.length; zi++) {
        this.Matrix[zi] = 0;
      }
    }
    this.RadiusX = RadiusX;
    this.RadiusY = RadiusY;
    this.TotalRadius = Math.max(RadiusX, RadiusY);
    this.TotalRadius2 = this.TotalRadius * this.TotalRadius;
    this.NumberOfBadBalls = numberOfBadBalls;
    this.CalcErrorEstimationNew(GoodBalls, BadBalls, Filling_x, Filling_y);
  };

  AlgoErrorEstimation.prototype.CalcErrorEstimationNew = function (GoodBalls, BadBalls, Filling_x, Filling_y) {
    var martix_size = this.martix_size;
    var Matrix = this.Matrix;
    var RadiusX = this.RadiusX;
    var RadiusY = this.RadiusY;
    var TotalRadius = this.TotalRadius;
    var TotalRadius2 = this.TotalRadius2;
    var NumberOfBadBalls = this.NumberOfBadBalls;

    var num;
    num = GoodBalls.length;
    var num2;
    num2 = 0;
    var num3;
    num3 = 0;
    var x;
    x = 0;
    var y;
    y = 0;
    var num4;
    num4 = 0;
    var i, j, k, l, num5, num6, num7, flag, flag2, balls;

    if (RadiusY === 0) {
      for (i = 0; i < martix_size; i++) {
        num2 = ((i + 1) / martix_size - 0.5) * TotalRadius * 2;
        num2 *= num2;
        for (j = 0; j < martix_size; j++) {
          num3 = ((j + 1) / martix_size - 0.5) * TotalRadius * 2;
          if (num2 + num3 * num3 <= TotalRadius2) {
            Matrix[i * martix_size + j] = 1;
          } else {
            Matrix[i * martix_size + j] = 0;
          }
        }
      }
    } else {
      for (i = 0; i < martix_size; i++) {
        num2 = ((i + 1) / martix_size - 0.5) * TotalRadius * 2;
        for (j = 0; j < martix_size; j++) {
          num3 = ((j + 1) / martix_size - 0.5) * TotalRadius * 2;
          if (Math.abs(num2) <= RadiusX && Math.abs(num3) <= RadiusY) {
            Matrix[i * martix_size + j] = 1;
          } else {
            Matrix[i * martix_size + j] = 0;
          }
        }
      }
    }
    noop("Good Balls\n");
    for (k = 0; k < num; k++) {
      this.GenerateOneBall(martix_size, TotalRadius, GoodBalls[k].r, GoodBalls[k].x, GoodBalls[k].y, 3, Matrix);
    }
    for (i = 0; i < martix_size; i++) {
      Matrix[i] = 0;
      Matrix[i * martix_size] = 0;
      Matrix[i * martix_size + martix_size - 1] = 0;
      Matrix[(martix_size - 1) * martix_size + i] = 0;
    }
    noop("Bad Balls\n");
    num4 = 0;
    i = (((Filling_x / TotalRadius + 1) * 0.5 * (martix_size - 1))) | 0;
    j = (((Filling_y / TotalRadius + 1) * 0.5 * (martix_size - 1))) | 0;
    if (Matrix[i * martix_size + j] === 1) {
      if (RadiusY === 0) {
        num5 = TotalRadius - Math.sqrt(Math.pow(Filling_x, 2.0) + Math.pow(Filling_y, 2.0));
      } else {
        num5 = Math.abs(RadiusX - Math.abs(Filling_x));
        if (num5 > Math.abs(RadiusY - Math.abs(Filling_y))) {
          num5 = Math.abs(RadiusY - Math.abs(Filling_y));
        }
      }
      for (l = 0; l < num; l++) {
        num6 = Math.sqrt(Math.pow(GoodBalls[l].x - Filling_x, 2.0) + Math.pow(GoodBalls[l].y - Filling_y, 2.0)) - GoodBalls[l].r;
        if (num6 < num5) {
          num5 = num6;
        }
      }
      if (num5 > 0) {
        balls = new Balls(Filling_x, Filling_y, num5);
        BadBalls.push(balls);
        this.GenerateOneBall(martix_size, TotalRadius, balls.r, balls.x, balls.y, 2, Matrix);
        num4++;
      }
    }
    for (; num4 < NumberOfBadBalls; num4++) {
      num7 = 0;
      flag = false;
      for (i = 1; i < martix_size; i++) {
        for (j = 1; j < martix_size; j++) {
          if (Matrix[i * martix_size + j] !== 1) {
            continue;
          }
          num2 = ((i + 1) / martix_size - 0.5) * TotalRadius * 2;
          num3 = ((j + 1) / martix_size - 0.5) * TotalRadius * 2;
          flag2 = false;
          if (RadiusY === 0) {
            num5 = TotalRadius - Math.sqrt(Math.pow(num2, 2.0) + Math.pow(num3, 2.0));
          } else {
            num5 = Math.abs(RadiusX - Math.abs(num2));
            if (num5 > Math.abs(RadiusY - Math.abs(num3))) {
              num5 = Math.abs(RadiusY - Math.abs(num3));
            }
          }
          for (l = 0; l < num; l++) {
            num6 = Math.sqrt(Math.pow(num2 - GoodBalls[l].x, 2.0) + Math.pow(num3 - GoodBalls[l].y, 2.0)) - GoodBalls[l].r;
            if (num6 < num5) {
              num5 = num6;
              flag2 = true;
            }
          }
          for (l = 0; l < num4; l++) {
            num6 = Math.sqrt(Math.pow(num2 - BadBalls[l].x, 2.0) + Math.pow(num3 - BadBalls[l].y, 2.0)) - BadBalls[l].r;
            if (num6 < num5) {
              num5 = num6;
              flag2 = true;
            }
          }
          if (num7 < num5 && flag2) {
            num7 = num5;
            flag = true;
            x = num2;
            y = num3;
          }
        }
      }
      if (flag) {
        balls = new Balls(x, y, num7);
        BadBalls.push(balls);
        this.GenerateOneBall(martix_size, TotalRadius, balls.r, balls.x, balls.y, 2, Matrix);
        continue;
      }
      break;
    }
  };

  AlgoErrorEstimation.prototype.GenerateOneBall = function (msize, TRadius, r, x0, y0, value, M) {
    var num;
    num = r * r;
    var i, j, num2, num3;
    for (i = 0; i < msize; i++) {
      num2 = ((i + 1) / msize - 0.5) * TRadius * 2;
      num2 -= x0;
      num2 *= num2;
      for (j = 0; j < msize; j++) {
        num3 = ((j + 1) / msize - 0.5) * TRadius * 2;
        num3 -= y0;
        if (num2 + num3 * num3 <= num) {
          M[i * msize + j] = value;
        }
      }
    }
  };

  AlgoErrorEstimation.prototype.CalcErrorEstimationFast = function (isRectange, martixSize, RadiusX, RadiusY, numberOfBadBalls, GoodBalls, BadBalls, Filling_x, Filling_y) {
    this.martix_size = martixSize;
    var list;
    list = [];
    var list2;
    list2 = [];
    var bi, balls, ballOfFloat, num;
    for (bi = 0; bi < GoodBalls.length; bi++) {
      balls = GoodBalls[bi];
      list.push(new BallOfFloat(balls.x, balls.y, balls.r));
    }
    if (RadiusY === 0) {
      RadiusY = RadiusX;
    }
    var defs;
    defs = new Defs();
    defs.fill_alternative_len();
    defs.init_StartX();
    Defs.Rezolution = martixSize;
    var diameter;
    diameter = 0;
    if (isRectange) {
      diameter = -1;
    }
    AlgoErrorEstimation.CalcErrorEstimation(diameter, RadiusX * 2, RadiusY * 2, numberOfBadBalls, list, list2, Filling_x, Filling_y, 1, false, false, false, 100);
    for (var j = 0; j < list2.length; j++) {
      ballOfFloat = list2[j];
      if (ballOfFloat.Radius <= 0) {
        ballOfFloat.Radius = 0.001;
        num = 1;
        num++;
      } else {
        BadBalls.push(new Balls(ballOfFloat.CenterX, ballOfFloat.CenterY, ballOfFloat.Radius));
      }
    }
  };

  AlgoErrorEstimation.CalcErrorEstimation = function (Diameter, sizeX, sizeY, numberOfBadBalls, GoodBalls, BadBalls, nextX, nextY, times, PrintStatistics, PrintTimer, PrintInitialAndFinalMatrix, frequency) {
    if (times === undefined) times = 1;
    if (PrintStatistics === undefined) PrintStatistics = false;
    if (PrintTimer === undefined) PrintTimer = false;
    if (PrintInitialAndFinalMatrix === undefined) PrintInitialAndFinalMatrix = false;
    if (frequency === undefined) frequency = 100;

    var num;
    num = 0.0;
    if (Diameter > 0) {
      sizeX = Diameter;
      sizeY = Diameter;
    }
    if (Math.max(sizeX, sizeY) <= 0) {
      noop("error! matrix size must be positive");
      return;
    }
    var num2;
    num2 = Defs.Rezolution / Math.max(sizeX, sizeY);
    var matrix;
    matrix = new Matrix((num2 * sizeX) | 0, (num2 * sizeY) | 0);
    if (Diameter >= 0) {
      matrix.is_round = true;
    } else {
      matrix.is_round = false;
    }
    var BallsList;
    BallsList = [];
    var i, j, k, now, now2, item, GoodBall, item2, item3, count, R, conv, cycleOut;
    for (i = 0; i < times; i++) {
      matrix.whiten_all();
      if (Diameter >= 0) {
        matrix.blacken_outside_circle();
      }
      now = Date.now();
      BallsList.length = 0;
      for (j = 0; j < GoodBalls.length; j++) {
        GoodBall = GoodBalls[j];
        if (!(GoodBall.Radius < 0)) {
          item = new BallOfFloat(GoodBall.CenterX, GoodBall.CenterY, GoodBall.Radius);
          BallsList.push(item);
        }
      }
      for (j = BallsList.length; j < GoodBalls.length; j++) {
        matrix.new_add_random_cycle(sizeX, sizeY, matrix.is_round, Defs.Rezolution, BallsList);
      }
      count = BallsList.length;
      for (j = 0; j < BallsList.length; j++) {
        item2 = BallsList[j];
        conv = matrix.ConvertBack(num2, sizeX, sizeY, item2.CenterX, item2.CenterY);
        matrix.blacken_cycle(conv.i, conv.j, (item2.Radius * num2) | 0);
      }
      if (PrintInitialAndFinalMatrix) {
        matrix.print_matrix(-1, -1);
      }
      if (PrintTimer && i % frequency === 0) {
        noop(i + " out of " + times);
      }
      k = 0;
      R = matrix.new_get_max_cycle(nextX, nextY, sizeX, sizeY, matrix.is_round, BallsList);
      if (R >= 0) {
        item = new BallOfFloat(nextX, nextY, R);
        conv = matrix.ConvertBack(num2, sizeX, sizeY, item.CenterX, item.CenterY);
        matrix.blacken_cycle(conv.i, conv.j, (item.Radius * num2) | 0);
        k++;
      } else {
        item = new BallOfFloat(nextX, nextY, -1);
      }
      BallsList.push(item);
      for (; k < numberOfBadBalls; k++) {
        cycleOut = {};
        matrix.new_get_max_free_cycle_in_matrix(sizeX, sizeY, matrix.is_round, Defs.Rezolution, BallsList, cycleOut);
        R = cycleOut.R;
        if (R < 0) {
          item = new BallOfFloat(cycleOut.Px, cycleOut.Py, -1);
        } else {
          item = new BallOfFloat(cycleOut.Px, cycleOut.Py, R);
          conv = matrix.ConvertBack(num2, sizeX, sizeY, item.CenterX, item.CenterY);
          matrix.blacken_cycle(conv.i, conv.j, (item.Radius * num2) | 0);
        }
        BallsList.push(item);
      }
      if (PrintInitialAndFinalMatrix) {
        matrix.print_matrix(-1, -1);
      }
      BadBalls.length = 0;
      for (j = 0; j < BallsList.length; j++) {
        item3 = BallsList[j];
        if (BallsList.indexOf(item3) >= count) {
          BadBalls.push(item3);
        }
      }
      now2 = Date.now();
      num += (now2 - now);
    }
    if (PrintStatistics) {
      noop("\n*** Finished ***\n\n");
      noop("Added " + numberOfBadBalls + " cycles to " + GoodBalls.length + " existing cycles on a " + matrix.lenX + "x" + matrix.lenY + " Matrix, " + times + " times\n");
      noop("Total time: " + (num | 0) + " milliseconds\nAvarage time: " + (num / times) + " milliseconds\n\n");
    }
  };

  root.AlgoErrorEstimation = AlgoErrorEstimation;
})(typeof self !== "undefined" ? self : window);
