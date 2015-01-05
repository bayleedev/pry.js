Command = require('../command')

class Version extends Command

  name: 'version'
  definition: 'Shows the current version or pry.js you are using.'

  execute: ->
    content = require('fs').readFileSync("#{__dirname}/../../../package.json")
    @output.send(JSON.parse(content)['version'])
    true

module.exports = Version
