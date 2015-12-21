'use strict'

module.exports =
  # App params
  params: require './_params'

  # `console.log` shortcut
  log: require './log.coffee'

  # Events debounce
  batch: require 'gulp-batch'
  # Watcher => events: ready add change unlink addDir unlinkDir raw error
  chokidar: require 'chokidar'
  # Gulp - don't panic!
  plumber: require 'gulp-plumber'
  # Page autoreload
  livereload: require 'gulp-livereload'

  # Base
  fs:    require 'fs'
  path:  require 'path'
  gulp:  require 'gulp'
  gutil: require 'gulp-util'

  # Common
  concat: require 'gulp-concat' # files

  # SCSS/CSS
  sass:         require 'gulp-sass'
  minCSS:       require 'gulp-minify-css'

  # https://github.com/ai
  postcss:         require 'gulp-postcss'
  autoprefixer:    require 'autoprefixer-core'
