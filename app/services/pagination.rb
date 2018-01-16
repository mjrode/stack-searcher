class Pagination

  def initialize(response)
    @response = response
    @headers = OpenStruct.new(response.headers)
  end

  def next_page?
    link = @headers.link
    next_link = link.first.include?('next') if link
    next_link ? true : false
  end
end
