'use strict';

var request = require('request');

module.exports = function (grunt) {
  // show elapsed time at the end
  require('time-grunt')(grunt);
  // load all grunt tasks
  require('load-grunt-tasks')(grunt);

  var reloadPort = 35729, files;

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    // clean client side js and css file
    clean: ["public/js", "public/css"],

    // client side coffeescript compile
    coffee: {
      client: {
        expand: true,
        cwd: 'public/scripts',
        src: ['**/*.coffee'],
        dest: 'public/js',
        ext: '.js'
      }
    },
    develop: {
      server: {
        file: 'app.js'
      }
    },
    watch: {
      options: {
        nospawn: true,
        livereload: reloadPort
      },
      js: {
        files: [
          'app.coffee',
          'app/**/*.coffee',
          'config/*.coffee',
          'public/scripts/*.coffee'
        ],
        tasks: ['coffee:client', 'develop', 'delayed-livereload']
      },
      views: {
        files: [
          'app/views/*.ejs',
          'app/views/**/*.ejs'
        ],
        options: { livereload: reloadPort }
      }
    }
  });

  grunt.config.requires('watch.js.files');
  files = grunt.config('watch.js.files');
  files = grunt.file.expand(files);

  grunt.registerTask('delayed-livereload', 'Live reload after the node server has restarted.', function () {
    var done = this.async();
    setTimeout(function () {
      request.get('http://localhost:' + reloadPort + '/changed?files=' + files.join(','),  function(err, res) {
          var reloaded = !err && res.statusCode === 200;
          if (reloaded)
            grunt.log.ok('Delayed live reload successful.');
          else
            grunt.log.error('Unable to make a delayed live reload.');
          done(reloaded);
        });
    }, 500);
  });

  // https://github.com/gruntjs/grunt-contrib-coffee
  grunt.loadNpmTasks('grunt-contrib-coffee');
  //https://github.com/gruntjs/grunt-contrib-clean
  grunt.loadNpmTasks('grunt-contrib-clean');

  grunt.registerTask('default', ['clean','coffee:client', 'develop', 'watch']);
};
