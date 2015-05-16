{ component, dom } = require 'odojs'
inject = require 'injectinto'

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