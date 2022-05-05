# frozen_string_literal: true

class GithubApiService
  def self.fetch_last_commit(repository)
    client = Octokit::Client.new access_token: repository.user.token, per_page: 100
    commits = client.commits(repository.github_id)
    { reference_url: commits.first['html_url'], reference_sha: commits.first['sha'] }
  end

  def self.list_repositories(user)
    client = Octokit::Client.new access_token: user.token, per_page: 100
    client.repos
  end

  def self.fetch_repository_info(repository)
    client = Octokit::Client.new access_token: repository.user.token, per_page: 100
    client.repo(repository.github_id)
  end

  def self.create_hook(repository)
    client = Octokit::Client.new access_token: repository.user.token, per_page: 100
    client.create_hook(
      repository.github_id,
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
