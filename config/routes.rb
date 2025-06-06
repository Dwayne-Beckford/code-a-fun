# config/routes.rb
# [...]
# The `new` route needs to be placed before the `show` route
Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/dashboard", to: "pages#dashboard"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :lessons, only: [:show]
  # Defines the root path route ("/")
  # root "posts#index"
  resources :user_lessons, only: [:show]
  get "user_lessons/:id/new", to: "feedbacks#new"
end
