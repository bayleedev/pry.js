SyncPrompt = require('./sync_prompt')
Output = require('./output/remote_output')
commands = require('./commands')
deasync = require('deasync')
net = require('net')

class App

  _commands: []

  constructor: (@scope) ->
    done = false
    @server = net.createServer (@socket) =>
      @socket.on "end", =>
        console.log "server disconnected"
        @server.close()
        done = true
      @socket.on 'data', (line) =>
        foo = (p) -> p
        line = JSON.parse(line.toString().split('\0')[0])
        @find_command(line.input, {next: foo, stop: foo}) if line.input
      @socket.pipe @socket
      @output = new Output(@socket)
      done = true
    @server.listen 8124, ->
      console.log "server bound"
    deasync.runLoopOnce() until @done

  commands: ->
    if @_commands.length is 0
      @_commands.push new command({@output, @scope}) for i,command of commands
    @_commands

  typeahead: (input = '') =>
    items = []
    for command in @commands()
      items = items.concat(command.typeahead(input))
    if input
      items = items.filter (item) ->
        item.indexOf(input) is 0
    [items, input]

  find_command: (input, chain) =>
    console.log {input}
    for command in @commands()
      console.log command.constructor.name
      if match = command.match(input.trim())
        args = String(match[1]).trim().split(' ')
        console.log {args}
        return command.execute.call command, args, chain
    false

  open: ->
    @prompt.type('whereami')
    @prompt.open()

module.exports = App
