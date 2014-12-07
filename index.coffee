prompt = require('sync-prompt').prompt
fs = require('fs')
pygmentize = require('pygmentize-bundled')
deasync = require("deasync")
chalk = require('chalk')

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
    done = false
    data = null
    pygmentize
      lang: @type()
      format: "terminal"
    , @content(), (err, res) =>
      done = true
      data = @add_line_numbers(res.toString())
    deasync.runLoopOnce() until done
    data

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


class Position

  _stack: null

  constructor: ->
    @_stack = new Error().stack

  show: (before = 5, after = 5) ->
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
    @_stack.split("\n")[4].match(/\(([^:]+):(\d+)/)

class Presenter

  pos: null

  constructor: ->
    @pos = new Position()

  whereami: ->
    @pos.show()
    true

  stop: ->
    false

pry = (scope) ->
  presenter = new Presenter()
  count = 0
  presenter.whereami()
  (pr = ->
    output = prompt("[#{count}] pry> ")
    count++
    if presenter[output]
      pr() if presenter[output]()
    else
      console.log("=> #{scope(output)}")
      pr()
  )()


module.exports = pry
