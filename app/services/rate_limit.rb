class RateLimit
  def self.check_limits(headers)
    limit_remaining = headers["x-ratelimit-remaining"]
  end
end
