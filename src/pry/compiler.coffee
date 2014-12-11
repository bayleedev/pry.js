coffee = require 'coffee-script'

class Compiler

  mode_id: 0

  modes: ['js', 'coffee']

  constructor: (@scope) ->

  set_mode: (mode) ->
    @mode_id = @modes.indexOf(mode)

  toggle_mode: ->
    @mode_id = (@mode_id + 1) % @modes.length
    console.log "=> ", "Switched mode to '#{@modes[@mode_id]}'."

  execute: (code) ->
    @["execute_#{@modes[@mode_id]}"](code)

  execute_coffee: (code) ->
    @execute_js(coffee.compile(code, bare: true))

  execute_js: (code) ->
    @scope(code)

module.exports = Compiler
