# frozen_string_literal: true

require 'test_helper'

module Web
  class HomeControllerTest < ActionDispatch::IntegrationTest
    test 'should open home page' do
      get root_path

      assert_response :success
    end
  end
end
