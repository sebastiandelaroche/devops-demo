
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Hi world from from kubernetes!');
});

module.exports = app;
