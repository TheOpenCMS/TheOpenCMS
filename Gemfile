source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

eval_gemfile "Gemfiles/subtrees/TheOpenCMS.rb"

gem 'webpacker', github: 'rails/webpacker'

gem 'jquery-rails',
  github: 'rails/jquery-rails',
  branch: '89d60928'

gem 'jquery-ui-rails',
  github: 'jquery-ui-rails/jquery-ui-rails',
  branch: '0b22d466'

gem 'config', '1.3.0'
gem 'colorize'

# LOGIN
gem 'devise', '4.1.1'

gem 'omniauth',        '1.3.1'
gem 'omniauth-oauth',  '1.1.0'
gem 'omniauth-oauth2', '1.4.0'

gem 'omniauth-facebook',      '4.0.0'
gem 'omniauth-vkontakte',     '1.3.7'
gem 'omniauth-google-oauth2', '0.4.1'
gem 'omniauth-odnoklassniki', '0.0.5'
gem 'omniauth-twitter',       '1.2.1'

# DELAYED JOBS
gem 'sidekiq', '4.2.1'
gem 'sidekiq-limit_fetch', '3.3.0'

gem 'redis-namespace', '1.5.2'
gem 'sinatra', '1.0', require: nil

gem 'whenever', '0.9.7', require: false

# CONTENT
gem 'protozaur', github: 'the-teacher/protozaur', branch: 'v2.0.pre'
gem 'slim-rails', github: 'slim-template/slim-rails', branch: '8dbc1fbf8'
gem 'slim', '3.0.7'
gem 'ffaker'

gem 'kaminari', github: 'amatsuda/kaminari', branch: '1c9ec3603'

# DATABASES & SEARCH
gem 'pg', '0.18.4'
gem 'mysql2', '0.4.4'
gem 'thinking-sphinx', '3.2.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.0.beta1'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', github: "rails/sass-rails"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.7.0'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'foreman'
  gem 'pry-rails'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
