Command = require('../command')

class Wtf extends Command

  name: 'wtf'
  definition: 'Shows the last caught exception.'
  help: '`wtf` will show you the last caught exception.'

  execute: (args, chain) ->
    if @command('xecute').last_error
      @output.send(@command('xecute').last_error.stack)
    else
      @output.send('No errors')
    chain.next()

module.exports = Wtf
