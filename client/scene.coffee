{ component, widget } = require 'odojs'
odoql = require 'odoql/odojs'
component.use odoql
widget.use odoql

require './default'
require './errors'

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

module.exports = scene