SyncHighlight = require './sync_highlight'
Position = require './Position'
SyncPrompt = require './sync_prompt'
Compiler = require './compiler'
Docs = require './file_doc'
fs = require 'fs'
_ = require 'underscore'
chalk = require 'chalk'

class Presenter

  last_error: {}

  constructor: (scope) ->
    @compiler = new Compiler(scope)
    @pos = new Position()
    @sync_prompt = new SyncPrompt({
      prompt: ->
        "[#{@cli.history().length}] pryjs> "
      delegate: @
    })

  ###
  # Display this help information.
  ###
  help: ->
    docs = new Docs(__filename).get_docs()
    _.each _.pairs(docs), ([name, docs]) ->
      console.log "#{chalk.red(name)}: #{docs.join('\n')}"
    true

  ###
  # Switch betwen JavaScipt and CoffeeScript input modes.
  ###
  mode: ->
    @compiler.toggle_mode()
    true

  ###
  # Show the current version number of pry you have installed.
  ###
  version: ->
    content = fs.readFileSync("#{__dirname}/../package.json")
    console.log(JSON.parse(content)['version'])
    true

  ###
  # Show context of your current pry statement. Accepts two optional arguments.
  # `whereami 10 5`
  ###
  whereami: (before = 5, after = 5) ->
    @pos.show.apply(@pos, [before, after].map (i) -> parseInt(i, 10))
    true

  ###
  # Destory the current instance of pry.
  ###
  stop: ->
    false

  ###
  # Stop the program.
  ###
  kill: ->
    process.kill()
    false

  ###
  # Display the last catch exception, if any exists.
  ###
  wtf: ->
    if @last_error.stack
      console.log(@last_error.stack)
    else
      console.log('No errors')
    true

  method_missing: (input) ->
    try
      output = @compiler.execute(input)
      console.log("=> ", new SyncHighlight(output).highlight())
    catch err
      @last_error = err
      console.log("=> ", err, err.stack)
    true

  prompt: ->
    return true unless @sync_prompt.done
    @sync_prompt.open()

module.exports = Presenter
