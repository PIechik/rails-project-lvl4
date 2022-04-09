# frozen_string_literal: true

require 'test_helper'

class CheckRepositoryJobTest < ActiveJob::TestCase
  test 'should perform javascript repository check' do
    check = repository_checks(:created_for_javascript)
    CheckRepositoryJob.perform_now(check)

    assert { check.finished? }
    assert { !check.passed }
    assert { check.issues_count.eql? 9 }
  end

  test 'should perform ruby repository check' do
    check = repository_checks(:created_for_ruby)
    CheckRepositoryJob.perform_now(check)

    assert { check.finished? }
    assert { !check.passed }
    assert { check.issues_count.eql? 2 }
  end
end
