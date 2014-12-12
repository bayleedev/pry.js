assert = require('assert')
expect = require('chai').expect
chalk = require('chalk')
File = require('../lib/pry/file')

describe 'File', ->

  subject = null

  beforeEach (complete) ->
    subject = new File('foo.coffee', 1)
    subject.content = ->
      'The\nquick\nbrown\nfox\njumps\nover\nthe\nlazy\ndog'
    complete()

  describe '#by_lines', ->

    it 'gives me the correct lines', ->
      expect(subject.by_lines(1,2)).to.equal 'The\nquick'

  describe '#add_line_numbers', ->

    it 'gives me the correct lines', ->
      expect(subject.add_line_numbers(subject.content())).to.equal [
        " =>  #{chalk.cyan(1)}: The"
        "     #{chalk.cyan(2)}: quick"
        "     #{chalk.cyan(3)}: brown"
        "     #{chalk.cyan(4)}: fox"
        "     #{chalk.cyan(5)}: jumps"
        "     #{chalk.cyan(6)}: over"
        "     #{chalk.cyan(7)}: the"
        "     #{chalk.cyan(8)}: lazy"
        "     #{chalk.cyan(9)}: dog"
      ].join('\n')

