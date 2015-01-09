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

        it 'stops on the first index', ->
          expect(spy.calledWith(-2, 8)).to.equal true

      describe 'given I call it with a long tail', ->

        before (complete) ->
          subject.execute([1, 100], next: sinon.spy())
          complete()

        it 'bleeds past the last index', ->
          expect(spy.calledWith(2, 103)).to.equal true
