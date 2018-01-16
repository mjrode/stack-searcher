class Github::SaveRepos < Less::Interaction
#  id          :integer          not null, primary key
#  name        :string
#  external_id :integer
#  description :string
#  url         :string
#  stars       :integer
#  forks       :integer
#  score       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null

  expects :repo_hash

  def run
    create_repo
  end

  private

  def create_repo
     repo = Repo.find_or_create_by(external_id: repo_hash['external_id'])
     repo.update(
       name: repo_hash['name'],
       external_id: repo_hash['external_id'],
       html_url: repo_hash['html_url'],
       api_url: repo_hash['api_url'],
       stars: repo_hash['stars'],
       login: repo_hash['login'],
       language: repo_hash['language'],
       watchers: repo_hash['watchers']
     )
  end
end
