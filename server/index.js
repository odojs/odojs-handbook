// Generated by CoffeeScript 1.9.1
var app, appdefault, bodyParser, component, compression, exe, express, odoql, oneDay, oneshot, path, port, ref, stringify, widget;

path = require('path');

express = require('express');

app = express();

compression = require('compression');

app.use(compression());

bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({
  extended: true
}));

app.use(bodyParser.json());

oneDay = 1000 * 60 * 60 * 24;

app.use(express["static"](path.join(__dirname, '..', 'client'), {
  maxAge: oneDay
}));

oneshot = require('odo-relay/oneshot');

ref = require('odojs'), component = ref.component, widget = ref.widget;

odoql = require('odoql/odojs');

component.use(odoql);

widget.use(odoql);

stringify = require('odojs/stringify');

component.use(odoql);

exe = require('odoql-exe');

exe = exe();

appdefault = require('../client/default');

app.get('/*', function(req, res) {
  var params;
  params = {};
  return oneshot(exe, appdefault, params, function(err, result) {
    return res.send("<!DOCTYPE html>\n<html>\n  <head>\n    <meta charset=\"utf-8\">\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge, chrome=1\" />\n    <meta name=\"viewport\" content=\"width=700\">\n    <title>Odo.js Examples</title>\n    <link rel=\"stylesheet\" href=\"/dist/odojs-examples-1.0.0.min.css\" />\n  </head>\n  <body>\n    <div id=\"loading\" class=\"wrapper\">\n      <svg class=\"logo\">\n        <use xmlns:xlink=\"http://www.w3.org/1999/xlink\" xlink:href=\"/dist/odojs-examples-1.0.0.min.svg#odojs\"></use>\n      </svg>\n      <div class=\"timeout\" style=\"display: none;\">\n        <h1>Loading too slow, something is wrong</h1>\n      </div>\n    </div>\n    <script src=\"/dist/loading.js\"></script>\n    <script>\n      window.__queries = " + (JSON.stringify(result.queries)) + ";\n      window.__state = " + (JSON.stringify(result.state)) + ";\n    </script>\n    <div id=\"root\" style=\"display: none;\">" + result.html + "</div>\n    <script src=\"/dist/odojs-examples-1.0.0.min.js\"></script>\n  </body>\n</html>");
  });
});

port = 8085;

app.listen(port);

console.log("Odo.js examples are listening on port " + port + "...");
