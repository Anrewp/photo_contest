Rails.application.routes.draw do
  root    'static_pages#home'
  get     '/home',                     to: 'static_pages#home'
  get     '/about',                    to: 'static_pages#about'
  get     '/signup',                   to: 'users#new'
  get     '/auth/:provider/callback',  to: 'sessions#create'
  delete  '/logout',                   to: 'sessions#destroy'
  get     '/index',                    to: 'static_pages#index'
  get     '/photos/index',             to: 'photos#index'
  # post    '/photos/:id',               to: 'photos#set_confirm' , as: 'photo'

  
  resources :photos

  resources :photos do
    member do
      post :set_confirm
      post :set_reject
      post :set_publish
      post :set_discard
    end
  end

  resources :users do
    resources :photos
  end

end
