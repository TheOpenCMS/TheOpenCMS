path  = require 'path'
__abs = (_path) -> path.resolve(_path) + '/'
__app_root  = "#{ __dirname }/../../"
__gulp_root = "#{ __dirname }/.."

config =
  # Livereload
  livereload:
    port: 3030

  clean:
    "#{ __app_root }/ptz"

  # SASS
  sass:
    src:  __abs "#{ __gulp_root }/../app/assets/stylesheets/"
    dest: __abs "#{ __gulp_root }/css/"

    mask_sass: "**/*.sass"
    mask_scss: "**/*.scss"

  # CSS
  css:
    src:  __abs "#{ __gulp_root }/css/"
    dest: __abs "#{ __gulp_root }/../"

    mask: "**/*.css"

module.exports = config
