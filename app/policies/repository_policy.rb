# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user)
    end
  end

  def show?
    author?
  end

  def new?
    user
  end

  def create?
    user
  end
  private

  def author?
    record.user == user
  end
end
