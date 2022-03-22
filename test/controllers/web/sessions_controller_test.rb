# frozen_string_literal: true

require 'test_helper'

module Web
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    test 'should sign in via github' do
      config_omniauth(users(:one))
      post auth_request_path(:github)
      follow_redirect!
      assert session[:user_id] == users(:one).id
    end
  end
end