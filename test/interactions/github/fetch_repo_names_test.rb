require 'test_helper'
require 'pry'

class FetchRepoNamesTest < ActiveSupport::TestCase
  def setup
    @url_1 = 'https://api.github.com/search/code?q=github_api+vcr+filename%3AGemfile.lock&per_page=20'
    @url_2 = 'https://api.github.com/search/code?q=github_api+vcr+filename%3AGemfile.lock&per_page=20'
  end

  test "returns 120 valid repo names" do
    use_cassette 'first code search request' do
      response = Github::FetchRepoNames.run(url: @url_1)
      assert_equal response.count, 120
    end
  end

  test "returns 120 valid repo names with diff page size" do
    use_cassette 'first code search request' do
      response = Github::FetchRepoNames.run(url: @url_2)
      assert_equal response.count, 120
    end
  end

end
