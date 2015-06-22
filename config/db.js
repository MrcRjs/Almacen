var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  //password : 'secret'
});

connection.connect(function(err) {
  if (err) {
    console.error('DB connect error: ' + err.stack);
    return;
  }

  console.log('Mysql conencted as ' + connection.threadId);
});