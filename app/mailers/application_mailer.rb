# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'githab-quality@mail.com'
  layout 'mailer'
end
