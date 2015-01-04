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

  user_prompt: ->
    @_user_prompt ||= new SyncPrompt({
      callback: @find_command
    })

  find_command: (input) =>
    for command in @commands()
      if match = command.match(input)
        return command.execute.apply(command, String(match[1]).trim().split(' '))
    false

  prompt: ->
    @user_prompt().open()

module.exports = App
