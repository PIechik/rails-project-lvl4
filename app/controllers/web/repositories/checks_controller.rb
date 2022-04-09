# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      def show
        @check = Repository::Check.find(params[:id])
      end

      def create
        @repository = Repository.find(params[:repository_id])
        @check = @repository.checks.build
        CheckRepositoryJob.perform_later(@check) if @check.save
        redirect_to @repository
      end
    end
  end
end
