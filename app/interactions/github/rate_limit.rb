class Github::RateLimit < Less::Interaction

  expects :repo_hash

  def run
    create_repo
  end

  private

  def create_repo
  end
end
