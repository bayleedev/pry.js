(function() {
  var File, Position, Presenter, chalk, deasync, fs, prompt, pry, pygmentize;

  prompt = require('sync-prompt').prompt;

  fs = require('fs');

  pygmentize = require('pygmentize-bundled');

  deasync = require("deasync");

  chalk = require('chalk');

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
      var data, done;
      done = false;
      data = null;
      pygmentize({
        lang: this.type(),
        format: "terminal"
      }, this.content(), (function(_this) {
        return function(err, res) {
          done = true;
          return data = _this.add_line_numbers(res.toString());
        };
      })(this));
      while (!done) {
        deasync.runLoopOnce();
      }
      return data;
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

  Position = (function() {
    Position.prototype._stack = null;

    function Position() {
      this._stack = new Error().stack;
    }

    Position.prototype.show = function(before, after) {
      if (before == null) {
        before = 5;
      }
      if (after == null) {
        after = 5;
      }
      return console.log(this.file().formatted_content().split("\n").slice(this.line() - (before + 1), this.line() + after).join("\n"));
    };

    Position.prototype.file = function() {
      return this._file || (this._file = new File(this.stack()[1], this.line()));
    };

    Position.prototype.line = function() {
      return parseInt(this.stack()[2], 10);
    };

    Position.prototype.stack = function() {
      return this._stack.split("\n")[4].match(/\(([^:]+):(\d+)/);
    };

    return Position;

  })();

  Presenter = (function() {
    Presenter.prototype.pos = null;

    Presenter.prototype.commands = [];

    function Presenter(scope) {
      this.scope = scope;
      this.pos = new Position();
    }

    Presenter.prototype.whereami = function() {
      this.pos.show();
      return true;
    };

    Presenter.prototype.stop = function() {
      return false;
    };

    Presenter.prototype.prompt = function() {
      var output;
      this.commands.push(output = prompt("[" + this.commands.length + "] pry> "));
      if (this[output]) {
        if (this[output]()) {
          return this.prompt();
        }
      } else {
        console.log("=> " + (this.scope(output)));
        return this.prompt();
      }
    };

    return Presenter;

  })();

  pry = function(scope) {
    var count, presenter;
    presenter = new Presenter(scope);
    count = 0;
    presenter.whereami();
    return presenter.prompt();
  };

  module.exports = pry;

}).call(this);
