# frozen_string_literal: true

class RepositoryCloner
  def self.clone_repository(repository)
    repository_storage = Rails.root.join("tmp/repos/#{repository.full_name}")
    if File.exist?(repository_storage)
      Open3.capture3("git clone #{repository.clone_url} #{repository_storage}")
    else
      Open3.capture3("git -C #{repository_storage} fetch #{repository.clone_url}")
    end
    Open3.capture3("cd #{repository_storage} && npm install")
  end
end
