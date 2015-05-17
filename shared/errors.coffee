{ component, dom, svg } = require 'odojs'
inject = require 'injectinto'

inject.bind 'page:error', component render: (state, params) ->
  titileattr =
    attributes:
      class: 'title'
    style:
      width: '100%'
  dom 'div', { attributes: class: 'wrapper error' }, [
    dom 'div', [
      svg 'svg', { attributes: class: 'logo' }, [
        svg 'use', { 'xlink:href': "/dist/odojs-handbook-1.0.0.min.svg#odojs" }
      ]
      dom 'div', [
        dom 'p', params.page.message
        dom 'p', params.page.details
      ]
    ]
  ]