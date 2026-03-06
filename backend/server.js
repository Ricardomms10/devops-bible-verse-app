const express = require('express');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to parse JSON (optional for this simple app, but good practice)
app.use(express.json());

// Load verses from JSON file
const versesPath = path.join(__dirname, 'verses.json');
let verses = [];
try {
    const data = fs.readFileSync(versesPath, 'utf8');
    verses = JSON.parse(data);
} catch (err) {
    console.error("Error reading verses.json:", err);
    verses = ["No verses found. Please check verses.json."];
}

// Serve frontend static files
app.use(express.static(path.join(__dirname, '../frontend')));

// API Endpoints
app.get('/api/verse', (req, res) => {
    const randomIndex = Math.floor(Math.random() * verses.length);
    res.json({ verse: verses[randomIndex] });
});

app.get('/api/health', (req, res) => {
    res.json({ status: "ok" });
});

app.get('/api/version', (req, res) => {
    res.json({ version: "1.0.0" });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
