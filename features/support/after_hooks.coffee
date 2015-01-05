module.exports = ->
  @After (callback) ->
    @process.kill('SIGHUP');
    callback()
