{ component, dom, svg, widget } = require 'odojs'
inject = require 'injectinto'
ql = require 'odoql'
hub = require 'odo-hub'

inject.bind 'page:default', component
  render: (state, params) ->
    console.log state
    dom 'div', { attributes: class: 'wrapper' }, [
      svg 'svg', { attributes: class: 'logo' }, [
        svg 'use', { 'xlink:href': "/dist/odojs-examples-1.0.0.min.svg#odojs" }
      ]
      dom 'div', 'Hello'
    ]