# frozen_string_literal: true

require 'test_helper'

module Web
  module Repositories
    class ChecksControllerTest < ActionDispatch::IntegrationTest
      include ActiveJob::TestHelper

      setup do
        sign_in(users(:one))
      end

      test 'should open check page' do
        check = repository_checks(:finished)
        get repository_check_path(check.repository, check)

        assert_response :success
      end

      test 'should create new check' do
        repository = repositories(:javascript)
        assert_difference 'Repository::Check.count' do
          post repository_checks_path(repository)
        end

        assert { Repository::Check.last.repository == repository }
        assert_enqueued_with(job: CheckRepositoryJob)
        assert_redirected_to repository
      end
    end
  end
end
