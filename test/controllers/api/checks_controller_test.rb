# frozen_string_literal: true

require 'test_helper'

module Api
  class ChecksControllerTest < ActionDispatch::IntegrationTest
    test 'should create new check' do
      repository = repositories(:javascript)
      post api_checks_path, params: { repository: { id: repository.github_id } }

      assert_enqueued_with(job: CheckRepositoryJob)
      assert_response :success
    end
  end
end
