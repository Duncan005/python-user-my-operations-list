// src/routes/auth.js
const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('../db'); // Database connection

const router = express.Router();

// Registration Route
router.post('/register', async (req, res) => {
    const { username, password } = req.body;

    try {
        // Check if user already exists
        db.query('SELECT * FROM users WHERE username = ?', [username], async (err, results) => {
            if (err) return res.status(500).json({ message: 'Server error' });

            if (results.length > 0) {
                return res.status(400).json({ message: 'User already exists' });
            }

            // Hash the password
            const hashedPassword = await bcrypt.hash(password, 10);

            // Insert new user
            db.query('INSERT INTO users (username, password) VALUES (?, ?)', [username, hashedPassword], (err) => {
                if (err) return res.status(500).json({ message: 'Server error' });
                res.status(201).json({ message: 'User registered successfully' });
            });
        });
    } catch (error) {
        res.status(500).json({ message: 'Server error' });
    }
});

// Login Route
router.post('/login', (req, res) => {
    const { username, password } = req.body;

    db.query('SELECT * FROM users WHERE username = ?', [username], (err, results) => {
        if (err) return res.status(500).json({ message: 'Server error' });

        if (results.length === 0) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        const user = results[0];

        // Compare password
        bcrypt.compare(password, user.password, (err, isMatch) => {
            if (err) return res.status(500).json({ message: 'Server error' });

            if (!isMatch) {
                return res.status(400).json({ message: 'Invalid credentials' });
            }

            // Create JWT
            const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, { expiresIn: '1h' });

            res.status(200).json({ message: 'Login successful', token });
        });
    });
});

module.exports = router;
