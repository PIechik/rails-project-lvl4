# frozen_string_literal: true

require 'test_helper'

module Web
  class SessionsControllerTest < ActionDispatch::IntegrationTest
    test 'should sign in via github' do
      config_omniauth(users(:one))
      post auth_request_path(:github)
      follow_redirect!
      assert session[:user_id] == users(:one).id
      assert_redirected_to root_path
    end

    test 'should sign out' do
      sign_in(users(:one))

      delete session_path(users(:one))
      assert_nil session[:user_id]
      assert_redirected_to root_path
    end
  end
end
