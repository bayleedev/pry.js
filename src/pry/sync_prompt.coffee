prompt = require('cli-input')
deasync = require('deasync')

class SyncPrompt

  done: true

  constructor: ({@callback, @format}) ->
    @cli = prompt
      infinite: false
      format: @format || 'pryjs> '
    @cli.on 'value', (input) =>
      @callback input.join(' '), @chain()

  chain: ->
    {next: @open, stop: @close}

  open: =>
    @done = false
    @cli.run()
    deasync.runLoopOnce() until @done

  type: (input) ->
    @cli.emit 'value', input.split(' ')

  close: =>
    @cli.readline.close()
    @done = true

module.exports = SyncPrompt
