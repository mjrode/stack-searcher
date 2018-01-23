# require 'test_helper'
# require 'pry'
#
# class FindRepo < ActiveSupport::TestCase
#   def setup
#   end
#
#   test "get 1_000 repo names with given libraries" do
#     use_cassette 'search with under 100 items' do
#       url = Github::ComposeUrl.run(
#         file_name:"Gemfile.lock",
#         libraries: ["vcr", "minitest"],
#         search_type: :code
#       )
#
#       repos = Github::FetchRepoNames.run(url: url)
#
#       url = Github::ComposeUrl.run(repo_names: repos, search_type: :repo)
#
#       binding.pry
#
#
#       assert_equal response.count, 1_000
#
#
#     end
#   end
#
# end
