require 'test_helper'
require 'pry'

class PaginationHelperTest < ActiveSupport::TestCase

  test 'returns true if there are more pages' do
    response = multiple_page_request
    pagination = PaginationHelper.new(response)
    assert_equal pagination.more_pages?, true
  end

  test 'returns false when there are no more pages' do
    response = single_page_request
    pagination = PaginationHelper.new(response)
    assert_equal pagination.more_pages?, false
  end

  test 'returns true when there are links present in the headers' do
    response = last_page_request
    pagination = PaginationHelper.new(response)
    assert_equal pagination.links_present?, true
  end

  test 'parse next url from links in header'  do
    response = multiple_page_request
    pagination = PaginationHelper.new(response)
    url = pagination.next_page_url
    assert_equal url, "https://api.github.com/search/code?q=vcr+minitest+filename%3AGemfile.lock&per_page=100&page=2"
  end

  test 'see which urls are present in headers'  do
    response = multiple_page_request
    pagination = PaginationHelper.new(response)
    url_hash = pagination.available_urls

    assert_equal url_hash[:next_available], true
    assert_equal url_hash[:last_available], true
    assert_equal url_hash[:prev_available], false
    assert_equal url_hash[:first_available], false
  end

  test 'return true when the next page should be requested' do
    response = multiple_page_request
    pagination = PaginationHelper.new(response)
    pagination.request_next_page?
  end

  private

  def last_page_request
    use_cassette 'code request that returns last page' do
      response = Common::GithubClient.run(
        url: "https://api.github.com/search/code?q=vcr+minitest+filename%3AGemfile.lock&page=10&per_page=100"
      )
    end
  end

  def multiple_page_request
    url = Github::ComposeUrl.run(
      file_name: 'Gemfile.lock',
      libraries: ['vcr', 'minitest'],
      search_type: :code
    )

    use_cassette 'code request that returns multiple pages' do
      response = Common::GithubClient.run(url: url)
    end

  end

  def single_page_request
    url = Github::ComposeUrl.run(
      file_name: 'Gemfile.lock',
      libraries: ['vcr', 'minitest', 'less_interactions'],
      search_type: :code
    )
    url

    use_cassette 'code request that returns one page' do
      response = Common::GithubClient.run(url: url)
    end
  end
end
