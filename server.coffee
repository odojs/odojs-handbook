express = require 'express'
app = express()
compression = require 'compression'
app.use compression()
bodyParser = require 'body-parser'
app.use bodyParser.urlencoded extended: yes
app.use bodyParser.json()
oneDay = 1000 * 60 * 60 * 24
path = require 'path'
app.use '/dist', express.static path.join(__dirname, 'dist'), maxAge: oneDay

oneshot = require 'odo-relay/oneshot'

{ component, widget, hook } = require 'odojs'
odoql = require 'odoql/odojs'
component.use odoql
widget.use odoql
hook.use odoql
stringify = require 'odojs/stringify'
component.use odoql

exe = require 'odoql-exe'
exe = exe()

require './shared/'
router = require './shared/router'
route = require 'odo-route'

app.get '/favicon.ico', (req, res) ->
  res.status(404).end()

# TODO queries on the server

app.get '/*', (req, res) ->
  params = route req.url
  oneshot exe, router, params, (err, result) ->
    # TODO templating engine
    res.send """
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
          <meta name="viewport" content="width=700">
          <title>Odo.js Examples</title>
          <link rel="stylesheet" href="/dist/odojs-examples-1.0.0.min.css" />
        </head>
        <body>
          <div id="loading" class="wrapper" style="display: none;">
            <p>Loading too slow, something is wrong</p>
          </div>
          <script src="/dist/loading.js"></script>
          <script>
            window.__queries = #{JSON.stringify result.queries};
            window.__state = #{JSON.stringify result.state};
          </script>
          #{result.html}
          <script src="/dist/odojs-examples-1.0.0.min.js"></script>
        </body>
      </html>
    """

port = 8085
app.listen port

console.log "Odo.js examples are listening on port #{port}..."