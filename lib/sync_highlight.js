(function() {
  var SyncHighlight, deasync, pygmentize;

  pygmentize = require('pygmentize-bundled');

  deasync = require("deasync");

  SyncHighlight = (function() {
    SyncHighlight.prototype.content = null;

    SyncHighlight.prototype.type = null;

    function SyncHighlight(obj, type) {
      this.type = type != null ? type : 'javascript';
      if (typeof obj === 'function') {
        this.content = obj.toString();
      } else if (typeof obj === 'string') {
        this.content = obj;
      } else {
        this.content = JSON.stringify(obj, this.stringify, "\t");
      }
    }

    SyncHighlight.prototype.stringify = function(key, value) {
      if (typeof value === 'function') {
        return util.inspect(value);
      }
      return value;
    };

    SyncHighlight.prototype.highlight = function() {
      var data, done;
      done = data = false;
      pygmentize({
        lang: this.type,
        format: "terminal"
      }, this.content, (function(_this) {
        return function(err, res) {
          done = true;
          return data = res.toString();
        };
      })(this));
      while (!done) {
        deasync.runLoopOnce();
      }
      return data;
    };

    return SyncHighlight;

  })();

  module.exports = SyncHighlight;

}).call(this);
