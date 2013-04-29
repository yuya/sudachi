module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    exec:
      sync:
        cmd: -> "./sync.sh"
    sass:
      dist:
        files:
          "Sudachi.css": "src/compass/Sudachi.scss"
        options:
          style: "compressed"
          compass: "src/compass/config.rb"
    coffee:
      dist:
        options:
          bare: true
        files:
          "Sudachi.js": "src/Sudachi.coffee"
    watch:
      dist:
        files: ["src/compass/**/*.scss", "src/*.coffee"]
        tasks: "compile"
      css:
        files: ["src/compass/**/*.scss"]
        tasks: "css"
      js:
        files: ["src/*.coffee"]
        tasks: "js"
    jshint:
      dist: ["Sudachi.js"]
      options:
        curly:   true
        eqeqeq:  true
        immed:   true
        latedef: true
        newcap:  true
        noarg:   true
        sub:     true
        undef:   true
        boss:    true
        eqnull:  true
        es5:     true
        dojo:    true
        devel:   true

  grunt.loadNpmTasks "grunt-exec"
  grunt.loadNpmTasks "grunt-notify"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  # grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "compile", ["coffee", "sass", "jshint", "exec:sync"]
  grunt.registerTask "test",    ["coffee:test", "exec:mocha"]
  grunt.registerTask "css",     ["sass", "exec:sync"]
  grunt.registerTask "js",      ["coffee", "jshint", "exec:sync"]
  grunt.registerTask "prod",    ["compile"]

  grunt.registerTask "default", ["prod"]
