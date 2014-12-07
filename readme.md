## Pryjs
A prototype for a [pry](https://github.com/pry/pry)-like node module.

![pryjs](./assets/screenshot.png)

### Usage
It's not as pretty, but you'll need to add the following to your code:

~~~ coffeescript
pry (p) -> eval p
~~~

~~~ javascript
pry(function(p) {
  return eval(p);
});
~~~

### Extra Commands
While you are in the prompt there are a few things you might want to do:
* `whereami` will show you exactly where you are in the code.
* `stop` will exit the pryjs prompt and continue through the app.

### Example
~~~ coffeescript
pry = require 'pryjs'

testFun = ->
  i = 32

  example = ->
    console.log 'n called!'

  pry (p) -> eval p # pry call

  example()
  console.log('ahh', i)

testFun()
~~~
~~~ javascript
var pry, testFun;

pry = require('pryjs');

testFun = function() {
  var example, i;
  i = 32;
  example = function() {
    console.log('n called!');
  };
  pry(function(p) {
    return eval(p);
  }); // pry call
  example();
  console.log('ahh', i);
};

testFun();
~~~
