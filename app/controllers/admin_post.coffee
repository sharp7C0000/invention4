express  = require 'express'
router   = express.Router()
session  = require 'express-session'
mongoose = require 'mongoose'
moment   = require 'moment'
Post     = mongoose.model 'Post'

util = require '../util/common'

module.exports = (app) ->
  app.use '/admin', router

router.use (req, res, next) ->
  # admin relative page need auth
  util.authenticatedOrNot(req, res, next)

# GET : post list page (Render view)
router.get '/posts', (req, res, next) ->

  resObj = defaultResponse(req)
  resObj.title          = "List of post"
  resObj.newPostUrl     = '/admin/post/'
  resObj.postListUrl    = '/admin/posts/list'
  resObj.postDeleteUrl  = '/admin/post/'
  resObj.postsDeleteUrl = '/admin/posts/delete'

  res.render 'admin_manage_post', resObj

# GET : post list datas (JSON)
router.get '/posts/list', (req, res, next) ->
  Post.find {}, 'title publish_date', {sort: {publish_date: -1}}, util.dbCallback((docs) ->
    res.status(200).json(
      status: "OK"
      data  : {
        # post datas
        posts: docs
      }
      error : null
    )
  )

# GET : new posting page (Render view)
router.get '/post/', (req, res, next) ->

  resObj = defaultResponse(req)
  resObj.postId       = null
  resObj.postTitle    = ""
  resObj.postContents = ""
  resObj.title      = "new post"
  resObj.submitUrl  = '/admin/post/'

  res.render 'admin_new_post', resObj

# GET : edit posting page (Render view)
router.get '/post/:id', (req, res, next) ->

  Post.findById(req.params.id, util.dbCallbackHTML((docs, error) ->
    if docs?
      resObj = defaultResponse(req)
      resObj.postId       = req.params.id
      resObj.postTitle    = docs.title
      resObj.postContents = docs.contents
      resObj.title        = "edit post"
      resObj.submitUrl    = '/admin/post/' + req.params.id

      res.render 'admin_new_post', resObj

    else if error?
      next error
    else
      next util.errorNotFound()
  ))

# POST : make new post (JSON)
router.post '/post/', (req, res, next) ->

  formData = req.body

  newPost = new Post(
    title        : formData.title
    contents     : formData.contents
    publish_date : moment().format("YYYY-MM-DD HH:mm:ss")
  )

  newPost.save(util.dbCallback((docs) ->
    res.status(200).json(
      status: "OK"
      data  : {
        # redirect after save posting
        redirectUrl: "/admin"
      }
      error : null
    )
  ))

# POST : update exsist post (JSON)
router.post '/post/:id', (req, res, next) ->

  formData = req.body

  Post.findByIdAndUpdate(req.params.id, {
    title    : formData.title
    contents : formData.contents
  }, util.dbCallback(() ->
      res.status(200).json(
        status: "OK"
        data  : {
          # redirect after save posting
          redirectUrl: "/admin"
        }
        error : null
      )
    )
  )

# DELETE : delete one exsit post (JSON)
router.delete '/post/:id', (req, res, next) ->

  Post.findByIdAndRemove(req.params.id, util.dbCallback(() ->
      res.status(200).json(
        status: "OK"
        data  : null
        error : null
      )
    )
  )

# POST : delete many post (JSON)
router.post '/posts/delete', (req, res, next) ->

  formData = req.body

  # TODO : check form is valid

  Post.remove('_id': { $in: formData }, util.dbCallback((docs) ->
    res.status(200).json(
      status: "OK"
      data  : null
      error : null
    )
  ))

###############################################################################
###############################################################################

defaultResponse = (req) ->
  logoutUrl     : '/auth/logout'
  managePostUrl : '/admin/posts'
  blogSettingUrl: '/admin/setting'
  username      : req.user.username
