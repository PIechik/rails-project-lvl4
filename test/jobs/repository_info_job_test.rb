# frozen_string_literal: true

require 'test_helper'

class RepositoryInfoJobTest < ActiveJob::TestCase
  test 'job updates repository info' do
    skip
    repository = repositories(:without_info)
    RepositoryInfoJob.perform_now(repository)
    assert { repository.name }
  end
end
