module.exports = (grunt) ->

  grunt.initConfig
    coffee:
      compile:
        expand: true
        cwd: './src/'
        src: ['**/*.coffee']
        dest: './lib/'
        ext: '.js'
    clean:
      compiled:
        src: ["lib/**/*"]
        options:
          "no-write": false

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.registerTask 'default', ['clean:compiled', 'coffee']
