#https://github.com/search?utf8=%E2%9C%93&q=rgeyer-rs-cookbooks%2Fcookbooks_all+in%3Aname+OR+ase-lab%2FPublisher+in%3Aname&type=Repositories
class Github::FindRepos < Less::Interaction
  

  def run
    @repos = []
    page_count
    paginate_through_repos(build_params)
    save_repos
  end

  private

  def save_repos
    @repos.each {|repo| Github::SaveRepos.run(repo_hash: repo)}
  end

  def paginate_through_repos(params)
    page_range.each do |page|
      params[:next_page] = page
      repo_response = repo_request(params)
      repos = repo_response.parsed_response['items']
      build_repo_hash(repos)
    end
  end

  def build_params
    {
      libraries: libraries,
      file_name: file_name,
      language:  language,
    }.compact
  end

  def repo_request(params)
    Common::GithubClient.run(params)
  end

  def build_repo_hash(repos)
    repos.each do |repo|
       repo_hash = {}
       repo_hash['external_id'] = repo['repository']['id']
       repo_hash['name']        = repo['repository']['name']
       repo_hash['html_url']    = repo['repository']['html_url']
       repo_hash['api_url']     = repo['repository']['url']
       repo_hash['score']       = repo['score']
       repo_hash['login']       = repo["repository"]['owner']['login']
       get_additional_repo_details(repo_hash['api_url'], repo_hash)
       @repos << repo_hash
    end
  end

  def get_additional_repo_details(api_url, repo_hash)
    response              = repo_request(api_url: api_url)
    repo_hash['stars']    = response["stargazers_count"]
    repo_hash['watchers'] = response["watchers_count"]
    repo_hash['forks']    = response["forks"]
    repo_hash['language'] = response["language"]
    puts response.headers["x-ratelimit-remaining"]
    repo_hash
  end

  def page_count
    params = build_params

    item_count = repo_request(params).parsed_response['total_count'].to_i
    puts item_count
    @page_count = item_count / Common::GithubClient::ITEMS_PER_PAGE
  end

  def page_range
    count = @page_count || page_count
    count = count < 1 ? 1 : count
    (1..count)
  end
end
