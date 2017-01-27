Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    resources :items, only: [:index]
  end

  resources :items, only: [:new]

  root to: 'static_pages#show'
end
