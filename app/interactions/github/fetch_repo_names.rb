class Github::FetchRepoNames < Less::Interaction
  expects :url

  def run
    @repo_names = []
    search_code
    @repo_names
  end

  private

  def search_code
    response = request
    build_repo_name_hash(response)
    paginate(response)
  end

  def request
    Common::GithubClient.run(url: url)
  end

  def build_repo_name_hash(response)
    response.parsed_response['items'].each do |item|
      repo_name = item['repository']["full_name"]
      @repo_names << repo_name
    end
  end

  def paginate(response)
    paginate = Pagination.new(response)
    if paginate.request_next_page?
      @url = paginate.next_page_url
      search_code
    end
  end
end
