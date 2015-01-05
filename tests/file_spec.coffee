expect = require('chai').expect
File = require('../src/pry/file')

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

  describe '#type', ->

    describe 'given a coffee file', ->

      beforeEach (complete) ->
        subject.name = 'file.coffee'
        complete()

      it 'returns coffee for a coffee file', ->
        expect(subject.type()).to.equal 'coffee'

    describe 'given a js file', ->

      beforeEach (complete) ->
        subject.name = 'file.js'
        complete()

      it 'returns js', ->
        expect(subject.type()).to.equal 'js'

    describe 'given a text file', ->

      beforeEach (complete) ->
        subject.name = 'file.txt'
        complete()

      it 'returns js', ->
        expect(subject.type()).to.equal 'js'
