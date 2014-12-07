prompt = require('sync-prompt').prompt
SyncHighlight = require('./sync_highlight')
Position = require('./Position')

class Presenter

  pos: null

  commands: []

  constructor: (@scope) ->
    @pos = new Position()

  whereami: (before = 5, after = 5) ->
    @pos.show.apply(@pos, [before, after].map (i) -> parseInt(i, 10))
    true

  stop: ->
    false

  prompt: ->
    @commands.push output = prompt("[#{@commands.length}] pryjs> ")
    ssv = output.split(' ')
    if @[ssv[0]]
      @prompt() if @[ssv[0]].apply(@, ssv.splice(1))
    else
      console.log("=> ", new SyncHighlight(@scope("_ = #{output};_")).highlight())
      @prompt()

module.exports = Presenter
