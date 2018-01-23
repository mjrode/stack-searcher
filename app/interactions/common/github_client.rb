class Common::GithubClient < Less::Interaction
  expects :url
  include HTTParty

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
    {username: 'mjrode', password: 'Rose44bud'}
  end

end
