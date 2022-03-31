# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(repository)
    repository_cloner = ApplicationContainer[:repository_cloner]
    repository_cloner.clone_repository(repository)

    repository_checker = ApplicationContainer[:repository_checker]
    output = repository_checker.run_check(repository)
    CheckResultsParser.parse_linter_output(output)
  end
end
