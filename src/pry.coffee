Presenter = require './pry/presenter'

class Pry

  constructor: ->
    @it = "(#{@_pry.toString()})()"

  _pry: ->
    pry.open (input) -> eval(input)

  open: (scope) ->
    presenter = new Presenter(scope)
    presenter.whereami()
    presenter.prompt()

module.exports = new Pry
