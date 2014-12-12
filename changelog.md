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
