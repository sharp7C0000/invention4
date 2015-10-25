express  = require 'express'

module.exports =
	# gen not found error
	errorNotFound: () ->
		err = new Error 'Not Found'
		err.status = 404
		err

	# gen internal server error
	errorInternalServer: () ->
		err = new Error 'Internal Server Error'
		err.status = 500
		err

	# get json db error
	errorJsonDB: () ->
		{
			status: "BAD_REQUEST"
			data: null
			error: {
				type    : "DATABASE_ERROR"
				# do not send error detail to client
				contents: null
			}
		}

	# get json bad request error
	errorJsonBadRequest: () ->
		{
			status: "BAD_REQUEST"
			data: null
			error: {
				type    : "SERVER_ERROR"
				# do not send error detail to client
				contents: null
			}
		}


	# check auth or not
	authenticatedOrNot: (req, res, next) ->
	  if req.isAuthenticated()
	    next()
	  else
	    res.redirect "/auth/login"
	  return

	# default database callback
	dbCallback: (callback) ->
		context = this
		(error, docs) ->
			if error?
				console.log "database error : " + error
				callback(null, context.errorJsonDB())

			else
				callback(docs, null)

	# default database callback (return HTML 400 error)
	dbCallbackHTML: (callback) ->
		context = this
		(error, docs) ->
			if error?
				console.log "database error : " + error
				callback(null, context.errorInternalServer())
			else
				callback(docs, null)
