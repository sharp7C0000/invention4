express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
moment   = require 'moment'
Post     = mongoose.model 'Post'
Setting  = mongoose.model 'Setting'
_        = require 'underscore'
marked   = require 'marked'

util   = require '../util/common'
config = require '../../config/config'

module.exports = (app) ->
  app.use '/', router

# GET : blog index page (Render view)
router.get '/', (req, res, next) ->
  pageAction(req, res, next, 1)

# GET : blog index page with pagenation(Render view)
router.get '/page/:pageNum', (req, res, next) ->
  # TODO : handling invalid pageNumber
  pageNum = parseInt(req.params.pageNum)
  pageAction(req, res, next, pageNum)

# GET : blog read post page (Render view)
router.get '/post/:id', (req, res, next) ->

  Setting.findOne {}, util.dbCallback((docs) =>
    setting = docs

    Post.findById(req.params.id, util.dbCallbackHTML((docs) ->
      if docs?
        resObj = {
          title       : docs.title
          publish_date: moment(docs["publish_date"]).format("LL")
          contents    : marked(docs.contents)
        }
        res.render 'blog_read_post', {
          title     : setting.title + " : " + docs.title
          blogName  : setting.title
          authorName: setting["author_name"]
          post      : resObj
        }
      else
        # TODO : make 400 page
        res.status(404).send('post not exsist')
    ))
  )

# GET : blog profile information (JSON)
router.get '/profile', (req, res, next) ->

  Setting.findOne {}, util.dbCallback((docs) =>
    setting = docs
    res.status(200).json(
      status: "OK"
      data  : {
        # profile datas
        authorName: setting["author_name"]
        contents  : marked(setting["profile_contents"])
        photoUrl  : setting["profile_photo"]
      }
      error : null
    )
  )

###############################################################################
###############################################################################

pageAction = (req, res, next, pageNum) ->
  
  totalDocs = 0

  Post.count {}, (err, result) ->
    if err?
      # TODO : handling error
    else
      totalDocs = result

  realPageNum    = pageNum - 1
  summaryCharNum = 200 # will setting at option menu

  getSummary  = (contents) ->
    compiled = marked(contents)
    compiled
    .replace(/<(?:.|\n)*?>/gm, '')
    .substring(0, summaryCharNum)

  Setting.findOne {}, util.dbCallback((docs) =>
    setting = docs
    perPage = setting["post_per_page"]

    Post.find {}, 'title publish_date contents', {
      sort : publish_date: -1
      skip : realPageNum * perPage
      limit: perPage
    }, util.dbCallbackHTML((docs) =>
      posts = _.map docs, (doc) -> {
        post_url    : "/post/" + doc._id
        title       : doc.title
        publish_date: moment(doc["publish_date"]).format("LL")
        summary     : getSummary(doc.contents)
      }

      nextPosts = (realPageNum + 1) * perPage
      prevPosts = (realPageNum - 1) * perPage

      nextPageUrlIndex = pageNum + 1
      prevPageUrlIndex = pageNum - 1

      nextUrl = if nextPageUrlIndex > 1 then "/page/" + nextPageUrlIndex else "/"
      prevUrl = if prevPageUrlIndex > 1 then "/page/" + prevPageUrlIndex else "/"

      nextUrl = if nextPosts > totalDocs then null else nextUrl
      prevUrl = if prevPosts < 0 then null else prevUrl

      res.render 'blog', {
        title     : setting.title
        blogName  : setting.title
        authorName: setting["author_name"]
        posts     : posts
        nextUrl   : nextUrl
        prevUrl   : prevUrl
      }
    )
  )
