# frozen_string_literal: true

class RepositoryChecker
  def self.run_check(repository)
    commands = { 'javascript' => 'npx eslint', 'ruby' => 'rubocop' }
    repositories_storage = Rails.root.join("tmp/repos/#{repository.full_name}/")
    Open3.capture3("#{commands[repository.language]} #{repositories_storage} --format json").first
  end
end
