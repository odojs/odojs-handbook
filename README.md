# Odo.js Handbook

This handbook is the best way to understand and use [Odo.js](https://github.com/odojs/odojs).

Odo.js is a large collection of tiny modules that can be used together to build web applications.

- [How does Odo.js fit in?](#how-does-odojs-fit-in)
- [Getting Started](#getting-started)
- [Code Overview](#code-overview)
- [Odo.js Documentation](#odo-js-documentation)

# How does Odo.js fit in?

Odo.js is inspired by [React](https://facebook.github.io/react/), [deku](https://github.com/segmentio/deku) and the [Relay](https://facebook.github.io/react/blog/2015/02/20/introducing-relay-and-graphql.html) [pattern](https://facebook.github.io/react/blog/2015/03/19/building-the-facebook-news-feed-with-relay.html).

Odo.js modules fit together to implement many desirable features of a modern javascript web framework:
- [Isomorphic](http://nerds.airbnb.com/isomorphic-javascript-future-web-apps/). When properly setup, Odo.js components can execute in Node.js and in the browser allowing dom elements to be pre-rendered on the server speeding up the initial load of websites.


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
