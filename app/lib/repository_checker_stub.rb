# frozen_string_literal: true

class RepositoryCheckerStub
  def self.run_check(repository)
    file_pathes =
      {
        'javascript' => 'test/fixtures/files/javascript_check_results.json',
        'ruby' => 'test/fixtures/files/rubocop_check_results.json'
      }
    File.read(Rails.root.join(file_pathes[repository.language]))
  end
end
