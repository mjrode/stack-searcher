class Common::GithubClient < Less::Interaction
  # Make requests to Githubs api.
  expects :url
  include HTTParty

  ITEMS_PER_PAGE = 100

  base_uri 'https://api.github.com/'
  # debug_output $stdout

  def run
    @response = make_request
    rate_limit
    response = process_response
  end

  private

  def make_request
    self.class.get(url, basic_auth: auth)
  end

  def process_response
    if @response.success?
      @response
    else
      raise StandardError, @response.response.inspect
    end
  end

  def rate_limit
    puts "Requests Remaining: #{limit_remaining}"
    sleep_until_reset if (limit_remaining < 2)
  end

  def sleep_until_reset
    reset_time = (Time.at(@response.headers["x-ratelimit-reset"].to_i)) - Time.now
    puts "Rate limit, sleeping: #{reset_time}"
    sleep reset_time if reset_time > 0
  end

  def limit_remaining
    limit = @response.headers["x-ratelimit-remaining"].to_i
  end

  def auth
    {username: Rails.application.secrets.GITHUB_USER_NAME, password: Rails.application.secrets.GITHUB_PASSWORD}
  end

end
