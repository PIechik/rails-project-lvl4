# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check)
    repository_cloner = ApplicationContainer[:repository_cloner]
    repository_cloner.clone_repository(check.repository)
    check.check!
    repository_checker = ApplicationContainer[:repository_checker]
    output = repository_checker.run_check(check.repository)
    check.output = output
    check.passed = true
    check.finish
    check.save
  end
end
