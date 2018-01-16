# require 'test_helper'
# require 'pry'
#
# class FindRepo < ActiveSupport::TestCase
#   def setup
#   end
#
#   test "if still valid repos if under 100 items are returned" do
#     url = Github::ComposeUrl.run(
#       file_name:"Gemfile.lock",
#       libraries: ["vcr", "octokit", "pg", "font-awesome-rails"]
#     )
#
#     use_cassette('search with under 100 items') do
#
#       response = Github::FindRepos.run(url: url)
#
#       assert_equal response.count, 28
#
#       repo = response.first
#       assert_equal repo['external_id'], 21468732
#       assert_equal repo['html_url'], 'https://github.com/johnkeith/GitCard'
#       assert_equal repo['api_url'], 'https://api.github.com/repos/johnkeith/GitCard'
#       assert_equal repo['score'], 6.8234324
#       assert_equal repo['login'], 'johnkeith'
#       assert_equal repo['language'], "Ruby"
#
#     end
#   end
#
# end
