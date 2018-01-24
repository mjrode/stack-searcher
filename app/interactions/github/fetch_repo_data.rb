#https://github.com/search?utf8=%E2%9C%93&q=rgeyer-rs-cookbooks%2Fcookbooks_all+in%3Aname+OR+ase-lab%2FPublisher+in%3Aname&type=Repositories
class Github::FetchRepoData < Less::Interaction
  # Takes an array of repo names, makes a request to the github API and then saves the data.
  # ["mjrode/stack-searcher", "mjrode/workhard", "mjrode/check_the_lines", "mjrode/TwitterLists"]
  expects :repo_array

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
       binding.pry
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
