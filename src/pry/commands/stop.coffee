Command = require('../command')

class Stop extends Command

  name: 'stop'
  aliases: ['exit', 'quit']
  definition: 'Ends the current prompt and continues running the rest of the code.'

  execute: ->
    false

module.exports = Stop
