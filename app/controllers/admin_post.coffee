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

# GET : post list page (Render view)
router.get '/posts', (req, res, next) ->

  resObj = defaultResponse(req)
  resObj.title       = "list of post"
  resObj.newPostUrl  = '/admin/post/'
  resObj.postListUrl = '/admin/posts/list'

  res.render 'admin_manage_post', resObj

# GET : post list datas (JSON)
router.get '/posts/list', (req, res, next) ->
  Post.find {}, 'title publish_date', (error, docs) ->
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
          # post datas
          posts: docs
        }
        error : null
      )

# GET : posting page (Render view)
router.get '/post/', (req, res, next) ->

  resObj = defaultResponse(req)
  resObj.title      = "new post"
  resObj.submitUrl  = '/admin/post/'

  res.render 'admin_new_post', resObj

# POST : make new post (JSON)
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


defaultResponse = (req) ->
  logoutUrl    : '/auth/logout'
  managePostUrl: '/admin/posts'
  username     : req.user.username

authenticatedOrNot = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.redirect "/auth/login"
  return