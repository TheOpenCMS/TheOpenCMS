#######################################################################
# USER ROOM GEMS
#######################################################################

gem 'devise', '4.2.1',
  github: 'plataformatec/devise',
  branch: 'a62faa2'

gem 'omniauth',        '1.6.1'
gem 'omniauth-oauth',  '1.1.0'
gem 'omniauth-oauth2', '1.4.0'

gem 'omniauth-facebook',      '4.0.0'
gem 'omniauth-twitter',       '1.4.0'
gem 'omniauth-vkontakte',     '1.3.7'
gem 'omniauth-google-oauth2', '0.4.1'
gem 'omniauth-odnoklassniki', '0.0.6'

#######################################################################
# THE OPEN CMS Engines
#######################################################################

gem 'voiceless',         path: '../Engines/tools/voiceless'
gem 'protozaur',         path: '../Engines/tools/protozaur'
gem 'log_js',            path: '../Engines/tools/log_js'

gem 'to_slug_param',     path: '../Engines/tools/to_slug_param'
gem 'friendly_id_pack',  path: '../Engines/tools/friendly_id_pack'
gem 'the_string_addon',  path: '../Engines/tools/the_string_addon'

gem 'the_notifications', path: '../Engines/tools/notifications'
gem 'the_pagination',    path: '../Engines/tools/pagination'
gem 'simple_sort',       path: '../Engines/tools/simple_sort'

gem 'image_tools',       path: '../Engines/tools/image_tools'
gem 'crop_tool',         path: '../Engines/tools/crop_tool'

gem 'active_permits',    path: '../Engines/tools/active_permits'
gem 'user_room',         path: '../Engines/apps/user_room'
gem 'the_publication',   path: '../Engines/apps/the_publication'
gem 'app_base',          path: '../Engines/apps/app_base'
gem 'app_theme',         path: '../Engines/apps/theopencms.org'

#######################################################################
# CONTENT
#######################################################################

gem 'ffaker'
gem 'paperclip', '5.1.0'
gem 'premailer-rails', '1.9.5'

gem 'kaminari',
  github: 'amatsuda/kaminari',
  branch: '4efe5fd'

gem 'slim-rails',
  github: 'slim-template/slim-rails',
  branch: '8dbc1fbf8'

#######################################################################
# BASE
#######################################################################

gem 'colorize'
gem 'config', '1.3.0'

gem 'sprockets',
  github: 'rails/sprockets' # 09f44cb

gem 'autoprefixer-rails'

gem 'exception_notification', '4.2.1'
gem 'newrelic_rpm', '4.1.0.333'
gem 'rollbar', '2.14.1'
gem 'oj', '2.18.5'

gem 'jquery-rails',
  github: 'rails/jquery-rails',
  branch: '89d60928'

gem 'jquery-ui-rails',
  github: 'jquery-ui-rails/jquery-ui-rails',
  branch: '0b22d466'

# gem 'webpacker',
#   github: 'rails/webpacker'

#######################################################################
# DATABASES
#######################################################################

gem 'pg', '0.18.4'
gem 'mysql2', '0.4.4'
gem 'thinking-sphinx', '3.2.0'

#######################################################################
# ASYNC TASKS AND DELAYED JOBS
#######################################################################

gem 'sidekiq', '5.0.0'
gem 'sidekiq-limit_fetch', '3.4.0'

gem 'redis-namespace', '1.5.3'
gem 'sinatra', '2.0.0', require: nil

gem 'whenever', '0.9.7', require: false
