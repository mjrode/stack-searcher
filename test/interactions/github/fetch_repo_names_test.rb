require 'test_helper'
require 'pry'

class FetchRepoNamesTest < ActiveSupport::TestCase
  def setup
  end

  test "returns 120 valid repo names" do
    use_cassette 'first code search request' do
      response = Github::FetchRepoNames.run(file_name: 'Gemfile.lock', libraries: ['github_api', 'vcr'])
      assert_equal response.count, 120
    end
  end

  test "returns valid repo names with only one page" do
    use_cassette 'third code search request' do
      response = Github::FetchRepoNames.run(file_name: 'Gemfile.lock', libraries: ['less_interactions', 'vcr'])
      assert_equal response.count, 4
      assert_equal response, ["mjrode/stack-searcher", "mjrode/workhard", "mjrode/check_the_lines", "mjrode/TwitterLists"]
    end
  end

  test "returns valid repo names for large request" do
    use_cassette 'third code search request' do
      response = Github::FetchRepoNames.run(file_name: 'Gemfile.lock', libraries: ['minitest', 'vcr'])
      assert_equal response.count, 1100
    end
  end
end
