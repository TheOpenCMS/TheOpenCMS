tools = require './tools.coffee'

fs  = tools.fs
log = tools.log

gulp  = tools.gulp
clean = tools.clean
gutil = tools.gutil

params  = tools.params
plumber = tools.plumber

# Main Task
gulp.task 'cleanDest', ->
  gulp.src(params.clean, { read: false })
    .pipe plumber()
    .pipe clean({ force: true })
    .on 'error', gutil.log
