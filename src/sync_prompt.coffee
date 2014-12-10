cli = require('cline')
deasync = require('deasync')

class SyncPrompt

  prompt: null   # function to determine next promp
                 # ran before each iteration
  delegate: null # object it delegates to by default
  done: true

  constructor: ({@prompt, @delegate}) ->

  open: ->
    @done = false
    @cli = cli()
    @cli.usage = ->
    @cli.interact(@prompt.call(@))
    @cli.on('history', @handle)
    deasync.runLoopOnce() until @done

  handle: (input) =>
    ssv = input.split(' ')
    if @delegate[ssv[0]]
      @close() unless @delegate[ssv[0]].apply(@delegate, ssv.splice(1))
    else
      @delegate.method_missing(input)
    @cli._prompt = @prompt.call(@)

  close: ->
    delete @cli._nextTick
    @cli.stream.close()
    @done = true

module.exports = SyncPrompt
