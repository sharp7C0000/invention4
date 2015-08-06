express  = require 'express'
router   = express.Router()
session  = require 'express-session'
mongoose = require 'mongoose'

passport = require 'passport'

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
  userID   = req.user._id

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

# POST : update user password (JSON)
router.post '/account/update/password', (req, res, next) ->
  formData = req.body
  userID   = req.user._id

  User.findById(userID, util.dbCallback((docs) ->

    if docs?

      # check old password is correct
      if passwordHash.verify(formData.oldPassword, docs.hashed_pw)

        User.findByIdAndUpdate(userID, {
          hashed_pw: passwordHash.generate(formData.newPassword)
        }, util.dbCallback(() ->
          res.status(200).json(
            status: "OK"
            data  : null
            error : null
          )
        ))

      else
        res.status(400).json(
          status: "BAD_REQUEST"
          data  : null
          error : {
            type    : "INVALID_FORM"
            contents: [
              field: "oldPassword"
              text : "incorrect old password"
            ]
          }
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
