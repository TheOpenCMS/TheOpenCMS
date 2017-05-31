# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_string_addon/version'

Gem::Specification.new do |spec|
  spec.name          = "the_string_addon"
  spec.version       = TheStringAddon::VERSION
  spec.authors       = ["Ilya N. Zykin"]
  spec.email         = ["zykin-ilya@ya.ru"]
  spec.summary       = %q{Helper methods for String class}
  spec.description   = %q{Few reusable methods for String}
  spec.homepage      = "https://github.com/TheProfitCMS/TheStringAddon"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails"
  spec.add_dependency "sanitize"
  spec.add_dependency "redcarpet"
  spec.add_dependency "pygments.rb"
  spec.add_dependency "rails_autolink"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
