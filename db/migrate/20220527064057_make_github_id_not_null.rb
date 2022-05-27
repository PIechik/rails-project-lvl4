class MakeGithubIdNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :repositories, :github_id, false
  end
end
