(function() {
  var SyncPrompt, cli, deasync,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  cli = require('cline');

  deasync = require('deasync');

  SyncPrompt = (function() {
    SyncPrompt.prototype.prompt = null;

    SyncPrompt.prototype.delegate = null;

    SyncPrompt.prototype.done = true;

    function SyncPrompt(_arg) {
      this.prompt = _arg.prompt, this.delegate = _arg.delegate;
      this.handle = __bind(this.handle, this);
    }

    SyncPrompt.prototype.open = function() {
      var _results;
      this.done = false;
      this.cli = cli();
      this.cli.interact(this.prompt.call(this));
      this.cli.on('history', this.handle);
      _results = [];
      while (!this.done) {
        _results.push(deasync.runLoopOnce());
      }
      return _results;
    };

    SyncPrompt.prototype.handle = function(input) {
      var ssv;
      ssv = input.split(' ');
      if (this.delegate[ssv[0]]) {
        if (!this.delegate[ssv[0]].apply(this.delegate, ssv.splice(1))) {
          this.close();
        }
      } else {
        this.delegate.method_missing(input);
      }
      return this.cli._prompt = this.prompt.call(this);
    };

    SyncPrompt.prototype.close = function() {
      delete this.cli._nextTick;
      this.cli.stream.close();
      return this.done = true;
    };

    return SyncPrompt;

  })();

  module.exports = SyncPrompt;

}).call(this);
