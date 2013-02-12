// Generated by CoffeeScript 1.4.0
(function() {

  define(function() {
    var Manipulater;
    Manipulater = (function() {

      function Manipulater() {}

      Manipulater.prototype.createTags = function(anArray, tagType, key, attr) {
        var n, results, _i, _len;
        results = "";
        for (_i = 0, _len = anArray.length; _i < _len; _i++) {
          n = anArray[_i];
          results += "<" + tagType + " " + attr + "=" + n[key] + " >";
        }
        return results;
      };

      Manipulater.prototype.wrapTags = function(tagsToWrap, keyDataArray, tagType, key, attr) {
        var index, n, results, tagsArray, _i, _len;
        results = "";
        tagsArray = tagsToWrap.split(">");
        tagsArray.pop();
        for (index = _i = 0, _len = tagsArray.length; _i < _len; index = ++_i) {
          n = tagsArray[index];
          results += "<" + tagType + " " + attr + "='" + keyDataArray[index][key] + "'> " + n + "> </" + tagType + ">";
        }
        return results;
      };

      Manipulater.prototype.injectInto = function(parentDiv, elements) {
        return $("" + parentDiv).append(elements);
      };

      return Manipulater;

    })();
    return Manipulater;
  });

}).call(this);