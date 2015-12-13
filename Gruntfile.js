'use strict';

var request = require('request');

module.exports = function (grunt) {
  // show elapsed time at the end
  require('time-grunt')(grunt);
  // load all grunt tasks
  require('load-grunt-tasks')(grunt);

  var reloadPort = 35729, files

  // looping tasks

  // requirejs task

  var requirejsOptions = function() {
    var files = grunt.file.expand('public/js/*.js');
    var opts  = {};

    files.forEach(function(file) {
      var filename = file.split('/').pop();
      opts[filename] = {
        options: {
          baseUrl               : "public/js",
          mainConfigFile        : "public/js/config.js",
          out                   : "public_production/js/" + filename,
          include               : filename,
          optimize              : "uglify2",
          findNestedDependencies: true
        }
      };
    });

    return opts;
  }

  // vulcanize task
  var files          = grunt.file.expand('public/webcomponent/*.html');
  var vulcanizeFiles = {};

  files.forEach(function(file) {
    var filename = file.split('/').pop();
    vulcanizeFiles["public_production/webcomponent/" + filename] = "public/webcomponent/" + filename
  });

  // less tasks
  var lessFiles      = {};
  grunt.file.recurse("public/less", function callback(abspath, rootdir, subdir, filename) {
    // exclude common.less
    if(abspath != "public/less/common.less") {
      var trimedFilename = filename.split(".")[0] + ".css";
      if(subdir) {
        lessFiles["public/css/" + subdir + "/" + trimedFilename] = abspath;
      } else {
        lessFiles["public/css/" + trimedFilename] = abspath;
      }
    }
  });

  // init config
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    // clean client side js and css file
    clean: {
      development: ["public/js", "public/css"],
      production : ["public/js",
                    "public/css",
                    "public_production/js",
                    "public_production/css",
                    "public_production/webcomponent",
                    "public_production/components",
                    "public_production/fonts" ]
    },

    // copy component file
    copy: {
      production: {
        files: [
          {
            src : 'public/components/requirejs/require.js',
            dest: 'public_production/components/requirejs/require.js'
          },
          {
            src : 'public/components/webcomponentsjs/webcomponents.min.js',
            dest: 'public_production/components/webcomponentsjs/webcomponents.js'
          },
          {
            src : 'public/components/socjs/soc.min.css',
            dest: 'public_production/components/socjs/soc.min.css'
          },
          {
            expand: true,
            cwd: 'public/css',
            src: '*',
            dest: 'public_production/css',
            flatten: true,
            filter: 'isFile',
          },
          {
            expand: true,
            cwd: 'public/fonts',
            src: '*',
            dest: 'public_production/fonts',
            flatten: true,
            filter: 'isFile',
          },
          {
            expand: true,
            cwd: 'public/components/socjs/font',
            src: '*',
            dest: 'public_production/components/socjs/font',
            flatten: true,
            filter: 'isFile',
          },
          {
            expand: true,
            cwd: 'public/img',
            src: '*',
            dest: 'public_production/img',
            flatten: true,
            filter: 'isFile'
          }
        ],
      },
    },

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

    //less file compile
    less: {
      production: {
        options: {
          paths   : ["public/less", "public/less/admin", "public/less/blog"],
          compress: true
        },
        files: lessFiles
      }
    },

    // optimize web component
    vulcanize: {
      default: {
        options: {
          // Task-specific options go here.
          inline: true,
          strip : true
        },
        files: vulcanizeFiles
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
          'public/scripts/**/*.coffee'
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

  grunt.registerTask('mkdir:production', 'Make directory', function() {
    grunt.file.mkdir("public_production/webcomponent");
    grunt.file.mkdir("public_production/js");
    grunt.file.mkdir("public_production/components");
    grunt.file.mkdir("public_production/css");
    grunt.file.mkdir("public_production/fonts");
  });

  // https://github.com/gruntjs/grunt-contrib-coffee
  grunt.loadNpmTasks('grunt-contrib-coffee');
  // https://github.com/gruntjs/grunt-contrib-less
  grunt.loadNpmTasks('grunt-contrib-less');
  // https://github.com/assemble/assemble-less
  grunt.loadNpmTasks('grunt-contrib-clean');
  // https://github.com/Polymer/grunt-vulcanize
  grunt.loadNpmTasks('grunt-vulcanize');
  // https://github.com/gruntjs/grunt-contrib-requirejs
  grunt.loadNpmTasks('grunt-contrib-requirejs');
  // https://github.com/gruntjs/grunt-contrib-copy
  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.registerTask('default', ['clean:development','coffee:client', 'develop', 'watch']);

  grunt.registerTask('donebuild', "donebuild", function() {
    // compress scripts
    grunt.config("requirejs", requirejsOptions());
    grunt.task.run("requirejs");
    grunt.task.run("copy:production");
  });

  grunt.registerTask('build', [
   'clean:production',
   'mkdir:production',
   'coffee:client',
   'vulcanize',
   'less:production',
   'donebuild'
 ]);
};
