# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      def show
        @check = Repository::Check.find(params[:id])
        @error_messages = CheckResultsParser.parse_linter_output(@check.output) if @check.output
      end

      def create
        @repository = Repository.find(params[:repository_id])
        @check = @repository.checks.build
        @check.save
        CheckRepositoryJob.perform_later(@check)
        redirect_to @repository
      end
    end
  end
end
