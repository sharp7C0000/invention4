path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root  : rootPath
    static: 'public'
    app:
      name: 'invention4 development'
    port: 3000
    db: 'mongodb://localhost/invention4-development'
    admin:
      name    : 'admin'
      password: '1234'


  test:
    root  : rootPath
    static: 'public'
    app:
      name: 'invention4 test'
    port: 3000
    db: 'mongodb://localhost/invention4-test'
    admin:
      name    : 'admin'
      password: '1234'


  production:
    root  : rootPath
    static: 'public_production'
    app:
      name: 'invention4'
    port: 3000
    db: 'mongodb://localhost/invention4-production'
    # admin:
    #   name    : #ur admin name
    #   password: #ur admin password


module.exports = config[env]
