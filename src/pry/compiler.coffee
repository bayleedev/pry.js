coffee = require 'coffee-script'
pry = require '../pry'

class Compiler

  mode_id: 0

  modes: ['js', 'coffee']

  constructor: ({@scope, @output}) ->

  set_mode: (mode) ->
    @mode_id = @modes.indexOf(mode)

  toggle_mode: ->
    @mode_id = (@mode_id + 1) % @modes.length
    @output.send "=> ", "Switched mode to '#{@modes[@mode_id]}'."

  execute: (code, language = @modes[@mode_id]) ->
    @["execute_#{language}"](code)

  execute_coffee: (code) ->
    @execute_js(coffee.compile(code, bare: true))

  execute_js: (code) ->
    @scope(code)

module.exports = Compiler
