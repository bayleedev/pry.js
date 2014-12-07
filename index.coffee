prompt = require('sync-prompt').prompt

class Position

  stack: null

  constructor: (stack) ->
    @stack = new Error().stack

  show: ->
    console.log(@line(), @file())

  line: ->
    @stack_line()[2]

  file: ->
    @stack_line()[1]

  stack_line: ->
    @stack.split("\n")[3].match(/\(([^:]+):(\d+)/)


pry = (scope) ->
  (pr = ->
    output = prompt('$ ')
    if output isnt 'stop'
      console.log("> #{scope(output)}")
      pr()
  )()


module.exports = pry
