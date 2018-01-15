class Github::FindRepos < Less::Interaction
  expects :libraries, allow_nil: true
  expects :file_name, allow_nil: true
  expects :language, allow_nil: true
  expects :sort, allow_nil: true

  def run
    @repos = []
    page_count
    paginate_through_repos(build_params)
    @repos
    binding.pry
  end

  private

  def paginate_through_repos(params)
    page_range.each do |page|
      params[:next_page] = page
      repo_response = repo_request(params)
      repos = repo_response.parsed_response['items']
      build_repo_hash(repos)
      break unless repo_response.headers['link'].include?('next')
    end
  end

  def build_params
    params = {
      libraries: libraries,
      file_name: file_name,
      language:  language,
      sort:      sort
    }
    params.compact!
    params
  end

  def repo_request(params)
    Common::GithubClient.run(params)
  end

  def build_repo_hash(repos)
    repos.each do |repo|
       repo_hash = {}
       repo_hash['external_id'] = repo['repository']['id']
       repo_hash['login'] = repo['repository']['login']
       repo_hash['name'] = repo['repository']['name']
       repo_hash['html_url'] = repo['repository']['html_url']
       repo_hash['api_url'] = repo['repository']['url']
       repo_hash['score'] = repo['score']
       @repos << repo_hash
    end
  end

  def page_count
    params = {file_name: file_name,
              libraries: libraries}

    (repo_request(params).parsed_response['total_count'].to_i / 100)
  end

  def page_range
    count = page_count
    (1..count)
  end
end
