module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/pry.js': ['src/*.coffee']
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.registerTask 'default', ['coffee']
