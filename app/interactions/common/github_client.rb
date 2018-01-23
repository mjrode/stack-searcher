class Common::GithubClient < Less::Interaction
  expects :url
  include HTTParty

  ITEMS_PER_PAGE = 100

  base_uri 'https://api.github.com/'

  def run
    @response = make_request
    @rate_limit = @response.headers['x-ratelimit-remaining'].to_i
    puts 'Rate limit remaining: ' + @rate_limit.to_s
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
    sleep 2 if @rate_limit < 20
  end

  def auth
    {username: Rails.application.secrets.GITHUB_USER_NAME, password: Rails.application.secrets.GITHUB_PASSWORD}
  end

end
