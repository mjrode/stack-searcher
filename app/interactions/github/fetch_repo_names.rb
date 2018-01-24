class Github::FetchRepoNames < Less::Interaction
  expects :url
  # Returns a list of the full repo names given a file_name and libraries

  def run
    @repo_names = []
    @url = url
    response = search_code
    @repo_names
  end

  private

  def search_code
    response = Common::GithubClient.run(url: @url)
    build_repo_name_hash(response)
    paginate(response)
  end

  def build_repo_name_hash(response)
    response.parsed_response['items'].each do |item|
      repo_name = item['repository']["full_name"]
      @repo_names << repo_name
    end
  end

  def paginate(response)
    next_page = Github::PaginationInteraction.run(response: response)
    if next_page
      @url = next_page
      search_code
    end
  end
end
