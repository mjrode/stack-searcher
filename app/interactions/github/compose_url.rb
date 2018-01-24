class Github::ComposeUrl < Less::Interaction
  # Builds the url we use to make the Github API request.
  # You can pass it a file_name ie: Gemfile, libraries ie: ['vcr', 'less_interactions']
  # Or you can pass it a list of repo_names ie: ["mjrode/stack-searcher", "mjrode/workhard", "mjrode/check_the_lines", "mjrode/TwitterLists"]
  # You must pass it the search type
  expects :file_name, allow_nil: true
  expects :libraries, allow_nil: true
  expects :language,  allow_nil: true
  expects :repo_names, allow_nil: true

  ITEMS_PER_PAGE = 100

  def run
    compose_url
  end

  private

  def compose_url
    if repo_names
      build_repo_search
    else
      build_code_search_url
    end
  end

  def build_repo_search
    #https://api.github.com/search/repositories?=%E2%9C%93&q=rgeyer-rs-cookbooks%2Fcookbooks_all+in%3Aname+OR+ase-lab%2FPublisher+in%3Aname&type=Repositories
    base_url = '/search/repositories?q='
    base_url += format_repo_names
    base_url += "in%3Aname&type=Repositories"
  end

  def format_repo_names
    repos = Array.wrap(repo_names)
    repos.join("+in:name+OR+")
  end

  def build_code_search_url
    base_url = '/search/code?q='
    base_url += format_libraries(libraries) if libraries
    base_url += "+filename%3A#{file_name}"
    base_url += "&per_page=#{ITEMS_PER_PAGE}"
    base_url
  end

  def format_libraries(libraries)
    lib = Array.wrap(libraries)
    lib = libraries.join('+')
  end
end
