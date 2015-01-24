Command = require('../command')
Range = require('../range')
Compiler = require('../compiler')
Validator = require('../validator')
SyncPrompt = require('../sync_prompt')

class Xecute extends Command

  name: ''

  last_error: null

  args: new Range(1, Infinity)

  constructor: ->
    super
    @compiler = new Compiler({@scope})

  execute: (input, chain) ->
    return @switch_mode(chain) if input[0] == 'mode'
    @executeCode input.join(' ')
    chain.next()

  executeCode: (code, language = null) ->
    try
      @output.send @compiler.execute(@cleanse(code), language)
    catch err
      @last_error = err

  cleanse: (code) ->
    try
      return code if Validator.valid(code)
      @prompt = new SyncPrompt
        callback: (input, chain) ->
          code += '\n' + input
          if Validator.valid(code) then chain.stop() else chain.next()
        format: '... '
      @prompt.open()
      code
    catch err
      return '\n'

  switch_mode: (chain) ->
    @compiler.toggle_mode()
    @output.send "Switched mode to '#{@compiler.mode()}'."
    chain.next()

  # Should always fallback to this
  command_regex: ->
    /(.*)/

module.exports = Xecute
