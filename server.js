var express 	= require('express');
	app 		= express();
    fs          = require('fs')
	morgan 		= require('morgan')


//DB Connection config
require('./config/db.js')

//Middleware
app.use(morgan('dev'))

// Routes
app.get('/status', function (req, res, next)
{
  res.sendStatus(200);
});

app.get('/', function (req, res, next)
{
  var data = fs.readFileSync(__dirname + '/views/index.html');
  res.status(200);
  res.header('Content-Type', 'text/html');
  res.end(data.toString());
});



app.listen(8080, function () {
  console.log( "Almacen listening 8080 ")
});
