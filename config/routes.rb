# frozen_string_literal: true

Rails.application.routes.draw do
  get 'foods/index'
  get 'foods/show'
  get 'foods/new'
  get 'foods/create'
  get 'foods/edit'
  get 'foods/destroy'

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # root to: "home#index"

  resources :foods, except: [:update]
end
