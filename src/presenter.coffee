SyncHighlight = require('./sync_highlight')
Position = require('./Position')
SyncPrompt = require('./sync_prompt')

class Presenter

  pos: null

  sync_prompt: null

  constructor: (@scope) ->
    @pos = new Position()
    @sync_prompt = new SyncPrompt({
      prompt: ->
        "[#{@cli.history().length}] pryjs> "
      delegate: @
    })

  # @public
  whereami: (before = 5, after = 5) ->
    @pos.show.apply(@pos, [before, after].map (i) -> parseInt(i, 10))
    true

  # @public
  stop: ->
    false

  # @public
  method_missing: (input) ->
    console.log("=> ", new SyncHighlight(@scope("_ = #{input};_")).highlight())
    true

  prompt: ->
    return true unless @sync_prompt.done
    @sync_prompt.open()

module.exports = Presenter
