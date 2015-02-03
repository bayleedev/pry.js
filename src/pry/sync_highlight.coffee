pygmentize = require 'pygmentize-bundled'
deasync = require 'deasync'
chalk = require 'chalk'
util = require 'util'

class SyncHighlight

  content: null

  type: null

  constructor: (obj, @type = 'javascript') ->
    if typeof obj == 'function'
      @content = obj.toString()
    else if typeof obj == 'string'
      @content = obj
    else
      @content = JSON.stringify(obj, @stringify, "\t")

  stringify: (key, value) ->
    return util.inspect(value) if typeof value == 'function'
    value

  highlight: ->
    if chalk.supportsColor
      done = data = false
      pygmentize
        lang: @type
        format: "terminal"
      , @content, (err, res) =>
        done = true
        data = res.toString()
      deasync.runLoopOnce() until done
    else
      data = @content
    data

  code_snippet: (start, end, line_number, line_pointer = ' => ') ->
    lines = @highlight().split('\n')
    for line,key in lines
      if key+1 == line_number
        pointer = line_pointer
      else
        pointer = @_spaces(line_pointer.length)
      lines[key] = "#{pointer}#{@_space(key+1)}#{chalk.cyan(key+1)}: #{line}"
    lines.slice(start - 1, end).join('\n')

  # Assumes the biggest line number is 9999
  _space: (line) ->
    @_spaces(4 - String(line).length)

  _spaces: (length, char = ' ') ->
    new Array(length + 1).join(char)

module.exports = SyncHighlight
