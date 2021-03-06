# Odo.js Handbook

This handbook is probably the best way to understand and use [Odo.js](https://github.com/odojs/odojs).

Odo.js is a large collection of tiny modules that can be used together to build web applications.

- [How does Odo.js fit in?](#how-does-odojs-fit-in)
- [Modules used in this example](#modules-used-in-this-example)
- [Getting Started](#getting-started)
- [Code Overview](#code-overview)
- [Odo.js Documentation](#odojs-documentation)

# How does Odo.js fit in?

Odo.js is inspired by [React](https://facebook.github.io/react/), [deku](https://github.com/segmentio/deku) and the [Relay](https://facebook.github.io/react/blog/2015/02/20/introducing-relay-and-graphql.html) [pattern](https://facebook.github.io/react/blog/2015/03/19/building-the-facebook-news-feed-with-relay.html).

Odo.js modules fit together to implement many desirable features of a modern javascript web framework:

- **[Isomorphic](http://nerds.airbnb.com/isomorphic-javascript-future-web-apps/)**. Odo.js components can execute in Node.js and in the browser allowing dom elements to be pre-rendered on the server speeding up the initial load of websites. The initial queries and query results (state) are also available to the browser.
- **Stateless Components**. Each component defines the information it needs and how to turn that information into dom elements.
- **Immutable State**. Parameters and state are passed into the components. Any changes to state and parameters are expected to be driven by events.
- **Custom Components**. Many existing frameworks require access to the dom and don’t work in a uni-directional data environment. Odo.js provides an extension point called [widgets](https://github.com/odojs/odojs/wiki/widget).
- **Custom Interactions**. Animations require access to the dom and control of when sub elements are added and removed from the dom. [Hooks](https://github.com/odojs/odojs/wiki/hook) provide this ability.
- **DOM Namespaces**. SVG and other elements require namespaces on elements and namespaces on attributes. These are all supported by the excellent [virtual-dom](https://github.com/Matt-Esch/virtual-dom) library that powers the virtual dom aspects of Odo.js.
- **Composition**. Components can include other components providing reuse and separation of concerns.
- **Routing**. The url is matched against patterns to generate parameters that are passed to components. Components can use this information to adjust their queries and output.
- **Querying**. [OdoQL](https://github.com/odojs/odoql) is an extensible collection of modules to define a JSON serializable query format. Queries can execute in the browser, on the server or be forwarded to another server.
- **Caching**. A running application’s queries are diffed and only queries that are new or changed are executed. Updates to data can use optimistic writes, presenting the data as updated while the request completes. Failure can rollback the data and take alternate actions, success can commit the optimistic write and does not require a re-query.
- **Batching**. All queries needed at the same time are batched together and sent to the server in one payload. Any further queries are dispatched and can cancel aspects of the initial batch while still preserving any additional data.
- **Custom Queries**. OdoQL is completely modular and extensible allowing any type of query to be represented.


What is also provided in this Handbook Example:

- **Gulp Build System**. In this example all client assets compile down to three files: javascript, css and svg symbols. This greatly reduces page load time. Source maps are provided for javascript and css!
- **CoffeeScript**. If you love [CoffeeScript](http://coffeescript.org/) you’ll like this example project. If not - all of Odo.js works with vanilla javascript as well.
- **Stylus**. If you like CoffeeScript you might like this css pre-processor. All the brackets, colons and semi-colons are no longer needed. [Stylus](https://learnboost.github.io/stylus/) also has most of the same features as [LESS](http://lesscss.org/) and [SASS](http://sass-lang.com/). 
- **SVG Symbols**. A gulp task pulls all svg files from the assets directory into a single svg file. Individual items can be included in svg diagrams through the `use` element with `xlink:href`. A single file that has multiple assets also reduces page load time.
- **Gulp Watch**. The default gulp task watches for changes and automatically recompiles the javascript, css, and svg dist files. A cache  It also runs a livereload server that can automatically refresh the browser page if used with the livereload plugin.


# Modules used in this example

- [browserify](http://browserify.org/). Allows Node.js style `require` statements in browser javascript. Also using related modules: [coffeeify](https://github.com/substack/coffeeify), [caching-coffeeify](https://github.com/thlorenz/caching-coffeeify) and [errorify](https://github.com/zertosh/errorify).
- [express](http://expressjs.com/) (and various express modules). Node.js web server. Odo.js works in other frameworks as well.
- [gulp](http://gulpjs.com/) (and various gulp modules). Node.js streaming build system.
- [injectinto](https://github.com/odojs/injectinto). Dependency injection for javascript.
- [odo-hub](https://github.com/odojs/odo-hub). Small message bus that doubles as a logger.
- [odo-relay](https://github.com/odojs/odo-relay). Pulls together OdoQL and Odo.js into the Relay pattern.
- [odo-route](https://github.com/odojs/odo-route). Simple route registration and mapping.
- [odojs](https://github.com/odojs/odojs). Uses [virtual-dom](https://github.com/Matt-Esch/virtual-dom) to provide methods to build components, widgets and hooks.
- [odoql](https://github.com/odojs/odoql). Allows OdoQL queries to be built through a chaining API.
- [odoql-exe](https://github.com/odojs/odoql-exe). Extensible execution strategies for OdoQL in javascript. Can run in the browser or in Node.js.
- [pagejs](https://visionmedia.github.io/page.js/). Micro router to control pushstate in the browser.
- [superagent](https://github.com/visionmedia/superagent). An http request API that works in the browser and in Node.js.
- [svg4everybody](https://github.com/jonathantneal/svg4everybody). Polyfill for old browsers to support svg symbols.


# Getting Started

Install dependencies
```sh
npm i
```

Start gulp watch
```sh
gulp
```

Start the webserver
```sh
nodemon --exec "node ./" -q -e "js"
```


# Code Overview

Server code is found in `server.coffee`.
Client code is found in `client.coffee`.
Isomorphic code is found in the `shared` directory.

The code structure provided is just an example. Your application can use a few Odo.js modules or all of them in a completely different configuration and setup.


# Odo.js Documentation

- [API](https://github.com/odojs/odojs/wiki/home)
- [Component](https://github.com/odojs/odojs/wiki/component)
- [Widget](https://github.com/odojs/odojs/wiki/widget)
- [Hook](https://github.com/odojs/odojs/wiki/hook)
- [DOM](https://github.com/odojs/odojs/wiki/dom)
- [SVG](https://github.com/odojs/odojs/wiki/svg)
- [Partial](https://github.com/odojs/odojs/wiki/partial)
- [Compose](https://github.com/odojs/odojs/wiki/compose)
- [Examples](https://github.com/odojs/odojs/wiki/examples)
