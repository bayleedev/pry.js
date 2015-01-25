expect = require('chai').expect
sinon = require('sinon')
Help = require('../../src/pry/commands/help')

describe 'Help', ->

  subject = null
  spy = sinon.spy()

  before (complete) ->
    subject = new Help
      scope: (p) -> p
    complete()

  describe '#typeahead', ->

    describe 'given I type nothing', ->

      it 'stops on the first index', ->
        expect(subject.typeahead()).to.deep.equal ['help']

    describe 'given I type "help"', ->

      it 'it gives me all the help commands', ->
        expect(subject.typeahead('help')).to.deep.equal ['help help']
