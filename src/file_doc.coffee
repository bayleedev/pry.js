coffee = require 'coffee-script'
_ = require 'underscore'
fs = require 'fs'

class FileDoc

  constructor: (@filename) ->

  get_docs: ->
    data = fs.readFileSync(@filename).toString()
    if @filename.match /coffee$/
      data = coffee.compile(data, bare: true)
    @_get_methods(data)

  # If it finds documentation it stores it in _temp
  # Once it finds a function definition it makes the function
  #   name the key and puts `_temp` onto the new key.
  _get_methods: (data) ->
    docs = _.reduce data.split("\n"), (memo, line) ->
      if line.trim().match /^\*/
        line = line.trim().match(/^\* ?(.*)$/)[1]
        memo._temp.push line if line.length > 1
      else if line.match /function/
        return memo if memo._temp.length is 0
        name = line.match(/([a-z]+)\W+function/)[1]
        memo[name] = memo._temp
        memo._temp = []
      memo
    , {_temp: []}
    delete docs._temp
    docs


module.exports = FileDoc
