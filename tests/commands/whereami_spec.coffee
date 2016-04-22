expect = require('chai').expect
sinon = require('sinon')
Whereami = require('../../src/pry/commands/whereami')

describe 'Whereami', ->

  subject = null
  spy = sinon.spy()

  before (complete) ->
    subject = new Whereami
      scope: (p) -> p
      output:
        send: -> true
    subject.file =
      length: ->
        10
      formatted_content_by_line: spy
      content: ->
        'The\nquick\nbrown\nfox\njumps\nover\nthe\nlazy\ndog'
    complete()

  describe '#execute', ->

    describe 'given I am on line 3', ->

      before (complete) ->
        subject.file.line = 3
        complete()

      describe 'given I call it with the default arguments', ->

        before (complete) ->
          subject.execute([], next: sinon.spy())
          complete()

        it 'blindly puts lines numbers', ->
          expect(spy.calledWith(-2, 8)).to.equal true
