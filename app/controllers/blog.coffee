express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
moment   = require 'moment'
Post     = mongoose.model 'Post'
_        = require 'underscore'
marked   = require 'marked'

util = require '../util/common'

module.exports = (app) ->
  app.use '/', router

# GET : blog index page (Render view)
router.get '/', (req, res, next) ->

	Post.find {}, 'title publish_date contents', {sort: {publish_date: -1}},
		util.dbCallbackHTML((docs) =>
			posts = _.map docs, (doc) ->
				{
					post_url    : "/post/" + doc._id
					title       : doc.title
					publish_date: moment(doc["publish_date"]).format("LL")
					summary     : doc.contents.substring(0, 200)
				}

			res.render 'blog', {title: 'My blog', posts: posts}
		)

# GET : blog read post page (Render view)
router.get '/post/:id', (req, res, next) ->

  Post.findById(req.params.id, util.dbCallbackHTML((docs) ->
    if docs?
      resObj = {
        title       : docs.title
        publish_date: moment(docs["publish_date"]).format("LL")
        contents    : marked(docs.contents)
      }
      res.render 'blog_read_post', {title: 'My blog', post: resObj}
    else
    	# TODO : make 400 page
    	res.status(404).send('post not exsist')
  ))
