# frozen_string_literal: true

class CreateGithubWebhookJob < ApplicationJob
  queue_as :default

  def perform(repository)
    GithubApiService.create_hook(repository)
  end
end
