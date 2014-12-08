(function() {
  var Position, Presenter, SyncHighlight, SyncPrompt;

  SyncHighlight = require('./sync_highlight');

  Position = require('./Position');

  SyncPrompt = require('./sync_prompt');

  Presenter = (function() {
    Presenter.prototype.pos = null;

    Presenter.prototype.sync_prompt = null;

    function Presenter(scope) {
      this.scope = scope;
      this.pos = new Position();
    }

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
      this.sync_prompt = null;
      return false;
    };

    Presenter.prototype.method_missing = function(input) {
      console.log("=> ", new SyncHighlight(this.scope("_ = " + input + ";_")).highlight());
      return true;
    };

    Presenter.prototype.prompt = function() {
      if (this.sync_prompt) {
        return;
      }
      this.sync_prompt = new SyncPrompt({
        prompt: function() {
          return "[" + (this.cli.history().length) + "] pryjs> ";
        },
        delegate: this
      });
      return this.sync_prompt.open();
    };

    return Presenter;

  })();

  module.exports = Presenter;

}).call(this);
