/** Minimal DOM for Fuzzy_*.xml loading in Node smoke tests. */
export function parseFuzzyXml(xml) {
  function Node(name, attrs, children, text) {
    this.nodeName = name;
    this.tagName = name;
    this.attributes = attrs || [];
    this.childNodes = children || [];
    this.textContent = text || "";
  }
  Node.prototype.getAttribute = function (n) {
    for (var i = 0; i < this.attributes.length; i++) {
      if (this.attributes[i].name === n) return this.attributes[i].value;
    }
    return null;
  };
  Node.prototype.getElementsByTagName = function (tag) {
    var out = [];
    function walk(n) {
      if (n.nodeName === tag) out.push(n);
      (n.childNodes || []).forEach(walk);
    }
    walk(this);
    return out;
  };

  function parseAttrs(s) {
    var attrs = [];
    var re = /([A-Za-z0-9_]+)\s*=\s*"([^"]*)"/g;
    var m;
    while ((m = re.exec(s))) {
      attrs.push({ name: m[1], nodeName: m[1], value: m[2] });
    }
    return attrs;
  }

  var tokens = [];
  var re = /<\/?([A-Za-z0-9_]+)([^>]*)>/g;
  var m;
  while ((m = re.exec(xml))) {
    var full = m[0];
    var name = m[1];
    var rest = m[2] || "";
    if (full[1] === "/") tokens.push({ type: "close", name: name });
    else if (rest.trim().endsWith("/") || full.endsWith("/>")) {
      tokens.push({ type: "empty", name: name, attrs: parseAttrs(rest) });
    } else tokens.push({ type: "open", name: name, attrs: parseAttrs(rest) });
  }

  var root = new Node("#document", [], []);
  var stack = [root];
  tokens.forEach(function (t) {
    if (t.type === "open") {
      var n = new Node(t.name, t.attrs, []);
      stack[stack.length - 1].childNodes.push(n);
      stack.push(n);
    } else if (t.type === "empty") {
      stack[stack.length - 1].childNodes.push(new Node(t.name, t.attrs, []));
    } else if (t.type === "close") {
      if (stack.length > 1) stack.pop();
    }
  });
  return root;
}
