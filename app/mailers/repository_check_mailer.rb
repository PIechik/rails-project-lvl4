# frozen_string_literal: true

class RepositoryCheckMailer < ApplicationMailer
  def report_errors_found
    create_message('errors_found')
  end

  def report_failed_check
    create_message('failed')
  end

  private

  def create_message(check_state)
    @check = params[:check]
    @repository = @check.repository
    mail(to: @repository.user.email, subject: t("mail.#{check_state}.subject"))
  end
end
