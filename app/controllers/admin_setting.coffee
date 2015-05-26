express  = require 'express'
router   = express.Router()
session  = require 'express-session'
mongoose = require 'mongoose'

util = require '../util/common'

module.exports = (app) ->
  app.use '/admin', router

router.use (req, res, next) ->
  # admin relative page need auth
  util.authenticatedOrNot(req, res, next)

# GET : post list page (Render view)
router.get '/setting', (req, res, next) ->

  resObj = defaultResponse(req)
  resObj.title = "blog setting"

  res.render 'admin_setting', resObj

###############################################################################
###############################################################################

defaultResponse = (req) ->
  logoutUrl     : '/auth/logout'
  managePostUrl : '/admin/posts'
  blogSettingUrl: '/admin/setting'
  username      : req.user.username
