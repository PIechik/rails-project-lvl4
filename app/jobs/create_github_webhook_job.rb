# frozen_string_literal: true

class CreateGithubWebhookJob < ApplicationJob
  queue_as :default

  def perform(repository)
    ApplicationContainer[:api_service].new(repository.user.token).create_hook(repository.github_id)
  end
end
