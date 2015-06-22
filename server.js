var express 	= require('express');
	port		= 8080
	app 		= express();
    fs          = require('fs');
	morgan 		= require('morgan');


//DB Connection config
require('./config/db.js');

//Middleware
app.use(morgan('dev'));
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

// Routes
app.get('/', function (req, res){
  res.render('index',{seccion : 'Inicio'});
});

app.get('/almacen', function (req, res){
  var sql = 'SELECT * FROM `Almacen`';
  connection.query(sql, function(err, results) {
    if(err) {
    	console.log('Query Error: ' + err);
    }
    console.log(results);
  	res.render('almacen',{seccion : 'Almacenes', results : results});
  });
});

app.get('/pieza', function (req, res){
  var sql = 'SELECT * FROM `Pieza`';
  connection.query(sql, function(err, results) {
    if(err) {
    	console.log('Query Error: ' + err);
    }
  console.log(results);
  res.render('pieza',{seccion : 'Piezas', results : results});
  });
});

app.get('/', function (req, res){
  res.render('index',{seccion : 'Existencias'});
});


app.listen(port, function () {
  console.log( "Almacen listening at " + port)
});
