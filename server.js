var express 	 = require('express');
	app 		 = express();
	morgan 		 = require('morgan');
	errorHandler = require('errorhandler');


//DB Connection config
require('./config/db.js');

//Server conf
app.set('env', 'development')
if('production' == app.get('env')) {
  app.set('port', 80);
}
else{app.set('port', 8080);}


//Middleware
app.use(morgan('dev'));
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.engine('html', require('ejs').renderFile);

if ('development' == app.get('env')) {
  app.use(errorHandler());
}

// Routes
require('./routes/apiRoutes')(app);
require('./routes/wwwRoutes')(app);

app.listen(app.get('port'), function () {
  console.log( "Almacen listening at " + app.get('port'));
});
