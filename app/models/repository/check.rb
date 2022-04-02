# frozen_string_literal: true

class Repository
  class Check < ApplicationRecord
    belongs_to :repository
  end
end
