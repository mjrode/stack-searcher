require 'test_helper'
require 'pry'

class PaginationTest < ActiveSupport::TestCase
  def setup

  end

  test "returns true if there is another page present" do
    response = multiple_page_request
    pagination = Pagination.new(response)
    assert pagination.next_page?
  end

  test 'returns false when there are no more pages' do
    response = single_page_request
    pagination = Pagination.new(response)
    assert_equal pagination.next_page?, false
  end

  private

  def last_page_request
    use_cassette 'code request that returns multiple pages' do
      response = Common::GithubClient.run(
        api_url: "https://api.github.com/search/code?q=vcr+minitest+filename%3AGemfile.lock&page=10&per_page=100"
      )
    end
  end

  def multiple_page_request
    use_cassette 'code request that returns multiple pages' do
      response = Common::GithubClient.run(
        file_name: 'Gemfile.lock',
        libraries: ['vcr', 'minitest']
      )
    end
  end

  def single_page_request
    use_cassette 'code request that returns one page' do
      response = Common::GithubClient.run(
        file_name: 'Gemfile.lock',
        libraries: ['vcr', 'minitest', 'less_interactions']
      )
    end
  end
end
