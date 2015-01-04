expect = require('chai').expect
sinon = require('sinon')
App = require('../src/pry/app')

describe 'app', ->

  subject = null

  command = (ret_match, ret_execute) ->
    match: sinon.stub().returns(ret_match)
    execute: sinon.stub().returns(ret_execute)

  before (complete) ->
    subject = new App
    complete()

  describe '#find_command', ->

    describe 'given three commands', ->

      response = null

      before (complete) ->
        subject._commands = [
          command(false, false)
          command(true, true)
          command(true, false)
        ]
        response = subject.find_command('foo')
        complete()

      it 'returns true', ->
        expect(response).to.equal true

      it 'calls the second command', ->
        expect(subject.commands()[1].execute.calledOnce).to.equal true

      it 'doesnt call the first and third command', ->
        expect(subject.commands()[0].execute.calledOnce).to.equal false
        expect(subject.commands()[2].execute.calledOnce).to.equal false
