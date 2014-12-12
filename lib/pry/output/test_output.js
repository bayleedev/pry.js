(function() {
  var TestOutput;

  TestOutput = (function() {
    function TestOutput() {}

    TestOutput.prototype.items = [];

    TestOutput.prototype.reset = function() {
      return this.items = [];
    };

    TestOutput.prototype.send = function() {
      this.items.push(arguments);
      return arguments;
    };

    return TestOutput;

  })();

  module.exports = new TestOutput;

}).call(this);
