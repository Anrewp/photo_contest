Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root    'static_pages#home'
  get     '/home',                     to: 'static_pages#home'
  get     '/about',                    to: 'static_pages#about'
  get     '/signup',                   to: 'users#new'
  get     '/auth/:provider/callback',  to: 'sessions#create'
  delete  '/logout',                   to: 'sessions#destroy'
  get     '/index',                    to: 'static_pages#index'
  get     '/photos/index',             to: 'photos#index'
  
  # post :check_data_provider_connection, format: :js
  
  resources :users do
    resources :photos
  end
  
  post '/users/:id' => 'photos#create', defaults: { format: 'js' }

   resources :photos do
    resources :likes
  end


end
