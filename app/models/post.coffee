# Post model

mongoose = require 'mongoose'
Schema   = mongoose.Schema

# -- Post schema --
# title        : the title of post
# contents     : the contents of post
# publish_date : publish date of post
PostSchema = new Schema(
  title        : String
  contents     : String
  publish_date : Date
)
Post = mongoose.model 'Post', PostSchema
 
mongoose.model 'Post', PostSchema
