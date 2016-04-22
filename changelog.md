# 1.0.2

## Fixed Bug

* Array index issue caused `whereami` to break on smaller files.

# 1.0.1

## Fixed Bug

* Uses the file length to correct get `whereami` lines.

# 1.0.0

## New Features

* When you install globally you get a `pryjs` binary added to your PATH.

## Fixed Bugs

* Small files no longer break `whereami`.

# 0.1.4

## New Features

* Use `continue` instead of `stop`.

# 0.1.3

## Fixed Bugs

* Pushed Bad Source to NPM

# 0.1.2

## Fixed Bugs

* Don't redeclare variables when executing coffee-script.
* Upgrade deaasync for Node v4.1.1

# 0.1.0

## New Features
* New variable given to you with the results of the last statement.

# 0.0.14

## Fixed Bugs

* No longer executing input multiple times.
* Show errors as they happen, not just when asked.

# 0.0.9

## New Features

* Allow typing multiple lines of javascript in the prompt.
* Add typeahead/autocomplete when writing up commands.
* Add `ctrl+v` for multiline instead of guessing.

# 0.0.8

## New Features

* Add a new `kill` command to kill the entire process instead of just this prompt.
* Add a new `wtf` command to show you the last caught error.
* Allow you to type CoffeeScript in the prompt.
* Add a new `help` command to list all the available commands.
* Add new `play` command that can play lines via their absolute line numbers.
* Change the pry statement to a much prettier `eval(pry.it)`.

## Fixed Bugs

* When nothing is returned it gives you back the prompt.

# 0.0.7

## New Features

* Fix array slice bug when trying to view lines before 0.

# 0.0.6

## New Features

* Allow version to be retrieved from the prompt.
* Fix prompt not giving back control of i/o.
* Catch exceptions in the prompt and display them instead of erroring.

# 0.0.5

## New Features

* Keyboard shorts in prompt.
* History in the prompt.
* Colored output for functions and objects.
