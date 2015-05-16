route = require 'odo-route'

route '/', -> page: name: 'default'
route '*', (p) -> page:
  name: 'error'
  message: "Sorry, the \"#{p.url}\" page was not found."

module.exports = route