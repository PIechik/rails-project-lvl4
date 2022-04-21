class AddReferenceUrlAndReferenceShaToRepositoryChecks < ActiveRecord::Migration[6.1]
  def change
    add_column :repository_checks, :reference_url, :string
    add_column :repository_checks, :reference_sha, :string
  end
end
