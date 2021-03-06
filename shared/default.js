// Generated by CoffeeScript 1.9.2
var component, dom, index, inject, ql, ref, svg,
  slice = [].slice;

ref = require('odojs'), component = ref.component, dom = ref.dom, svg = ref.svg;

inject = require('injectinto');

ql = require('odoql');

ql = ql.use('json').use('localstorage').use('store').use('http').use('csv');

index = component({
  query: function(params) {
    return {
      users: ql.store('users'),
      long: ql('long').store().options({
        async: true
      }).query(),
      nulled: ql.literal(null)
    };
  },
  render: function(state, params) {
    var u;
    console.log(state);
    return dom('div', {
      attributes: {
        "class": 'wrapper'
      }
    }, [svg('svg', {
        attributes: {
          "class": 'logo'
        }
      }, [
        svg('use', {
          'xlink:href': "/dist/odojs-handbook-1.0.0.min.svg#redwire"
        })
      ])].concat(slice.call((function() {
        var i, len, ref1, ref2, results;
        ref2 = (ref1 = state.users) != null ? ref1 : [];
        results = [];
        for (i = 0, len = ref2.length; i < len; i++) {
          u = ref2[i];
          results.push(dom('div', u.name));
        }
        return results;
      })()), [dom('div', state.long)]));
  }
});

inject.bind('page:default', index);
