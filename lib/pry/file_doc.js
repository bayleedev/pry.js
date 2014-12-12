(function() {
  var FileDoc, coffee, fs, _;

  coffee = require('coffee-script');

  _ = require('underscore');

  fs = require('fs');

  FileDoc = (function() {
    function FileDoc(filename) {
      this.filename = filename;
    }

    FileDoc.prototype.get_docs = function() {
      var data;
      data = fs.readFileSync(this.filename).toString();
      if (this.filename.match(/coffee$/)) {
        data = coffee.compile(data, {
          bare: true
        });
      }
      return this._get_methods(data);
    };

    FileDoc.prototype._get_methods = function(data) {
      var docs;
      docs = _.reduce(data.split("\n"), function(memo, line) {
        var name;
        if (line.trim().match(/^\*/)) {
          line = line.trim().match(/^\* ?(.*)$/)[1];
          if (line.length > 1) {
            memo._temp.push(line);
          }
        } else if (line.match(/function/)) {
          if (memo._temp.length === 0) {
            return memo;
          }
          name = line.match(/([a-z]+)\W+function/)[1];
          memo[name] = memo._temp;
          memo._temp = [];
        }
        return memo;
      }, {
        _temp: []
      });
      delete docs._temp;
      return docs;
    };

    return FileDoc;

  })();

  module.exports = FileDoc;

}).call(this);
