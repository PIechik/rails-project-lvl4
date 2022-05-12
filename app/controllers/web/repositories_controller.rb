# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :require_authentication!

    def index
      @repositories = current_user.repositories
    end

    def show
      @repository = Repository.find(params[:id])
      @check = Repository::Check.new
    end

    def new
      @repository = current_user.repositories.build
      @permitted_repositories = Repository.permitted_repositories(current_user)
    end

    def create
      @repository = current_user.repositories.build(repository_params)
      if @repository.save
        RepositoryInfoJob.perform_later(@repository)
        CreateGithubWebhookJob.perform_later(@repository)
      end
      redirect_to repositories_path
    end

    private

    def repository_params
      params.require(:repository).permit(:github_id)
    end
  end
end
