class TestOutput

  items: []

  reset: ->
    @items = []

  send: ->
    @items.push arguments
    arguments

module.exports = new TestOutput
