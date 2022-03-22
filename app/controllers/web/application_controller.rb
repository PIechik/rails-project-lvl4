# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    include AuthManager
  end
end
