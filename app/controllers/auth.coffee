express  = require 'express'
router = express.Router()
passport = require 'passport'

module.exports = (app) ->
  app.use '/login', router

# GET : render login page
router.get '/', (req, res, next) ->
	res.render 'auth',
	  title: 'login'
	  submitUrl: '/login'

# POST : post login form
router.post '/', (req, res, next) ->
	passport.authenticate("local", (err, user, info) ->
    return next(err)  if err
    return res.status(400).json(info) if not user
    req.logIn user, (err) ->
      return next(err)  if err
      res.status(200).send("ok")
    return
  ) req, res, next