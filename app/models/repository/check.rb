# frozen_string_literal: true

class Repository
  class Check < ApplicationRecord
    include AASM

    belongs_to :repository
    aasm do
      state :created, initial: true
      state :checking, :finished, :failed

      event :check do
        transitions from: :created, to: :checking
      end

      event :finish do
        transitions from: :checking, to: :finished
      end

      event :mark_as_failed do
        transitions from: %i[created checking], to: :failed
      end
    end
  end
end
