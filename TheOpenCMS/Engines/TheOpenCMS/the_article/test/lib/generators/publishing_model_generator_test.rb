require 'test_helper'
require 'generators/publishing_model/publishing_model_generator'

class PublishingModelGeneratorTest < Rails::Generators::TestCase
  tests PublishingModelGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
