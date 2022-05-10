# frozen_string_literal: true

class RepositoryCheckMailer < ApplicationMailer
  def report_failed_check
    @check = params[:check]
    @repository = @check.repository
    mail(to: @repository.user.email, subject: t('mail.failed.subject'))
  end
end
