gulp = require 'gulp'

require './gulp_tasks/livereload.coffee'

require './gulp_tasks/sass.coffee'
require './gulp_tasks/css.coffee'
require './gulp_tasks/clean.coffee'

# Default task call every tasks created so far.
gulp.task 'default', [
  'cleanDest'
  'watchSassScss'
  'watchCSS'
]
