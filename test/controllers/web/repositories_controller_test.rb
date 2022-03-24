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
      response = file_fixture('repositories_info.json').read
      uri_template = Addressable::Template.new('https://api.github.com/user/repos?per_page=100')
      stub_request(:get, uri_template)
        .with(
          headers: {
            'Accept' => 'application/vnd.github.v3+json',
            'Authorization' => 'token MyString',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Octokit Ruby Gem 4.22.0'
          }
        )
        .to_return(status: 200, body: response, headers: { 'Content-Type' => 'application/json' })
      get new_repository_path

      assert_response :success
      assert_select 'select' do
        assert_select 'option', response['repository']['name']
      end
    end

    test 'should create new repository' do
      skip
      # uri_template = Addressable::Template.new('api.github.com/repos/{user}/{repo}')
      post repositories_path, params: { github_id: 3 }

      assert_response :success
      assert_redirected_to repositories_path
    end
  end
end
