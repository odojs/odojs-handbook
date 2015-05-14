{ component, dom, svg } = require 'odojs'
ql = require 'odoql'

module.exports = component
  query: (params) ->
    test: ql.concat 'Hel', 'lo'
  render: (state, params) ->
    dom 'div', { attributes: class: 'wrapper' }, [
      svg 'svg', { attributes: class: 'logo' }, [
        svg 'use', { 'xlink:href': "/dist/odojs-examples-1.0.0.min.svg#odojs" }
      ]
      dom 'div', state.test
    ]