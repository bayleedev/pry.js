expect = require('chai').expect
Validator = require('../src/pry/validator')

describe 'Validator', ->

  subject = null

  beforeEach (complete) ->
    subject = Validator
    complete()

  describe '#valid', ->

    it 'returns true for good js for double quotes', ->
      expect(subject.valid('hello("(")')).to.equal true

    it 'returns false for missing bracket for double quotes', ->
      expect(subject.valid('hello(")"')).to.equal false

    it 'returns true for good js for single quotes', ->
      expect(subject.valid("hello('(')")).to.equal true

    it 'returns false for missing bracket for single quotes', ->
      expect(subject.valid("hello(')'")).to.equal false

    it 'throws exception when mismatched', ->
      expect(subject.valid.bind(@, 'hello("hello[)"]')).to.throw 'Mismatched ] at column 15'
