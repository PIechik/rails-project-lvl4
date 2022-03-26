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

    test 'should open new repository page' do
      response = file_fixture('repositories_info.json').read # TODO: change name
      stub_repositories_list_request(response)
      get new_repository_path

      assert_response :success
      assert_select 'select' do
        assert_select 'option', response['repository']['name']
      end
    end

    test 'should create new repository' do
      response = file_fixture('repositories_info.json').read
      stub_repositories_list_request(response)
      post repositories_path, params: { repository: { github_id: 3 } }

      assert_redirected_to repositories_path
    end
  end
end
