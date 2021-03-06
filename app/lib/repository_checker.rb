# frozen_string_literal: true

class RepositoryChecker
  def self.run_check(repository)
    commands = { 'javascript' => 'node_modules/eslint/bin/eslint.js',
                 'ruby' => 'bundle exec rubocop' }
    configs = { 'javascript' => '.eslintrc.json', 'ruby' => '.rubocop.yml' }
    repositories_storage = Rails.root.join("tmp/repos/#{repository.full_name}/")
    language = repository.language
    additional_options = { 'javascript' => '--no-eslintrc' }
    options = "--config ./#{configs[language]} --format json #{additional_options[language]}"
    Open3.capture3("#{commands[language]} #{repositories_storage} #{options}").first
  end
end
