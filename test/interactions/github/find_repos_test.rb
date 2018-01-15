require 'test_helper'
require 'pry'

class FindRepo < ActiveSupport::TestCase
  def setup
  end


  test "retuns a hash of all repos matching the search terms" do
    use_cassette("pagination_request") do
      response = Github::FindRepos.run(
        file_name: 'Gemfile.lock',
        libraries: ['vcr', 'minitest'],
        language: 'Ruby'
      )

    binding.pry
    end
  end

end
