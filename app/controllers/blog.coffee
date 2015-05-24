express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'

module.exports = (app) ->
  app.use '/', router

# GET : blog index page (Render view)
router.get '/', (req, res, next) ->
  res.render 'blog', title: 'My blog'