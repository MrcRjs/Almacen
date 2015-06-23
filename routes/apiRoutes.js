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
          sql       : 'SELECT * FROM Existencias USE INDEX (fkPieza) WHERE PiezaT=?',
          timeout   : 200,
          values    : [tipo]
        };
    if(modelo){
      query.values.push(modelo); 
      query.sql += 'AND PiezaM=?';
    }
    connection.query(query, function(err, results) {
      if(err) {
        response.status(500).send('Sorry, we\'ve got an internal error.');
        console.log('Query Error: ' + err);
      }
      res.send(results)
    });
  });
});
