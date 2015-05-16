{ component, dom, svg } = require 'odojs'
inject = require 'injectinto'
ql = require 'odoql'

inject.bind 'page:default', component
  query: (params) ->
    test: ql.concat('Hel', ql.if(ql.gt(6, 5), 'lo World', 'lo'))
  render: (state, params) ->
    dom 'div', { attributes: class: 'wrapper' }, [
      svg 'svg', { attributes: class: 'logo' }, [
        svg 'use', { 'xlink:href': "/dist/odojs-examples-1.0.0.min.svg#odojs" }
      ]
      dom 'div', state.test
    ]