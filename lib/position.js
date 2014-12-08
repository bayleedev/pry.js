(function() {
  var File, Position;

  File = require('./file');

  Position = (function() {
    Position.prototype._stack = null;

    function Position() {
      this._stack = new Error().stack;
    }

    Position.prototype.show = function(before, after) {
      var start;
      start = this.line() - (before + 1);
      start = (start < 0 ? 0 : start);
      return console.log(this.file().formatted_content().split("\n").slice(start, this.line() + after).join("\n"));
    };

    Position.prototype.file = function() {
      return this._file || (this._file = new File(this.stack()[1], this.line()));
    };

    Position.prototype.line = function() {
      return parseInt(this.stack()[2], 10);
    };

    Position.prototype.stack = function() {
      return this._stack.split("\n")[4].match(/([^ (]+):(\d+):\d+\)?$/);
    };

    return Position;

  })();

  module.exports = Position;

}).call(this);
