(function() {
  var Presenter, Pry;

  Presenter = require('./pry/presenter');

  Pry = (function() {
    function Pry() {
      this.it = "(" + (this._pry.toString()) + ")()";
    }

    Pry.prototype._pry = function() {
      return pry.open(function(input) {
        return eval(input);
      });
    };

    Pry.prototype.open = function(scope) {
      var presenter;
      presenter = new Presenter(scope);
      presenter.whereami();
      return presenter.prompt();
    };

    return Pry;

  })();

  module.exports = new Pry;

}).call(this);
