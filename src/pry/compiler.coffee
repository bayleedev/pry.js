coffee = require('coffee-script')
pry = require('../pry')

class Compiler

  mode_id: 0

  noVarPattern: /^\s*var .*$/gm

  modes: ['js', 'coffee']

  constructor: ({@scope}) ->

  mode: ->
    @modes[@mode_id]

  toggle_mode: ->
    @mode_id = (@mode_id + 1) % @modes.length

  execute: (code, language = @modes[@mode_id]) ->
    @["execute_#{language}"](code)

  execute_coffee: (code) ->
    @execute_js(coffee
      .compile(code, bare: true)
      .replace(@noVarPattern, ''))

  execute_js: (code) ->
    @scope(code)

module.exports = Compiler
