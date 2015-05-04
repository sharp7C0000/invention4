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
  # redirect manage post tab
	res.redirect "/admin/posts"

authenticatedOrNot = (req, res, next) ->
  if req.isAuthenticated()
    next()
  else
    res.redirect "/auth/login"
  return