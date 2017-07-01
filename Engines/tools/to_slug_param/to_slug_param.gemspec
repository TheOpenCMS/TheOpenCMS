# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

module ToSlugParam
  VERSION = "1.2"
end

Gem::Specification.new do |spec|
  spec.name          = 'to_slug_param'
  spec.version       = ToSlugParam::VERSION
  spec.authors       = ['Ilya N. Zykin']
  spec.email         = ['zykin-ilya@ya.ru']
  spec.description   = %q{ Convert strings and symbols to slug param }
  spec.summary       = %q{ Transliteration + Parameterization for slugs building }
  spec.homepage      = 'https://github.com/the-teacher/to_slug_param'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails-i18n'
  spec.add_dependency 'stringex', '~> 2.7.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
