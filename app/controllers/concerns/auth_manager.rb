# frozen_string_literal: true

module AuthManager
  def self.included(base)
    base.helper_method :signed_in?, :current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    current_user ? true : false
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def require_authentication!
    redirect_to root_path, notice: t('not_authorized') unless signed_in?
  end
end
