Rails.application.routes.draw do
  root 'bookings#home'
  resources :bookings, only: [:new, :create]
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
