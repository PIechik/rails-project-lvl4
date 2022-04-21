# frozen_string_literal: true

require 'test_helper'

module Web
  module Repositories
    class ChecksControllerTest < ActionDispatch::IntegrationTest
      include ActiveJob::TestHelper

      test 'should open check page' do
        get repository_check_path(repository_checks(:finished).repository, repository_checks(:finished))

        assert_response :success
        assert_select 'td', repository_checks(:finished).output[0]
      end

      test 'should create new check' do
        assert_difference 'Repository::Check.count' do
          post repository_checks_path(repositories(:javascript))
        end

        assert_enqueued_with(job: CheckRepositoryJob)
        assert_redirected_to repositories(:javascript)
      end
    end
  end
end
