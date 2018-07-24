
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hi world from kubernetes developed by Sebastian and Mateo!');
});

module.exports = app;
