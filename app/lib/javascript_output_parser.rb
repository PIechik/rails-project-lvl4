# frozen_string_literal: true

class JavascriptOutputParser
  def self.parse_linter_output(output)
    errors_info = {}
    JSON.parse(output).each do |offenses_in_file|
      next if offenses_in_file['messages'].empty?

      messages = []
      offenses_in_file['messages'].each do |message|
        error = { rule_id: message['ruleId'], message: message['message'], location: "#{message['line']}:#{message['column']}" }
        messages << error
      end
      errors_info[offences_in_file['filePath']] = messages
    end
    errors_info
  end

  def self.count_issues(output)
    issues_count = 0
    JSON.parse(output).each do |offences_in_file|
      issues_count += offences_in_file['messages'].size
    end
    issues_count
  end
end
