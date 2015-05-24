express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
moment   = require 'moment'
Post     = mongoose.model 'Post'
_        = require 'underscore'

util = require '../util/common'

module.exports = (app) ->
  app.use '/', router

# GET : blog index page (Render view)
router.get '/', (req, res, next) ->
	
	Post.find {}, 'title publish_date contents', util.dbCallbackHTML((docs) =>
		posts = _.map docs, (doc) ->
			{
				title       : doc.title
				publish_date: doc["publish_date"]
				summary     : doc.contents.substring(0, 200)
			}

		res.render 'blog', {title: 'My blog', posts: posts}
	)
	