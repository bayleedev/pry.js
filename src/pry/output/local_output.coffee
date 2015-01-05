class LocalOutput

  output: []

  send: ->
    console.log.apply(console.log, arguments)

  add: (args...) ->
    @output.push args.join(' ')

  sendAll: ->
    @send(@output.join('\n'))
    @output = []


module.exports = LocalOutput
