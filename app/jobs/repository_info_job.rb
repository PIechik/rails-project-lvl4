# frozen_string_literal: true

class RepositoryInfoJob < ApplicationJob
  queue_as :default

  def perform(repository)
    repository_info = GithubApiService.fetch_repository_info(repository)
    repository.name = repository_info['name']
    repository.full_name = repository_info['full_name']
    repository.language = repository_info['language']&.downcase
    repository.clone_url = repository_info['clone_url']
    repository.save!
  end
end
