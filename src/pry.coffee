App = require('./pry/app')

class Pry

  constructor: ->
    @it = "(#{@_pry.toString()}).call(this)"

  _pry: ->
    _ = null
    pry.open ((input) ->
      _ = eval(input)
    ).bind(@)

  open: (scope) ->
    app = new App(scope)
    app.open()

module.exports = new Pry
