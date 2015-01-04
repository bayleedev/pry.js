expect = require('chai').expect
chalk = require('chalk')
SyncHighlight = require('../src/pry/sync_highlight')

describe 'SyncHighlight', ->

  subject = null

  beforeEach (complete) ->
    subject = new SyncHighlight('foo.coffee', 'javascript')
    subject.content = 'The\nquick\nbrown\nfox\njumps\nover\nthe\nlazy\ndog'
    subject.highlight = ->
      subject.content
    complete()

  describe '#code_snippet', ->

    it 'contains a pointer on the correct line', ->
      expect(subject.code_snippet(1, 9, 3).split('\n')[2]).to.match new RegExp('=>')

    it 'gives me the correct lines', ->
      expect(subject.code_snippet(4, 5).split('\n')[0]).to.match /fox/
      expect(subject.code_snippet(4, 5).split('\n')[1]).to.match /jumps/
