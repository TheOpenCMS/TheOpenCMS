# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

module ImageTools
  VERSION = "0.1"
end

Gem::Specification.new do |spec|
  spec.name          = "image_tools"
  spec.version       = ImageTools::VERSION
  spec.authors       = ["Ilya N. Zykin"]
  spec.email         = ["zykin-ilya@ya.ru"]
  spec.summary       = %q{ImageTools - helpers for image manipulations}
  spec.description   = %q{Helpers for image manipulations}
  spec.homepage      = "https://github.com/TheOpenCMS"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'mini_magick'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
