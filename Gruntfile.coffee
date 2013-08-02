require "shelljs/global"

# like set -e
config.fatal = true

module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-concat-sourcemap')
  grunt.loadNpmTasks('grunt-multiresize')
  grunt.loadNpmTasks('grunt-contrib-copy')

  grunt.config.init
    pkg: grunt.file.readJSON "package.json"
    coffee:
      options: { join: true, sourceMap: true, bare: true }
      default: files:
        # shared
        "build/chrome/facebook-search.js": [
          "source/chrome/facebook-search.coffee"
        ]
    watch:
      options: { atBegin: true }
      default:
        files: ['source/**']
        tasks: ['build']
    concat_sourcemap:
      options: { sourcesContent: true, sourceRoot: 'foobar' }
      default: files:
        "build/chrome/facebook-search.js": [
          "source/chrome/jquery.js"
          "build/chrome/facebook-search.js"
        ]
    copy:
      default: files:
        "build/chrome/manifest.json": [
          "source/chrome/manifest.json"
        ]
    multiresize:
      default:
        src: 'source/chrome/icon256.png'
        dest: [
          'build/chrome/icon128.png',
          'build/chrome/icon48.png',
          'build/chrome/icon16.png',
        ]
        destSizes: ['128x128', '48x48', '16x16']

  grunt.registerTask "build", "Build extension", ->
    rm '-rf', 'build'
    grunt.task.run "coffee"
    grunt.task.run "concat_sourcemap"
    grunt.task.run "copy"
    grunt.task.run "multiresize"

  grunt.registerTask "release", "Release extension", ->
    grunt.task.run "build"
    grunt.task.run "zip"

  grunt.registerTask "zip", "Zip extension", ->
    exec "find build -name '*.coffee' | xargs rm"
    exec "find build -name '*.sass' | xargs rm"
    exec "find build -name '*.map' | xargs rm"
    exec "zip -r chrome.zip build/chrome"

  grunt.registerTask "default", ->
    grunt.log.writeln("grunt build")
    grunt.log.writeln("grunt release")
    grunt.log.writeln("grunt watch")
