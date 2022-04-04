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
      get repository_path(repositories(:one))

      assert_response :success
    end

    test 'should open new repository page' do
      response = File.read('test/fixtures/files/repositories_info.json')
      stub_repositories_list_request(response)
      get new_repository_path

      response = JSON.parse(response)
      assert_response :success
      assert_select 'option', value: response['id']
    end

    test 'should create new repository' do
      response = file_fixture('repositories_info.json').read
      stub_repositories_list_request(response)
      post repositories_path, params: { repository: { github_id: 3 } }

      assert_redirected_to repositories_path
    end
  end
end
