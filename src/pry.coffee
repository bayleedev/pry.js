App = require('./pry/app')

class Pry

  constructor: ->
    @it = "(#{@_pry.toString()})()"

  _pry: ->
    pry.open (input) -> eval(input)

  open: (scope) ->
    app = new App(scope)
    app.open()

module.exports = new Pry
