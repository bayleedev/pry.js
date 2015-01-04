class Range

  start: 0
  end: 0

  constructor: (@start, @end) ->
    throw "Start must be smaller than end" if @start > @end

  includes: (i) ->
    @start <= i and i <= @end

  to_regex: ->
    if @end == Infinity
      "{#{@start},}"
    else
      "{#{@start},#{@end}}"

module.exports = Range
