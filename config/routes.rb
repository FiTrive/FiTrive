Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root 'tweets#index'

  resources :users, only: [:show]
  
  resources :tweets do

    resources :comments, only: [:create]

  end

  resources :tags, only: [:create]

  resources :spots

  end
