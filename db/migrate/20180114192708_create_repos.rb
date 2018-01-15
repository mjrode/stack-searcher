class CreateRepos < ActiveRecord::Migration[5.1]
  def change
    create_table :repos do |t|
      t.string :name
      t.integer :external_id
      t.string :description
      t.string :url
      t.integer :stars
      t.integer :forks
      t.integer :score

      t.timestamps
    end
  end
end
