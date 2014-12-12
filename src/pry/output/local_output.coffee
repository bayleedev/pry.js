class LocalOutput

  send: ->
    console.log.apply(console.log, arguments)

module.exports = new LocalOutput
