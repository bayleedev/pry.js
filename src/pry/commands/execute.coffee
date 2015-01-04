Command = require('../command')
Range = require('../range')
Compiler = require('../compiler')

class Execute extends Command

  name: ''

  last_error: null

  args: new Range(1, Infinity)

  constructor: ->
    super
    @compiler = new Compiler({@scope})

  execute: (input...) ->
    return @switch_mode() if input[0] == 'mode'
    @executeCode input.join(' ')
    true

  executeCode: (code, language = null) ->
    try
      console.log @compiler.execute(code, language)
    catch err
      @last_error = err

  switch_mode: ->
    @compiler.toggle_mode()
    @output.send "Switched mode to '#{@compiler.mode()}'."
    true

  # Should always fallback to this
  command_regex: ->
    /(.*)/

module.exports = Execute
