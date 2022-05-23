# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthConcern
    include Pundit

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    helper_method :signed_in?, :current_user
  end
end
