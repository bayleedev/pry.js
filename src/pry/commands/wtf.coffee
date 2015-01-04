Command = require('../command')

class Wtf extends Command

  name: 'wtf'
  definition: 'Shows the last caught exception.'
  help: '`wtf` will show you the last caught exception.'

  execute: ->
    if @command('execute').last_error
      @output.send(@command('execute').last_error.stack)
    else
      @output.send('No errors')
    true

module.exports = Wtf
