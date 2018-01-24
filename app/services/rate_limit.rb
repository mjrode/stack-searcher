class RateLimit

  def self.check_limits
    response = Common::GithubClient.run(url: '/rate_limit')
    parse_response(response)
    console_output
  end

  def self.parse_response(response)
    limits = response.parsed_response['resources']
    @core_requests_remaining = limits["core"]["remaining"]
    @core_time_until_reset   = time_until_reset(limits["core"]["reset"])
    @search_requests_remaining = limits["search"]["remaining"]
    @search_time_until_reset   = time_until_reset(limits["search"]["reset"])
  end

  def self.time_until_reset(unix_time)
    Time.at(unix_time) - Time.now
  end

  def self.console_output
    "Core Remaining: #{@core_requests_remaining}, resets in #{@core_time_until_reset} seconds | Search Remaining: #{@search_requests_remaining}, resets in #{@search_time_until_reset}"
  end
end
