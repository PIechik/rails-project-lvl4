# frozen_string_literal: true

require 'test_helper'

class CreateGithubWebhookJobTest < ActiveJob::TestCase
  test 'should create webhook for repo' do
    repository = repositories(:ruby)
    response = CreateGithubWebhookJob.perform_now(repository)
    assert response['active']
  end
end
