###
Map url patterns to parameters
###

route = require 'odo-route'

route '/', -> page: name: 'default'

route '*', (p) ->
  status: 404
  page:
    name: 'error'
    message: "Sorry, the \"#{p.url}\" page was not found."

module.exports = route