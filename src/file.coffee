fs = require('fs')
chalk = require('chalk')
SyncHighlight = require ('./sync_highlight')

class File

  constructor: (@file, @line) ->

  type: ->
    if @file.match /coffee/
      'coffeescript'
    else
      'javascript'

  content: ->
    fs.readFileSync(@file).toString()

  formatted_content: ->
    @add_line_numbers(new SyncHighlight(@content(), @type()).highlight())

  add_line_numbers: (content) ->
    lines = content.split("\n")
    space = (longest, line_number) ->
      long = String(longest).length
      now = String(line_number).length
      new Array(long - now + 1).join(' ')
    space = space.bind(@, lines.length + 1)
    for line,key in lines
      pointer = "    "
      pointer = " => " if key+1 == @line
      lines[key] = "#{pointer}#{space(key+1)}#{chalk.cyan(key+1)}: #{line}"
    lines.join("\n")

module.exports = File
