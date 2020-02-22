Rails.application.routes.draw do
  resources :items
  resources :users

   resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    post 'authenticate', to: 'authentication#authenticate'
end
