# frozen_string_literal: true

class CreateGithubWebhookJob < ApplicationJob
  queue_as :default

  def perform(repository)
    GithubApiService.new(repository.user.token).create_hook(repository.github_id)
  end
end
