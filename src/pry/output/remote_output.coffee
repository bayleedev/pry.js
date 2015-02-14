class RemoteOutput

  output: []

  constructor: (@client) ->

  send: (data) ->
    console.log {data}
    @client.write(JSON.stringify({output: [data]}) + "\0")

  add: (args...) ->
    @output.push args.join(' ')

  sendAll: ->
    @send(@output.join('\n'))
    @output = []


module.exports = RemoteOutput
