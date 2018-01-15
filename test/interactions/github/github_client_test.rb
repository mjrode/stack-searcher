require 'test_helper'
require 'pry'

class GithubClient < ActiveSupport::TestCase
  def setup
  end

  test "basic request returns valid response" do
    use_cassette("basic_request") do
      response = Common::GithubClient.run(
        file_name: 'Gemfile.lock',
        libraries: ['vcr', 'minitest']
      )

      assert response.success?
      assert_equal response.parsed_response['total_count'], 5855
      assert_equal response.parsed_response['items'].count, 100
    end
  end

  test "return repository info" do
  use_cassette("repo_api_request") do
    response = Common::GithubClient.run(api_url: 'https://api.github.com/repos/hakanensari/fixer')

    assert response.success?
    assert_equal response.parsed_response["watchers_count"], 1933
    assert_equal response.parsed_response["stargazers_count"], 1933
    assert_equal response.parsed_response["url"], "https://api.github.com/repos/hakanensari/fixer"
  end
end

end
