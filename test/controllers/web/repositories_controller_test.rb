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
      response = File.read('test/fixtures/files/repositories.json')
      stub_repositories_list_request(response)
      get new_repository_path

      response = JSON.parse(response)
      assert_response :success
      assert_select 'option', value: response[0]['id']
    end

    test 'should create new repository' do
      response = File.read('test/fixtures/files/repository.json')
      stub_repositories_list_request(response)
      assert_difference 'Repository.count' do
        post repositories_path, params: { repository: { github_id: 3 } }
      end

      assert_redirected_to repositories_path
    end
  end
end
