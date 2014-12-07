pry = require './index'

testFun = ->
  i = 32

  example = ->
    console.log 'n called!'

  pry (p) -> eval p # pry call

  example()
  console.log('ahh', i)

testFun()
