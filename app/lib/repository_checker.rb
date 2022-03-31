# frozen_string_literal: true

class RepositoryChecker
  def self.run_check(repository)
    repositories_storage = Rails.root.join("tmp/repos/#{repository.full_name}/")
    stdout, exit_status = Open3.capture3("npx eslint #{repositories_storage} --format json") { |_stdin, stdout, _stderr, wait_thr| [stdout.read, wait_thr.value] }
    stdout
  end
end
