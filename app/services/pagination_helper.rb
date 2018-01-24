class PaginationHelper
  # not used 

  def initialize(response)
    @response = response
    @headers = OpenStruct.new(response.headers)
  end

  def request_next_page?
    more_pages? ? true : false
  end

  def more_pages?
    link = @headers.link
    next_link = link.first.include?('next') if link
    next_link ? true : false
  end

  def next_page_url
    raw_url = split_urls.select {|url| url.include?('next')}
    parse_url(raw_url)
  end

  def available_urls
    a = @headers['link'].join.split(',').map{|string| string.split("rel=").last}

    first_available = a.any? {|a| a.include?('first')}
    last_available = a.any?  {|a| a.include?('last')}
    prev_available = a.any?  {|a| a.include?('prev')}
    next_available = a.any?  {|a| a.include?('next')}

    {
      first_available: first_available,
      last_available: last_available,
      prev_available: prev_available,
      next_available: next_available
    }
  end

  def links_present?
    @headers.link ? true : false
  end

  def parse_url(raw_url)
    raw_url.join[/<(.*?)>/, 1]
  end

  def split_urls
    @headers.link.join('').split(',')
  end
end
