'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({

    // Metadata
    pkg: grunt.file.readJSON('package.json'),
    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      ' Licensed <%= _.pluck(pkg.licenses, "type").join(", ") %> */\n',

    // Sass
    sass: {
      options: {
        sourcemaps: false,
        trace: true,
        style: 'nested',
        precision: 8
      },
      files:
        {
          expand: true,     // Enable dynamic expansion.
          cwd: 'css/scss/',      // Src matches are relative to this path.
          src: ['*.scss'], // Actual pattern(s) to match.
          dest: '../',   // Destination path prefix.
          ext: '.css',   // Dest filepaths will have this extension.
        }
    },

    // Autoprefixer
    autoprefixer: {
      options: {
        browsers: ['last 2 versions', 'ie 8', 'android 4', 'android 3', 'android 2.3']
      },
      no_dest: {
        src: 'css/*.css'
      }
    }
  });

  // Load plugins
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-autoprefixer');

// These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');


  // Default task
  grunt.registerTask('default', ['sass', 'autoprefixer']);

};