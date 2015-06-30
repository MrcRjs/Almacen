module.exports = (function(app) {

   //API way (Either from browser or native-clients)

  /********************************/
  /* Main                         */
  /********************************/

  /********************************/
  /* Almacenes                    */
  /********************************/
  app.post('/api/:almacen/:estanteria?', function (req, res){
    var alm = req.params.almacen;
        //est = req.params.estanteria ? req.params.estanteria : NULL; 
        sql = 'SELECT * FROM `Almacen`';
    connection.query(sql, function(err, results) {
      if(err) {
      	console.log('Query Error: ' + err);
      }

    });
  });

  /********************************/
  /* Piezas                       */
  /********************************/

  app.get('/api/pieza/:tipo/:modelo?', function (req, res){
    var tipo   = req.params.tipo
        modelo = req.params.modelo
        query  = {
          sql       : 'SELECT CONCAT(Tipo,CAST(Modelo as CHAR)) AS Pieza,\
                      Descripción, \
                      Categoría, \
                      Precio, \
                      Existencias, \
                      Sucursal, \
                      Ciudad \
                      FROM VPiezas \
                      WHERE Tipo=?',
          timeout   : 200,
          values    : [tipo]
        };
    if(modelo){
      query.values.push(modelo); 
      query.sql += 'AND Modelo=?';
    }
    connection.query(query, function(err, results) {
      if(err) {
        res.status(500).send(err);
        console.log('Query Error: ' + err);
      }
      res.status(200).send(results);
    });
  });

  app.get('/api/catalogo', function (req, res){
      
    var query = 
        "SELECT CONCAT(Tipo,CAST(Modelo as CHAR)) AS Pieza,\
        Descripción, \
        Categoría, \
        Precio, \
        Existencias, \
        Sucursal, \
        Ciudad \
        FROM VPiezas;";

    connection.query({sql:query,timeout : 200}, function(err, results) {
      if(err) {
        res.status(500).send(err);
        console.log('Query Error: ' + err);
      }
      res.status(200).send(results);
    });
  });


});
