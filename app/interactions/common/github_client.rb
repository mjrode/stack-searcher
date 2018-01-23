class Common::GithubClient < Less::Interaction
  expects :url
  include HTTParty

  ITEMS_PER_PAGE = 100

  base_uri 'https://api.github.com/'

  def run
    @response = make_request
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

  def auth
    {username: Rails.application.secrets.GITHUB_USER_NAME, password: Rails.application.secrets.GITHUB_PASSWORD}
  end

end
