KIT_ROOT = File.expand_path('../', __FILE__)
require_relative 'kit/kit'

task_name = ARGV.first || 'deploy!'

kit = DeployKit.new
kit.configs_load!
kit.send(task_name)
