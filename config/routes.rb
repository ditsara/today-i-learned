# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in
  # https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no
  # exceptions, otherwise 500. Can be used by load balancers and uptime
  # monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :user do
    resource :registrations, only: %i[new create update]
    resource :sessions, only: %i[new create destroy]
    resources :password_resets, only: %i[new create edit update]
  end

  namespace :u do
    resources :posts, except: %i[destroy] do
      collection do
        get 'hash_tag/:id', to: 'posts#hash_tag', as: 'hash_tag'
        get 'user/:id', to: 'posts#user', as: 'user'
      end

      resources :replies, only: %i[new edit create update]
    end
    resource :profiles, only: :show
  end

  namespace :a do
    resources :users, only: %i[index show update]
    resources :settings, only: %i[new create]
  end

  root 'pub/pages#index'
end
