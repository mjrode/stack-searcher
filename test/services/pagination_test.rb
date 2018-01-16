require 'test_helper'
require 'pry'

class PaginationTest < ActiveSupport::TestCase
  def setup

  end

  test 'returns true if there are more pages' do
    response = multiple_page_request
    pagination = Pagination.new(response)
    assert_equal pagination.more_pages?, true
  end

  test 'returns false when there are no more pages' do
    response = single_page_request
    pagination = Pagination.new(response)
    assert_equal pagination.more_pages?, false
  end

  # test 'returns next page url when present' do
  #   response = multiple_page_request
  #   pagination = Pagination.new(response)
  #   binding.pry
  # end

  test 'returns true when there are links present in the headers' do
    response = last_page_request
    pagination = Pagination.new(response)
    assert_equal pagination.links_present?, true
  end

  test 'parse next url from links in header'  do
    response = multiple_page_request
    pagination = Pagination.new(response)
    url = pagination.next_page_url
    assert_equal url, 'https://api.github.com/search/code?q=vcr+minitest+filename%3AGemfile.lock&page=2&per_page=100'
  end

  test 'see which urls are present in headers'  do
    response = multiple_page_request
    pagination = Pagination.new(response)
    url_hash = pagination.available_urls

    assert_equal url_hash[:next_available], true
    assert_equal url_hash[:last_available], true
    assert_equal url_hash[:prev_available], false
    assert_equal url_hash[:first_available], false
  end

  private

  def last_page_request
    use_cassette 'code request that returns last page' do
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
