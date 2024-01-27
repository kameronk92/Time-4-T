Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v0 do
      post 'customers/new', to: 'customers#create'
      post 'customers/:id/subscription/:id', to: 'customer_subscriptions#create'
    end
  end
end
