var app = require('./controller/app.js');
var os = require('os')

const ip = require('ip');
var IP = ip.address()
console.log(IP);
var server = app.listen(81,IP,function () {
    console.log(`Web App Hosted at http://`+os.hostname()+`:81/`);
  });

