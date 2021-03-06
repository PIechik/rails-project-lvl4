# frozen_string_literal: true

module AuthConcern
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    current_user.present?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def user_not_authorized
    flash[:alert] = t('not_authorized')
    redirect_to root_path
  end
end
