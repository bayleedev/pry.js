expect = require('chai').expect
Range = require('../src/pry/range')

describe 'Range', ->

  subject = null

  describe '#includes', ->

    describe 'given a range of 1 to 100', ->

      beforeEach (complete) ->
        subject = new Range(1, 100)
        complete()

      it 'includes 1', ->
        expect(subject.includes(1)).to.equal true

      it 'includes 100', ->
        expect(subject.includes(100)).to.equal true

      it 'includes 50', ->
        expect(subject.includes(50)).to.equal true

      it 'doesnt include 101', ->
        expect(subject.includes(101)).to.equal false

      it 'doesnt include 0', ->
        expect(subject.includes(0)).to.equal false

  describe '#to_regex', ->

    describe 'given a range of 1 to 100', ->

      beforeEach (complete) ->
        subject = new Range(1, 100)
        complete()

      it 'gives back the correct regex', ->
        expect(subject.to_regex()).to.equal '{1,100}'

    describe 'given a range of 1 to Infinity', ->

      beforeEach (complete) ->
        subject = new Range(1, Infinity)
        complete()

      it 'gives back the correct regex', ->
        expect(subject.to_regex()).to.equal '{1,}'
