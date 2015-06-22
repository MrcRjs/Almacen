var express 	= require('express');
	port		= 8080
	app 		= express();
    fs          = require('fs');
	morgan 		= require('morgan');


//DB Connection config
require('./config/db.js')

//Middleware
app.use(morgan('dev'));
app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);

// Routes
app.get('/status', function (req, res){
  res.sendStatus(200);
});

app.get('/', function (req, res){
  res.status(200);
  res.render('index.html');
});



app.listen(port, function () {
  console.log( "Almacen listening at " + port)
});
