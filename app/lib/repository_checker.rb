# frozen_string_literal: true

class RepositoryChecker
  def self.run_check(repository)
    commands = { 'javascript' => 'npx eslint', 'ruby' => 'rubocop' }
    configs = { 'javascript' => '.eslintrc.json', 'ruby' => '.rubocop.yml' }
    repositories_storage = Rails.root.join("tmp/repos/#{repository.full_name}/")
    language = repository.language
    options = "--config ./#{configs[language]} --format json"
    Open3.capture3("#{commands[language]} #{repositories_storage} #{options}").first
  end
end
