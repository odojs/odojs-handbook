hub = require 'odo-hub'
window.hub = hub
{ component, widget } = require 'odojs'
odoql = require 'odoql/odojs'
component.use odoql
widget.use odoql

require './shared/'

router = require './shared/router'
root = document.querySelector '#root'
body = document.querySelector 'body'
loading = document.querySelector '#loading'
body.removeChild loading

exe = require 'odoql-exe'
exe = exe()

relay = require 'odo-relay'
scene = relay root, router, exe,
  queries: window.__queries
  state: window.__state

# load routes
route = require 'odo-route'
page = require 'page'
for route in route.routes()
  do (route) ->
    page route.pattern, (e) ->
      scene.update route.cb
        url: e.pathname
        params: e.params

# Log all events, with special logging for queries
hub.all (e, description, p, cb) ->
  if e is 'queries starting'
    console.log "? #{p.description}"
  else if e is 'queries completed'
    timings = Object.keys(p)
      .map (prop) ->
        "  #{prop} in #{p[prop]}ms"
      .join '\n'
    console.log "√ completed\n#{timings}"
  else
    console.log "+ #{description}"
  cb()

page = require 'page'
page()