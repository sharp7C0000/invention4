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

  Setting.findOne({}, util.dbCallbackHTML((docs, error) ->
    if docs?

      resObj = defaultResponse(req)
      resObj.blogTitle       = docs.title
      resObj.authorName      = docs["author_name"]
      resObj.postPerPage     = docs["post_per_page"]
      resObj.profilePhoto    = docs["profile_photo"]
      resObj.profileContents = docs["profile_contents"]

      resObj.title        = "Blog setting"
      resObj.submitUrl    = '/admin/setting/'

      res.render 'admin_setting', resObj

    else if error?
      next error
    else
      next util.errorNotFound()
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
