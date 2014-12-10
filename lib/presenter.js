(function() {
  var Compiler, Position, Presenter, SyncHighlight, SyncPrompt, fs;

  SyncHighlight = require('./sync_highlight');

  Position = require('./Position');

  SyncPrompt = require('./sync_prompt');

  Compiler = require('./compiler');

  fs = require('fs');

  Presenter = (function() {
    Presenter.prototype.last_error = {};

    function Presenter(scope) {
      this.compiler = new Compiler(scope);
      this.pos = new Position();
      this.sync_prompt = new SyncPrompt({
        prompt: function() {
          return "[" + (this.cli.history().length) + "] pryjs> ";
        },
        delegate: this
      });
    }

    Presenter.prototype.mode = function() {
      this.compiler.toggle_mode();
      return true;
    };

    Presenter.prototype.version = function() {
      var content;
      content = fs.readFileSync("" + __dirname + "/../package.json");
      console.log(JSON.parse(content)['version']);
      return true;
    };

    Presenter.prototype.whereami = function(before, after) {
      if (before == null) {
        before = 5;
      }
      if (after == null) {
        after = 5;
      }
      this.pos.show.apply(this.pos, [before, after].map(function(i) {
        return parseInt(i, 10);
      }));
      return true;
    };

    Presenter.prototype.stop = function() {
      return false;
    };

    Presenter.prototype.kill = function() {
      process.kill();
      return false;
    };

    Presenter.prototype.wtf = function() {
      if (this.last_error.stack) {
        console.log(this.last_error.stack);
      } else {
        console.log('No errors');
      }
      return true;
    };

    Presenter.prototype.method_missing = function(input) {
      var err, output;
      try {
        output = this.compiler.execute(input);
        console.log("=> ", new SyncHighlight(output).highlight());
      } catch (_error) {
        err = _error;
        this.last_error = err;
        console.log("=> ", err, err.stack);
      }
      return true;
    };

    Presenter.prototype.prompt = function() {
      if (!this.sync_prompt.done) {
        return true;
      }
      return this.sync_prompt.open();
    };

    return Presenter;

  })();

  module.exports = Presenter;

}).call(this);
