File = require('./file')

class Position

  _stack: null

  constructor: ->
    @_stack = new Error().stack

  show: (before, after) ->
    console.log(@file()
      .formatted_content()
      .split("\n")
      .slice(@line() - (before + 1), @line() + after)
      .join("\n"))

  file: ->
    @_file ||= new File(@stack()[1], @line())

  line: ->
    parseInt(@stack()[2], 10)

  stack: ->
    @_stack.split("\n")[4].match(/([^ (]+):(\d+):\d+\)?$/)

module.exports = Position
