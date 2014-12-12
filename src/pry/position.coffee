File = require './file'

class Position

  _stack: null

  constructor: ({@output}) ->
    @_stack = new Error().stack

  show: (before, after) ->
    start = @line() - (before + 1)
    start = (if start < 0 then 0 else start)
    @output.send(@file()
      .formatted_content()
      .split("\n")
      .slice(start, @line() + after)
      .join("\n"))

  file: ->
    @_file ||= new File(@stack()[1], @line())

  line: ->
    parseInt(@stack()[2], 10)

  stack: ->
    @_stack.split("\n")[6].match(/([^ (]+):(\d+):\d+\)?$/)

module.exports = Position
