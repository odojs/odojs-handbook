{ component, widget } = require 'odojs'
odoql = require 'odoql/odojs'
relay = require 'odo-relay'

component.use odoql
widget.use odoql

require './default'
require './errors'

Router = require './router'
body = document.querySelector 'body'

exe = require 'odoql-exe'
exe = exe()
scene = relay body, Router, exe

module.exports = scene