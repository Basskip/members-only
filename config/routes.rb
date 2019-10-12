Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  delete '/logout', to: 'sessions#destroy'
  resources :posts, only: [:new, :create, :index]
  resources :sessions, only: [:new, :create]
end
