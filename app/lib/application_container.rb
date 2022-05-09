# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :repository_checker, -> { RepositoryCheckerStub }
    register :repository_manager, -> { RepositoryManagerStub }
    register :api_service, -> { GithubApiServiceStub }
  else
    register :repository_checker, -> { RepositoryChecker }
    register :repository_manager, -> { RepositoryManager }
    register :api_service, -> { GithubApiService }
  end
end
