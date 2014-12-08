SyncHighlight = require('./sync_highlight')
Position = require('./Position')
SyncPrompt = require('./sync_prompt')
fs = require('fs')

class Presenter

  pos: null

  sync_prompt: null

  last_error: {}

  constructor: (@scope) ->
    @pos = new Position()
    @sync_prompt = new SyncPrompt({
      prompt: ->
        "[#{@cli.history().length}] pryjs> "
      delegate: @
    })

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
      console.log("=> ", new SyncHighlight(@scope("_ = #{input};_")).highlight())
    catch err
      @last_error = err
      console.log("=> ", err, err.stack)
    true

  prompt: ->
    return true unless @sync_prompt.done
    @sync_prompt.open()

module.exports = Presenter
