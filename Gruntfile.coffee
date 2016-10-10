module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      compile:
        expand: true
        cwd: './src/'
        src: ['**/*.coffee']
        dest: './build/'
        ext: '.js'
    clean:
      compiled:
        src: ["build/**/*"]
        options:
          "no-write": false

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.registerTask 'default', ['clean:compiled', 'coffee']
