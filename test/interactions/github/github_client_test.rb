require 'test_helper'
require 'pry'

class GithubClient < ActiveSupport::TestCase
  def setup
  end

  test "basic code request returns valid response" do
    url = Github::ComposeUrl.run(
      file_name: 'Gemfile.lock',
      libraries: ['vcr', 'minitest', 'less_interactions'],
      search_type: :code
    )
    use_cassette("basic_request") do
      response = Common::GithubClient.run(url: url)
      assert response.success?
      assert_equal response.parsed_response['total_count'], 3
      assert_equal response.parsed_response['items'].count, 3
    end
  end

  test "return repository info" do
    use_cassette("repo_api_request") do
      response = Common::GithubClient.run(url: 'https://api.github.com/repos/hakanensari/fixer')

      assert response.success?
      assert_equal response.parsed_response["watchers_count"], 1935
      assert_equal response.parsed_response["stargazers_count"], 1935
      assert_equal response.parsed_response["url"], "https://api.github.com/repos/hakanensari/fixer"
      assert_equal response.parsed_response['owner']['login'], 'hakanensari'
    end
  end

end
