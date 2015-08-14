var express = require('express');
var app = exports.app = express();

var api = require("./api.js");
 
require('./api.js')(app);
 
app.listen(6066)
