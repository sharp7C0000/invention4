express = require 'express'
glob = require 'glob'

favicon = require 'serve-favicon'
logger = require 'morgan'
cookieParser = require 'cookie-parser'
bodyParser = require 'body-parser'
compress = require 'compression'
methodOverride = require 'method-override'
lessMiddleware = require 'less-middleware'
session        = require 'express-session'

passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
User = require('mongoose').model("User")

module.exports = (app, config) ->
  app.set 'views', config.root + '/app/views'
  app.set 'view engine', 'ejs'

  # app.use(favicon(config.root + '/public/img/favicon.ico'));
  app.use logger 'dev'
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(
    extended: true
  )
  app.use cookieParser()
  app.use compress()

  # compile less when development
  if app.get('env') == 'development'
    app.use lessMiddleware( '/less',
      dest: '/css',
      pathRoot: config.root + '/' + config.static
    )

  # grobal view template variable
  app.locals.mode = app.get('env')

  app.use express.static config.root + '/' + config.static
  app.use methodOverride()

  app.use session({
    secret: "cookie_secret"
    resave: true
    saveUninitialized: true
  })
  app.use passport.initialize()
  app.use passport.session()

  # setting passport
  localStreategy = new LocalStrategy((username, password, done) ->
    User.findOne { username: username }, (err, user) ->
      # DB error
      if err   then return done(err)
      # Cannot find user
      if !user then return done(null, false, {
        field: "username"
        text : "No user finded"
      })

      # Check password
      if passwordHash.verify(password, user.hashed_pw) is true
        done(null, user)
      else
        done(null, false, {
          field: "password"
          text : "Password not machting"
        })
  )
  passport.use(localStreategy)

  # Serialize, deserialize
  passport.serializeUser (user, done) -> done(null, user.id)
  passport.deserializeUser (id, done) -> User.findById id, (err, user) -> done(err, user)

  controllers = glob.sync config.root + '/app/controllers/**/*.coffee'
  controllers.forEach (controller) ->
    require(controller)(app);

  # catch 404 and forward to error handler
  app.use (req, res, next) ->
    err = new Error 'Not Found'
    err.status = 404
    next err

  # error handlers

  # development error handler
  # will print stacktrace
  if app.get('env') == 'development'
    app.use (err, req, res, next) ->
      res.status err.status || 500
      res.render 'error',
        message: err.message
        error: err
        title: 'error'

  # production error handler
  # no stacktraces leaked to user
  app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error',
      message: err.message
      error: {}
      title: 'error'
