# frozen_string_literal: true

require 'test_helper'

class CheckRepositoryJobTest < ActiveJob::TestCase
  test 'should perform javascript repository check' do
    check = repository_checks(:created_for_javascript)
    stub_last_commit_request(check.repository.github_id)
    CheckRepositoryJob.perform_now(check)

    assert { check.finished? }
    assert { !check.passed }
    assert { check.issues_count.eql? 9 }
  end

  test 'should perform ruby repository check' do
    check = repository_checks(:created_for_ruby)
    stub_last_commit_request(check.repository.github_id)
    CheckRepositoryJob.perform_now(check)

    assert { check.finished? }
    assert { !check.passed }
    assert { check.issues_count.eql? 2 }
  end
end
