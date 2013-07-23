# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_string_to_slug/version'

Gem::Specification.new do |spec|
  spec.name          = "the_string_to_slug"
  spec.version       = TheStringToSlug::VERSION
  spec.authors       = ["Ilya N. Zykin"]
  spec.email         = ["zykin-ilya@ya.ru"]
  spec.description   = %q{ Convert text string to slug param }
  spec.summary       = %q{ Translite, downcase, parameterize }
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency             "rails-i18n", "~> 4.0.0.pre"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
