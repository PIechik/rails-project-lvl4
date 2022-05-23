# frozen_string_literal: true

class Repository
  class CheckPolicy < ApplicationPolicy
    def show?
      author?
    end

    def create?
      author?
    end

    private

    def author?
      record.repository.user == user
    end
  end
end
