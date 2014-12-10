SyncHighlight = require('./sync_highlight')
Position = require('./Position')
SyncPrompt = require('./sync_prompt')
Compiler = require('./compiler')
fs = require('fs')

class Presenter

  last_error: {}

  constructor: (scope) ->
    @compiler = new Compiler(scope)
    @pos = new Position()
    @sync_prompt = new SyncPrompt({
      prompt: ->
        "[#{@cli.history().length}] pryjs> "
      delegate: @
    })

  # @public
  mode: ->
    @compiler.toggle_mode()
    true

  # @public
  version: ->
    content = fs.readFileSync("#{__dirname}/../package.json")
    console.log(JSON.parse(content)['version'])
    true

  # @public
  whereami: (before = 5, after = 5) ->
    @pos.show.apply(@pos, [before, after].map (i) -> parseInt(i, 10))
    true

  # @public
  stop: ->
    false

  # @public
  kill: ->
    process.kill()
    false

  # @public
  wtf: ->
    if @last_error.stack
      console.log(@last_error.stack)
    else
      console.log('No errors')
    true

  # @public
  method_missing: (input) ->
    try
      output = @compiler.execute(input)
      console.log("=> ", new SyncHighlight(output).highlight())
    catch err
      @last_error = err
      console.log("=> ", err, err.stack)
    true

  prompt: ->
    return true unless @sync_prompt.done
    @sync_prompt.open()

module.exports = Presenter
