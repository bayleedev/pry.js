pry = require('../lib/pry');

// http://rosettacode.org/wiki/FizzBuzz#JavaScript
function fizzBuzz() {
  var i, output;
  for (i = 1; i < 101; i++) {
    output = '';
    eval(pry.it);
    if (!(i % 3)) output += 'Fizz';
    if (!(i % 5)) output += 'Buzz';
    console.log(output || i);
  }
};

fizzBuzz()
