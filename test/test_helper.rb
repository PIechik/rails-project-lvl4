# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    # parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def config_omniauth(user)
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        {
          info: {
            email: user.email,
            nickname: user.nickname
          },
          credentials: {
            token: user.token
          }
        }
      )
      # Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    end

    def sign_in(user)
      config_omniauth(user)
      post auth_request_path(:github)
      follow_redirect!
    end

    def stub_repositories_list_request(response)
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
    end
  end
end
