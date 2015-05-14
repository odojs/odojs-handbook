// Generated by CoffeeScript 1.9.1
var Router, component, dom, getpage, hub, inject, page, ref;

ref = require('odojs'), component = ref.component, dom = ref.dom;

inject = require('injectinto');

hub = require('odo-hub');

page = require('page');

inject.bind('page:default', require('./default'));

page('/', function(e) {
  return hub.emit('navigate to the default page');
});

page(function(details) {
  return hub.emit('navigation error, {pathname} not found', details);
});

getpage = function(params) {
  var ref1;
  page = (ref1 = params.page) != null ? ref1 : 'default';
  if (page instanceof Object) {
    page = page.name;
  }
  return inject.one("page:" + page);
};

Router = component({
  query: function(params) {
    return getpage(params).query(params);
  },
  render: function(state, params) {
    return dom('#root', [getpage(params)(state, params)]);
  }
});

inject.bind('router', Router);

module.exports = Router;
