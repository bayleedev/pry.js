Presenter = require('./presenter')

module.exports = (scope) ->
  presenter = new Presenter(scope)
  presenter.whereami()
  presenter.prompt()
