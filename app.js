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

var app = express();

// if development setting initial data
if(app.get('env') == 'development') {
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

    var Setting = mongoose.model('Setting');

    Setting.count({}, function( err, count){
      if(count == 0) {
        setting = new Setting();
        setting.save(function(err, setting){
          if(err) {
            console.error(err);
          } else {
            console.log("setting created")
          }
        });
      }
    });
  });
}

require('./config/express')(app, config);

app.listen(config.port);
