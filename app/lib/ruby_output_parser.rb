# frozen_string_literal: true

class RubyOutputParser
  def self.parse_linter_output(output)
    errors_info = {}
    JSON.parse(output)['files'].each do |offenses_in_file|
      next if offenses_in_file['offenses'].empty?

      messages = []
      offenses_in_file['offenses'].each do |offense|
        messages << error_description(offense)
      end
      errors_info[offenses_in_file['path']] = messages
    end
    errors_info
  end

  def self.error_description(offense)
    { rule_id: offense['cop_name'], message: offense['message'], location: "#{offense['location']['line']}:#{offense['location']['column']}" }
  end

  def self.count_issues(output)
    JSON.parse(output)['summary']['offense_count']
  end
end
