# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

module Notifications
  VERSION = "0.6.0"
end

Gem::Specification.new do |spec|
  spec.name          = "the_notifications"
  spec.version       = Notifications::VERSION
  spec.authors       = ["Ilya N. Zykin"]
  spec.email         = ["zykin-ilya@ya.ru"]
  spec.description   = %q{Notifications and Alerts for a Rails app}
  spec.summary       = %q{This gem helps to render flash messages in a Rails app}
  spec.homepage      = "https://github.com/TheOpenCMS"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "slim"
end
