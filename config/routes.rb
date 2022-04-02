# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'
    post '/auth/:provider', to: redirect('/auth/:provider'), as: :auth_request
    get '/auth/:provider/callback', to: 'sessions#create', as: :callback_auth
    resources :sessions, only: :destroy
    resources :repositories, only: %i[index show new create] do
      scope module: :repositories do
        resources :checks, only: %i[show create]
      end
    end
  end
end
