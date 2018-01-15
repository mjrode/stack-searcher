require 'test_helper'
require 'pry'

class FindRepo < ActiveSupport::TestCase
  def setup
  end


  test "gets total page count" do
    use_cassette("page_count_request") do
      response = Github::FindRepos.run(
        file_name: 'Gemfile.lock',
        libraries: ['vcr', 'minitest']
      )

      assert_equal response, 59
    end
  end

end
