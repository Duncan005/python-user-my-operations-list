const mysql = require('mysql2');

// Create a MySQL connection
const connection = mysql.createConnection({
  host: 'localhost',  // Use your MySQL host
  user: 'root',       // Use your MySQL username
  password: '',       // Use your MySQL password
  database: 'telemedicine' // Use your database name
});

// Connect to MySQL
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err.message);
  } else {
    console.log('Connected to MySQL Database.');
  }
});

module.exports = connection;
