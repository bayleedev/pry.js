myStepDefinitionsWrapper = ->
  @World = require("../support/world").World

  @Given /^I have open the "([^"]*)" example$/, (example, callback) ->
    @runCommand "node examples/#{example}.js", callback

  @When /^I type in "([^"]*)"$/, (command, callback) ->
    @type command, callback

  @When /^I type in ctrl\+v$/, (callback) ->
    @print_buffer new Buffer(String.fromCharCode(22)), callback

  @Then /^The output should match "([^"]*)"$/, (pattern, callback) ->
    @getOutput (result) ->
      if result.match(pattern)
        callback()
      else
        callback.fail new Error("Expected to find #{pattern} in #{result}.")

  @Then /^The output should not match "([^"]*)"$/, (pattern, callback) ->
    @getOutput (result) ->
      if result.match(pattern)
        callback.fail new Error("Expected not to find #{pattern} in #{result}.")
      else
        callback()

  @Then /^The output should be "([^"]*)"$/, (pattern, callback) ->
    @getOutput (result) ->
      if result == pattern
        callback()
      else
        callback.fail new Error("Expected to find #{pattern} in #{result}.")

  @Then /^The output should be "([0-9]*)" lines?$/, (lines, callback) ->
    @getOutput (result) ->
      real_lines = result.trim().split('\n').length
      if real_lines == parseInt(lines, 10)
        callback()
      else
        callback.fail new Error("Expected #{lines} lines. Got #{real_lines}")

module.exports = myStepDefinitionsWrapper
