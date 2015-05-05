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