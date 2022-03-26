# frozen_string_literal: true

class RepositoryInfoJob < ApplicationJob
  queue_as :default

  def perform(repository)
    client = Octokit::Client.new access_token: repository.user.token, per_page: 100
    repository_info = client.repo(repository.github_id)
    repository.name = repository_info['repository']['name']
    repository.language = repository_info['repository']['language']
    repository.save
  end
end
