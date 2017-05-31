#!/usr/bin/ruby

ENV['BUNDLE_GEMFILE'] = './gemfiles/Gemfile'
ENV['MENTOS_LOG'] = "#{ Dir.pwd }/mentos.log"

require 'rubygems'
require 'bundler/setup'

require 'pry'
require 'rails'
require 'the_string_addon'

require_relative '../app/models/auto_link'
require_relative '../app/models/colored_code'
require_relative '../app/models/markdown2_tags'
require_relative '../app/models/content_for_processing'
