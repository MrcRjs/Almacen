module.exports = (function(app) {

   //API way (Either from browser or native-clients)

  /********************************/
  /* Main                         */
  /********************************/

  app.get('/', function (req, res){
    res.render('index',{seccion : 'Inicio'});
  });

  /********************************/
  /* Almacenes                    */
  /********************************/
  app.get('/almacen', function (req, res){
    var sql = 'SELECT * FROM `Almacen`';
    connection.query(sql, function(err, results) {
      if(err) {
      	console.log('Query Error: ' + err);
      }
    	res.render('almacen',{seccion : 'Almacenes', results : results});
    });
  });

  /********************************/
  /* Piezas                       */
  /********************************/

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
});
