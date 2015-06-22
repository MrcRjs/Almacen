mysql = require('mysql');
var options = {
  host     : 'localhost',
  user     : 'Username',
  password : 'password',
  database : 'Almacen'
}
connection = mysql.createConnection(options);

connection.connect(function(err) {
  if (err) {
    console.error('DB connect error: ' + err.stack);
    return;
  }

  console.log('Connected to mysql as ' + connection.threadId);
});
module.exports = connection;