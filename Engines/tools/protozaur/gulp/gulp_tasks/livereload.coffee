tools  = require './tools.coffee'

gulp   = tools.gulp
params = tools.params

livereload = tools.livereload

gulp.task 'autoreload', ->
  # http://localhost:3030/livereload.js
  livereload.listen( params.livereload.port )
