class AddIssuesCountAndPassedToRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    add_column :repository_checks, :issues_count, :integer, default: 0
    add_column :repository_checks, :passed, :boolean, default: false
    add_column :repository_checks, :output, :json
  end
end
