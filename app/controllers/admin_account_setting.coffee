express  = require 'express'
router   = express.Router()
session  = require 'express-session'
mongoose = require 'mongoose'

User  = mongoose.model 'User'

util = require '../util/common'

module.exports = (app) ->
  app.use '/admin', router

router.use (req, res, next) ->
  # admin relative page need auth
  util.authenticatedOrNot(req, res, next)

# POST : user information (JSON)
router.post '/account/info', (req, res, next) ->
  formData = req.body
  userID   = formData.userID

  User.findById(userID, util.dbCallback((docs) ->

    if docs?
      res.status(200).json(
        status: "OK"
        data  : {
          username: docs.username
          email   : docs.email
        }
        error : null
      )

    else
      res.status(400).json(
        status: "BAD_REQUEST"
        data  : null
        error : {
          type    : "USER_NOT_EXSIST"
          contents: null
        }
      )
  ))

###############################################################################
###############################################################################

defaultResponse = (req) ->
  logoutUrl     : '/auth/logout'
  managePostUrl : '/admin/posts'
  blogSettingUrl: '/admin/setting'
  username      : req.user.username
