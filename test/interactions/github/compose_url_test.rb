require 'test_helper'
require 'pry'

class ComposeUrlTest < ActiveSupport::TestCase
  def setup
  end

  test "returns valid url given a library and a filename" do
    url = Github::ComposeUrl.run(
      file_name: 'Gemfile.lock',
      libraries: ['vcr', 'minitest', 'less_interactions'],
      search_type: :code
    )
    assert_equal url, "/search/code?q=vcr+minitest+less_interactions+filename%3AGemfile.lock&per_page=100"
  end

  test "returns valid url given two libraries and a filename" do
    url = Github::ComposeUrl.run(
      file_name: 'Gemfile.lock',
      libraries: ['vcr', 'minitest'],
      search_type: :code
    )
    assert_equal url, "/search/code?q=vcr+minitest+filename%3AGemfile.lock&per_page=100"
  end

  test "returns valid url given list of repo name" do
    # repo_names = ['rgeyer-rs-cookbooks/cookbooks_all', 'ase-lab/Publisher']
    url = Github::ComposeUrl.run(
      repo_names: ['rgeyer-rs-cookbooks/cookbooks_all', 'ase-lab/Publisher'],
      search_type: :repo
    )
    assert_equal url, "/search/repositories?q=rgeyer-rs-cookbooks/cookbooks_all+in:name+OR+ase-lab/Publisherin%3Aname&type=Repositories"
  end

end
