/* LocatorPlacement.FuzzyManager
 * Port of FuzzyManager load/geometry-type/multi-fill coeff scaling.
 * LoadFuzzyTableFileXml(xmlString) uses DOMParser (browser) or self.DOMParser.
 */
(function (root) {
  'use strict';
  var NS = root.LocatorPlacement = root.LocatorPlacement || {};

  var eFuzzyType = {
    NotDefined: 'NotDefined',
    Dome: 'Dome',
    SFCenterSECenter: 'SFCenterSECenter',
    SFCenterSENoCenter: 'SFCenterSENoCenter',
    SFNoCenterSECenter: 'SFNoCenterSECenter',
    SFNoCenterSENoCenter: 'SFNoCenterSENoCenter',
    NoSymAndCons: 'NoSymAndCons',
    SF: 'SF',
    MFSECenter: 'MFSECenter',
    MFSENoCenter: 'MFSENoCenter'
  };

  function TablePointFuzzyLogic(valIndex, fuzzyLogicVal) {
    this.Index = (valIndex * 10) + ' %';
    this.FuzzyLogicVal = fuzzyLogicVal;
    this.MinVal = -Number.MAX_VALUE;
    this.MaxVal = Number.MAX_VALUE;
  }

  function FuzzyData() {
    this.FileName = '';
    this.DisplayName = '';
    this.ShortDisplayName = '';
    this.FuzzyType = eFuzzyType.NotDefined;
  }
  FuzzyData.prototype.Clear = function () {
    this.FileName = '';
    this.DisplayName = '';
    this.ShortDisplayName = '';
    this.FuzzyType = eFuzzyType.NotDefined;
  };

  function FuzzyManager() {
    this.deviceInWork = null;
    this.epsilon = 0.01;
    this.fuzzyLoadedFileMultiplyCoefficient = 1.0;
    this.isAutoCalculation = true;
    this.fuzzyDataAuto = new FuzzyData();
    this.fuzzyData = this.fuzzyDataAuto;
    this.listFuzzyTables = null;
    this.fuzzyLogicValuesSymmetry = [];
    this.fuzzyLogicValuesCone = [];
    var i;
    for (i = 0; i < 11; i++) {
      this.fuzzyLogicValuesSymmetry.push(new TablePointFuzzyLogic(i, 0.0));
      this.fuzzyLogicValuesCone.push(new TablePointFuzzyLogic(i, 0.0));
    }
  }

  FuzzyManager.FuzzyCoeffMultipleFillingPointsDeveloper = 1.0;
  FuzzyManager.eFuzzyType = eFuzzyType;
  FuzzyManager.TablePointFuzzyLogic = TablePointFuzzyLogic;
  FuzzyManager.FuzzyData = FuzzyData;

  FuzzyManager.DistanceFromCenter = function (x, y) {
    return Math.sqrt(Math.pow(x, 2.0) + Math.pow(y, 2.0));
  };

  Object.defineProperty(FuzzyManager.prototype, 'FuzzyLogicValuesSymmetry', {
    get: function () { return this.fuzzyLogicValuesSymmetry; }
  });
  Object.defineProperty(FuzzyManager.prototype, 'FuzzyLogicValuesCone', {
    get: function () { return this.fuzzyLogicValuesCone; }
  });
  Object.defineProperty(FuzzyManager.prototype, 'FuzzyLoadedFileMultiplyCoefficient', {
    get: function () { return this.fuzzyLoadedFileMultiplyCoefficient; }
  });
  Object.defineProperty(FuzzyManager.prototype, 'FuzzyType', {
    get: function () {
      if (!this.fuzzyData) return eFuzzyType.NotDefined;
      return this.fuzzyData.FuzzyType;
    }
  });
  Object.defineProperty(FuzzyManager.prototype, 'DisplayName', {
    get: function () {
      if (!this.fuzzyData) return '';
      return this.fuzzyData.DisplayName;
    }
  });

  FuzzyManager.prototype.setDeviceInWork = function (device) {
    this.deviceInWork = device;
  };

  FuzzyManager.prototype.GetFuzzyTypeFromGeometry = function () {
    var device = this.deviceInWork;
    var result = eFuzzyType.NotDefined;
    this.epsilon = device.DeviceDiameter / 2.0 * 0.1;
    var flag = false;
    var flag2 = false;
    var emptyPoints = device.EmptyPoints;
    var fillPoints = device.FillPoints;
    if (emptyPoints != null) {
      if (emptyPoints.length === 0) {
        flag = true;
      } else if (emptyPoints.length === 1) {
        var num = FuzzyManager.DistanceFromCenter(emptyPoints[0].X, emptyPoints[0].Y);
        if (num <= this.epsilon) {
          flag = true;
        }
      }
    } else {
      flag = true;
    }
    var flag3 = false;
    if (fillPoints != null && fillPoints.length === 1) {
      flag3 = true;
    }
    if (flag3) {
      num = FuzzyManager.DistanceFromCenter(fillPoints[0].X, fillPoints[0].Y);
      if (num <= this.epsilon) {
        flag2 = true;
      }
    }
    var v = device.VesselInWork;
    var top = v.TopShapeType;
    if ((top === 'Dome' || top === 2) && (v.TotalHeight - v.TopShapeHeight) / v.TotalHeight < 0.15) {
      return eFuzzyType.Dome;
    }
    if (!flag3 && flag) {
      return eFuzzyType.MFSECenter;
    }
    if (!flag3 && !flag) {
      return eFuzzyType.MFSENoCenter;
    }
    if (flag2 && flag) {
      return eFuzzyType.SFCenterSECenter;
    }
    if (flag2 && !flag) {
      return eFuzzyType.SFCenterSENoCenter;
    }
    if (!flag2 && flag) {
      return eFuzzyType.SFNoCenterSECenter;
    }
    if (fillPoints != null && fillPoints.length === 1 && emptyPoints != null && emptyPoints.length === 1) {
      return eFuzzyType.SFNoCenterSENoCenter;
    }
    if (fillPoints != null && fillPoints.length === 1) {
      return eFuzzyType.SF;
    }
    return result;
  };

  FuzzyManager.prototype.CalulateFuzzyCoeffFromMultipleToSingle = function () {
    this.fuzzyLoadedFileMultiplyCoefficient = 1.0;
    if (!this.deviceInWork.FillPoints || this.deviceInWork.FillPoints.length <= 1) {
      return 1.0;
    }
    var device = this.deviceInWork;
    var list = [];
    var i, j;
    for (i = 0; i < device.FillPoints.length; i++) {
      for (j = i + 1; j < device.FillPoints.length; j++) {
        list.push(Math.sqrt(
          Math.pow(device.FillPoints[i].X - device.FillPoints[j].X, 2.0) +
          Math.pow(device.FillPoints[i].Y - device.FillPoints[j].Y, 2.0)
        ));
      }
    }
    list.sort(function (a, b) { return a - b; });
    var num = list[list.length - 1];
    var num2 = device.VesselInWork.CenterShapeDiameterMeter / 2.0;
    if (device.VesselInWork.CenterShapeType === 'Cube' || device.VesselInWork.CenterShapeType === NS.ShapeCenterType.Cube) {
      var num3 = Math.sqrt(
        Math.pow(device.VesselInWork.CenterShapeXMeter, 2.0) +
        Math.pow(device.VesselInWork.CenterShapeYMeter, 2.0)
      );
      num2 = num3 / 2.0;
    }
    if (num <= 1E-05) {
      return 1.0;
    }
    this.fuzzyLoadedFileMultiplyCoefficient = 1.0 - Math.min(num2, num) / num2;
    this.fuzzyLoadedFileMultiplyCoefficient *= FuzzyManager.FuzzyCoeffMultipleFillingPointsDeveloper;
    return this.fuzzyLoadedFileMultiplyCoefficient;
  };

  FuzzyManager.prototype.UpdateFuzzyCoeffFromMultipleToSingle = function () {
    var num = this.CalulateFuzzyCoeffFromMultipleToSingle();
    if (!this.fuzzyLogicValuesSymmetry) return;
    var i;
    for (i = 0; i < this.fuzzyLogicValuesSymmetry.length; i++) {
      this.fuzzyLogicValuesSymmetry[i].FuzzyLogicVal *= num;
    }
  };

  function parseDouble(s) {
    return parseFloat(String(s).replace(',', '.'));
  }

  function loadGeneral(fuzzyData, xmlRoot) {
    var gen = xmlRoot.getElementsByTagName('General')[0];
    if (!gen) return;
    if (gen.getAttribute('DisplayName') != null) {
      fuzzyData.DisplayName = gen.getAttribute('DisplayName');
    }
    if (gen.getAttribute('ShortName') != null) {
      fuzzyData.ShortDisplayName = gen.getAttribute('ShortName');
    }
    if (gen.getAttribute('Type') != null) {
      fuzzyData.FuzzyType = gen.getAttribute('Type');
    }
  }

  function algorithmFuzzyParams(paramNodes) {
    var list = [];
    if (!paramNodes) return list;
    var list2 = [];
    var i, j;
    for (i = 0; i < paramNodes.length; i++) {
      var attrs = paramNodes[i].attributes;
      if (!attrs) continue;
      for (j = 0; j < attrs.length; j++) {
        if (attrs[j].name === 'Val' || attrs[j].nodeName === 'Val') {
          list2.push(parseDouble(attrs[j].value));
        }
      }
    }
    for (i = 0; i < list2.length; i++) {
      list.push(new TablePointFuzzyLogic(list2.length - 1 - i, list2[i]));
    }
    return list;
  }

  /* Parse Fuzzy XML string into this manager's coefficient tables */
  FuzzyManager.prototype.LoadFuzzyTableFileXml = function (fuzzyDataObj, xmlString) {
    var Parser = (typeof DOMParser !== 'undefined') ? DOMParser : (root.DOMParser || null);
    if (!Parser) {
      throw new Error('DOMParser required to load Fuzzy XML');
    }
    var doc = new Parser().parseFromString(xmlString, 'application/xml');
    var xmlRoot = doc.getElementsByTagName('Fuzzy')[0];
    if (!xmlRoot) throw new Error('Fuzzy root missing');
    loadGeneral(fuzzyDataObj, xmlRoot);
    var almostFull = xmlRoot.getElementsByTagName('FuzzyLogicParamsAlmostFull')[0];
    var paramsSym = xmlRoot.getElementsByTagName('FuzzyLogicParams')[0];
    var coneNodes = almostFull ? almostFull.getElementsByTagName('FuzzyLogicParam') : [];
    var symNodes = paramsSym ? paramsSym.getElementsByTagName('FuzzyLogicParam') : [];
    this.fuzzyLogicValuesCone = algorithmFuzzyParams(coneNodes);
    this.fuzzyLogicValuesSymmetry = algorithmFuzzyParams(symNodes);
    this.fuzzyData = fuzzyDataObj;
  };

  /* Load by eFuzzyType using a table map: { SFCenterSECenter: xmlString, ... } */
  FuzzyManager.prototype.LoadFuzzyTableFile = function (fuzzyDataObj, fTypeOrXml, tableMapOpt) {
    if (typeof fTypeOrXml === 'string' && fTypeOrXml.indexOf('<') >= 0) {
      this.LoadFuzzyTableFileXml(fuzzyDataObj, fTypeOrXml);
      return;
    }
    var fType = fTypeOrXml;
    var eFuzzyType2 = fType;
    var flag = false;
    if (fType === eFuzzyType.MFSECenter) {
      eFuzzyType2 = eFuzzyType.SFCenterSECenter;
      flag = true;
    } else if (fType === eFuzzyType.MFSENoCenter) {
      eFuzzyType2 = eFuzzyType.SFNoCenterSECenter;
      flag = true;
    }
    var map = tableMapOpt || FuzzyManager.FuzzyTableXmlByType || {};
    var xml = map[eFuzzyType2];
    if (!xml) {
      throw new Error('Fuzzy XML not found for type: ' + eFuzzyType2);
    }
    this.LoadFuzzyTableFileXml(fuzzyDataObj, xml);
    if (flag) {
      this.UpdateFuzzyCoeffFromMultipleToSingle();
    }
  };

  FuzzyManager.prototype.LoadFromGeometry = function (tableMap) {
    var t = this.GetFuzzyTypeFromGeometry();
    if (t === eFuzzyType.NotDefined) return t;
    this.LoadFuzzyTableFile(this.fuzzyData, t, tableMap);
    return t;
  };

  FuzzyManager.GetFuzzyDataOnlyXml = function (xmlString) {
    var result = new FuzzyData();
    var Parser = (typeof DOMParser !== 'undefined') ? DOMParser : (root.DOMParser || null);
    var doc = new Parser().parseFromString(xmlString, 'application/xml');
    var xmlRoot = doc.getElementsByTagName('Fuzzy')[0];
    loadGeneral(result, xmlRoot);
    return result;
  };

  /* Optional baked default SFCenterSECenter table (install Fuzzy_SFCenterSECenter.xml) */
  FuzzyManager.FuzzyTableXmlByType = FuzzyManager.FuzzyTableXmlByType || {};
  FuzzyManager.FuzzyTableXmlByType.SFCenterSECenter =
    '<?xml version="1.0"?>\n' +
    '<Fuzzy>\n' +
    '  <General Type="SFCenterSECenter" DisplayName="Single fill in point at the center and single emptying points at the center" ShortName="Single point: Fill Center Empty Center" />\n' +
    '  <FuzzyLogicParams>\n' +
    '    <FuzzyLogicParam Val="0.9" /><FuzzyLogicParam Val="0.8" /><FuzzyLogicParam Val="0.6" />\n' +
    '    <FuzzyLogicParam Val="0.3" /><FuzzyLogicParam Val="0.15" /><FuzzyLogicParam Val="0" />\n' +
    '    <FuzzyLogicParam Val="0" /><FuzzyLogicParam Val="0" /><FuzzyLogicParam Val="0" />\n' +
    '    <FuzzyLogicParam Val="0" /><FuzzyLogicParam Val="0" />\n' +
    '  </FuzzyLogicParams>\n' +
    '  <FuzzyLogicParamsAlmostFull>\n' +
    '    <FuzzyLogicParam Val="0.9" /><FuzzyLogicParam Val="0.7" /><FuzzyLogicParam Val="0.2" />\n' +
    '    <FuzzyLogicParam Val="0.1" /><FuzzyLogicParam Val="0" /><FuzzyLogicParam Val="0" />\n' +
    '    <FuzzyLogicParam Val="0" /><FuzzyLogicParam Val="0" /><FuzzyLogicParam Val="0" />\n' +
    '    <FuzzyLogicParam Val="0" /><FuzzyLogicParam Val="0" />\n' +
    '  </FuzzyLogicParamsAlmostFull>\n' +
    '</Fuzzy>';

  NS.eFuzzyType = eFuzzyType;
  NS.TablePointFuzzyLogic = TablePointFuzzyLogic;
  NS.FuzzyData = FuzzyData;
  NS.FuzzyManager = FuzzyManager;
})(typeof self !== 'undefined' ? self : (typeof globalThis !== 'undefined' ? globalThis : this));
