express  = require 'express'
router   = express.Router()
session  = require 'express-session'
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/admin', router
    
router.use (req, res, next) ->
  # admin relative page need auth
  authenticatedOrNot(req, res, next)

router.get '/', (req, res, next) ->
	res.render 'admin',
    title     : 'admin page'
    logoutUrl : '/auth/logout'
    newPostUrl: '/admin/post/'
    username  : req.user.username

router.get '/post/', (req, res, next) ->
  res.render 'admin_new_post',
    title     : 'new post'
    logoutUrl : '/auth/logout'
    username  : req.user.username

router.get '/admin2', (req, res, next) ->
  res.render 'admin',
      title: 'admin2 page'

authenticatedOrNot = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.redirect "/auth/login"
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