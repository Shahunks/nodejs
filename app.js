const express = require('express')

const config = require('./config.json');

const app = express()
const port = 3000;

app.get('/', (req, res) => res.send(config))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))
