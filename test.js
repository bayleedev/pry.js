testFun = function() {
  (function() {
    example2 = function() {
      return console.log('rawr!');
    };
    return eval('example1 = function() { console.log("I will rule the world!!"); };');
  })();
  example1();
  example2();
};

testFun();
