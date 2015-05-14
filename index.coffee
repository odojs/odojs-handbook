express = require 'express'
compression = require 'compression'
bodyParser = require 'body-parser'
path = require 'path'
ql = require 'odoql'
async = require 'odo-async'
fs = require 'fs'

app = express()

app.use compression()
app.use bodyParser.urlencoded extended: yes
app.use bodyParser.json()

oneDay = 1000 * 60 * 60 * 24
app.use express.static __dirname, maxAge: oneDay

# app.get '/query', (req, res) ->
#   query = JSON.parse req.query.q
#   ql.exec query, stores, (err, results) ->
#     if err?
#       res.status 400
#       res.json err
#       return
#     res.json results

app.get '/*', (req, res) ->
  res.sendFile path.join __dirname, 'index.html'

port = 8085
app.listen port

console.log "Odo.js examples are listening on port #{port}..."