# require 'test_helper'
# require 'pry'
#
# class FetchRepoDataTest < ActiveSupport::TestCase
#   def setup
#   end
#
#   test "get 1_000 repo names with given libraries" do
#     use_cassette 'search with under 100 items' do
#       url = Github::FetchRepoNames.run()
#
#       repos = Github::FetchRepoNames.run(url: url)
#
#       url = Github::ComposeUrl.run(repo_names: repos, search_type: :repo)
#
#
#       assert_equal response.count, 1_000
#
#
#     end
#   end
#
# end
