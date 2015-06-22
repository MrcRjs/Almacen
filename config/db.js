var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'Username',
  password : 'password'
});

connection.connect(function(err) {
  if (err) {
    console.error('DB connect error: ' + err.stack);
    return;
  }

  console.log('Connected to mysql as ' + connection.threadId);
});