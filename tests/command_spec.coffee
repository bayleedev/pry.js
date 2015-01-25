expect = require('chai').expect
Command = require('../src/pry/command')
Range = require('../src/pry/range')

describe 'Command', ->

  subject = null

  beforeEach (complete) ->
    subject = new Command
      scope: (p) -> p
      output:
        send: -> true
    complete()

  describe '#command', ->

    beforeEach (complete) ->
      subject.constructor.commands =
        one:
          constructor:
            name: 'Blaine'
        two:
          constructor:
            name: 'Sch'
      complete()

    it 'matches case insensitive strings', ->
      expect(subject.command('blaine').constructor.name).to.equal 'Blaine'

  describe '#typeahead', ->

    describe 'given a name and aliases', ->

      beforeEach (complete) ->
        subject.name = 'foobar'
        subject.aliases = ['fb', 'gh']
        complete()

      it 'matches case insensitive strings', ->
        expect(subject.typeahead()).to.deep.equal ['fb', 'gh', 'foobar']

  describe '#command_regex', ->

    describe 'given a name of foo and 1-3 arguments', ->

      beforeEach (complete) ->
        subject.name = 'foo'
        subject.args = new Range(0, 3)
        complete()

      it 'matches foo', ->
        expect('foo').to.match subject.command_regex()

      it 'matches foo bar', ->
        expect('foo bar').to.match subject.command_regex()

      it 'matches foo bar baz guz', ->
        expect('foo bar baz guz').to.match subject.command_regex()

      it 'doesnt matches foo bar baz guz gul', ->
        expect('foo bar baz guz gul').to.not.match subject.command_regex()

  describe '#find_file', ->

    describe 'given a valid backtrace', ->

      beforeEach (complete) ->
        subject.stack = 'ReferenceError: Position is not defined\n
  at new Presenter (~/sites/devup/apps/pry.js/src/pry/presenter.coffee:14:16)\n
  at Pry.open (~/sites/devup/apps/pry.js/src/pry.coffee:13:17)\n
  at eval (<anonymous>:2:18)\n
  at eval (<anonymous>:5:7)\n
  at fizzBuzz (~/sites/devup/apps/pry.js/examples/fizzbuzz.coffee:6:5)\n
  at Object.<anonymous> (~/sites/devup/apps/pry.js/examples/fizzbuzz.coffee:16:1)\n
  at Object.<anonymous> (~/sites/devup/apps/pry.js/examples/fizzbuzz.coffee:1:1)\n
  at Module._compile (module.js:456:26)\n
  at Object.exports.run (/usr/local/lib/node_modules/coffee-script/lib/coffee-script/coffee-script.js:119:23)\n
  at compileScript (/usr/local/lib/node_modules/coffee-script/lib/coffee-script/command.js:208:29)'
        complete()

      it 'find the fizzBugg file', ->
        expect(subject.find_file().name).to.eq '~/sites/devup/apps/pry.js/examples/fizzbuzz.coffee'

      it 'find the fizzBugg line', ->
        expect(subject.find_file().line).to.eq 6

    describe 'given a invalid backtrace', ->

      beforeEach (complete) ->
        subject.stack = 'ReferenceError: Position is not defined\n
  at new Presenter (~/sites/devup/apps/pry.js/src/pry/presenter.coffee:14:16)\n
  at eval (<anonymous>:2:18)\n
  at eval (<anonymous>:5:7)\n
  at fizzBuzz (~/sites/devup/apps/pry.js/examples/fizzbuzz.coffee:6:5)\n
  at Object.<anonymous> (~/sites/devup/apps/pry.js/examples/fizzbuzz.coffee:16:1)\n
  at Object.<anonymous> (~/sites/devup/apps/pry.js/examples/fizzbuzz.coffee:1:1)\n
  at Module._compile (module.js:456:26)\n
  at Object.exports.run (/usr/local/lib/node_modules/coffee-script/lib/coffee-script/coffee-script.js:119:23)\n
  at compileScript (/usr/local/lib/node_modules/coffee-script/lib/coffee-script/command.js:208:29)'
        complete()

      it 'find the default command file', ->
        expect(subject.find_file().name).to.match /command\.(coffee|js)$/

      it 'finds the first line', ->
        expect(subject.find_file().line).to.eq 1
