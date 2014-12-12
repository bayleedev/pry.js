assert = require('assert')
expect = require('chai').expect
sinon = require('sinon')
Presenter = require('../lib/pry/presenter')

describe 'Presenter', ->

  subject = response = spy = null

  beforeEach (complete) ->
    subject = new Presenter(
      (p) -> eval(p),
      classes: {output: 'test'}
    )
    subject.output().reset()
    complete()

  describe '#version', ->

    beforeEach (complete) ->
      expect(subject.version()).to.equal true
      response = subject.output().items
      complete()

    it 'gives me a valid version format', ->
      expect(response[0][0]).to.match /\d+\.\d+\.\d+/

  describe '#wtf', ->

    describe 'with an error', ->

      beforeEach (complete) ->
        subject.last_error = new Error()
        expect(subject.wtf()).to.equal true
        response = subject.output().items
        complete()

      it 'gives me a valid version format', ->
        expect(response[0][0]).to.equal subject.last_error.stack

    describe 'without an error', ->

      beforeEach (complete) ->
        subject.last_error = {}
        expect(subject.wtf()).to.equal true
        response = subject.output().items
        complete()

      it 'gives me a valid version format', ->
        expect(response[0][0]).to.equal 'No errors'
