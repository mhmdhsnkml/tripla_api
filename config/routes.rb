Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :sleep_records, only: [] do
        collection do
          post :clock_in
          post :clock_out
        end
      end

      resources :follows, only: [:create, :destroy]
      resources :feeds, only: [:index]
    end
  end
end
