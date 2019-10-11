Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "sessions#new"
  delete '/logout', to: 'sessions#destroy'
  resources :posts
  resources :sessions, only: [:new, :create]
end
