(function() {
  var Position, Presenter, SyncHighlight, prompt;

  prompt = require('sync-prompt').prompt;

  SyncHighlight = require('./sync_highlight');

  Position = require('./Position');

  Presenter = (function() {
    Presenter.prototype.pos = null;

    Presenter.prototype.commands = [];

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
      return false;
    };

    Presenter.prototype.prompt = function() {
      var output, ssv;
      this.commands.push(output = prompt("[" + this.commands.length + "] pryjs> "));
      ssv = output.split(' ');
      if (this[ssv[0]]) {
        if (this[ssv[0]].apply(this, ssv.splice(1))) {
          return this.prompt();
        }
      } else {
        console.log("=> ", new SyncHighlight(this.scope("_ = " + output + ";_")).highlight());
        return this.prompt();
      }
    };

    return Presenter;

  })();

  module.exports = Presenter;

}).call(this);
