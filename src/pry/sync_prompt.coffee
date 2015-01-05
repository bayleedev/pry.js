prompt = require('cli-input')
deasync = require('deasync')

class SyncPrompt

  done: true

  constructor: ({@callback}) ->
    @cli = prompt
      infinite: false,
      format: 'pryjs> '
    @done = false
    @cli.on('value', @handle)

  open: ->
    @cli.run()
    deasync.runLoopOnce() until @done

  handle: (command) =>
    if @callback(command.join(' '))
      @open()
    else
      @close()

  close: ->
    @cli.readline.close()
    @done = true

module.exports = SyncPrompt
