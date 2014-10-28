express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/admin', router

router.get '/', (req, res, next) ->
	res.render 'admin',
      title: 'admin page'

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