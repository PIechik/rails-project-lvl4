# frozen_string_literal: true

class RepositoryChecker
  def self.run_check(repository)
    commands = { 'javascript' => 'npx eslint', 'ruby' => 'rubocop' }
    configs = { 'javascript' => '.eslint.json', 'ruby' => '.rubocop.yml' }
    repositories_storage = Rails.root.join("tmp/repos/#{repository.full_name}/")
    language = repository.language
    Open3.capture3("#{commands[language]} #{repositories_storage} --config ./#{configs[language]} --format json").first
  end
end
