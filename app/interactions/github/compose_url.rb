class Github::ComposeUrl < Less::Interaction
  expects :file_name
  expects :libraries
  expects :language,  allow_nil: true
  expects :search_type, allow_nil: true

  def run
    compose_url(search_type)
  end

  private

  def compose_url(search_type)
    # Can search code, repo, user, owner
    build_code_search_url
  end

  def build_code_search_url
    base_url = '/search/code?q='
    base_url += format_libraries(libraries) if libraries
    base_url += "+filename%3A#{file_name}"
    base_url += "&per_page=#{Common::GithubClient::ITEMS_PER_PAGE}"
    base_url
  end

  def format_libraries(libraries)
    Array.wrap(libraries)
    libraries.join('+')
  end
end
