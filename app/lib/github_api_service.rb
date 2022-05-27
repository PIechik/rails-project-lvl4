# frozen_string_literal: true

class GithubApiService
  attr_reader :client

  def initialize(token)
    @client = Octokit::Client.new access_token: token, per_page: 100
  end

  def fetch_last_commit(github_id)
    commits = client.commits(github_id)
    { reference_url: commits.first['html_url'], reference_sha: commits.first['sha'] }
  end

  def list_repositories
    client.repos
  end

  def fetch_repository_info(github_id)
    client.repo(github_id)
  end

  def create_hook(github_id)
    client.create_hook(
      github_id,
      'web',
      {
        url: Rails.application.routes.url_helpers.api_checks_url,
        content_type: 'json'
      },
      {
        events: %w[push pull_request],
        active: true
      }
    )
  end
end
