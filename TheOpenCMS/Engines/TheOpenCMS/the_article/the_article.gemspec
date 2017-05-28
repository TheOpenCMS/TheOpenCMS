# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

module TheArticle
  VERSION = "0.1.0"
end

Gem::Specification.new do |spec|
  spec.name          = "the_article"
  spec.version       = TheArticle::VERSION
  spec.authors       = ["Ilya N. Zykin"]
  spec.email         = ["zykin-ilya@ya.ru"]

  spec.summary       = %q{Publishing Engine}
  spec.description   = %q{Publishing Engine for TheOpenCMS}
  spec.homepage      = "https://github.com/TheOpenCMS"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'slim'
  spec.add_dependency 'config'

  spec.add_dependency 'log_js'
  spec.add_dependency 'protozaur'
  spec.add_dependency 'premailer-rails'

  spec.add_dependency 'simple_sort'
  spec.add_dependency 'the_pagination'
  spec.add_dependency 'the_notifications'
  spec.add_dependency 'the_string_to_slug'

  spec.add_dependency 'mini_magick'
  spec.add_dependency 'paperclip'
  spec.add_dependency 'image_tools'
  spec.add_dependency 'crop_tool'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
