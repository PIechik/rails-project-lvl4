# frozen_string_literal: true

class RepositoryManager
  attr_reader :repository, :repository_storage

  def initialize(repository)
    @repository = repository
    @repository_storage = Rails.root.join("tmp/repos/#{repository.full_name}")
  end

  def fetch_last_commit
    client = Octokit::Client.new access_token: repository.user.token, per_page: 100
    commits = client.commits(repository.github_id)
    commits.first['url']
    connits.first['sha']
  end

  def clone_repository
    Open3.capture3("git clone #{repository.clone_url} #{repository_storage}")
  end

  def install_dependencies
    Open3.capture3("cd #{repository_storage} && npm install")
  end

  def remove_tmp_repository
    Open3.capture3("rm -rf #{repository_storage}")
  end
end
