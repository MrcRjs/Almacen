var express 	= require('express');
	app 		= express();
	morgan 		= require('morgan');


//DB Connection config
require('./config/db.js');

//Middleware
app.use(morgan('dev'));
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

// Routes
require('./routes/apiRoutes')(app);

var port = 8080;
app.listen(port, function () {
  console.log( "Almacen listening at " + port)
});
