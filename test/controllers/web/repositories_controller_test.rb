# frozen_string_literal: true

require 'test_helper'

module Web
  class RepositoriesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      sign_in(@user)
    end

    test 'should open index page' do
      get repositories_path

      assert_response :success
    end

    test 'should open show repository page' do
      get repository_path(repositories(:javascript))

      assert_response :success
    end

    test 'should open new repository page' do
      get new_repository_path

      assert_response :success
    end

    test 'should create new repository' do
      assert_difference 'Repository.count' do
        post repositories_path, params: { repository: { github_id: 3 } }
      end

      assert_enqueued_with(job: RepositoryInfoJob)
      assert_enqueued_with(job: CreateGithubWebhookJob)
      assert_redirected_to repositories_path
    end
  end
end
