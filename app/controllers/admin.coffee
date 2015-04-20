express  = require 'express'
router   = express.Router()
session  = require 'express-session'
mongoose = require 'mongoose'
moment   = require 'moment'
Post     = mongoose.model 'Post'

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

  formData = req.body

  newPost = new Post(
    title        : formData.title 
    contents     : formData.contents
    publish_date : moment().format("YYYY-MM-DD HH:mm:ss")
  )

  newPost.save((error, doc) ->
    if error?
      
      console.log "database error : " + error

      return res.status(400).json(
        status: "BAD_REQUEST"
        data  : null
        error : {
          type    : "DATABASE_ERROR"
          # do not send error detail to client
          contents: null
        }
      )
    else
      res.status(200).json(
        status: "OK"
        data  : {
          # redirect after save posting
          redirectUrl: "/admin"
        }
        error : null
      )
  )

authenticatedOrNot = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.redirect "/auth/login"
  return