SyncPrompt = require('./sync_prompt')
Help = require('./commands/help')
Kill = require('./commands/kill')
Play = require('./commands/play')
Stop = require('./commands/stop')
Version = require('./commands/version')
Whereami = require('./commands/whereami')
Wtf = require('./commands/wtf')
Execute = require('./commands/execute')
Output = require('./output/local_output')

class App

  constructor: (@scope) ->
    @output = new Output()
    @prompt = new SyncPrompt({
      callback: @find_command
    })

  commands: ->
    @_commands ||= [
      new Help({@scope, @output})
      new Kill({@scope, @output})
      new Play({@scope, @output})
      new Stop({@scope, @output})
      new Version({@scope, @output})
      new Whereami({@scope, @output})
      new Wtf({@scope, @output})
      new Execute({@scope, @output})
    ]

  find_command: (input, chain) =>
    for command in @commands()
      if match = command.match(input)
        args = String(match[1]).trim().split(' ')
        return command.execute.call command, args, chain
    false

  open: ->
    @prompt.type('whereami')

module.exports = App
