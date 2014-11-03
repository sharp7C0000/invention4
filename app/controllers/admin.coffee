express  = require 'express'
router = express.Router()
session        = require 'express-session'
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/admin', router
    
router.use (req, res, next) ->
  # admin relative page need auth
  authenticatedOrNot(req, res, next)

router.get '/', (req, res, next) ->
	res.render 'admin',
      title: 'admin page'

router.get '/admin2', (req, res, next) ->
  res.render 'admin',
      title: 'admin2 page'

authenticatedOrNot = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.redirect "/login"
  return

userExist = (req, res, next) ->
  Users.count
    username: req.body.username
  , (err, count) ->
    if count is 0
      next()
    else
      
      # req.session.error = "User Exist"
      res.redirect "/singup"
    return

  return