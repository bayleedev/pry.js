class RemoteOutput

  output: []

  name: 'blaine'

  constructor: (@client) ->

  send: (data) ->
    console.log {data}
    @client.write(data)

  add: (args...) ->
    @output.push args.join(' ')

  sendAll: ->
    @send(@output.join('\n'))
    @output = []


module.exports = RemoteOutput
