express  = require 'express'
router   = express.Router()
session  = require 'express-session'
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/admin', router
    
router.use (req, res, next) ->
  # admin relative page need auth
  authenticatedOrNot(req, res, next)

# GET : admin page (Render view)
router.get '/', (req, res, next) ->
	res.render 'admin',
    title     : 'admin page'
    logoutUrl : '/auth/logout'
    managePostUrl: '/admin'
    newPostUrl: '/admin/post/'
    username  : req.user.username

# GET : posting page (Render view)
router.get '/post/', (req, res, next) ->
  res.render 'admin_new_post',
    title     : 'new post'
    logoutUrl : '/auth/logout'
    managePostUrl: '/admin'
    submitUrl: '/admin/post/'
    username  : req.user.username

# POST : post login form (JSON)
router.post '/post/', (req, res, next) ->
  console.log "ok", req
  

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