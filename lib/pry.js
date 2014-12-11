(function() {
  var Presenter;

  Presenter = require('./pry/presenter');

  module.exports = function(scope) {
    var presenter;
    presenter = new Presenter(scope);
    presenter.whereami();
    return presenter.prompt();
  };

}).call(this);
