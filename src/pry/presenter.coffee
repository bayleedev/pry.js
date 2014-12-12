SyncHighlight = require('./sync_highlight')
Position = require('./position')
SyncPrompt = require('./sync_prompt')
Compiler = require('./compiler')
Docs = require('./file_doc')
_ = require('underscore')
chalk = require('chalk')
chalk.enabled = true

class Presenter

  last_error: {}

  constructor: (@scope, @options = {}) ->
    @pos = new Position({output: @output()})

  user_prompt: ->
    @_user_prompt ||= new SyncPrompt({
      prompt: ->
        "[#{@cli.history().length}] pryjs> "
      delegate: @
    })

  output: ->
    require("./output/#{@options.classes?.output || 'local'}_output")

  compiler: ->
    @_compiler ||= new Compiler({@scope, output: @output()})

  ###
  # Display this help information.
  ###
  help: ->
    docs = new Docs(__filename).get_docs()
    _.each _.pairs(docs), ([name, docs]) ->
      @output().send "#{chalk.red(name)}: #{docs.join('\n')}"
    true

  ###
  # Play specific lines of code, as if the user entered them.
  # `play 10 12` Plays line 10-12
  # `play 10` Plays line 10
  ###
  play: (start, end = start) ->
    @method_missing(file.by_lines(start, end), @pos.file().type())
    true

  ###
  # Switch betwen JavaScipt and CoffeeScript input modes.
  ###
  mode: ->
    @compiler().toggle_mode()
    true

  ###
  # Show the current version number of pry you have installed.
  ###
  version: ->
    content = require('fs').readFileSync("#{__dirname}/../../package.json")
    @output().send(JSON.parse(content)['version'])
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
      @output().send(@last_error.stack)
    else
      @output().send('No errors')
    true

  method_missing: (input, language) ->
    try
      output = @compiler().execute(input, language)
      @output().send("=> ", new SyncHighlight(output or 'undefined').highlight())
    catch err
      @last_error = err
      @output().send("=> ", err, err.stack)
    true

  prompt: ->
    return true unless @user_prompt().done
    @user_prompt().open()

module.exports = Presenter
