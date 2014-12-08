File = require('./file')

class Position

  _stack: null

  constructor: ->
    @_stack = new Error().stack

  show: (before, after) ->
    start = @line() - (before + 1)
    start = (if start < 0 then 0 else start)
    console.log(@file()
      .formatted_content()
      .split("\n")
      .slice(start, @line() + after)
      .join("\n"))

  file: ->
    @_file ||= new File(@stack()[1], @line())

  line: ->
    parseInt(@stack()[2], 10)

  stack: ->
    @_stack.split("\n")[4].match(/([^ (]+):(\d+):\d+\)?$/)

module.exports = Position
