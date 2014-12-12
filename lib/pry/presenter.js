(function() {
  var Compiler, Docs, Position, Presenter, SyncHighlight, SyncPrompt, chalk, _;

  SyncHighlight = require('./sync_highlight');

  Position = require('./position');

  SyncPrompt = require('./sync_prompt');

  Compiler = require('./compiler');

  Docs = require('./file_doc');

  _ = require('underscore');

  chalk = require('chalk');

  chalk.enabled = true;

  Presenter = (function() {
    Presenter.prototype.last_error = {};

    function Presenter(scope, options) {
      this.scope = scope;
      this.options = options != null ? options : {};
      this.pos = new Position({
        output: this.output()
      });
    }

    Presenter.prototype.user_prompt = function() {
      return this._user_prompt || (this._user_prompt = new SyncPrompt({
        prompt: function() {
          return "[" + (this.cli.history().length) + "] pryjs> ";
        },
        delegate: this
      }));
    };

    Presenter.prototype.output = function() {
      var _ref;
      return require("./output/" + (((_ref = this.options.classes) != null ? _ref.output : void 0) || 'local') + "_output");
    };

    Presenter.prototype.compiler = function() {
      return this._compiler || (this._compiler = new Compiler({
        scope: this.scope,
        output: this.output()
      }));
    };


    /*
     * Display this help information.
     */

    Presenter.prototype.help = function() {
      var docs;
      docs = new Docs(__filename).get_docs();
      _.each(_.pairs(docs), function(_arg) {
        var docs, name;
        name = _arg[0], docs = _arg[1];
        return this.output().send("" + (chalk.red(name)) + ": " + (docs.join('\n')));
      });
      return true;
    };


    /*
     * Play specific lines of code, as if the user entered them.
     * `play 10 12` Plays line 10-12
     * `play 10` Plays line 10
     */

    Presenter.prototype.play = function(start, end) {
      if (end == null) {
        end = start;
      }
      this.method_missing(file.by_lines(start, end), this.pos.file().type());
      return true;
    };


    /*
     * Switch betwen JavaScipt and CoffeeScript input modes.
     */

    Presenter.prototype.mode = function() {
      this.compiler().toggle_mode();
      return true;
    };


    /*
     * Show the current version number of pry you have installed.
     */

    Presenter.prototype.version = function() {
      var content;
      content = require('fs').readFileSync("" + __dirname + "/../../package.json");
      this.output().send(JSON.parse(content)['version']);
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
        this.output().send(this.last_error.stack);
      } else {
        this.output().send('No errors');
      }
      return true;
    };

    Presenter.prototype.method_missing = function(input, language) {
      var err, output;
      try {
        output = this.compiler().execute(input, language);
        this.output().send("=> ", new SyncHighlight(output || 'undefined').highlight());
      } catch (_error) {
        err = _error;
        this.last_error = err;
        this.output().send("=> ", err, err.stack);
      }
      return true;
    };

    Presenter.prototype.prompt = function() {
      if (!this.user_prompt().done) {
        return true;
      }
      return this.user_prompt().open();
    };

    return Presenter;

  })();

  module.exports = Presenter;

}).call(this);
