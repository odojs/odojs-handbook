###
  Register things to do when various events fire
###
hub = require 'odo-hub'
scene = require './scene'
request = require 'superagent'

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

# Navigation
hub.every 'navigate to the default page', (p, cb) ->
  scene.update page: name: 'default'
  cb()

hub.every 'navigation error, {pathname} not found', (p, cb) ->
  scene.update page:
    name: 'error'
    message: "Sorry, the \"#{p.pathname}\" page was not found."
  cb()
