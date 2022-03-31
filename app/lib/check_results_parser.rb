# frozen_string_literal: true

class CheckResultsParser
  def self.parse_linter_output(output)
    errors_info = []
    JSON.parse(output).each do |offences_in_file|
      next if offences_in_file['messages'].empty?

      offences_in_file['messages'].each do |message|
        error = {}
        error[:file_path] = offences_in_file['filePath']
        error[:rule_id] = message['ruleId']
        error[:message] = message['message']
        error[:location] = "#{message['line']}:#{message['column']}"
        errors_info << error
      end
    end
    errors_info
  end
end
