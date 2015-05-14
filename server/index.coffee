path = require 'path'

express = require 'express'
app = express()
compression = require 'compression'
app.use compression()
bodyParser = require 'body-parser'
app.use bodyParser.urlencoded extended: yes
app.use bodyParser.json()
oneDay = 1000 * 60 * 60 * 24
app.use express.static path.join(__dirname, '..', 'client', 'dist'), maxAge: oneDay

# app.get '/query', (req, res) ->
#   query = JSON.parse req.query.q
#   ql.exec query, stores, (err, results) ->
#     if err?
#       res.status 400
#       res.json err
#       return
#     res.json results

oneshot = require 'odo-relay/oneshot'

{ component, widget } = require 'odojs'
odoql = require 'odoql/odojs'
component.use odoql
widget.use odoql

exe = require 'odoql-exe'
exe = exe()

# TODO router not direct to component
appdefault = require '../client/default'

app.get '/*', (req, res) ->
  # TODO params from url
  params = {}
  oneshot exe, appdefault, params, (err, result) ->
    # TODO templating engine
    res.send """
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset=\"utf-8\">
          <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge, chrome=1\" />
          <meta name=\"viewport\" content=\"width=700\">
          <title>Odo.js Examples</title>
          <link rel=\"stylesheet\" href=\"/odojs-examples-1.0.0.min.css\" />
        </head>
        <body>
          <div class=\"loading wrapper\">
            <svg class=\"logo\">
              <use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"/odojs-examples-1.0.0.min.svg#odojs\"></use>
            </svg>
            <div class=\"timeout\" style=\"display: none;\">
              <h1>Loading too slow, something is wrong</h1>
            </div>
          </div>
          <script src=\"/loading.js\"></script>
          <script>
            window.__queries = #{JSON.stringify result.queries};
            window.__state = #{JSON.stringify result.state};
          </script>
          <script src=\"/odojs-examples-1.0.0.min.js\"></script>
        </body>
      </html>
    """

port = 8085
app.listen port

console.log "Odo.js examples are listening on port #{port}..."