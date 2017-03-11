# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'user_room/version'

Gem::Specification.new do |spec|
  spec.name          = "user_room"
  spec.version       = UserRoom::VERSION
  spec.authors       = ["Ilya N. Zykin"]
  spec.email         = ["zykin-ilya@ya.ru"]

  spec.summary       = %q{Devise/User part of application}
  spec.description   = %q{Devise/User part of application}
  spec.homepage      = "https://github/com/user_room"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # DEPENDENCIES
  spec.add_dependency 'devise'
  spec.add_dependency 'omniauth-twitter'
  spec.add_dependency 'omniauth-facebook'
  spec.add_dependency 'omniauth-vkontakte'
  spec.add_dependency 'omniauth-google-oauth2'
  spec.add_dependency 'omniauth-odnoklassniki'

  spec.add_dependency 'slim'
  spec.add_dependency 'config'

  spec.add_dependency 'pagination'
  spec.add_dependency 'simple_sort'
  spec.add_dependency 'to_slug_param'
  spec.add_dependency 'premailer-rails'

  spec.add_dependency 'mini_magick'
  spec.add_dependency 'paperclip'

  spec.add_dependency 'image_tools'
  spec.add_dependency 'crop_tool'

  spec.add_dependency 'log_js'
  spec.add_dependency 'role_slim_js'
  spec.add_dependency 'notifications'

  spec.add_dependency 'protozaur'
  spec.add_dependency 'protozaur_theme'
  # ~ DEPENDENCIES

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
