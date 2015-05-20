{ component, dom, svg } = require 'odojs'
inject = require 'injectinto'
ql = require 'odoql'
ql = ql
  .use 'json'
  .use 'localstorage'
  .use 'store'

xxx = component
  query: (params) ->
    test1: ql.concat('Hel', ql.if(ql.gt(6, 5), 'lo World', 'lo'))
    test2: ql.localstorage 'test'
    test3: ql.store 'users'
  render: (state, params) ->
    console.log state.test2
    console.log state.test3
    dom 'div', { attributes: class: 'wrapper' }, [
      svg 'svg', { attributes: class: 'logo' }, [
        svg 'use', { 'xlink:href': "/dist/odojs-handbook-1.0.0.min.svg#odojs" }
      ]
      dom 'div', state.test1
    ]

inject.bind 'page:default', xxx