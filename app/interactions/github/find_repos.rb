#https://github.com/search?utf8=%E2%9C%93&q=rgeyer-rs-cookbooks%2Fcookbooks_all+in%3Aname+OR+ase-lab%2FPublisher+in%3Aname&type=Repositories
class Github::FindRepos < Less::Interaction
  expects :url

  def run
    @repos = []
    fetch_repos
    build_repo_hash(fetch_repos)
    save_repos
  end

  private

  def save_repos
    @repos.each {|repo| Github::SaveRepos.run(repo_hash: repo)}
  end

  def fetch_repos
    response = Common::GithubClient.run(url: url)
    response.parsed_response['items']
  end

  def build_repo_hash(repos)
    repos.each do |repo|
       repo_hash = {}
       repo_hash['external_id'] = repo['id']
       repo_hash['name']        = repo['name']
       repo_hash['html_url']    = repo['html_url']
       repo_hash['api_url']     = repo['url']
       repo_hash['score']       = repo['score']
       repo_hash['login']       = repo['owner']['login']
       repo_hash['stars']    = repo["stargazers_count"]
       repo_hash['watchers'] = repo["watchers_count"]
       repo_hash['forks']    = repo["forks"]
       repo_hash['language'] = repo["language"]
       @repos << repo_hash
    end
  end
end
