(function() {
  var Compiler, Docs, Position, Presenter, SyncHighlight, SyncPrompt, chalk, fs, _;

  SyncHighlight = require('./sync_highlight');

  Position = require('./Position');

  SyncPrompt = require('./sync_prompt');

  Compiler = require('./compiler');

  Docs = require('./file_doc');

  fs = require('fs');

  _ = require('underscore');

  chalk = require('chalk');

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


    /*
     * Display this help information.
     */

    Presenter.prototype.help = function() {
      var docs;
      docs = new Docs(__filename).get_docs();
      _.each(_.pairs(docs), function(_arg) {
        var docs, name;
        name = _arg[0], docs = _arg[1];
        return console.log("" + (chalk.red(name)) + ": " + (docs.join('\n')));
      });
      return true;
    };


    /*
     * Switch betwen JavaScipt and CoffeeScript input modes.
     */

    Presenter.prototype.mode = function() {
      this.compiler.toggle_mode();
      return true;
    };


    /*
     * Show the current version number of pry you have installed.
     */

    Presenter.prototype.version = function() {
      var content;
      content = fs.readFileSync("" + __dirname + "/../package.json");
      console.log(JSON.parse(content)['version']);
      return true;
    };


    /*
     * Show context of your current pry statement. Accepts two optional arguments.
     * `whereami 10 5`
     */

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


    /*
     * Destory the current instance of pry.
     */

    Presenter.prototype.stop = function() {
      return false;
    };


    /*
     * Stop the program.
     */

    Presenter.prototype.kill = function() {
      process.kill();
      return false;
    };


    /*
     * Display the last catch exception, if any exists.
     */

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
