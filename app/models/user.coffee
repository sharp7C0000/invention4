# User model

mongoose = require 'mongoose'
Schema   = mongoose.Schema

# -- User schema --
# username  : the name of user which using login
# email     : the email address of user
# hashed_pw : hashed password
UserSchema = new Schema(
  username  : { type: String, unique: true }
  email     : { type: String, unique: true }
  hashed_pw : String
)
User = mongoose.model 'User', UserSchema
 
mongoose.model 'User', UserSchema
