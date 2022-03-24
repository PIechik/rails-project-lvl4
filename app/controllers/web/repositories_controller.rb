# frozen_string_literal: true

module Web
  class RepositoriesController < ApplicationController
    before_action :require_authentication!

    def index
      @repositories = current_user.repositories
    end

    def new
      @repository = current_user.repositories.build
      client = Octokit::Client.new access_token: current_user.token, per_page: 100
      @repositories_from_github = client.repos
    end

    def create
      @repository = current_user.repositories.build(repository_params)
      # client = Octokit::Client.new access_token: current_user.token, per_page: 100
      # repository_info = client.repo(repository_params[:github_id].to_i)
      @repository.save

      redirect_to repositories_path
    end

    private

    def repository_params
      params.require(:repository).permit(:github_id)
    end
  end
end
