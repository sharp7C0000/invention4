### temporay response message structure
  
  status: "ok"
  data  : [
    {sid:1, title: "post1"}
    {sid:2, title: "post2"}
    {sid:3, title: "post3"}
  ]
  error : null

  ----------------

  status : "ok"
  data   : null
  error  : null

  ----------------

  status: "bad_request"
  data  : null
  error: {
    type    : "formValidationFail"
    # contents type could be any type
    contents: [{
      field: "username"
      text : "no user finded"
    }]
  }

###

express  = require 'express'
router = express.Router()
passport = require 'passport'

module.exports = (app) ->
  app.use '/auth', router

# GET : login page (Render view)
router.get '/login', (req, res, next) ->
  if req.isAuthenticated()
    res.redirect "/admin"
  else
    res.render 'auth',
    title    : 'login'
    submitUrl: '/auth/login'
    username : undefined

# POST : post login form (JSON)
router.post '/login', (req, res, next) ->
	passport.authenticate("local", (err, user, info) ->
    if err 
      return next(err)
    if not user
      return res.status(400).json(
        status: "BAD_REQUEST"
        data  : null
        error : {
          type    : "INVALID_FORM"
          contents: [info]
        }
      )
    req.logIn user, (err) ->
      if err
        return next(err)
      res.status(200).json(
        status: "OK"
        data  : null
        error : null
      )
  ) req, res, next

# DELETE : request logout action (JSON)
router.delete '/logout', (req, res, next) ->
  req.logout();
  res.status(200).json(
    status: "OK"
    data  : {
      # redirect after logout
      redirectUrl: "/admin"
    }
    error : null
  )



