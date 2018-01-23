require 'test_helper'
require 'pry'

class FetchRepoNamesTest < ActiveSupport::TestCase
  def setup
    @url_1 = 'https://api.github.com/search/code?q=github_api+vcr+filename%3AGemfile.lock&per_page=20'
    @url_2 = 'https://api.github.com/search/code?q=github_api+vcr+filename%3AGemfile.lock&per_page=100'
    @url_3 = 'https://api.github.com/search/code?q=less_interactions+vcr+filename%3AGemfile.lock&per_page=100'
  end

  test "returns 120 valid repo names" do
    use_cassette 'first code search request' do
      response = Github::FetchRepoNames.run(url: @url_1)
      assert_equal response.count, 20
    end
  end

  test "returns 120 valid repo names with diff page size" do
    use_cassette 'second code search request' do
      response = Github::FetchRepoNames.run(url: @url_2)
      assert_equal response.count, 100
    end
  end

  test "returns valid repo names with only one page" do
    use_cassette 'third code search request' do
      response = Github::FetchRepoNames.run(url: @url_3)
      assert_equal response.count, 4
      assert_equal response, ["mjrode/stack-searcher", "mjrode/workhard", "mjrode/check_the_lines", "mjrode/TwitterLists"]
    end
  end

end
