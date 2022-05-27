# frozen_string_literal: true

class RepositoryManager
  attr_reader :repository, :repository_storage

  def initialize(repository)
    @repository = repository
    @repository_storage = Rails.root.join("tmp/repos/#{repository.full_name}")
  end

  def clone_repository
    Open3.capture3("git clone #{repository.clone_url} #{repository_storage}")
  end

  def remove_tmp_repository
    Open3.capture3("rm -rf #{repository_storage}")
  end
end
