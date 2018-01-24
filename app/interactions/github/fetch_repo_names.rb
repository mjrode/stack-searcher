class Github::FetchRepoNames < Less::Interaction
  expects :file_name
  expects :libraries

  # Returns a list of the full repo names given a file_name and libraries

  def run
    @repo_names = []
    @url = compose_url
    response = search_code
    @repo_names
  end

  private

  def compose_url
    Github::ComposeUrl.run(file_name: file_name, libraries: libraries)
  end

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
