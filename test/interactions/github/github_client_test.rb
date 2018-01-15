require 'test_helper'
require 'pry'

class GithubClient < ActiveSupport::TestCase
  def setup
  end

  test "raises param not provided error" do
    assert_raises Less::MissingParameterError do
      response = Common::GithubClient.run
    end
  end

  test "basic request returns valid response" do
    use_cassette("basic_request") do
      response = Common::GithubClient.run(
        file_name: 'Gemfile.lock',
        libraries: ['vcr', 'minitest']
      )

      assert response.success?
      assert_equal response.parsed_response['total_count'], 5945
      assert_equal response.parsed_response['items'].count, 100
    end
  end

end
