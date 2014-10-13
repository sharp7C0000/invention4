path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'invention4'
    port: 3000
    db: 'mongodb://localhost/invention4-development'
    

  test:
    root: rootPath
    app:
      name: 'invention4'
    port: 3000
    db: 'mongodb://localhost/invention4-test'
    

  production:
    root: rootPath
    app:
      name: 'invention4'
    port: 3000
    db: 'mongodb://localhost/invention4-production'
    

module.exports = config[env]
