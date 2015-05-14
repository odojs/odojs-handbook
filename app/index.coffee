hub = require 'odo-hub'
window.hub = hub
page = require 'page'
scene = require './scene'
require './intent'

# Connect to the url
page()

# Tell the loading screen that we successfully finished loading.
window.__loadinghandle.fin()