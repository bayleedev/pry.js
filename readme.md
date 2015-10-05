## Pryjs

A interactive repl for node, inspired by [pry](https://github.com/pry/pry).

[![Build Status](https://travis-ci.org/blainesch/pry.js.svg?branch=master)](https://travis-ci.org/blainesch/pry.js)

### Installing

~~~
npm install --save pryjs
~~~

### Usage

Throw this beautiful snippet in the middle of your code:

~~~ javascript
pry = require('pryjs')
eval(pry.it)
~~~

### Extra Commands

While you are in the prompt there are a few things you might want to do:
* `help` display all the available commands.
* `kill` completely stop the script.
* `mode` switch between javascript and coffeescript mode. Defaults to javascript.
* `play` play lines of code as if you had entered them. Accepts two integers: start and end. End defaults to start.
* `stop` will exit the pryjs prompt and continue through the app.
* `version` display the current version.
* `whereami` will show you exactly where you are in the code. Accepts two integers to replace the default 5 before and 5 after.
* `wtf` display the last caught exception.

### Examples

Examples can be found in the [examples directory](./examples).

### Screenshots

![pryjs](./assets/demo.png)
