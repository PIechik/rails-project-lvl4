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
      stub_request(:get, 'https://api.github.com/user/repos?per_page=100')
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

      response = JSON.parse(response)
      assert_response :success
      assert_select 'option', value: response[0]['id']
    end

    test 'should create new repository' do
      response = File.read('test/fixtures/files/repository.json')
      stub_request(:get, 'https://api.github.com/repositories/3')
        .with(
          headers: {
            'Accept' => 'application/vnd.github.v3+json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'token MyString',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Octokit Ruby Gem 4.22.0'
          }
        )
        .to_return(status: 200, body: '', headers: {})
      stub_request(:post, 'https://api.github.com/repositories/3/hooks')
        .with(
          body: '{"name":"web","config":{"url":"https://916e-89-239-162-176.eu.ngrok.io/api/checks","content_type":"json"},"events":["push","pull_request"],"active":true}',
          headers: {
            'Accept' => 'application/vnd.github.v3+json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization' => 'token MyString',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Octokit Ruby Gem 4.22.0'
          }
        )
        .to_return(status: 200, body: '', headers: {})
      assert_difference 'Repository.count' do
        post repositories_path, params: { repository: { github_id: 3 } }
      end

      assert_performed_jobs 2
      assert_redirected_to repositories_path
    end
  end
end
