Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root    'static_pages#home'
  get     '/home',                     to: 'static_pages#home'
  get     '/about',                    to: 'static_pages#about'
  get     '/signup',                   to: 'users#new'
  get     '/auth/:provider/callback',  to: 'sessions#create'
  delete  '/logout',                   to: 'sessions#destroy'
  get     '/index',                    to: 'static_pages#index'
  get     '/photos/index',             to: 'photos#index'
  get     '/u_paginate',               to: 'users#show'
  
  resources :users do
    resources :photos
  end

   resources :photos do
    resources :likes
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  namespace 'api' do
    namespace 'v1' do
      resources :photos, only: :index
      resources :users, only: [:info, :photos, :user_token] do
        collection do
          resources :photos, only: :show 
          get 'info'
          get 'photos'
          get 'user_token'
        end
      end
    end
  end
  
end
