# odo-exe uses an optional odo-hub for logging and statistics
hub = require 'odo-hub'

# Configure Odo.js with mixins
{ component, widget, hook } = require 'odojs'
odoql = require 'odoql/odojs'
component.use odoql
widget.use odoql
hook.use odoql
stringify = require 'odojs/stringify'
component.use stringify

# Setup client odoql execution providers
# TODO add providers here to give components more query options
# e.g. exe.use require 'odoql-csv'
exe = require 'odoql-exe'
exe = exe hub: hub

# Shared components register against injectinto
require './shared/'

# Configure a generic express server and host /dist at /dist
# These are the only files needed on the client
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

# Stop annoying requests
app.get '/favicon.ico', (req, res) ->
  res.status(404).end()

# TODO create a generic query endpoint for odoql

# TODO create post endpoints for data updates

# Setup odo relay oneshot against the root router component
# So we can build queries, state and dom elements on the server
router = require './shared/router'
route = require 'odo-route'
oneshot = require 'odo-relay/oneshot'
app.get '/*', (req, res) ->
  # Map the url to parameters
  params = route req.url
  # Detect any hardcoded statuses and output
  res.status params.status if params?.status?
  oneshot exe, router, params, (err, result) ->
    # TODO an error page
    return res.status(500).send err if err?
    # TODO Use a templating engine instead of a literal string
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