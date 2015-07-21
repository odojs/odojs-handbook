{ component, dom, svg } = require 'odojs'
inject = require 'injectinto'
ql = require 'odoql'
ql = ql
  .use 'json'
  .use 'localstorage'
  .use 'store'
  .use 'http'
  .use 'csv'

index = component
  query: (params) ->
    users: ql.store 'users'
    long: (ql 'long'
      .store()
      .options(async: yes)
      .query())
    nulled: ql.literal null
  render: (state, params) ->
    console.log state
    dom 'div', { attributes: class: 'wrapper' }, [
      svg 'svg', { attributes: class: 'logo' }, [
        svg 'use', { 'xlink:href': "/dist/odojs-handbook-1.0.0.min.svg#redwire" }
      ]
      (dom 'div', u.name for u in state.users ? [])...
      dom 'div', state.long
    ]

inject.bind 'page:default', index