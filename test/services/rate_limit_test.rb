require 'test_helper'
require 'pry'

class RateLimitTest < ActiveSupport::TestCase

  def setup
      Timecop.freeze('2018-01-23 23:31:14 -0600')
  end

  test 'get a valid response back when requesting rate limits' do
    use_cassette('rate_limit') do
      response = RateLimit.check_limits
      assert_equal response, 'Core Remaining: 4997, resets in 3943.0 seconds | Search Remaining: 28, resets in 1026.0'
    end
  end
end
