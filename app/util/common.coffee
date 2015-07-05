express  = require 'express'

module.exports =
	# check auth or not
	authenticatedOrNot: (req, res, next) ->
	  if req.isAuthenticated()
	    next()
	  else
	    res.redirect "/auth/login"
	  return

	# default database callback
	dbCallback: (success) ->
		(error, docs) ->
			if error?

			  console.log "database error : " + error

			  return res.status(400).json(
			    status: "BAD_REQUEST"
			    data  : null
			    error : {
			      type    : "DATABASE_ERROR"
			      # do not send error detail to client
			      contents: null
			    }
			  )

			else
				success(docs)

	# default database callback (return HTML 400 error)
	dbCallbackHTML: (success) ->
		(error, docs) ->
			if error?

			  console.log "database error : " + error

			  # TODO : show default 400 error page
			  return res.status(400).send(error)

			else
				success(docs)
