(function() {
  var File, SyncHighlight, chalk, fs;

  fs = require('fs');

  chalk = require('chalk');

  SyncHighlight = require('./sync_highlight');

  File = (function() {
    function File(file, line) {
      this.file = file;
      this.line = line;
    }

    File.prototype.type = function() {
      if (this.file.match(/coffee/)) {
        return 'coffeescript';
      } else {
        return 'javascript';
      }
    };

    File.prototype.content = function() {
      return fs.readFileSync(this.file).toString();
    };

    File.prototype.formatted_content = function() {
      return this.add_line_numbers(new SyncHighlight(this.content(), this.type()).highlight());
    };

    File.prototype.add_line_numbers = function(content) {
      var key, line, lines, pointer, space, _i, _len;
      lines = content.split("\n");
      space = function(longest, line_number) {
        var long, now;
        long = String(longest).length;
        now = String(line_number).length;
        return new Array(long - now + 1).join(' ');
      };
      space = space.bind(this, lines.length + 1);
      for (key = _i = 0, _len = lines.length; _i < _len; key = ++_i) {
        line = lines[key];
        pointer = "    ";
        if (key + 1 === this.line) {
          pointer = " => ";
        }
        lines[key] = "" + pointer + (space(key + 1)) + (chalk.cyan(key + 1)) + ": " + line;
      }
      return lines.join("\n");
    };

    return File;

  })();

  module.exports = File;

}).call(this);
