# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check)
    RepositoryCheckService.new(check).run_check
  end
end
