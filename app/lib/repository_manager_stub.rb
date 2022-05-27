# frozen_string_literal: true

class RepositoryManagerStub
  attr_reader :repository, :repository_storage

  def initialize(_repository); end # rubocop:disable

  def clone_repository; end

  def remove_tmp_repository; end
end
