var express = require('express');
var app = express();

//DB Connection config
require('./config/db.js')

app.get('/', function(req, res){
  res.send('hello world');
});

app.listen(8080);