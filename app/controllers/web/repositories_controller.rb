# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    def index
      authorize(Repository)
      @repositories = policy_scope(Repository)
    end

    def show
      @repository = Repository.find(params[:id])
      authorize(@repository)
      authorize(@repository)
      @check = Repository::Check.new
    end

    def new
      authorize Repository
      @repository = current_user.repositories.build
      @permitted_repositories = Repository.permitted_repositories(current_user)
    end

    def create
      authorize Repository
      @repository = current_user.repositories.build(repository_params)
      notice = 'failed'
      if @repository.save
        RepositoryInfoJob.perform_later(@repository)
        CreateGithubWebhookJob.perform_later(@repository)
        notice = 'successfull'
      end
      redirect_to repositories_path, notice: t("repository_creation.#{notice}")
    end

    private

    def repository_params
      params.require(:repository).permit(:github_id)
    end
  end
end
