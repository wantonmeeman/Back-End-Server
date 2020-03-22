var app = require('./controller/app.js');

var port=3000//8081

//localhost 

var server = app.listen(81,'192.168.1.165' ,function () {
    console.log(`Web App Hosted at http://dongen:80`);
  });
// var server = app.listen(80,'192.168.1.165' ,function () {
//     console.log(`Web App Hosted at http://dongen:80`);
// });
//works with postman, if set proxy server to 192.168.1.165