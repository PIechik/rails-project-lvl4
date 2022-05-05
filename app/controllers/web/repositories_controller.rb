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
      client = Octokit::Client.new access_token: current_user.token, per_page: 100
      repositories = client.repos
      permitted_languages = Repository.language.values
      @permitted_repositories = []
      repositories.each do |repository|
        @permitted_repositories << repository if repository['language']&.downcase.in? permitted_languages
      end
    end

    def create
      @repository = current_user.repositories.build(repository_params)
      @repository.save
      RepositoryInfoJob.perform_later(@repository)
      CreateGithubWebhookJob.perform_later(@repository)
      redirect_to repositories_path
    end

    private

    def repository_params
      params.require(:repository).permit(:github_id)
    end
  end
end
