var express = require('express');
var app = express();

var api = require("./api.js");
 
require('./api.js')(app);
 
app.listen(6066)