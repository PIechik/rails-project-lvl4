# frozen_string_literal: true

class RepositoryCheckerStub
  def self.run_check(_repository)
    File.read(Rails.root.join('test/fixtures/files/repository_checker_results.json'))
  end
end
