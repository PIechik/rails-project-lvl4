# frozen_string_literal: true

class RepositoryCheckService
  attr_reader :check, :repository, :repository_manager, :repository_checker, :parser

  def initialize(check)
    @check = check
    @repository = check.repository
    @repository_manager = ApplicationContainer[:repository_manager].new(@repository)
    @repository_checker = ApplicationContainer[:repository_checker]
    @parser = "#{@repository.language}_output_parser".classify.constantize
  end

  def run_check
    prepare_repository
    check.check!
    output = repository_checker.run_check(repository)
    parse_output(output)
    check.finish!
    repository_manager.remove_tmp_repository
  end

  def prepare_repository
    check.update(repository_manager.fetch_last_commit)
    repository_manager.clone_repository
    repository_manager.install_dependencies
  end

  def parse_output(output)
    check.output = parser.parse_linter_output(output)
    check.issues_count = parser.count_issues(output)
    check.passed = true if check.issues_count.zero?
    check.save
  end
end
