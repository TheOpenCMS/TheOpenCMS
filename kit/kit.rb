%w[
  bundler/setup
  pry
  config
  colorize
  tempfile
].each { |lib| require lib }

class DeployKit
  def kit
    self
  end

  def app_env
    ENV['DEPLOY_ENV'] || 'development'
  end

  def app_name
    config.app.name
  end

  def app_scope
    "#{ app_env }/#{ app_name }"
  end
end

%w[
  kit/base/*.rb
  kit/common/*.rb
  kit/rails/*.rb
  kit/custom/*.rb
].each do |path|
  Dir.glob(path).each { |f| require_relative "../#{f}" }
end
