Rails.application.routes.draw do
  namespace :user do
    resource :registrations, only: [:new, :create, :update]
    # get 'sessions/new'
    # get 'sessions/create'
    # get 'sessions/destroy'
    resource :sessions, only: [:new, :create, :destroy]
  end
  # Define your application routes per the DSL in
  # https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no
  # exceptions, otherwise 500. Can be used by load balancers and uptime
  # monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :u do
    resources :posts do
      collection do
        get 'hash_tag/:id', to: 'posts#hash_tag', as: 'hash_tag'
      end
    end
    resource :profiles, only: :show
  end

  root "pub/pages#index"
end
