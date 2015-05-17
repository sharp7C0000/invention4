# Setting model

mongoose = require 'mongoose'
Schema   = mongoose.Schema

# -- Setting schema --
# title        : the title of this blog
SettingSchema = new Schema(
  title        : { type: String, required: true, default: "Your Blog" }
)
Setting = mongoose.model 'Setting', SettingSchema
 
mongoose.model 'Setting', SettingSchema
