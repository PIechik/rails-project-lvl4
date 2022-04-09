# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check)
    repository = check.repository
    repository_manager = ApplicationContainer[:repository_manager].new(repository)
    repository_manager.clone_repository
    repository_manager.install_dependencies
    check.check!
    repository_checker = ApplicationContainer[:repository_checker]
    output = repository_checker.run_check(repository)
    parser = "#{repository.language}_output_parser".classify.constantize
    check.output = parser.parse_linter_output(output)
    check.issues_count = parser.count_issues(output)
    check.passed = true if check.issues_count.zero?
    check.finish
    check.save
    repository_manager.remove_tmp_repository
  end
end
