# Setting model

mongoose = require 'mongoose'
Schema   = mongoose.Schema

# -- Setting schema --
# title           : the title of this blog
# author_name     : author name
# profile_photo   : profile photo url
# profile_contents: contents of profile (Markdown)
SettingSchema = new Schema(
  title           : { type: String, required: true, default: "My Blog" }
  author_name     : { type: String, required: true, default: "author" }
  profile_photo   : String
  profile_contents: String
)
Setting = mongoose.model 'Setting', SettingSchema

mongoose.model 'Setting', SettingSchema
