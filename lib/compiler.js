(function() {
  var Compiler, coffee, pry;

  coffee = require('coffee-script');

  pry = require('./pry');

  Compiler = (function() {
    Compiler.prototype.mode_id = 0;

    Compiler.prototype.modes = ['js', 'coffee'];

    function Compiler(scope) {
      this.scope = scope;
    }

    Compiler.prototype.toggle_mode = function() {
      this.mode_id = (this.mode_id + 1) % this.modes.length;
      return console.log("=> Switched mode to '" + this.modes[this.mode_id] + "'.");
    };

    Compiler.prototype.execute = function(code) {
      return this["execute_" + this.modes[this.mode_id]](code);
    };

    Compiler.prototype.execute_js = function(code) {
      return this.scope("_ = " + code + ";_");
    };

    Compiler.prototype.execute_coffee = function(code) {
      return this.scope("_ = " + (coffee.compile(code, {
        bare: true
      })) + ";_");
    };

    return Compiler;

  })();

  module.exports = Compiler;

}).call(this);
