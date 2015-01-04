expect = require('chai').expect
Compiler = require('../src/pry/compiler')

describe 'Compiler', ->

  subject = null

  beforeEach (complete) ->
    subject = new Compiler
      scope: (input) ->
        eval(input)
      output:
        send: ->
          arguments
    complete()

  describe '#toggle_mode', ->

    beforeEach (complete) ->
      expect(subject.mode_id).to.equal 0
      subject.toggle_mode()
      complete()

    it 'switches the mode to coffeescript', ->
      expect(subject.mode_id).to.equal 1

    it 'switches back to javascript', ->
      subject.toggle_mode()
      expect(subject.mode_id).to.equal 0

  describe '#execute', ->

    describe 'in javascript mode', ->

      it 'can add numbers together', ->
        expect(subject.execute('var i = 0;++i;')).to.equal 1

    describe 'in coffee mode', ->

      beforeEach (complete) ->
        subject.toggle_mode()
        expect(subject.mode_id).to.equal 1
        complete()

      it 'can add numbers together', ->
        expect(subject.execute('i = 0\n++i')).to.equal 1
