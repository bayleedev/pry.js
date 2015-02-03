Command = require('../command')
Range = require('../range')

class Play extends Command

  name: 'play'
  definition: 'Play a specific line, or set of lines in the file you are in.'
  help: '`play 1 2` will play lines 1 and 2.\n`play 1` will just play line 1.'
  args: new Range(1, 2)

  constructor: ->
    super
    @file = @find_file()

  execute: ([start, end], chain) ->
    end ||= start
    @command('xecute').execute_code(@file.by_lines(start, end), @file.type())
    chain.next()

module.exports = Play
