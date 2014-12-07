prompt = require('sync-prompt').prompt
fs = require('fs')
pygmentize = require('pygmentize-bundled')
deasync = require("deasync")
chalk = require('chalk')

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
    done = data = false
    pygmentize
      lang: @type
      format: "terminal"
    , @content, (err, res) =>
      done = true
      data = res.toString()
    deasync.runLoopOnce() until done
    data

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

class Presenter

  pos: null

  commands: []

  constructor: (@scope) ->
    @pos = new Position()

  whereami: (before = 5, after = 5) ->
    @pos.show.apply(@pos, [before, after].map (i) -> parseInt(i, 10))
    true

  stop: ->
    false

  prompt: ->
    @commands.push output = prompt("[#{@commands.length}] pryjs> ")
    ssv = output.split(' ')
    if @[ssv[0]]
      @prompt() if @[ssv[0]].apply(@, ssv.splice(1))
    else
      console.log("=> ", new SyncHighlight(@scope("_ = #{output};_")).highlight())
      @prompt()

pry = (scope) ->
  presenter = new Presenter(scope)
  presenter.whereami()
  presenter.prompt()

module.exports = pry
