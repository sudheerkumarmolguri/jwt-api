Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "/register", to: "registrations#create"
  post "/login", to: "authentication#login"
  post "/orders", to: "orders#create"

  get "/profile", to: "profile#show"
  get "/user", to: "users#show"
  get "/admin", to: "admin#show"

  resources :orders, only: [:index, :create, :destroy]
  # config/routes.rb
    namespace :admin do
      resources :orders, only: [:index, :update] do
        member do
         put :approve
         put :reject
        end
      end
    end
end

  




 

