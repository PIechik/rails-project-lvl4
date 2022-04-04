# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check)
    repository_manager = ApplicationContainer[:repository_manager].new(check.repository)
    repository_manager.clone_repository
    repository_manager.install_dependencies
    check.check!
    repository_checker = ApplicationContainer[:repository_checker]
    output = repository_checker.run_check(check.repository)
    check.output = output
    check.issues_count = CheckResultsParser.count_issues(output)
    check.passed = true if check.issues_count.zero?
    check.finish
    check.save
    repository_manager.remove_tmp_repository
  end
end
