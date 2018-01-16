require 'test_helper'
require 'pry'

class ComposeUrlTest < ActiveSupport::TestCase
  def setup
  end

  test "returns valid url given a library and a filename" do
    url = Github::ComposeUrl.run(
      file_name: 'Gemfile.lock',
      libraries: ['vcr', 'minitest', 'less_interactions']
    )
    assert_equal url, "/search/code?q=vcr+minitest+less_interactions+filename%3AGemfile.lock&per_page=100"
  end

end
