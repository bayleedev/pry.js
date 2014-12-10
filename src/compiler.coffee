coffee = require 'coffee-script'
pry = require './pry'

class Compiler

  mode_id: 0

  modes: ['js', 'coffee']

  constructor: (@scope) ->

  toggle_mode: ->
    @mode_id = (@mode_id + 1) % @modes.length
    console.log "=> Switched mode to '#{@modes[@mode_id]}'."

  execute: (code) ->
    @["execute_#{@modes[@mode_id]}"](code)

  execute_js: (code) ->
    @scope("_ = #{code};_")

  execute_coffee: (code) ->
    @scope("_ = #{coffee.compile(code, bare: true)};_")

module.exports = Compiler
