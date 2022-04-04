# frozen_string_literal: true

require 'test_helper'

class CheckRepositoryJobTest < ActiveJob::TestCase
  test 'should perform repository check' do
    check = repository_checks(:created)
    CheckRepositoryJob.perform_now(check)

    assert check.finished?
    assert_not check.passed
    assert_equal 9, check.issues_count
  end
end
