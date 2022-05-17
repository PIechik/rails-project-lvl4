# frozen_string_literal: true

require 'test_helper'

class CheckRepositoryJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  test 'should perform javascript repository check' do
    check = repository_checks(:created_for_javascript)
    CheckRepositoryJob.perform_now(check)

    assert { check.finished? }
    assert { check.passed }
    assert { check.issues_count.eql? 0 }
  end

  test 'should perform ruby repository check' do
    check = repository_checks(:created_for_ruby)
    CheckRepositoryJob.perform_now(check)

    assert { check.finished? }
    assert { !check.passed }
    assert { check.issues_count.eql? 2 }
    assert_enqueued_email_with(RepositoryCheckMailer, :report_failed_check, args: { check: check })
  end
end
