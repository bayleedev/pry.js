cli = require('cline');
deasync = require('deasync')

class SyncPrompt

  prompt: null # function to determine next promp
               # ran before each iteration

  delegate: null # object it delegates to by default

  constructor: ({@prompt, @delegate}) ->

  open: ->
    @done = false
    @cli = cli()
    @cli.interact(@prompt())
    @cli.on('history', @handle)
    deasync.runLoopOnce() until @done

  handle: (input) =>
    ssv = input.split(' ')
    if @delegate[ssv[0]]
      @close() unless @delegate[ssv[0]].apply(@, ssv.splice(1))
    else
      @delegate.method_missing(input)

  close: ->
    @done = true
    delete @cli._nextTick
    @cli.stream.close()

module.exports = SyncPrompt
