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
  resources :recipes do
     patch 'toggle', on: :member
  end
  resources :recipes do
  patch 'toggle_public', on: :member
  end
  get 'general_shopping_list_index', to: 'general_shopping_list#index'
  get '/public_recipes', to: 'public_recipes#index'
  get 'recipes/:recipe_id/recipe_foods/new', to: 'recipe_foods#new', as: 'new_recipe_recipe_food'
  root to: 'public_recipes#index'
end
