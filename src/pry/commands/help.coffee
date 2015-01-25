Command = require('../command')
Range = require('../range')
chalk = require('chalk')

class Help extends Command

  name: 'help'
  aliases: ['\\?']
  definition: 'Shows a list of commands. Type `help foo` for help on the `foo` command.'
  help: 'You just lost the game.'
  args: new Range(0, 1)

  typeahead: (input = '') ->
    if input.indexOf('help') is 0
      items = []
      for name,command of @commands()
        items.push "help #{command.name}" if command.name
      items
    else
      ['help']

  execute: ([name], chain) ->
    if name
      command = @command(name)
      @output.add(chalk.blue(command.name), '-', command.definition)
      @output.add(command.help)
      @output.sendAll()
    else
      for name, command of @commands()
        @output.add(chalk.blue(command.name), '-', command.definition) if command.name
      @output.sendAll()
    chain.next()

module.exports = Help
