require('coffee-script/register');
passwordHash = require('password-hash');

var express = require('express'),
  config = require('./config/config'),
  glob = require('glob'),
  mongoose = require('mongoose');

var dbOpt = {};

if(config.dbAuth) {
  dbOpt = {
    user: config.dbAuth.user,
    pass: config.dbAuth.pass
  }
}

mongoose.connect(config.db, dbOpt);

var db = mongoose.connection;
db.on('error', function () {
  throw new Error('unable to connect to database at ' + config.db);
});

// coffeescript problem
var models = glob.sync(config.root + '/app/models/*.coffee');

models.forEach(function (model) {
  require(model);
});

var app = express();

// insert initial data
db.once('open', function() {
  var User = mongoose.model('User');

  User.count({}, function( err, count){
    if(count == 0) {

      var initialUserName = config.initialAdmin.name;
      var initialPassword = config.initialAdmin.pass;

      admin = new User({
        username  : initialUserName,
        hashed_pw : passwordHash.generate(initialPassword)
      });
      admin.save(function(err, user){
        if(err) {
        	console.error(err);
          process.exit();
        } else {
        	console.log("user " + user.username + " created")
        }
      });
    }
  });

  var Setting = mongoose.model('Setting');

  Setting.count({}, function( err, count){
    if(count == 0) {
      setting = new Setting();
      setting.save(function(err, setting){
        if(err) {
          console.error(err);
          process.exit();
        } else {
          console.log("setting created")
        }
      });
    }
  });
});

require('./config/express')(app, config);

app.listen(config.port, config.ip, function () {
console.log( "Listening on " + config.ip + ", server_port " + config.port )
});
