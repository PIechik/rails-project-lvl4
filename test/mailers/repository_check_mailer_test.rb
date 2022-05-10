# frozen_string_literal: true

require 'test_helper'

class RepositoryCheckMailerTest < ActionMailer::TestCase
  test 'should send check email' do
    check = repository_checks(:finished)
    user = check.repository.user
    mail = RepositoryCheckMailer.with(check: check).report_failed_check
    mail.deliver_now

    assert_emails 1
    assert { user.email == mail.to.first }
    assert { mail.subject == 'Linter check failed' }
  end
end
