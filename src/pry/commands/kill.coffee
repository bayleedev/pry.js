Command = require('../command')

class Kill extends Command

  name: 'kill!'
  aliases: ['kill', 'exit!', 'quit!', 'stop!']
  definition: 'Exits from the entire script.'

  execute: (args, chain) ->
    chain.stop()
    process.kill()
    false

module.exports = Kill
