# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      def show
        @check = Repository::Check.find(params[:id])
        authorize @check
      end

      def create
        @repository = Repository.find(params[:repository_id])
        @check = @repository.checks.build
        authorize @check
        notice = 'failed'
        if @check.save
          CheckRepositoryJob.perform_later(@check)
          notice = 'successfull'
        end
        redirect_to @repository, notice: t("check_creation.#{notice}")
      end
    end
  end
end
