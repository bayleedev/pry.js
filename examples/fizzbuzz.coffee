pry = require('../src/pry') # require('pryjs')

# http://rosettacode.org/wiki/FizzBuzz#CoffeeScript
fizzBuzz = ->
  for i in [1..100]
    output = ''
    eval(pry.it)
    output += "Fizz" if i % 3 is 0
    output += "Buzz" if i % 5 is 0
    console.log output || i

fizzBuzz()
