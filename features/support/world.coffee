spawn = require('child_process').spawn
_ = require('underscore')
chalk = require('chalk')

WorldConstructor = (callback) ->

  class World

    process: null

    output: []

    runCommand: (command, callback) =>
      command = command.split(' ')
      @waitForOutput(callback)
      @process = spawn(
        command[0],
        command.slice(1),
        cwd: "#{__dirname}/../../"
      )
      @process.stdout.on 'data', (output) =>
        @output.push output.toString()

    type: (input, callback) =>
      @waitForOutput(callback)
      @process.stdin.write "#{input}\n"

    print_buffer: (buffer, callback) =>
      @waitForOutput(callback)
      @process.stdin.write buffer

    waitForOutput: (callback) =>
      @_waitForOutput(@output.length, new Date(), callback)

    # Subtract 2
    # 1 for index to count
    # 1 account for the new prompt it sends
    getOutput: (callback) =>
      output = _.compact(_.map(chalk.stripColor(@output.join('\n'))
        .replace(/\u001b\[(?:\d|NaN)(?:G|J)/g, '')
        .split('\n')
        .join('\n')
        .split(/(?:-{9}>|\.{10}|\[\d+\] pryjs>).*$/gm), (el) -> el.trim()))
      callback(output[output.length - 1].trim())

    _waitForOutput: (oldOutputLength, oldDate, callback) =>
      if new Date() - 4500 > oldDate
        callback.fail new Error('Timeout of 4.5 seconds exceeded')
      else if @output.length > oldOutputLength
        callback()
      else
        setTimeout(@_waitForOutput.bind(@, oldOutputLength, oldDate, callback), 500)

  callback(new World)

exports.World = WorldConstructor
