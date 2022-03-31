# frozen_string_literal: true

module Web
  module Repositories
    class ChecksController < ApplicationController
      def create
        @repository = Repository.find(params[:repository_id])
        @check = @repository.checks.build
      end
    end
  end
end
