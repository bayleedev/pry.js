(function() {
  var Position, Presenter, SyncHighlight, SyncPrompt, fs;

  SyncHighlight = require('./sync_highlight');

  Position = require('./Position');

  SyncPrompt = require('./sync_prompt');

  fs = require('fs');

  Presenter = (function() {
    Presenter.prototype.pos = null;

    Presenter.prototype.sync_prompt = null;

    function Presenter(scope) {
      this.scope = scope;
      this.pos = new Position();
      this.sync_prompt = new SyncPrompt({
        prompt: function() {
          return "[" + (this.cli.history().length) + "] pryjs> ";
        },
        delegate: this
      });
    }

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

    Presenter.prototype.method_missing = function(input) {
      var err;
      try {
        console.log("=> ", new SyncHighlight(this.scope("_ = " + input + ";_")).highlight());
      } catch (_error) {
        err = _error;
        console.log("=> ", err);
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
