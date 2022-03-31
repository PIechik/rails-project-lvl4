# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :repository_checker, -> { RepositoryCheckerStub }
    register :repository_cloner, -> { RepositoryClonerStub }
  else
    register :repository_checker, -> { RepositoryChecker }
    register :repository_cloner, -> { RepositoryCloner }
  end
end
