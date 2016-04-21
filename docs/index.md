---
layout: home
---

This offers many advantages over other debuggers. It allows you to see and write
in *CoffeeScript* or *JavaScript*, so you can debug in the language you wrote in.
It's easy to setup. Just a simple `npm install` and it's already working! The
tests run the examples! It uses
[Cucumber](https://www.npmjs.com/package/cucumber) to run the examples for all
of our tests, so you know they work!

## Quick Start

~~~ bash
npm install --save pryjs
~~~

### Usage

Throw this beautiful snippet in the middle of your code:

~~~ javascript
import pry from 'pryjs'
eval(pry.it)
~~~

~~~ javascript
pry = require('pryjs')
eval(pry.it)
~~~

You *MUST* name the variable `pry`. You are executing an anonymous function, and
this assumes the variable is named `pry` in your scope. This is so it can keep
prompting you.

## Global Command

~~~ bash
npm install -g pryjs
~~~

~~~ bash
pryjs
~~~

## Extra Commands

While you are in the prompt there are a few things you might want to do:

* `help` display all the available commands.
* `kill` completely stop the script.
* `mode` switch between javascript and coffeescript mode. Defaults to javascript.
* `play` play lines of code as if you had entered them. Accepts two integers: start and end. End defaults to start.
* `stop` will exit the pryjs prompt and continue through the app.
* `version` display the current version.
* `whereami` will show you exactly where you are in the code. Accepts two integers to replace the default 5 before and 5 after.
* `wtf` display the last caught exception.

## Learn More

There are more examples and information in the readme of the [GitHub Repo](https://github.com/blainesch/pry.js).
