express  = require 'express'
router = express.Router()

module.exports = (app) ->
  app.use '/login', router

router.get '/', (req, res, next) ->
	res.render 'auth',
	  title: 'login'