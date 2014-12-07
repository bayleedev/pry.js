(function() {
  var Presenter;

  Presenter = require('./presenter');

  module.exports = function(scope) {
    var presenter;
    presenter = new Presenter(scope);
    presenter.whereami();
    return presenter.prompt();
  };

}).call(this);
