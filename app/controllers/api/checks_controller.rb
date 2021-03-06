# frozen_string_literal: true

module Api
  class ChecksController < Api::ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      @repository = Repository.find_by(full_name: params[:repository][:full_name])
      @check = @repository.checks.build
      CheckRepositoryJob.perform_later(@check) if @check.save
      head :ok
    end
  end
end
