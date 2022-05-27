# frozen_string_literal: true

class Repository < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :checks, dependent: :destroy

  enumerize :language, in: %i[javascript ruby]
  validates :github_id, uniqueness: true
  validates :github_id, presence: true

  def self.permitted_repositories(user)
    repositories = ApplicationContainer[:api_service].new(user.token).list_repositories
    permitted_languages = language.values
    repositories.select do |repository|
      repository if repository['language']&.downcase.in?(permitted_languages) && !Repository.find_by(github_id: repository['id'])
    end
  end
end
