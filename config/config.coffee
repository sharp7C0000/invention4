path          = require 'path'
rootPath      = path.normalize __dirname + '/..'
env            = process.env.NODE_ENV || 'development'
dbAddress      = process.env.INVENTION4_DB_ADDRESS || 'mongodb://localhost'
port           = process.env.INVENTION4_PORT || 3000
ip             = process.env.INVENTION4_IP || '127.0.0.1'

config =
  development:
    root  : rootPath
    static: 'public'
    app:
      name: 'invention4 development'
    port: port
    ip: ip
    db:
      dbAddress + "/invention4-development"
    # dbAuth:
    #   user: changeit
    #   pass: changeit
    # initialAdmin:
    #   name: changeit
    #   pass: changeit

  test:
    root  : rootPath
    static: 'public'
    app:
      name: 'invention4 test'
    port: port
    ip: ip
    db: dbAddress + "/invention4-test"
    # dbAuth:
    #   user: changeit
    #   pass: changeit
    # initialAdmin:
    #   name: changeit
    #   pass: changeit

  production:
    root  : rootPath
    static: 'public_production'
    app:
      name: 'invention4'
    port: port
    ip: ip
    db: dbAddress + "/invention4-production"
    # dbAuth:
    #   user: changeit
    #   pass: changeit
    # initialAdmin:
    #   name: changeit
    #   pass: changeit

module.exports = config[env]
