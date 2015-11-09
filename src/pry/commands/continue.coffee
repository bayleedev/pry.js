Command = require('../command')

class Continue extends Command

  name: 'continue'
  aliases: ['exit', 'quit', 'stop']
  definition: 'Ends the current prompt and continues running the rest of the code.'

  execute: (args, chain) ->
    chain.stop()

module.exports = Continue
