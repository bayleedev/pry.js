readline = require('readline')
EventEmitter = require('events').EventEmitter
deasync = require('deasync')
_ = require('underscore')

class MultilineState

  data: ''

  keypress: (input, chars) ->
    @data += chars
    if @data.match(/(\r|\n)\1$/)
      @data = ''
      input.state('single')
      input.send_data()
    else if chars.match(/(\r|\n)$/)
      input.prompt()

  prompt: (input, prompt) ->
    if @data == ''
      input.cli.setPrompt(prompt.replace(/[^>](?!$)/g, '-'))
    else
      input.cli.setPrompt(prompt.replace(/.(?!$)/g, '.'))
    input.cli.prompt()

class SinglelineState

  keypress: (input, chars) ->
    if chars is '\u0016'
      input.state('multi')
      input.prompt()
    else if chars.match(/(\r|\n)$/)
      input.send_data()

  prompt: (input, prompt) ->
    input.cli.setPrompt(prompt)
    input.cli.prompt()

class SyncPrompt extends EventEmitter

  lines: ''

  count: 0

  states:
    multi: new MultilineState
    single: new SinglelineState

  _state: 'single'

  done: false

  constructor: (@options = {}) ->
    @options = _.extend(_.pick(process, 'stdin', 'stdout'), @options)
    @cli = readline.createInterface
      input: @options.stdin
      output: @options.stdout
      completer: @options.typeahead
    @cli.on('line', @line)
    @options.stdin.on('data', @keypress)

  state: (state) =>
    @_state = state if state
    @states[@_state]

  line: (line) =>
    line = line.slice(1) if line.charCodeAt(0) is 22
    @lines += '\n' + line

  keypress: (chars) =>
    @state().keypress(@, chars.toString())

  send_data: =>
    @count++
    @emit('data', @lines.trim(), next: @prompt, stop: @close)
    @lines = ''

  prompt: =>
    @state().prompt(@, "[#{@count}] pryjs> ")

  open: ->
    @done = false
    @prompt()
    deasync.runLoopOnce() until @done

  # Manually trigger input
  type: (input) =>
    @lines = input
    @send_data()

  close: =>
    @done = true
    @options.stdin.removeListener('data', @keypress)
    @cli.close()

module.exports = SyncPrompt
