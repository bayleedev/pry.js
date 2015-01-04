Command = require('../command')

class Kill extends Command

  name: 'kill!'
  aliases: ['exit!', 'quit!', 'stop!']
  definition: 'Exits from the entire script.'

  execute: ->
    process.kill()
    false

module.exports = Kill
