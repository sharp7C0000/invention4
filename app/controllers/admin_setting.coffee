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

# GET : setting page (Render view)
router.get '/setting', (req, res, next) ->

  Setting.find({}, util.dbCallbackHTML((docs) ->
    if docs?

      doc = docs[0]

      resObj = defaultResponse(req)
      resObj.blogTitle       = doc.title
      resObj.authorName      = doc["author_name"]
      resObj.postPerPage     = doc["post_per_page"]
      resObj.profilePhoto    = doc["profile_photo"]
      resObj.profileContents = doc["profile_contents"]

      resObj.title        = "blog setting"
      resObj.submitUrl    = '/admin/setting/'

      res.render 'admin_setting', resObj
    else
      # TODO : make 400 page
      res.status(404).send('setting not exsist')
  ))

# POST : save setting data (JSON)
router.post '/setting', (req, res, next) ->

  formData = req.body

  updateObj = {
    title           : formData.blogTitle
    author_name     : formData.authorName
    post_per_page   : formData.postPerPage
  }

  if formData.profilePhotoUrl?
    updateObj["profile_photo"] = formData.profilePhotoUrl
  if formData.profileContents?
    updateObj["profile_contents"] = formData.profileContents

  Setting.findOneAndUpdate({}, updateObj, util.dbCallback(() ->
      res.status(200).json(
        status: "OK"
        data  : null
        error : null
      )
    )
  )

###############################################################################
###############################################################################

defaultResponse = (req) ->
  logoutUrl     : '/auth/logout'
  managePostUrl : '/admin/posts'
  blogSettingUrl: '/admin/setting'
  username      : req.user.username
