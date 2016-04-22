fs = require('fs')
SyncHighlight = require('./sync_highlight')

class File

  constructor: (@name, @line) ->
    @line = parseInt(@line)

  type: ->
    if @name.match /coffee$/
      'coffee'
    else
      'js'

  by_lines: (start, end = start) ->
    @content().split('\n').slice(start - 1, end).join('\n')

  length: ->
    @content().split('\n').length || 0

  content: ->
    @_content ||= fs.readFileSync(@name).toString()

  formatted_content_by_line: (start, end = start, line = @line) ->
    start = (if start <= 0 then 1 else start)
    new SyncHighlight(@content(), @type()).code_snippet(start, end, line)

module.exports = File
