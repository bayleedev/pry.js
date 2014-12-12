(function() {
  var LocalOutput;

  LocalOutput = (function() {
    function LocalOutput() {}

    LocalOutput.prototype.send = function() {
      return console.log.apply(console.log, arguments);
    };

    return LocalOutput;

  })();

  module.exports = new LocalOutput;

}).call(this);
