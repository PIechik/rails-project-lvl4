# frozen_string_literal: true

class GithubApiServiceStub
  attr_reader :client

  def initialize(_token); end

  def fetch_last_commit(_github_id)
    { reference_url: Faker::Internet.url, reference_sha: Faker::Crypto.sha1 }
  end

  def list_repositories
    JSON.parse(File.read('test/fixtures/files/repositories.json'))
  end

  def fetch_repository_info(_github_id)
    JSON.parse(File.read('test/fixtures/files/repository.json'))
  end

  def create_hook(_github_id)
    JSON.parse(File.read('test/fixtures/files/webhook_response.json'))
  end
end
