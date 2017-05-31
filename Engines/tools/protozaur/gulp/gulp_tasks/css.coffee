tools = require './tools.coffee'

fs   = tools.fs
log  = tools.log

gulp  = tools.gulp
gutil = tools.gutil

params = tools.params

batch    = tools.batch
plumber  = tools.plumber
chokidar = tools.chokidar

concat = tools.concat
minCSS = tools.minCSS

livereload = tools.livereload

# Main Task
gulp.task 'copyCSS', ['compressCss'], ->
  css_files = params.css.src + params.css.mask

  gulp.src([ params.css.src, css_files ])
    .pipe plumber()
    # .pipe minCSS( keepBreaks: false )
    .pipe gulp.dest(params.css.dest)
    .pipe livereload()
    .on 'error', gutil.log

gulp.task 'compressCss', ->
  reset = params.css.dest + 'ptz/reset.css'
  base  = params.css.dest + 'ptz/base.css'
  fw    = params.css.dest + 'ptz/framework.css'

  ib_base_1 = params.css.dest + 'ptz/inputs_buttons/buttons.css'
  ib_base_2 = params.css.dest + 'ptz/inputs_buttons/button_groups.css'
  ib_base_3 = params.css.dest + 'ptz/inputs_buttons/inputs.css'
  ib_base_4 = params.css.dest + 'ptz/inputs_buttons/sizes.css'

  dest_path = params.css.dest + 'ptz'

  gulp.src([ reset ])
    .pipe plumber()
    .pipe concat('reset.min.css')
    .pipe minCSS( keepBreaks: false )
    .pipe gulp.dest(dest_path)
    .on 'error', gutil.log

  gulp.src([ base ])
    .pipe plumber()
    .pipe concat('base.min.css')
    .pipe minCSS( keepBreaks: false )
    .pipe gulp.dest(dest_path)
    .on 'error', gutil.log

  gulp.src([ fw ])
    .pipe plumber()
    .pipe concat('framework.min.css')
    .pipe minCSS( keepBreaks: false )
    .pipe gulp.dest(dest_path)
    .on 'error', gutil.log

  gulp.src([ reset, base, fw, ib_base_1, ib_base_2, ib_base_3, ib_base_4 ])
    .pipe plumber()
    .pipe concat('protozaur.min.css')
    .pipe minCSS( keepBreaks: false )
    .pipe gulp.dest(dest_path)
    .on 'error', gutil.log

# Watcher
gulp.task 'watchCSS', ->
  css_files = params.css.src + params.css.mask

  chokidar.watch([ params.css.src, css_files ])
    .on 'ready', ->
      log 'copyCSS::ready'
      gulp.start('copyCSS')

    .on 'add', batch { timeout: 100 }, (events, cb) ->
      log 'copyCSS::add'

      gulp.start('copyCSS')
      events.on('data', log).on('end', cb)

    .on 'change', batch { timeout: 100 }, (events, cb) ->
      log 'copyCSS::change'

      gulp.start('copyCSS')

      events.on('data', log).on('end', cb)

    .on 'unlink', batch { timeout: 100 }, (events, cb) ->
      log 'copyCSS::unlink'

      events
        .on('data', (filepath) ->
          filename = filepath.split(params.css.src)[1]
          filepath = params.css.dest + filename
          fs.unlink filepath, (err) -> log "Deleted (File) => `#{ filepath }`"
        )
        .on('end', cb)

    .on 'addDir', batch { timeout: 100 }, (events, cb) ->
      log 'copyCSS::linkDirs'

      gulp.start('copyCSS')
      events.on('data', log).on('end', cb)

    .on 'unlinkDir', batch { timeout: 100 }, (events, cb) ->
      log 'copyCSS::unlinkDirs'

      events.on('data', (dirpath) ->
        dirpath = dirpath.split(params.css.src)[1]
        dirpath = params.css.dest + dirpath

        fs.rmdir dirpath, (err) -> log "Deleted (Directory) `#{ dirpath }`"
      ).on('end', cb)
