# frozen_string_literal: true

class RepositoryManagerStub
  attr_reader :repository, :repository_storage

  def initialize(_); end

  def fetch_last_commit
    { reference_url: Faker::Internet.url, reference_sha: Faker::Crypto.sha1 }
  end

  def clone_repository; end

  def install_dependencies; end

  def remove_tmp_repository; end
end
