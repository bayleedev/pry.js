pygmentize = require('pygmentize-bundled')
deasync = require("deasync")

class SyncHighlight

  content: null

  type: null

  constructor: (obj, @type = 'javascript') ->
    if typeof obj == 'function'
      @content = obj.toString()
    else if typeof obj == 'string'
      @content = obj
    else
      @content = JSON.stringify(obj, @stringify, "\t")

  stringify: (key, value) ->
    return util.inspect(value) if typeof value == 'function'
    value

  highlight: ->
    done = data = false
    pygmentize
      lang: @type
      format: "terminal"
    , @content, (err, res) =>
      done = true
      data = res.toString()
    deasync.runLoopOnce() until done
    data

module.exports = SyncHighlight
