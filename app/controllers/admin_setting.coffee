express  = require 'express'
router   = express.Router()
session  = require 'express-session'
mongoose = require 'mongoose'

Setting  = mongoose.model 'Setting'

util = require '../util/common'

module.exports = (app) ->
  app.use '/admin', router

router.use (req, res, next) ->
  # admin relative page need auth
  util.authenticatedOrNot(req, res, next)

# GET : post list page (Render view)
router.get '/setting', (req, res, next) ->

  Setting.find({}, util.dbCallbackHTML((docs) ->
    if docs?

      doc = docs[0]

      profilePhoto    = doc["profile_photo"]
      profileContents = doc["profile_contents"] 

      resObj = defaultResponse(req)
      resObj.blogTitle       = doc.title
      resObj.authorName      = doc["author_name"]
      resObj.postPerPage     = doc["post_per_page"]
      resObj.profilePhoto    = if profilePhoto? then profilePhoto else "" 
      resObj.profileContents = if profileContents? then profileContents else ""
      
      resObj.title        = "blog setting"
      resObj.submitUrl    = '/admin/setting/'

      res.render 'admin_setting', resObj
    else
      # TODO : make 400 page
      res.status(404).send('setting not exsist')
  ))


###############################################################################
###############################################################################

defaultResponse = (req) ->
  logoutUrl     : '/auth/logout'
  managePostUrl : '/admin/posts'
  blogSettingUrl: '/admin/setting'
  username      : req.user.username
