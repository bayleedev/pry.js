var deasync = require('deasync');
var cp = require('child_process');
var pygmentize = require('pygmentize-bundled')
fs = require('fs')
// output result of ls -la
try{
  var done = false;
  var data;
  content = fs.readFileSync('./index.coffee').toString();
  pygmentize({
    lang: 'coffeescript',
    format: 'terminal'
  }, content, function(err, res) {
    done = true;
    console.log(res.toString());
  });
  while(!done) {
    require('deasync').runLoopOnce();
  }
}
catch(err){
  console.log(err);
}
// done is printed last, as supposed, with cp.exec wrapped in deasync; first without.
console.log('done');
