{ component, widget } = require 'odojs'
odoql = require 'odoql/odojs'
component.use odoql
widget.use odoql

require './default'
require './errors'

router = require './router'
body = document.querySelector 'body'

exe = require 'odoql-exe'
exe = exe()

relay = require 'odo-relay'
scene = relay body, router, exe,
  queries: window.__queries
  state: window.__state

module.exports = scene