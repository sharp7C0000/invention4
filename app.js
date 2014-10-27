require('coffee-script/register');
passwordHash = require('password-hash');

var express = require('express'),
  config = require('./config/config'),
  glob = require('glob'),
  mongoose = require('mongoose');

mongoose.connect(config.db);
var db = mongoose.connection;
db.on('error', function () {
  throw new Error('unable to connect to database at ' + config.db);
});

// coffeescript problem
var models = glob.sync(config.root + '/app/models/*.coffee');

models.forEach(function (model) {
  require(model);
});

// insert initial data
db.once('open', function() {
  var User = mongoose.model('User');
	admin = new User({
    username  : "admin",
    email     : "support@invention4.com",
    hashed_pw : passwordHash.generate('1111')
  });
  admin.save(function(err, user){
    if(err) {
    	console.error(err);
    } else {
    	console.log("user " + user.username + " created")
    }
  });
});

var app = express();

require('./config/express')(app, config);

app.listen(config.port);

