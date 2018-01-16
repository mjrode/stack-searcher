Github::FindRepos.run(
  file_name:"Gemfile.lock",
  libraries: ["vcr"]
)

response = Common::GithubClient.run(file_name: 'Gemfile.lock',libraries: ['vcr', 'minitest', 'less_interactions'])

https://api.github.com/search/code?



'https://api.github.com/search/code?q=less_interactions+vcr+filename%3AGemfile.lock&per_page=100'

https://api.github.com/search/repositories?=%E2%9C%93&q=rgeyer-rs-cookbooks%2Fcookbooks_all+in%3Aname+OR+ase-lab%2FPublisher+in%3Aname&type=Repositories

['rgeyer-rs-cookbooks/cookbooks_all', 'ase-lab/Publisher']
