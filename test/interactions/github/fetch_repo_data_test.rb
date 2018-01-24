require 'test_helper'
require 'pry'

class FetchRepoDataTest < ActiveSupport::TestCase
  def setup
  end

  test "save 120 repos" do
    use_cassette 'save 120 repos' do
      repo_array = Github::FetchRepoNames.run(file_name: 'Gemfile.lock', libraries: ['github_api', 'vcr'])
      response = Github::FetchRepoData.run(repo_array: repo_array)

      assert_equal response.count, 172
      assert_equal Repo.count, 169
    end
  end
end
