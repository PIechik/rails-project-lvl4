# frozen_string_literal: true

module Web
  class SessionsController < Web::ApplicationController
    def create
      @user = User.find_or_create_by(email: auth_hash['info']['email'])
      @user.nickname = auth_hash['info']['nickname']
      @user.token = auth_hash['credentials']['token']
      if @user.save
        sign_in(@user)
        notice_message = 'logged_in'
      else
        notice_message = 'authorization_failed'
      end
      redirect_to root_path, notice: t(notice_message)
    end

    def destroy
      sign_out
      redirect_to root_path, notice: t('logged_out')
    end

    private

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
