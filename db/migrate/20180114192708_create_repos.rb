class CreateRepos < ActiveRecord::Migration[5.1]
  def change
    create_table :repos do |t|
      t.string :name
      t.integer :external_id
      t.integer :watchers
      t.string :description
      t.string :html_url
      t.string :api_url
      t.string :login
      t.string :language
      t.integer :stars
      t.integer :forks
      t.integer :score

      t.timestamps
    end
  end
end
