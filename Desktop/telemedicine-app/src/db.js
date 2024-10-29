// src/db.js
const mysql = require('mysql2');

const connection = mysql.createConnection({
    host: 'localhost',        // Change if necessary
    user: 'root',  // Your MySQL username
    password: '', // Your MySQL password
    database: 'telemedicine',  // Your database name
});

connection.connect((err) => {
    if (err) throw err;
    console.log('Connected to MySQL database');
});

module.exports = connection;
