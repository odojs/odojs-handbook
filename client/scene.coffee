{ component, widget } = require 'odojs'
odoql = require 'odoql/odojs'
component.use odoql
widget.use odoql

require '../shared/'

router = require './router'
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

module.exports = scene