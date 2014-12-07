prompt = require('sync-prompt').prompt

pry = (scope) ->
  (pr = ->
    output = prompt('$ ')
    if output isnt 'stop'
      console.log("> #{scope(output)}")
      pr()
  )()

m = ->
  i = 32
  pry (p) -> eval p
  console.log 'ahh', i

m()
