Command = require('../command')
Range = require('../range')

class Whereami extends Command

  name: 'whereami'
  definition: 'Shows you exactly where you are in the code.'
  help: '`whereami` - Shows you where you are.
\n`whereami 6` - Gives you 6 lines before instead of 5.
\n`whereami 6 8` - Gives you 6 lines before instead of 5, and 8 lines after.'
  args: new Range(0, 2)

  constructor: ->
    super
    @file = @find_file()

  execute: ([before, after], chain) ->
    before ||= 5
    after ||= 5
    start = @file.line - parseInt(before, 10)
    end = @file.line + parseInt(after, 10)
    @output.send(@file.formatted_content_by_line(start, end))
    chain.next()

module.exports = Whereami
