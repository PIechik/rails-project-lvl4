# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check)
    repository_cloner = ApplicationContainer[:repository_cloner]
    repository_cloner.clone_repository(check.repository)

    repository_checker = ApplicationContainer[:repository_checker]
    output = repository_checker.run_check(check.repository)
    check.output = output
    check.passed = true if output.empty?
    check.save
  end
end
