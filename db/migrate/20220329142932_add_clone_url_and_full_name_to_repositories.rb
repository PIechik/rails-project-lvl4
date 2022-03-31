class AddCloneUrlAndFullNameToRepositories < ActiveRecord::Migration[6.1]
  def change
    add_column :repositories, :clone_url, :string
    add_column :repositories, :full_name, :string
  end
end
