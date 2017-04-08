tools = require './tools.coffee'

fs  = tools.fs
log = tools.log

gulp  = tools.gulp
gutil = tools.gutil

params = tools.params

batch    = tools.batch
plumber  = tools.plumber
chokidar = tools.chokidar

sass   = tools.sass
minCSS = tools.minCSS

postcss         = tools.postcss
autoprefixer    = tools.autoprefixer

livereload = tools.livereload

# Main Task
gulp.task 'compileSass', ->
  sass_files = params.sass.src + params.sass.mask_sass

  gulp.src(sass_files)
    .pipe plumber()
    .pipe sass( outputStyle: 'expanded', indentedSyntax: true, errLogToConsole: true )
    .pipe postcss [
      autoprefixer( browsers: ['last 3 version'] )
    ]
    # .pipe minCSS( keepBreaks: true )
    .pipe gulp.dest(params.sass.dest)
    .pipe livereload()
    .on 'error', gutil.log

gulp.task 'compileScss', ->
  scss_files = params.sass.src + params.sass.mask_scss

  gulp.src(scss_files)
    .pipe plumber()
    .pipe sass( outputStyle: 'expanded', errLogToConsole: true )
    .pipe postcss [
      autoprefixer( browsers: ['last 3 version'] )
    ]
    # .pipe minCSS( keepBreaks: true )
    .pipe gulp.dest(params.sass.dest)
    .pipe livereload()
    .on 'error', gutil.log

# Watcher
gulp.task 'watchSassScss', ->
  sass_files = params.sass.src + params.sass.mask_sass
  scss_files = params.sass.src + params.sass.mask_scss

  chokidar.watch([ params.sass.src, sass_files, scss_files ])
    .on 'ready', ->
      log 'compileSass::ready'

      gulp.start('compileSass')
      gulp.start('compileScss')

    .on 'add', batch { timeout: 100 }, (events, cb) ->
      log 'compileSass::add'

      gulp.start('compileSass')
      gulp.start('compileScss')

      events.on('data', log).on('end', cb)

    .on 'change', batch { timeout: 100 }, (events, cb) ->
      gulp.start('compileSass')
      gulp.start('compileScss')

      events.on('data', log).on('end', cb)

    .on 'unlink', batch { timeout: 100 }, (events, cb) ->
      log 'compileSass::unlink'

      events
        .on('data', (filepath) ->
          filename = filepath.split(params.sass.src)[1]
          filename = filename.replace(/sass$/g, 'css')
          filename = filename.replace(/scss$/g, 'css')
          filepath = params.sass.dest + filename

          fs.unlink filepath, (err) -> log "Deleted (File) `#{ filepath }`"
        )
        .on('end', cb)

    .on 'addDir', batch { timeout: 100 }, (events, cb) ->
      log 'compileSass::linkDirs'

      gulp.start('compileSass')
      gulp.start('compileScss')

      events.on('data', log).on('end', cb)

    .on 'unlinkDir', batch { timeout: 100 }, (events, cb) ->
      log 'compileSass::unlinkDirs'

      events.on('data', (dirpath) ->
        dirpath = dirpath.split(params.sass.src)[1]
        dirpath = params.sass.dest + dirpath

        fs.rmdir dirpath, (err) -> log "Deleted (Directory) `#{ dirpath }`"
      ).on('end', cb)
