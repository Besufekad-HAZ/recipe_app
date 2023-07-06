# frozen_string_literal: true

Rails.application.routes.draw do

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # Add the following route for signing out
  resources :users, only: [:show]
  resources :recipes, except: [:update]
  resources :foods, except: [:update]

  get '/public_recipes', to: 'public_recipes#index'

  root to: 'public_recipes#index'
end
