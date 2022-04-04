# frozen_string_literal: true

require 'test_helper'

class RepositoryInfoJobTest < ActiveJob::TestCase
  test 'job updates repository info' do
    skip
    repository = repositories(:without_info)
    stub_request(:get, "https://api.github.com/repos/one/one")
      .with(
        headers: {
          'Accept'=>'application/vnd.github.v3+json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'token MyString',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Octokit Ruby Gem 4.22.0'
      })
      .to_return(status: 200, body: File.read(repositories_info), headers: { 'Content-Type' => 'application/json' })
    RepositoryInfoJob.perform_now(repository)
    assert { repository.name }
  end
end
