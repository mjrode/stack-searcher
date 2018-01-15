require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'rubygems'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def use_cassette(name, &blk)
    VCR.use_cassette(name, record: :new_episodes, &blk)
  end

  # Add more helper methods to be used by all tests here...
end
