const express = require('express')
const app = express()
const port = process.env.PORT

app.get('/', (req, res) => res.json({name: process.env.NAME}))

app.listen(port, () => console.log(`${process.env.NAME} listening on port: ${port}`))
