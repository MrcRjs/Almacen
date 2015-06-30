module.exports = (function(app) {
  //restful module
  var rest = require('restler');

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
  app.get('/pieza/:tipo/:modelo?', function (req,res) {
    var tipo    = req.params.tipo;
        modelo  = req.params.modelo;
        route = 'http://localhost:' + app.get('port') + '/api/pieza/' + tipo;
        if(modelo){ route += '/' + modelo };
        
        rest.get(route)
        .on('success', function (piezas) {
          var cols = Object.keys( piezas[0] );
          res.render('pieza',{seccion : 'Piezas', results : piezas, cols : cols});
        })
        .on('fail', function(err) {
          res.render('error', {seccion : 'Error', error : err});
        })
        .on('error', function() {
          res.render('error', {seccion : 'Error', error : 'Error interno del'});
        });
    });
  app.get('/catalogo', function (req,res) {
        route = 'http://localhost:' + app.get('port') + '/api/catalogo/';
        rest.get(route).on('complete', function (piezas) {
          var cols = Object.keys( piezas[0] );
          res.render('pieza',{seccion : 'Catálogo', results : piezas, cols : cols});
        });
    });

});
