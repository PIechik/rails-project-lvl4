# frozen_string_literal: true

class RepositoryCheckService
  attr_reader :check, :repository, :repository_manager, :repository_checker, :parser, :api_service

  def initialize(check)
    @check = check
    @repository = check.repository
    @repository_manager = ApplicationContainer[:repository_manager].new(@repository)
    @repository_checker = ApplicationContainer[:repository_checker]
    @api_service = ApplicationContainer[:api_service].new(repository.user.token)
    @parser = "#{@repository.language}_output_parser".classify.constantize
  end

  def run_check
    prepare_repository
    check.check!
    output = repository_checker.run_check(repository)
    parse_output(output)
    check.finish!
    mail.deliver_later unless check.issues_count.zero?
    repository_manager.remove_tmp_repository
  end

  def mail
    RepositoryCheckMailer.with(check: check).report_failed_check
  end

  def prepare_repository
    last_commit = api_service.fetch_last_commit(repository.github_id)
    check.update(last_commit)
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
