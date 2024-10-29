// src/app.js
require('dotenv').config(); // Load environment variables from .env file

const express = require('express');
const db = require('./db'); // Database connection
const authRoutes = require('./routes/auth'); // Adjust the path as necessary

const app = express();
app.use(express.json()); // For parsing application/json

// Use the authentication routes
app.use('/api/auth', authRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});


