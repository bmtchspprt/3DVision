(function (global) {
  "use strict";
  var root = global.LocatorAlgo = global.LocatorAlgo || {};

  function Balls(x, y, r) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.numTouchBalls = 0;
    this.angleAuxliary = 0;
    this.isNearWall = false;
    this.isGoodBal = false;
    this.xOffset = 0;
    this.yOffset = 0;
  }

  function BallOfFloat(X, Y, R) {
    if (arguments.length === 0) {
      this.CenterX = -1;
      this.CenterY = -1;
      this.Radius = -1;
    } else {
      this.CenterX = X;
      this.CenterY = Y;
      this.Radius = R;
    }
  }

  root.Balls = Balls;
  root.BallOfFloat = BallOfFloat;
})(typeof self !== "undefined" ? self : window);
