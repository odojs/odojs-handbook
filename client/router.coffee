{ component, dom } = require 'odojs'
inject = require 'injectinto'
hub = require 'odo-hub'
page = require 'page'

inject.bind 'page:default', require './default'

# Here is our router. This works on first request and any 'virtual' requests from then on. The server is normally configured to return the same index.html file for all urls that don't match physical files so a manual refresh also works. It's pretty cool.
page '/', (e) ->
  hub.emit 'navigate to the default page'
page (details) ->
  hub.emit 'navigation error, {pathname} not found', details

getpage = (params) ->
  page = params.page ? 'default'
  page = page.name if page instanceof Object
  inject.one "page:#{page}"

Router = component
  query: (params) ->
    getpage(params).query params
  render: (state, params) ->
    dom '#root', [
      getpage(params) state, params
    ]

inject.bind 'router', Router

module.exports = Router