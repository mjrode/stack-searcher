# Find code where the libraries exist
# 5 Seconds for 1_000 repos
url = Github::ComposeUrl.run(
  file_name: 'Gemfile.lock',
  libraries: ['vcr', 'minitest', 'httparty'],
  search_type: :code
)

# Grab the repo names of those files
repo_names = Github::FetchRepoNames.run(url: url)

# Able to chunk repos up into groups of 5

# Compose a URL based on the Repo names found
url = Github::ComposeUrl.run( repo_names: repo_names, search_type: :repo)

puts Github::FindRepos.run(url: url)

repos =
["oguzcanhuner/marvell", "midnighteuler/chorus-docker-manager", "midnighteuler/chorus-jupyter", "thiagofm/buscape_api", "pawel2105/TDD-API-wrapper-for-dribbble", "distkloc/dribbble-api-wrapper-tutorial", "8bithero/dribbble-api-wrapper", "Overbryd/adyen_client", "nandosousafr/social_authority", "ream88/simple_tumblr"]

q: 'oguzcanhuner/marvell+in:name+OR+Overbryd/adyen_client+in:name+OR+nandosousafr/social_authority+in:name+OR+ream88/simple_tumblrin%3Aname'
